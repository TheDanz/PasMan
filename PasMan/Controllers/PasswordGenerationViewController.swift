import UIKit

class PasswordGenerationViewController: UIViewController {
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.setScreenCaptureProtection()
        label.font = UIFont(name: "Avenir Next Bold", size: 24)
        label.text = "YOUR STRONG PASSWORD".localized()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.15)
        label.layer.cornerRadius = 12
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var lengthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        label.text = "Password length: 8".localized()
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var lengthSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        slider.minimumValue = 8
        slider.maximumValue = 20
        let config = UIImage.SymbolConfiguration(pointSize: 30)
        slider.minimumValueImage = UIImage(systemName: "8.circle", withConfiguration: config)
        slider.maximumValueImage = UIImage(systemName: "20.circle", withConfiguration: config)
        let action = UIAction { _ in
            self.lengthLabel.text = "Password length: ".localized() + "\(Int(slider.value))"
        }
        slider.addAction(action, for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(slider)
        return slider
    }()
    
    lazy var lowercaseView: LabelSwitchView = {
        let labelSwitchView = LabelSwitchView()
        labelSwitchView.leftLabel.text = "Lowercase letters".localized()
        labelSwitchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelSwitchView)
        return labelSwitchView
    }()
    
    lazy var uppercaseView: LabelSwitchView = {
        let labelSwitchView = LabelSwitchView()
        labelSwitchView.leftLabel.text = "Uppercase letters".localized()
        labelSwitchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelSwitchView)
        return labelSwitchView
    }()
    
    lazy var digitsView: LabelSwitchView = {
        let labelSwitchView = LabelSwitchView()
        labelSwitchView.leftLabel.text = "Digits".localized()
        labelSwitchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelSwitchView)
        return labelSwitchView
    }()
    
    lazy var specialCharactersView: LabelSwitchView = {
        let labelSwitchView = LabelSwitchView()
        labelSwitchView.leftLabel.text = "Special characters".localized()
        labelSwitchView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(labelSwitchView)
        return labelSwitchView
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
        button.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction { _ in
            
            let passwordTableNC = self.tabBarController?.viewControllers?[2] as? UINavigationController
            let homeNC = self.tabBarController?.viewControllers?[0] as? UINavigationController
            let passwordTVC = passwordTableNC?.topViewController as? TableViewController
            let homeVC = homeNC?.topViewController as? HomeViewController
            
            let destinationVC = NewPasswordViewController()
            destinationVC.reloadDataDelegate = passwordTVC
            destinationVC.updateNumberOfPasswordsLabelDelegate = homeVC
            
            self.present(destinationVC, animated: true)
            destinationVC.passwordTextField.text = self.passwordLabel.text
        }
        button.addAction(action, for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()
    
    lazy var regeneratePasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.clockwise.circle"), for: .normal)
        button.imageView?.tintColor = .black
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.translatesAutoresizingMaskIntoConstraints = false
        let action = UIAction { _ in
            
            let length = Int(self.lengthSlider.value)
            var options = Set<PasswordGeneration.CharacterSet>()
            if self.lowercaseView.rightSwitch.isOn {
                options.insert(.lowerCaseLetters)
            }
            if self.uppercaseView.rightSwitch.isOn {
                options.insert(.upperCaseLetters)
            }
            if self.digitsView.rightSwitch.isOn {
                options.insert(.numbers)
            }
            if self.specialCharactersView.rightSwitch.isOn {
                options.insert(.specialCharacters)
            }

            let generator = PasswordGeneration()
            let password = generator.generatePassword(length: length, using: options)
            self.passwordLabel.text = password
        }
        button.addAction(action, for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        setPasswordLabelConstraints()
        setLengthLabelConstraints()
        setLengthSliderConstraints()
        setLowercaseViewConstraints()
        setUppercaseViewConstraints()
        setDigitsViewConstraints()
        setSpecialCharactersViewConstraints()
        setSaveButtonConstraints()
        setRegeneratePasswordButtonConstraints()
    }
    
    func setPasswordLabelConstraints() {
        passwordLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        passwordLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
    }
    
    func setLengthLabelConstraints() {
        lengthLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20).isActive = true
        lengthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        lengthLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setLengthSliderConstraints() {
        lengthSlider.topAnchor.constraint(equalTo: lengthLabel.bottomAnchor, constant: 5).isActive = true
        lengthSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        lengthSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setLowercaseViewConstraints() {
        lowercaseView.topAnchor.constraint(equalTo: lengthSlider.bottomAnchor, constant: 15).isActive = true
        lowercaseView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        lowercaseView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        lowercaseView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUppercaseViewConstraints() {
        uppercaseView.topAnchor.constraint(equalTo: lowercaseView.bottomAnchor, constant: 10).isActive = true
        uppercaseView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        uppercaseView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        uppercaseView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setDigitsViewConstraints() {
        digitsView.topAnchor.constraint(equalTo: uppercaseView.bottomAnchor, constant: 10).isActive = true
        digitsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        digitsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        digitsView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setSpecialCharactersViewConstraints() {
        specialCharactersView.topAnchor.constraint(equalTo: digitsView.bottomAnchor, constant: 10).isActive = true
        specialCharactersView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        specialCharactersView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        specialCharactersView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setSaveButtonConstraints() {
        saveButton.topAnchor.constraint(equalTo: specialCharactersView.bottomAnchor, constant: 10).isActive = true
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: regeneratePasswordButton.leftAnchor, constant: -10).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setRegeneratePasswordButtonConstraints() {
        regeneratePasswordButton.topAnchor.constraint(equalTo: specialCharactersView.bottomAnchor, constant: 10).isActive = true
        regeneratePasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        regeneratePasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        regeneratePasswordButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
