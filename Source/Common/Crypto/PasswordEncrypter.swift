//
//  Encrypter.swift
//  sample01
//
//  Created by Nguyen Phuoc Loc on 8/9/17.
//  Copyright © 2017 Nguyen Phuoc Loc. All rights reserved.
//

import Foundation

class PasswordEncrypter {
    
    static let key = "!@#$%^&*()~_+|"
    
    static func encrypt(password : String) -> String {
        // Hash md5 key
        let keyMD5 = Crypto.md5(data: key)
        var sourceData : Data = password.data(using: String.Encoding.unicode)!
        // Remove first 2 bytes (255, 254)
        if  sourceData.count > 2 {
            sourceData.removeFirst(2)
        }
        // Encrypt data using TripleDes crypte
        let data3DES = Crypto.encrypt3DES(sourceData: sourceData, key: keyMD5)
        return (data3DES.base64EncodedString())
    }
    
    static func encrypt(password : String, withKey: String) -> String {
        // Hash md5 key
        let keyMD5 = Crypto.md5(data: withKey)
        var sourceData : Data = password.data(using: String.Encoding.unicode)!
        // Remove first 2 bytes (255, 254)
        if  sourceData.count > 2 {
            sourceData.removeFirst(2)
        }
        // Encrypt data using TripleDes crypte
        let data3DES = Crypto.encrypt3DES(sourceData: sourceData, key: keyMD5)
        return (data3DES.base64EncodedString())
    }
    
    
    static func decrypt(passwordEncrypted : String) -> String {
        // Hash key using MD5
        let keyMD5 = Crypto.md5(data: key)
        let encryptedData: Data = NSData(base64Encoded: passwordEncrypted,
                                         options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)! as Data
        
        // Decrypted data using TripleDes crypto
        var decryptedData = Crypto.decrypt3DES(encryptedData: encryptedData, key: keyMD5)
        // Insert first 2 bytes (255, 254)
        decryptedData.insert(254, at: 0)
        decryptedData.insert(255, at: 0)
        let decryptedString = NSString(data: decryptedData, encoding: String.Encoding.unicode.rawValue)! as String
        return decryptedString
    }
    
}

