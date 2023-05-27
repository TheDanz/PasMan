import UIKit

class TabBarController: UITabBarController {
    
    private let homeVC = HomeViewController()
    private let passwordGenerationVC = PasswordGenerationViewController()
    private let passwordTVC = TableViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: nil) { _ in
            UIPasteboard.general.string = ""
        }
        
        homeVC.title = "Home".localized()
        passwordGenerationVC.title = "Generate".localized()
        passwordTVC.title = "Passwords".localized()
                
        let homeNC = UINavigationController(rootViewController: homeVC)
        let passwordGenerationNC = UINavigationController(rootViewController: passwordGenerationVC)
        let passwordTableNC = UINavigationController(rootViewController: passwordTVC)

        setViewControllers([homeNC, passwordGenerationNC, passwordTableNC], animated: false)
        
        tabBar.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.2)
        
        if let items = tabBar.items {
            
            let images = ["house.circle", "123.rectangle", "lock.circle"]
            
            for i in 0..<items.count {
                let config = UIImage.SymbolConfiguration(pointSize: 20)
                items[i].image = UIImage(systemName: images[i], withConfiguration: config)
            }
        }
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let tabBarIndex = tabBarController.selectedIndex
        switch tabBarIndex {
        case 0:
            self.homeVC.updateLeftExpirationViewText()
            self.homeVC.updateRightWeaknessViewText()
        case 2:
            DispatchQueue.main.async {
                self.passwordTVC.passwordsTableView.reloadData()
            }
        default:
            break
        }
    }
}
