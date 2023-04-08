import UIKit

class HomeViewController: UIViewController {
    
    lazy var welcomingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Bold", size: 55)
        label.text = "KEEP YOUR\nPASSWORDS\nSAFE"
        label.textAlignment = .right
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()
    
    lazy var currentNumberOfPasswordsLabel: UILabel = {
        let label = UILabel()
        let numberOfPasswords = DataStoreManager.shared.countOfPasswords
        label.text = "\(numberOfPasswords)"
        label.font = UIFont(name: "Avenir Next Bold", size: 130)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupWelcomingLabelConstraints()
        setupCurrentNumberOfPasswordsLabel()
    }
    
    func setupWelcomingLabelConstraints() {
        welcomingLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        welcomingLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        welcomingLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
    }
    
    func setupCurrentNumberOfPasswordsLabel() {
        currentNumberOfPasswordsLabel.topAnchor.constraint(equalTo: welcomingLabel.bottomAnchor, constant: 0).isActive = true
        currentNumberOfPasswordsLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10).isActive = true
        currentNumberOfPasswordsLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10).isActive = true
        currentNumberOfPasswordsLabel.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
}

// MARK: - Delegates

extension HomeViewController: UpdateNumberOfPasswordsLabelDelegate {
    
    func updateNumberOfPasswordsLabel() {
        let numberOfPasswords = DataStoreManager.shared.countOfPasswords
        self.currentNumberOfPasswordsLabel.text = "\(numberOfPasswords)"
    }
}
