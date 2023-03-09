import UIKit
import CoreData

class PasswordTableViewController: UIViewController {
    
    let dataStoreManager = DataStoreManager()
    var fetchedResultsController: NSFetchedResultsController<PasswordModel>!
    
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
        
        setupFetchedResultsContoller()
    }
    
    func setupFetchedResultsContoller() {
        
        let fetchRequest: NSFetchRequest<PasswordModel> = PasswordModel.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 15
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: dataStoreManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController.delegate = self
        
        try! fetchedResultsController.performFetch()
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
        
        let sectionInfo = fetchedResultsController?.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PasswordTableViewCell.identifier) as? PasswordTableViewCell else {
            return UITableViewCell()
        }
        
        let passwordModel = fetchedResultsController?.object(at: indexPath)
        cell.titleLabel.text = passwordModel?.title
        cell.loginLabel.text = passwordModel?.login
        return cell
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension PasswordTableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        default:
            break
        }
    }
}
