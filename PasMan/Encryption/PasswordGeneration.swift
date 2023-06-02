import Foundation

final class PasswordGeneration {
    
    enum CharacterSet: String {
        case upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz"
        case numbers = "0123456789"
        case specialCharacters = "!@#$%^&*()_+-=[]{}|;:<>,.?"
    }
    
    func generatePassword(length: Int, using: Set<CharacterSet>) -> String {
        
        if using.isEmpty {
            return "YOUR STRONG PASSWORD".localized()
        }
        
        var password = ""
        var characters: [Character] = []
        
        for set in using {
            characters.append(contentsOf: Array(set.rawValue))
        }
        
        for _ in 0..<length {
            
            var randomByte = UInt8()
            let status = SecRandomCopyBytes(kSecRandomDefault, 1, &randomByte)
            
            guard status == errSecSuccess else { return "YOUR STRONG PASSWORD".localized() }
            
            let index = Int(randomByte) % characters.count
            password += String(characters[index])
        }
        
        return password
    }
}
