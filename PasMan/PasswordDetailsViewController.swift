import UIKit

class PasswordDetailsViewController: UIViewController {
    
    lazy var titleView: UIView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Website"
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var loginView: UIView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Username"
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var passwordView: UIView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Password"
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var additionalInformationView: UIView = {
        let passwordDetailsView = PasswordDetailsView()
        passwordDetailsView.titleLabel.text = "Additional Information"
        passwordDetailsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(passwordDetailsView)
        return passwordDetailsView
    }()
    
    lazy var deletePasswordButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.1)
        button.setTitle("Delete password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setTitleViewConstraints()
        setLoginViewConstraints()
        setPasswordViewConstraints()
        setAdditionalInformationViewConstraints()
        setDeleteButtonPasswordConstraints()
    }
    
    func setTitleViewConstraints() {
        titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        titleView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setLoginViewConstraints() {
        loginView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 10).isActive = true
        loginView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        loginView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setPasswordViewConstraints() {
        passwordView.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 10).isActive = true
        passwordView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        passwordView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    func setAdditionalInformationViewConstraints() {
        additionalInformationView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 10).isActive = true
        additionalInformationView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        additionalInformationView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        additionalInformationView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    func setDeleteButtonPasswordConstraints() {
        deletePasswordButton.topAnchor.constraint(equalTo: additionalInformationView.bottomAnchor, constant: 10).isActive = true
        deletePasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        deletePasswordButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        deletePasswordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
