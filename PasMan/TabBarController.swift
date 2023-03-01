import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let passwordTVC = UINavigationController(rootViewController: PasswordTableViewController())

        setViewControllers([homeVC, passwordTVC], animated: false)
        
        if let items = tabBar.items {
            
            let images = ["house.circle", "lock.circle"]
            
            for i in 0..<items.count {
                let config = UIImage.SymbolConfiguration(pointSize: 30)
                items[i].image = UIImage(systemName: images[i], withConfiguration: config)
            }
        }
    }
}
