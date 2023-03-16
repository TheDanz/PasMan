import Foundation
import CoreData


extension PasswordModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PasswordModel> {
        return NSFetchRequest<PasswordModel>(entityName: "PasswordModel")
    }

    @NSManaged public var login: String?
    @NSManaged public var password: String?
    @NSManaged public var title: String?
    @NSManaged public var additionalInformation: String?

}

extension PasswordModel : Identifiable {

}
