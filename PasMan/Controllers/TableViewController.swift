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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.passwordsTableView.reloadData()
        }
    }
    
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
        let sortDescriptor = NSSortDescriptor(key: "uuid", ascending: true)
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
        
        let numberOfObjects = fetchedResultsController?.sections?[section].numberOfObjects ?? 0
        
        if numberOfObjects == 0 {
            
            let noDataLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height))
            noDataLabel.font = UIFont(name: "Avenir Next Bold", size: 30)
            noDataLabel.text = "You haven't saved any passwords yet".localized()
            noDataLabel.textAlignment = .center
            noDataLabel.textColor = #colorLiteral(red: 0.3921568627, green: 0.5843137255, blue: 0.9294117647, alpha: 1)
            noDataLabel.numberOfLines = 0
            tableView.backgroundView = noDataLabel
            
            return 0
        }
        
        if tableView.backgroundView != nil {
            tableView.backgroundView = nil
        }
        
        return numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PasswordTableViewCell.identifier) as? PasswordTableViewCell else {
            return UITableViewCell()
        }
        
        let passwordModel = fetchedResultsController?.object(at: indexPath)
        DispatchQueue.main.async {
            cell.titleLabel.text = DataStoreManager.shared.getTitle(for: passwordModel!)
            cell.loginLabel.text = DataStoreManager.shared.getLogin(for: passwordModel!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let passwordModelToDelete = fetchedResultsController.object(at: indexPath)
            dataStoreManager.deletePasswordModel(object: passwordModelToDelete)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let destinationVC = DetailsViewController()
        let passwordModel = fetchedResultsController.object(at: indexPath)
        destinationVC.data = passwordModel
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
