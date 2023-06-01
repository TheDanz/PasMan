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
    
    static var masterKuznyechik: Kuznyechik?
    
    func getTitlesWithExpirationDateOfLess14days() -> [String]? {
        
        let request = PasswordModel.fetchRequest()
        let passwordModels = try? viewContext.fetch(request)
        
        guard let passwordModels = passwordModels else { return nil }
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return nil }
        
        var output: [String] = []
        for passwordModel in passwordModels {
            
            if let expirationDate = passwordModel.expirationDate {
                
                let calendar = Calendar.current
                let date1 = calendar.startOfDay(for: Date())
                let date2 = calendar.startOfDay(for: expirationDate)
                let components = calendar.dateComponents([.day], from: date1, to: date2)
                
                let objectKey = Array(passwordModel.key!).map({ Int8(bitPattern: $0) })
                let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
                
                guard let title = try? Kuznyechik(key: decryptedKey).decrypt(data: passwordModel.title!) else { return nil }
                
                if components.day! < 14 {
                    output.append(title)
                }
            }
        }
        
        if output.isEmpty {
            return nil
        }
        return output
    }
    
    func getTitlesWithStrengthOfLess36bits() -> [String]? {
        
        let request = PasswordModel.fetchRequest()
        let passwordModels = try? viewContext.fetch(request)
        
        guard let passwordModels = passwordModels else { return nil }
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return nil }
        
        var output: [String] = []
        for passwordModel in passwordModels {
            
            let objectKey = Array(passwordModel.key!).map({ Int8(bitPattern: $0) })
            let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
            
            guard let title = try? Kuznyechik(key: decryptedKey).decrypt(data: passwordModel.title!) else { return nil }
            
            if passwordModel.bitStrength < 36 {
                output.append(title)
            }
        }
        
        if output.isEmpty {
            return nil
        }
        return output
    }
    
    func getTitle(for object: PasswordModel) -> String {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return "N/A" }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
                
        guard let title = try? Kuznyechik(key: decryptedKey).decrypt(data: object.title!) else { return "N/A" }
    
        return title
    }
    
    func getLogin(for object: PasswordModel) -> String {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return "N/A" }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
                
        guard let login = try? Kuznyechik(key: decryptedKey).decrypt(data: object.login!) else { return "N/A" }
    
        return login
    }
    
    func getPassword(for object: PasswordModel) -> String {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return "N/A" }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
                
        guard let password = try? Kuznyechik(key: decryptedKey).decrypt(data: object.password!) else { return "N/A" }
    
        return password
    }
    
    func getAdditionalInformation(for object: PasswordModel) -> String {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return "N/A" }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
                
        guard let additionalInformation = try? Kuznyechik(key: decryptedKey).decrypt(data: object.additionalInformation!) else { return "N/A" }
    
        return additionalInformation
    }
    
    func createPasswordModel(title: String, login: String, password: String, uuid: String? = nil, expirationDate: Date? = nil, bitStrength: Int) {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return }
        
        let randomKey = masterKuznyechik.generateRandomKey()
        let encryptedKey = masterKuznyechik.encrypt(key: randomKey)
        let kuznyechik = Kuznyechik(key: randomKey)
        
        let passwordModel = PasswordModel(context: viewContext)
        passwordModel.title = kuznyechik.encrypt(string: title)
        passwordModel.login = kuznyechik.encrypt(string: login)
        passwordModel.password = kuznyechik.encrypt(string: password)
        passwordModel.uuid = uuid
        passwordModel.expirationDate = expirationDate
        passwordModel.bitStrength = Int32(bitStrength)
        passwordModel.key = Data(bytes: encryptedKey, count: encryptedKey.count)
        
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
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return }
        
        if let uuid = object.uuid {
            let userNotificationsManager = UserNotificationsManager()
            userNotificationsManager.updateNotificationBody(withUUID: uuid, newBody: "Your ".localized() + title + " password has expired!".localized())
        }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
        
        object.title = Kuznyechik(key: decryptedKey).encrypt(string: title)
        try? viewContext.save()
    }
    
    func updateLogin(for object: PasswordModel, login: String) {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
        
        object.login = Kuznyechik(key: decryptedKey).encrypt(string: login)
        try? viewContext.save()
    }
    
    func updatePassword(for object: PasswordModel, password: String) {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return }
    
        updateBitStrength(for: object, bitStrength: WeaknessChecker.check(password: password).1)
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
        
        object.password = Kuznyechik(key: decryptedKey).encrypt(string: password)
        try? viewContext.save()
    }
    
    func updateAdditionalInformation(for object: PasswordModel, information: String) {
        
        guard let masterKuznyechik = DataStoreManager.masterKuznyechik else { return }
        
        let objectKey = Array(object.key!).map({ Int8(bitPattern: $0) })
        let decryptedKey = masterKuznyechik.decrypt(key: objectKey)
        
        object.additionalInformation = Kuznyechik(key: decryptedKey).encrypt(string: information)
        try? viewContext.save()
    }
    
    func updateExpirationDate(for object: PasswordModel, expirationDate: Date) {
        object.expirationDate = expirationDate
        try? viewContext.save()
    }
    
    private func updateBitStrength(for object: PasswordModel, bitStrength: Int) {
        object.bitStrength = Int32(bitStrength)
        try? viewContext.save()
    }
}

extension DataStoreManager: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
