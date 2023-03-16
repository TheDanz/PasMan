import UIKit
import Foundation

protocol ReloadDataDelegate {
    func reloadData()
}

protocol DeletePasswordModelDelegate {
    func deletePasswordModel(at indexPath: IndexPath)
}

protocol ReloadRowsDelegate {
    func reloadRows(indexPath: [IndexPath], animation: UITableView.RowAnimation)
}
