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
        label.text = "You must use local authorization methods (biometry, Apple Watch or the device passcode) to access the application"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        login()
        
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
            
            let reason = "Please login with Local Authentication"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Authorization Error", message: "Please try again", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Dismiss", style: .cancel)
                        alert.addAction(action)
                        self?.present(alert, animated: true)
                        return
                    }
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarController())
                }
            }
        } else {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "ERROR", message: error?.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "Dismiss", style: .cancel)
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
