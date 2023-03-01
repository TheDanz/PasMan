import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: HomeViewController())

        setViewControllers([homeVC], animated: false)
        
        if let items = tabBar.items {
            
            let images = ["house.circle"]
            
            for i in 0..<items.count {
                let config = UIImage.SymbolConfiguration(pointSize: 30)
                items[i].image = UIImage(systemName: images[i], withConfiguration: config)
            }
        }
    }
}
