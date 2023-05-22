import UIKit

class HomeViewController: UIViewController {
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 50)
        label.text = "mainLabel".localized()
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var expirationPasswordsLabel: UILabel = {
        let label = UILabel()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let passwordModels = DataStoreManager.shared.getPasswordModelWithExpirationDateOfLess14days()
        if let passwordModels = passwordModels {
            label.text = "These passwords will expire within 14 days:\n".localized()
            for passwordModel in passwordModels {
                label.text! += "\(passwordModel.title!)" + " on ".localized() + "\(dateFormatter.string(from: passwordModel.expirationDate!))\n"
            }
        } else {
            label.text = "You don't have passwords that expire after 14 days".localized()
        }
        
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
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
                        
            let passwordTableNC = self.tabBarController?.viewControllers?[2] as? UINavigationController
            let passwordTVC = passwordTableNC?.topViewController as? TableViewController
            
            let destinationVC = NewPasswordViewController()
            destinationVC.reloadDataDelegate = passwordTVC
            
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
        
        let userNotificationsManager = UserNotificationsManager()
        userNotificationsManager.requestAuthorization()
        
        setupAllConstraints()
    }
    
    private func setupAllConstraints() {
        setupMainLabelConstraints()
        setupExpirationPasswordsLabelConstraints()
        setupAddPasswordButtonConstraints()
    }
    
    private func setupMainLabelConstraints() {
        mainLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        mainLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        mainLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        mainLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
    }
    
    private func setupExpirationPasswordsLabelConstraints() {
        expirationPasswordsLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 10).isActive = true
        expirationPasswordsLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        expirationPasswordsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        expirationPasswordsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupAddPasswordButtonConstraints() {
        addPasswordButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -35).isActive = true
        addPasswordButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -25).isActive = true
        addPasswordButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        addPasswordButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
