import CoreData

class DataStoreManager {
    
    static var shared: DataStoreManager  = DataStoreManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext = persistentContainer.viewContext

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createPasswordModel(title: String, login: String, password: String) {
        
        let passwordModel = PasswordModel(context: viewContext)
        passwordModel.title = title
        passwordModel.login = login
        passwordModel.password = password
        
        try? viewContext.save()
    }
    
    func deletePasswordModel(object: PasswordModel) {
        viewContext.delete(object)
        try? viewContext.save()
    }
    
    func updateTitle(for object: PasswordModel, title: String) {
        object.title = title
        try? viewContext.save()
    }
    
    func updateLogin(for object: PasswordModel, login: String) {
        object.login = login
        try? viewContext.save()
    }
    
    func updatePassword(for object: PasswordModel, password: String) {
        object.password = password
        try? viewContext.save()
    }
    
    func updateAdditionalInformation(for object: PasswordModel, information: String) {
        object.additionalInformation = information
        try? viewContext.save()
    }
}

extension DataStoreManager: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
