import UIKit
import LocalAuthentication

class AuthorizationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        login()
    }

    private func login() {
        
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            
            let reason = "Please login with Local Authentication"
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { [weak self] success, error in
                DispatchQueue.main.async {
                    guard success, error == nil else {
                        let alert = UIAlertController(title: "Authorisation Error", message: "Please try again", preferredStyle: .alert)
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
}
