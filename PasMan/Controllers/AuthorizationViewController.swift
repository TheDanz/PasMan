import UIKit
import LocalAuthentication

class AuthorizationViewController: UIViewController {
    
    lazy var shieldImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(systemName: "lock.shield")
        imageView.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        self.view.addSubview(imageView)
        return imageView
    }()
    
    lazy var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 20)
        label.text = "You must use local authorization methods (biometry, Apple Watch or the device passcode) to access the application".localized()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var againButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.isHidden = true
        button.setTitle("Try again".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        button.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        button.layer.cornerRadius = 12
        let action = UIAction { _ in
            button.isHidden = button.isHidden ? false : true
            self.login()
        }
        button.addAction(action, for: .touchUpInside)
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        login()
        
        againButton.center = view.center
        shieldImageView.center = view.center
        
        UIView.animate(withDuration: 1) {
            self.shieldImageView.center = CGPoint(x: self.view.frame.maxX / 2,
                                                  y: self.shieldImageView.frame.height)
        }
        
        setupBottomLabelConstraints()
    }

    private func login() {
        
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Please login with Local Authentication".localized()
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        self?.againButton.isHidden = false
                        return
                    }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                }
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "ERROR".localized(), message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss".localized(), style: .cancel)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }
    
    private func setupBottomLabelConstraints() {
        bottomLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        bottomLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        bottomLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
}
