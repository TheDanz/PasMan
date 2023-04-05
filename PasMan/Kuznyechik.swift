import Foundation

final class Kuznyechik {
    
    private let lVector: [Int8] = [
        0x01, 0x94, 0x20, 0x85, 0x10, 0xC2, 0xC0, 0x01, 0xFB, 0x01, 0xC0, 0xC2, 0x10, 0x85, 0x20, 0x94
    ].map { Int8(bitPattern: $0) }
        
    private let Pi: [Int8] = [
        0xFC, 0xEE, 0xDD, 0x11, 0xCF, 0x6E, 0x31, 0x16, 0xFB, 0xC4, 0xFA, 0xDA, 0x23, 0xC5, 0x04, 0x4D,
        0xE9, 0x77, 0xF0, 0xDB, 0x93, 0x2E, 0x99, 0xBA, 0x17, 0x36, 0xF1, 0xBB, 0x14, 0xCD, 0x5F, 0xC1,
        0xF9, 0x18, 0x65, 0x5A, 0xE2, 0x5C, 0xEF, 0x21, 0x81, 0x1C, 0x3C, 0x42, 0x8B, 0x01, 0x8E, 0x4F,
        0x05, 0x84, 0x02, 0xAE, 0xE3, 0x6A, 0x8F, 0xA0, 0x06, 0x0B, 0xED, 0x98, 0x7F, 0xD4, 0xD3, 0x1F,
        0xEB, 0x34, 0x2C, 0x51, 0xEA, 0xC8, 0x48, 0xAB, 0xF2, 0x2A, 0x68, 0xA2, 0xFD, 0x3A, 0xCE, 0xCC,
        0xB5, 0x70, 0x0E, 0x56, 0x08, 0x0C, 0x76, 0x12, 0xBF, 0x72, 0x13, 0x47, 0x9C, 0xB7, 0x5D, 0x87,
        0x15, 0xA1, 0x96, 0x29, 0x10, 0x7B, 0x9A, 0xC7, 0xF3, 0x91, 0x78, 0x6F, 0x9D, 0x9E, 0xB2, 0xB1,
        0x32, 0x75, 0x19, 0x3D, 0xFF, 0x35, 0x8A, 0x7E, 0x6D, 0x54, 0xC6, 0x80, 0xC3, 0xBD, 0x0D, 0x57,
        0xDF, 0xF5, 0x24, 0xA9, 0x3E, 0xA8, 0x43, 0xC9, 0xD7, 0x79, 0xD6, 0xF6, 0x7C, 0x22, 0xB9, 0x03,
        0xE0, 0x0F, 0xEC, 0xDE, 0x7A, 0x94, 0xB0, 0xBC, 0xDC, 0xE8, 0x28, 0x50, 0x4E, 0x33, 0x0A, 0x4A,
        0xA7, 0x97, 0x60, 0x73, 0x1E, 0x00, 0x62, 0x44, 0x1A, 0xB8, 0x38, 0x82, 0x64, 0x9F, 0x26, 0x41,
        0xAD, 0x45, 0x46, 0x92, 0x27, 0x5E, 0x55, 0x2F, 0x8C, 0xA3, 0xA5, 0x7D, 0x69, 0xD5, 0x95, 0x3B,
        0x07, 0x58, 0xB3, 0x40, 0x86, 0xAC, 0x1D, 0xF7, 0x30, 0x37, 0x6B, 0xE4, 0x88, 0xD9, 0xE7, 0x89,
        0xE1, 0x1B, 0x83, 0x49, 0x4C, 0x3F, 0xF8, 0xFE, 0x8D, 0x53, 0xAA, 0x90, 0xCA, 0xD8, 0x85, 0x61,
        0x20, 0x71, 0x67, 0xA4, 0x2D, 0x2B, 0x09, 0x5B, 0xCB, 0x9B, 0x25, 0xD0, 0xBE, 0xE5, 0x6C, 0x52,
        0x59, 0xA6, 0x74, 0xD2, 0xE6, 0xF4, 0xB4, 0xC0, 0xD1, 0x66, 0xAF, 0xC2, 0x39, 0x4B, 0x63, 0xB6
    ].map { Int8(bitPattern: $0) }
    
