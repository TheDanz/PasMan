import Foundation

final class WeaknessChecker {
    
    enum PasswordStrength {
        case veryWeak
        case weak
        case medium
        case high
        case veryHigh
    }
    
    static func check(password: String) -> PasswordStrength {
        
        let N = Set(password).count
        let L = password.count
        
        let bits = Double(L) * log2(Double(N))
                
        switch Int(bits) {
        case ..<28:
            return .veryWeak
        case 28...35:
            return .weak
        case 36...59:
            return .medium
        case 60...127:
            return .high
        case 128...:
            return .veryHigh
        default:
            return .weak
        }
    }
}
