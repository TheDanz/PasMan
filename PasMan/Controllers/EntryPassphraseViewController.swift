import UIKit
import CryptoKit

class EntryPassphraseViewController: UIViewController {
    
    lazy var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.text = "Enter a passphrase that will decrypt your passwords.".localized()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var passphraseTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Passphrase".localized()
        textField.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        textField.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        textField.layer.borderColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.textContentType = .oneTimeCode
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()

    lazy var OKButton: UIButton = {
        let button = UIButton()
        button.setTitle("OK", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        let action = UIAction { _ in
            
            guard let text = self.passphraseTextField.text else { return }
            
            let data = Data(text.utf8)
            let hash = SHA256.hash(data: data)
            let hashString = hash.compactMap { String(format: "%02x", $0) }.joined()
            let bytes = hashString.hexaBytes.map({ Int8(bitPattern: $0) })
            
            guard let passphraseFromKeychain = try? KeychainManager.get("ru.PasMan.Passphrase") else { return }
            
            guard Data(hash) == passphraseFromKeychain else {
                let alert = AlertManager.createOKAlert(title: "Passphrases do not match".localized())
                self.present(alert, animated: true)
                return
            }
            
            DataStoreManager.masterKuznyechik = Kuznyechik(key: bytes)
            
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        setupAllConstraints()
    }
    
    @objc
    func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setupAllConstraints() {
        setupTopLabelConstraints()
        setupPassphraseTextFieldConstraints()
        setupOKButtonConstraints()
    }

    private func setupTopLabelConstraints() {
        topLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        topLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        topLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
    }
    
    private func setupPassphraseTextFieldConstraints() {
        passphraseTextField.topAnchor.constraint(equalTo: self.topLabel.bottomAnchor, constant: 40).isActive = true
        passphraseTextField.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        passphraseTextField.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        passphraseTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupOKButtonConstraints() {
        OKButton.topAnchor.constraint(equalTo: self.passphraseTextField.bottomAnchor, constant: 10).isActive = true
        OKButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
        OKButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
        OKButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
