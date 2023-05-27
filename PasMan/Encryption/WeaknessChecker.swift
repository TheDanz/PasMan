import Foundation

final class WeaknessChecker {
    
    enum PasswordStrength {
        case veryWeak
        case weak
        case medium
        case high
        case veryHigh
    }
    
    static func check(password: String) -> (PasswordStrength, Int) {
        
        let N = Set(password).count
        let L = password.count
        var bits: Double = 0
        
        if N > 0 {
            bits = Double(L) * log2(Double(N))
        }
        
        return (WeaknessChecker.getStrengthFrom(bits: Int(bits)), Int(bits))
    }

    static func getStrengthFrom(bits: Int) -> PasswordStrength {
        
        switch bits {
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
