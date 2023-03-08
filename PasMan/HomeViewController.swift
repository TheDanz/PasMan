import UIKit

class HomeViewController: UIViewController {
    
    lazy var welcomingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 53)
        label.text = "All your passwords in one place...\nIn secure place"
        label.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setWelcomingLabelConstraints()
    }
    
    func setWelcomingLabelConstraints() {
        welcomingLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        welcomingLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        welcomingLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
}
