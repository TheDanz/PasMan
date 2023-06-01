import Foundation
import CoreData


extension PasswordModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PasswordModel> {
        return NSFetchRequest<PasswordModel>(entityName: "PasswordModel")
    }

    @NSManaged public var additionalInformation: Data?
    @NSManaged public var bitStrength: Int32
    @NSManaged public var expirationDate: Date?
    @NSManaged public var key: Data?
    @NSManaged public var login: Data?
    @NSManaged public var password: Data?
    @NSManaged public var title: Data?
    @NSManaged public var uuid: String?
}

extension PasswordModel : Identifiable {

}
