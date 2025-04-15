import UIKit

extension UIView {
    func setScreenCaptureProtection() {
        let secureTextField = UITextField()
        let secureView: UIView = secureTextField.subviews.first {
            NSStringFromClass(type(of: $0)).contains("LayoutCanvasView")
        }!
        let originalLayer = secureView.layer
        secureView.setValue(self.layer, forKey: "layer")
        secureTextField.isSecureTextEntry = false
        secureTextField.isSecureTextEntry = true
        secureView.setValue(originalLayer, forKey: "layer")
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

extension StringProtocol {
    var hexaData: Data { .init(hexa) }
    var hexaBytes: [UInt8] { .init(hexa) }
    private var hexa: UnfoldSequence<UInt8, Index> {
        sequence(state: startIndex) { startIndex in
            guard startIndex < self.endIndex else { return nil }
            let endIndex = self.index(startIndex, offsetBy: 2, limitedBy: self.endIndex) ?? self.endIndex
            defer { startIndex = endIndex }
            return UInt8(self[startIndex..<endIndex], radix: 16)
        }
    }
}
