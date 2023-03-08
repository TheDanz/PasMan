import UIKit

class PasswordAddingViewController: UIViewController {
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter title here..."
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter login here..."
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password here..."
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
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
        button.backgroundColor = UIColor(red: 0.823, green: 0.867, blue: 0.751, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.addTarget(self, action: #selector(savePasswordButtonClick(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setSaveButtonConstraints()
        setTitleTextFieldConstraints()
        setLoginTextFieldConstraints()
        setPasswordTextFieldConstraints()
    }
    
    @objc
    func savePasswordButtonClick(sender: Any) {
        dismiss(animated: true)
    }
    
    func setSaveButtonConstraints() {
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        saveButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 60).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setTitleTextFieldConstraints() {
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setLoginTextFieldConstraints() {
        loginTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        loginTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setPasswordTextFieldConstraints() {
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