    private let inversePi: [Int8] = [
        0xA5, 0x2D, 0x32, 0x8F, 0x0E, 0x30, 0x38, 0xC0, 0x54, 0xE6, 0x9E, 0x39, 0x55, 0x7E, 0x52, 0x91,
        0x64, 0x03, 0x57, 0x5A, 0x1C, 0x60, 0x07, 0x18, 0x21, 0x72, 0xA8, 0xD1, 0x29, 0xC6, 0xA4, 0x3F,
        0xE0, 0x27, 0x8D, 0x0C, 0x82, 0xEA, 0xAE, 0xB4, 0x9A, 0x63, 0x49, 0xE5, 0x42, 0xE4, 0x15, 0xB7,
        0xC8, 0x06, 0x70, 0x9D, 0x41, 0x75, 0x19, 0xC9, 0xAA, 0xFC, 0x4D, 0xBF, 0x2A, 0x73, 0x84, 0xD5,
        0xC3, 0xAF, 0x2B, 0x86, 0xA7, 0xB1, 0xB2, 0x5B, 0x46, 0xD3, 0x9F, 0xFD, 0xD4, 0x0F, 0x9C, 0x2F,
        0x9B, 0x43, 0xEF, 0xD9, 0x79, 0xB6, 0x53, 0x7F, 0xC1, 0xF0, 0x23, 0xE7, 0x25, 0x5E, 0xB5, 0x1E,
        0xA2, 0xDF, 0xA6, 0xFE, 0xAC, 0x22, 0xF9, 0xE2, 0x4A, 0xBC, 0x35, 0xCA, 0xEE, 0x78, 0x05, 0x6B,
        0x51, 0xE1, 0x59, 0xA3, 0xF2, 0x71, 0x56, 0x11, 0x6A, 0x89, 0x94, 0x65, 0x8C, 0xBB, 0x77, 0x3C,
        0x7B, 0x28, 0xAB, 0xD2, 0x31, 0xDE, 0xC4, 0x5F, 0xCC, 0xCF, 0x76, 0x2C, 0xB8, 0xD8, 0x2E, 0x36,
        0xDB, 0x69, 0xB3, 0x14, 0x95, 0xBE, 0x62, 0xA1, 0x3B, 0x16, 0x66, 0xE9, 0x5C, 0x6C, 0x6D, 0xAD,
        0x37, 0x61, 0x4B, 0xB9, 0xE3, 0xBA, 0xF1, 0xA0, 0x85, 0x83, 0xDA, 0x47, 0xC5, 0xB0, 0x33, 0xFA,
        0x96, 0x6F, 0x6E, 0xC2, 0xF6, 0x50, 0xFF, 0x5D, 0xA9, 0x8E, 0x17, 0x1B, 0x97, 0x7D, 0xEC, 0x58,
        0xF7, 0x1F, 0xFB, 0x7C, 0x09, 0x0D, 0x7A, 0x67, 0x45, 0x87, 0xDC, 0xE8, 0x4F, 0x1D, 0x4E, 0x04,
        0xEB, 0xF8, 0xF3, 0x3E, 0x3D, 0xBD, 0x8A, 0x88, 0xDD, 0xCD, 0x0B, 0x13, 0x98, 0x02, 0x93, 0x80,
        0x90, 0xD0, 0x24, 0x34, 0xCB, 0xED, 0xF4, 0xCE, 0x99, 0x10, 0x44, 0x40, 0x92, 0x3A, 0x01, 0x26,
        0x12, 0x1A, 0x48, 0x68, 0xF5, 0x81, 0x8B, 0xC7, 0xD6, 0x20, 0x0A, 0x08, 0x00, 0x4C, 0xD7, 0x74
     ].map { Int8(bitPattern: $0) }
    
    private var iterationСonstants: [[Int8]] = Array(repeating: Array(repeating: 0, count: 16) , count: 32)
    private var iterationKeys: [[Int8]] = Array(repeating: Array(repeating: 0, count: 64) , count: 10)
    
    private func X(_ first: [Int8], _ second: [Int8]) -> [Int8] {

        var output: [Int8] = Array(repeating: 0, count: 16)

        for i in 0..<16 {
            output[i] = first[i] ^ second[i]
        }

        return output
    }
    
    private func S(_ input: [Int8]) -> [Int8] {

        var output: [Int8] = Array(repeating: 0, count: 16)

        for i in 0..<16 {

            var index = Int(input[i])
            if index < 0 {
                index += 256
            }
            
            output[i] = Pi[index]
        }
        
        return output
    }
    
    private func inverseS(_ input: [Int8]) -> [Int8] {
        
        var output: [Int8] = Array(repeating: 0, count: 16)

        for i in 0..<16 {

            var index = Int(input[i])
            if index < 0 {
                index += 256
            }
            
            output[i] = inversePi[index]
        }
        
        return output
    }
    
    private func GFMultiplication(_ first: Int8, _ second: Int8) -> Int8 {
        
        var first = first
        var second = second
        var result = Int8()
        var bit = Int8()
          
        for _ in 0..<8 {
              
            if (second & 1) == 1 {
                result ^= first
            }
              
            bit = first & -128
            first <<= 1
              
            if bit < 0 {
                first ^= -61
            }
            
            second >>= 1
        }
          
        return result
    }
    
    private func R(_ input: [Int8]) -> [Int8] {
          
        var output: [Int8] = Array(repeating: 0, count: 16)
        var a15 = Int8()
          
        for i in stride(from: 15, through: 0, by: -1) {
              
            if i != 0 {
                output[i - 1] = input[i]
            }
            
            a15 ^= GFMultiplication(input[i], lVector[i])
        }
        
        output[15] = a15
        return output
    }
    
