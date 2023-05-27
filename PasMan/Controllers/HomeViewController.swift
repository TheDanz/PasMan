import UIKit

class HomeViewController: UIViewController {
    
    lazy var mainView: HomeLabelView = {
        let homeLabelView = HomeLabelView()
        homeLabelView.mainLabel.font = UIFont(name: "Avenir Next Bold", size: 45)
        homeLabelView.mainLabel.text = "mainLabel".localized()
        homeLabelView.mainLabel.textAlignment = .center
        homeLabelView.mainLabel.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        homeLabelView.mainLabel.numberOfLines = 3
        homeLabelView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(homeLabelView)
        return homeLabelView
    }()
    
    lazy var leftExpirationView: HomeLabelView = {
        let homeLabelView = HomeLabelView()
        homeLabelView.mainLabel.font = UIFont(name: "Avenir Next Bold", size: 16)
        homeLabelView.mainLabel.textAlignment = .left
        homeLabelView.mainLabel.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        homeLabelView.mainLabel.numberOfLines = 0
        homeLabelView.sizeToFit()
        homeLabelView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(homeLabelView)
        return homeLabelView
    }()
    
    lazy var rightWeaknessView: HomeLabelView = {
        let homeLabelView = HomeLabelView()
        homeLabelView.mainLabel.text = "You don't have weak passwords".localized()
        homeLabelView.mainLabel.font = UIFont(name: "Avenir Next Bold", size: 16)
        homeLabelView.mainLabel.textAlignment = .right
        homeLabelView.mainLabel.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        homeLabelView.mainLabel.numberOfLines = 0
        homeLabelView.sizeToFit()
        homeLabelView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(homeLabelView)
        return homeLabelView
    }()

    lazy var addPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        let action = UIAction { _ in
            let destinationVC = NewPasswordViewController()
            self.present(destinationVC, animated: true)
        }
        button.addAction(action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        updateLeftExpirationViewText()
        updateRightWeaknessViewText()
        
        let userNotificationsManager = UserNotificationsManager()
        userNotificationsManager.requestAuthorization()
        
        setupAllConstraints()
    }
    
    func updateLeftExpirationViewText() {
        
        let passwordModels = DataStoreManager.shared.getPasswordModelWithExpirationDateOfLess14days()
        if let passwordModels = passwordModels {
            leftExpirationView.mainLabel.text = "These passwords will expire within 14 days:\n\n".localized()
            for passwordModel in passwordModels {
                leftExpirationView.mainLabel.text! += "\(passwordModel.title!)\n"
            }
        } else {
            leftExpirationView.mainLabel.text = "You don't have passwords that expire after 14 days".localized()
        }
    }
    
    func updateRightWeaknessViewText() {
        
        let passwordModels = DataStoreManager.shared.getPasswordModelWithStrengthOfLess36bits()
        if let passwordModels = passwordModels {
            rightWeaknessView.mainLabel.text = "These passwords are too weak:\n\n".localized()
            for passwordModel in passwordModels {
                rightWeaknessView.mainLabel.text! += "\(passwordModel.title!)\n"
            }
        } else {
            rightWeaknessView.mainLabel.text = "You don't have weak passwords".localized()
        }
    }
    
    private func setupAllConstraints() {
        setupMainViewConstraints()
        setupLeftExpirationViewConstraints()
        setupRightWeaknessViewConstraints()
        setupAddPasswordButtonConstraints()
    }
    
    private func setupMainViewConstraints() {
        mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        mainView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        mainView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setupLeftExpirationViewConstraints() {
        leftExpirationView.topAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 10).isActive = true
        leftExpirationView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        leftExpirationView.heightAnchor.constraint(greaterThanOrEqualTo: rightWeaknessView.heightAnchor).isActive = true
        leftExpirationView.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.47).isActive = true
        leftExpirationView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.46).isActive = true
    }
    
    private func setupRightWeaknessViewConstraints() {
        rightWeaknessView.topAnchor.constraint(equalTo: self.mainView.bottomAnchor, constant: 10).isActive = true
        rightWeaknessView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        rightWeaknessView.heightAnchor.constraint(greaterThanOrEqualTo: leftExpirationView.heightAnchor).isActive = true
        rightWeaknessView.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.47).isActive = true
        rightWeaknessView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.46).isActive = true
    }
    
    private func setupAddPasswordButtonConstraints() {
        addPasswordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -15).isActive = true
        addPasswordButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        addPasswordButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        addPasswordButton.widthAnchor.constraint(equalToConstant: 55).isActive = true
    }
}
