import UIKit

class NewPasswordViewController: UIViewController {
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Caption".localized()
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username".localized()
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
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password".localized()
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
    
    lazy var lifeTimeView: LabelSwitchView = {
        let labelSwitchView = LabelSwitchView()
        labelSwitchView.leftLabel.text = "Add expiration time?".localized()
        labelSwitchView.rightSwitch.addTarget(self, action: #selector(lifeTimeSwitchChangedValue), for: .valueChanged)
        labelSwitchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelSwitchView)
        return labelSwitchView
    }()
    
    lazy var stepperView: LabelStepperView = {
        let labelStepperView = LabelStepperView()
        labelStepperView.isHidden = true
        labelStepperView.rightStepper.minimumValue = 1
        labelStepperView.rightStepper.maximumValue = 360
        labelStepperView.rightStepper.stepValue = 1
        labelStepperView.leftLabel.text = "Amount of days".localized() + ": 1"
        labelStepperView.rightStepper.addTarget(self, action: #selector(stepperChangedValue), for: .valueChanged)
        labelStepperView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelStepperView)
        return labelStepperView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save password".localized(), for: .normal)
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
                
                let alert = UIAlertController(title: "ERROR".localized(), message: "Fill in all the fields".localized(), preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                alert.addAction(action)
                
                self.present(alert, animated: true)
                return
            }
            
            var uuidString = UUID().uuidString
            var expirationDate: Date? = nil
            
            if self.lifeTimeView.rightSwitch.isOn {
                
                let userNotificationsManager = UserNotificationsManager()
                let days = Int(self.stepperView.rightStepper.value)
                userNotificationsManager.sendNotifications(after: days, body: "Your ".localized() + title + " password has expired!".localized(), uuid: uuidString)
                
                expirationDate = Calendar.current.date(byAdding: .day, value: Int(self.stepperView.rightStepper.value), to: Date())!
            }
            
            let passwordStrength = WeaknessChecker.check(password: password).0
            let passwordBitStrength = WeaknessChecker.check(password: password).1
        
            guard passwordStrength != .veryWeak && passwordStrength != .weak else {
                
                let alert = AlertManager.createOKCancelAlert(title: "Password strength is too low".localized(),
                                                             message: "Are you sure you want to save your password?".localized()) {
                    
                    DataStoreManager.shared.createPasswordModel(title: title.trimmingCharacters(in: [" "]),
                                                                login: login.trimmingCharacters(in: [" "]),
                                                                password: password, uuid: uuidString,
                                                                expirationDate: expirationDate,
                                                                bitStrength: passwordBitStrength)
                    self.dismiss(animated: true)
                }
                self.present(alert, animated: true)
                return
            }
            
            DataStoreManager.shared.createPasswordModel(title: title.trimmingCharacters(in: [" "]),
                                                        login: login.trimmingCharacters(in: [" "]),
                                                        password: password, uuid: uuidString,
                                                        expirationDate: expirationDate,
                                                        bitStrength: passwordBitStrength)
            self.dismiss(animated: true)
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
    private func lifeTimeSwitchChangedValue(_ sender: UISwitch) {
        stepperView.isHidden = stepperView.isHidden ? false : true
    }
    
    @objc
    private func stepperChangedValue(_ sender: UIStepper) {
        stepperView.leftLabel.text = "Amount of days".localized() + ": " + String(Int(stepperView.rightStepper.value))
    }
    
    @objc
    private func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    private func setupAllConstraints() {
        setupTitleTextFieldConstraints()
        setupLoginTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupLifeTimeViewConstraints()
        setupSaveButtonConstraints()
        setupStepperViewConstraints()
    }
    
    private func setupTitleTextFieldConstraints() {
        titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupLoginTextFieldConstraints() {
        loginTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 5).isActive = true
        loginTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupPasswordTextFieldConstraints() {
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 5).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupLifeTimeViewConstraints() {
        lifeTimeView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        lifeTimeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        lifeTimeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        lifeTimeView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupStepperViewConstraints() {
        stepperView.topAnchor.constraint(equalTo: lifeTimeView.bottomAnchor, constant: 5).isActive = true
        stepperView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stepperView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        stepperView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupSaveButtonConstraints() {
        saveButton.topAnchor.constraint(equalTo: stepperView.bottomAnchor, constant: 30).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