    private func inverseR(_ input: [Int8]) -> [Int8] {
        
        var output: [Int8] = Array(repeating: 0, count: 16)
        var a0 = input[15]
        
        for i in 1..<16 {
            
            output[i] = input[i - 1]
            a0 ^= GFMultiplication(output[i], lVector[i])
        }
        
        output[0] = a0
        return output
    }
      
    private func L(_ input: [Int8]) -> [Int8] {
        
        var output = input

        for _ in 0..<16 {
            output = R(output)
        }
        
        return output
    }
    
    private func inverseL(_ input: [Int8]) -> [Int8] {
        
        var output = input

        for _ in 0..<16 {
            output = inverseR(output)
        }

        return output
    }
    
    private func F(leftKey: [Int8], rightKey: [Int8], iterationConstant: [Int8]) -> [[Int8]] {
        
        var XSL = X(leftKey, iterationConstant)
        XSL = S(XSL)
        XSL = L(XSL)
        
        let outputLeftKey = X(XSL, rightKey)
        let outputRightKey = leftKey
        let outputKey = [outputLeftKey, outputRightKey]
        
        return outputKey
    }
    
    private func generateIterationConstants() {
        
        for i in 0..<32 {
            iterationСonstants[i][0] = Int8(i + 1)
        }
    
        for i in 0..<32 {
            iterationСonstants[i] = L(iterationСonstants[i])
        }
    }
    
    func generateIterationKeys(key: [Int8]) {
        
        generateIterationConstants()
        
        iterationKeys[0] = Array(key.prefix(16))
        iterationKeys[1] = key.suffix(16)
        
        var pairOfKeys = [iterationKeys[0], iterationKeys[1]]
         
        for i in 0..<4 {
            
            for j in 0..<8 {
                pairOfKeys = F(leftKey: pairOfKeys[0], rightKey: pairOfKeys[1], iterationConstant: iterationСonstants[j + 8 * i])
            }
            
            iterationKeys[2 * i + 2] = pairOfKeys[0]
            iterationKeys[2 * i + 3] = pairOfKeys[1]
        }
    }
    
    private func splitIntoBlocks(bytes: [Int8]) -> [[Int8]] {
        
        var bytes = bytes
        var blocks: [[Int8]] = []
        
        while bytes.count > 0 {
            
            let prefix = [Int8](bytes.prefix(16))
            blocks.append(prefix)
            
            let offsetBy = bytes.count >= 16 ? 16 : bytes.count
            let leftBound = bytes.startIndex
            let rightBound = bytes.index(bytes.startIndex, offsetBy: offsetBy)
            let range = leftBound..<rightBound
            bytes.removeSubrange(range)
        }
        
        return blocks
    }
    
    private func mergeIntoArray(blocks: [[Int8]]) -> [Int8] {
        
        var array = Array<Int8>()
        
        for block in blocks {
            for element in block {
                array.append(element)
            }
        }
        
        return array
    }
    
    private func encrypt(block: [Int8]) -> [Int8] {
        
        var output: [Int8] = block
        
        for i in 0..<9 {
            
            output = X(iterationKeys[i], output)
            output = S(output)
            output = L(output)
        }
        
        output = X(output, iterationKeys[9])
        return output
    }
    
    func encrypt(string: String) -> Data {
        
        let bytesToEncrypt = Array(string.utf8).map({ Int8(bitPattern: $0) })
        let blocksToEncrypt = splitIntoBlocks(bytes: bytesToEncrypt)
        
        var encryptedBlocks: [[Int8]] = []
        for block in blocksToEncrypt {
            encryptedBlocks.append(encrypt(block: block))
        }
        
        let encrtypedBytes = mergeIntoArray(blocks: encryptedBlocks)
        let encryptedData = Data(bytes: encrtypedBytes, count: encrtypedBytes.count)
        
        return encryptedData
    }
    
    private func decrypt(block: [Int8]) -> [Int8] {
        
        var output: [Int8] = block
        output  = X(output, iterationKeys[9])
        
        for i in stride(from: 8, through: 0, by: -1) {
            
            output = inverseL(output)
            output = inverseS(output)
            output = X(iterationKeys[i], output)
        }
        
        return output
    }

    func decrypt(data: Data) -> String {
        
        let bytesToDecrypt = Array(data).map({ Int8(bitPattern: $0) })
        let blocksToDecrypt = splitIntoBlocks(bytes: bytesToDecrypt)
        
        var decryptedBlocks: [[Int8]] = []
        for block in blocksToDecrypt {
            decryptedBlocks.append(decrypt(block: block))
        }
        
        let decrtypedBytes = mergeIntoArray(blocks: decryptedBlocks).map({ UInt8(bitPattern: $0) })
        let decryptedString = String(bytes: decrtypedBytes, encoding: .utf8)!
        
        return decryptedString
    }
}
