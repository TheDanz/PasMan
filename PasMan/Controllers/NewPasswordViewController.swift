import UIKit

class NewPasswordViewController: UIViewController {
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title here ..."
        textField.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        textField.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        textField.layer.borderColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter username here ..."
        textField.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        textField.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        textField.layer.borderColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title password ..."
        textField.font = UIFont(name: "Avenir Next Demi Bold", size: 15)
        textField.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        textField.layer.borderColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.autocorrectionType = .no
        textField.returnKeyType = .done
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        
        let action = UIAction { _ in
            
            guard let title = self.titleTextField.text,
                  let login = self.loginTextField.text,
                  let password = self.passwordTextField.text else { return }
            
            guard !title.isEmpty,
                  !login.isEmpty,
                  !password.isEmpty else {
                
                let alert = UIAlertController(title: "ERROR", message: "Fill in all the fields", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                
                self.present(alert, animated: true)
                return
            }
            
            DataStoreManager.shared.createPasswordModel(title: title, login: login, password: password)
            self.reloadDataDelegate?.reloadData()
            self.updateNumberOfPasswordsLabelDelegate?.updateNumberOfPasswordsLabel()
            
            self.dismiss(animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()
    
    var reloadDataDelegate: ReloadDataDelegate?
    var updateNumberOfPasswordsLabelDelegate: UpdateNumberOfPasswordsLabelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSaveButtonConstraints()
        setupTitleTextFieldConstraints()
        setupLoginTextFieldConstraints()
        setupPasswordTextFieldConstraints()
    }

    func setupSaveButtonConstraints() {
        saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupTitleTextFieldConstraints() {
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupLoginTextFieldConstraints() {
        loginTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        loginTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupPasswordTextFieldConstraints() {
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
