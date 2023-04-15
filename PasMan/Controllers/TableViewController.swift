import UIKit
import CoreData

class TableViewController: UIViewController {
    
    private let dataStoreManager = DataStoreManager.shared
    private var fetchedResultsController: NSFetchedResultsController<PasswordModel>!
    
    let passwordsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(PasswordTableViewCell.self, forCellReuseIdentifier: PasswordTableViewCell.identifier)
        return tableView
    }()
    
    var updateNumberOfPasswordsLabelDelegate: UpdateNumberOfPasswordsLabelDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionInfo = fetchedResultsController?.sections?[section]
        return sectionInfo?.numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PasswordTableViewCell.identifier) as? PasswordTableViewCell else {
            return UITableViewCell()
        }
        
        let kuznyechik = Kuznyechik()
        let passwordModel = fetchedResultsController?.object(at: indexPath)
        DispatchQueue.main.async {
            cell.titleLabel.text = passwordModel?.title
            cell.loginLabel.text = kuznyechik.decrypt(data: (passwordModel?.login)!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let passwordModelToDelete = fetchedResultsController.object(at: indexPath)
            dataStoreManager.deletePasswordModel(object: passwordModelToDelete)
            updateNumberOfPasswordsLabelDelegate?.updateNumberOfPasswordsLabel()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = DetailsViewController()
        let passwordModel = fetchedResultsController.object(at: indexPath)
        destinationVC.data = passwordModel
        destinationVC.deletePasswordModelDelegate = self
        destinationVC.reloadRowsDelegate = self
        destinationVC.updateNumberOfPasswordsLabelDelegate = self.updateNumberOfPasswordsLabelDelegate
        destinationVC.index = indexPath
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let indexPath = indexPath {
                passwordsTableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                passwordsTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
}

// MARK: - Delegates

extension TableViewController: ReloadDataDelegate {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.passwordsTableView.reloadData()
        }
    }
}

extension TableViewController: DeletePasswordModelDelegate {
    
    func deletePasswordModel(at indexPath: IndexPath) {
        let passwordModelToDelete = fetchedResultsController.object(at: indexPath)
        dataStoreManager.deletePasswordModel(object: passwordModelToDelete)
    }
}

extension TableViewController: ReloadRowsDelegate {
    
    func reloadRows(indexPath: [IndexPath], animation: UITableView.RowAnimation) {
        passwordsTableView.reloadRows(at: indexPath, with: animation)
    }
}
