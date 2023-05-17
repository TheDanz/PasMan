import UIKit

extension UIView {
    func setScreenCaptureProtection() {
        DispatchQueue.main.async {
            let field = UITextField()
            field.isSecureTextEntry = true
            self.addSubview(field)
            self.layer.superlayer?.addSublayer(field.layer)
            field.layer.sublayers?.first?.addSublayer(self.layer)
        }
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

extension String {
   func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
       return NSLocalizedString(self, tableName: tableName, value: self, comment: "")
   }
}
