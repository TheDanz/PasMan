import Foundation

protocol ReloadDataDelegate {
    func reloadData()
}

protocol DeletePasswordModelDelegate {
    func deletePasswordModel(at indexPath: IndexPath)
}
