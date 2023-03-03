import UIKit

class PasswordAddingViewController: UIViewController {
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        button.backgroundColor = UIColor(red: 0.823, green: 0.867, blue: 0.751, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.addTarget(self, action: #selector(savePasswordButtonClick(sender:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setSaveButtonConstraints()
    }
    
    @objc
    func savePasswordButtonClick(sender: Any) {
        dismiss(animated: true)
    }
    
    func setSaveButtonConstraints() {
        saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
