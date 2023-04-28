import Foundation

class KeychainManager {
    
    enum KeychainError: Error {
        case unknown(OSStatus)
        case duplicateItem
    }
    
    static func save(_ value: Data, forTag tag: String) throws {
        
        let query: [String: AnyObject] = [kSecClass as String: kSecClassGenericPassword,
                                          kSecAttrAccount as String: tag as AnyObject,
                                          kSecValueData as String: value as AnyObject]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateItem
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
    }
    
    static func get(_ tag: String) throws -> Data? {
        
        let query: [String: AnyObject] = [kSecClass as String: kSecClassGenericPassword,
                                          kSecAttrAccount as String: tag as AnyObject,
                                          kSecReturnData as String: kCFBooleanTrue,
                                          kSecMatchLimit as String: kSecMatchLimitOne]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        return result as? Data
    }
    
    static func delete(_ tag: String) throws -> Bool {
        
        let query: [String: AnyObject] = [kSecClass as String: kSecClassGenericPassword,
                                          kSecAttrAccount as String: tag as AnyObject]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeychainError.unknown(status)
        }
        
        return status == noErr
    }
}
