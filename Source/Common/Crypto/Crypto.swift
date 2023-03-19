//
//  Crypto.swift
//  sample01
//
//  Created by Nguyen Phuoc Loc on 8/9/17.
//  Copyright © 2017 Nguyen Phuoc Loc. All rights reserved.
//

import Foundation
import CommonCrypto

class Crypto {
    
    static func encrypt3DES(sourceData: Data, key: Data) -> Data{
        // var iv : [UInt8] = [56, 101, 63, 23, 96, 182, 209, 205]  // I didn't use
        let buffer_size : size_t = sourceData.count + kCCBlockSize3DES
        let buffer = UnsafeMutablePointer<NSData>.allocate(capacity: buffer_size)
        var num_bytes_encrypted : size_t = 0
        
        let operation: CCOperation = UInt32(kCCEncrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        let keyLength        = size_t(kCCKeySize3DES)
        
        var keyData: Data = Data(key)
        while keyData.count < keyLength {
            if (keyLength - keyData.count) >= key.count {
                keyData.append([UInt8](key), count: key.count)
            }
            else {
                keyData.append([UInt8](key), count: keyLength - keyData.count)
            }
        }
        
        let Crypto_status: CCCryptorStatus = CCCrypt(
            operation,
            algoritm,
            options,
            [UInt8](keyData),
            keyLength,
            nil,
            [UInt8](sourceData),
            sourceData.count,
            buffer,
            buffer_size,
            &num_bytes_encrypted)
        
        if UInt32(Crypto_status) == UInt32(kCCSuccess){
            
            let myResult: Data = NSData(bytes: buffer, length: num_bytes_encrypted) as Data
            
            free(buffer)
            
            return myResult
        }else{
            free(buffer)
            return "".data(using: String.Encoding.unicode)!
        }
    }
    
    
    static func decrypt3DES(encryptedData : Data, key: Data) -> Data{
        let mydata_len : Int = encryptedData.count
        let buffer_size : size_t = mydata_len+kCCBlockSizeAES128
        let buffer = UnsafeMutablePointer<NSData>.allocate(capacity: buffer_size)
        var num_bytes_encrypted : size_t = 0
        // var iv : [UInt8] = [56, 101, 63, 23, 96, 182, 209, 205]  // I didn't use
        let operation: CCOperation = UInt32(kCCDecrypt)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = UInt32(kCCOptionECBMode + kCCOptionPKCS7Padding)
        let keyLength        = size_t(kCCKeySize3DES)
        
        var keyData: Data = Data(key)
        while keyData.count < keyLength {
            if (keyLength - keyData.count) >= key.count {
                keyData.append([UInt8](key), count: key.count)
            }
            else {
                keyData.append([UInt8](key), count: keyLength - keyData.count)
            }
        }
        let decrypt_status : CCCryptorStatus = CCCrypt(
            operation,
            algoritm,
            options,
            [UInt8](keyData),
            keyLength,
            nil,
            [UInt8](encryptedData),
            mydata_len,
            buffer,
            buffer_size,
            &num_bytes_encrypted)
        
        if UInt32(decrypt_status) == UInt32(kCCSuccess){
            let myResult : Data = NSData(bytes: buffer, length: num_bytes_encrypted) as Data
            free(buffer)
            return myResult
        }else{
            free(buffer)
            return "".data(using: String.Encoding.unicode)!
        }
    }
    
    static func md5(data:String) -> Data {
        var messageData = data.data(using:.unicode)!
        // remove first 2 bytes which not used
        if messageData.count > 2 {
            messageData.removeFirst(2)
        }
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        return digestData as Data
    }
}

