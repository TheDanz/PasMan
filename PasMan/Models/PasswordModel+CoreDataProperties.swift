import Foundation
import CoreData


extension PasswordModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PasswordModel> {
        return NSFetchRequest<PasswordModel>(entityName: "PasswordModel")
    }

    @NSManaged public var additionalInformation: Data?
    @NSManaged public var login: Data?
    @NSManaged public var password: Data?
    @NSManaged public var title: String?

}

extension PasswordModel : Identifiable {

}
