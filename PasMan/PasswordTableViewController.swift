import UIKit

class PasswordTableViewController: UIViewController {
    
    let passwordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(PasswordTableViewCell.self, forCellReuseIdentifier: PasswordTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(passwordsTableView)
        passwordsTableView.delegate = self
        passwordsTableView.dataSource = self
        setPasswordsTableViewConstants()
    }
    
    func setPasswordsTableViewConstants() {
        passwordsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        passwordsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        passwordsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        passwordsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
}

// MARK: - Table View Methods

extension PasswordTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension PasswordTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PasswordTableViewCell.identifier) as? PasswordTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = "Title Label"
        cell.loginLabel.text = "Login Label"
        return cell
    }
}
