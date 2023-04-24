import UIKit

class TabBarController: UITabBarController {
    
    lazy var middleButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 45, height: 45)
        button.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        button.addTarget(self, action: #selector(self.presentPasswordAddingVC(sender:)), for: .touchUpInside)
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        tabBar.addSubview(button)
        return button
    }()
    
    private let homeVC = HomeViewController()
    private let passwordGenerationVC = PasswordGenerationViewController()
    private let passwordAddingVC = NewPasswordViewController()
    private let passwordTVC = TableViewController()
    private let nothingVC = UIViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTVC.updateNumberOfPasswordsLabelDelegate = homeVC
        
        delegate = self
        
        let homeNC = UINavigationController(rootViewController: homeVC)
        let passwordGenerationNC = UINavigationController(rootViewController: passwordGenerationVC)
        let passwordAddingNC = UINavigationController(rootViewController: passwordAddingVC)
        let passwordTableNC = UINavigationController(rootViewController: passwordTVC)
        let nothingNC = UINavigationController(rootViewController: nothingVC)

        setViewControllers([homeNC, passwordGenerationNC, passwordAddingNC, passwordTableNC, nothingNC], animated: false)
        
        tabBar.tintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 0.2)
        
        if let items = tabBar.items {
            
            let images = ["house.circle", "123.rectangle", nil, "lock.circle", "x.circle"]
            
            for i in 0..<items.count {
                let config = UIImage.SymbolConfiguration(pointSize: 20)
                items[i].image = UIImage(systemName: images[i] ?? "", withConfiguration: config)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        middleButton.center = CGPoint(x: tabBar.frame.width / 2, y: 10)
    }
    
    @objc
    func presentPasswordAddingVC(sender: Any) {
        let destinationVC = NewPasswordViewController()
        destinationVC.reloadDataDelegate = passwordTVC
        destinationVC.updateNumberOfPasswordsLabelDelegate = homeVC
        present(destinationVC, animated: true)
    }
}

// MARK: - TabBarController Delegate

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        
        if selectedIndex == 2 {
            return false
        }
        
        return true
    }
}
