import Foundation

final class WeaknessPasswordChecker {
    
    enum PasswordStrength {
        case veryWeak
        case weak
        case medium
        case high
        case veryHigh
    }

    func getStrengthFrom(password: String) -> (strength: PasswordStrength, bits: Int) {
        
        if let weakPasswords = getWeakPasswords() {
            if weakPasswords.contains(password) {
                return (.veryWeak, 0)
            }
        }
        
        let bits = getBitStrengthOf(password: password)
        
        switch bits {
        case ..<28:
            return (.veryWeak, bits)
        case 28...35:
            return (.weak, bits)
        case 36...59:
            return (.medium, bits)
        case 60...127:
            return (.high, bits)
        case 128...:
            return (.veryHigh, bits)
        default:
            return (.veryWeak, bits)
        }
    }
    
    private func getBitStrengthOf(password: String) -> Int {
        
        let N = Set(password).count
        let L = password.count
        var bits: Double = 0
        
        if N > 0 {
            bits = Double(L) * log2(Double(N))
        }
        
        return Int(bits)
    }
    
    private func getWeakPasswords() -> [String]? {
        
        guard let path = Bundle.main.path(forResource: "WeakPasswords", ofType: "txt") else { return nil }
        guard let text = try? String(contentsOfFile: path) else { return nil }
        
        let weakPasswords = text.components(separatedBy: "\n")
        return weakPasswords
    }
}
