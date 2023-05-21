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
    
    var countOfPasswords: Int {
        get {
            return try! viewContext.fetch(PasswordModel.fetchRequest()).count
        }
    }
    
    func createPasswordModel(title: String, login: String, password: String, uuid: String? = nil, expirationDate: Date? = nil) {
        let kuznyechik = Kuznyechik()
        let passwordModel = PasswordModel(context: viewContext)
        passwordModel.title = title
        passwordModel.login = kuznyechik.encrypt(string: login)
        passwordModel.password = kuznyechik.encrypt(string: password)
        passwordModel.uuid = uuid
        passwordModel.expirationDate = expirationDate
        try? viewContext.save()
    }
    
    func deletePasswordModel(object: PasswordModel) {
                
        if let uuid = object.uuid {
            let userNotificationsManager = UserNotificationsManager()
            userNotificationsManager.deleteNotification(withUUID: uuid)
        }
        
        viewContext.delete(object)
        try? viewContext.save()
    }
    
    func updateTitle(for object: PasswordModel, title: String) {
        
        if let uuid = object.uuid {
            let userNotificationsManager = UserNotificationsManager()
            userNotificationsManager.updateNotificationBody(withUUID: uuid, newBody: "Your ".localized() + title + " password has expired!".localized())
        }
        
        object.title = title
        try? viewContext.save()
    }
    
    func updateLogin(for object: PasswordModel, login: String) {
        let kuznyechik = Kuznyechik()
        object.login = kuznyechik.encrypt(string: login)
        try? viewContext.save()
    }
    
    func updatePassword(for object: PasswordModel, password: String) {
        let kuznyechik = Kuznyechik()
        object.password = kuznyechik.encrypt(string: password)
        try? viewContext.save()
    }
    
    func updateAdditionalInformation(for object: PasswordModel, information: String) {
        let kuznyechik = Kuznyechik()
        object.additionalInformation = kuznyechik.encrypt(string: information)
        try? viewContext.save()
    }
    
    func updateExpirationDate(for object: PasswordModel, expirationDate: Date) {
        object.expirationDate = expirationDate
        try? viewContext.save()
    }
}

extension DataStoreManager: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
