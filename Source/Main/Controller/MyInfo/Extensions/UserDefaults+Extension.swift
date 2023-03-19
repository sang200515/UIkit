//
//  UserDefaults+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension UserDefaults{
    
    func setMyInfoToken(token : String?) {
        self.setValue(token, forKey: Constants.LocalKey.myinfo_token_key)
        self.synchronize()
    }
    
    func getMyInfoToken() -> String? {
        return self.value(forKey: Constants.LocalKey.myinfo_token_key) as? String
    }
    
    func setUsernameEmployee(username: String?) {
        self.setValue(username, forKey: Constants.LocalKey.username_login)
        self.synchronize()
    }
    
    func getUsernameEmployee() -> String? {
        return self.value(forKey: Constants.LocalKey.username_login) as? String
    }
    
    func setUserLogin(user: User?) {
        self.setValue(user, forKey: "User_login")
        self.synchronize()
    }
    
    func getUserLogin() -> User? {
        return self.value(forKey: "User_login") as? User
    }
    
    func setPhoneNumberUserLogin(_ phoneNumber: String?) {
        self.setValue(phoneNumber, forKey: "Phone_Number_User")
        self.synchronize()
    }
    
    func getPhoneNumberUserLogin() -> String? {
        return self.value(forKey: "Phone_Number_User") as? String
    }
    
    func setIsUpdateVersion(isUpdate: Int?) {
        self.setValue(isUpdate, forKey: "Is_Update_Version")
        self.synchronize()
    }
    
    func getIsUpdateVersion() -> Int? {
        return self.value(forKey: "Is_Update_Version") as? Int
    }
    
    func setIsUpdateVersionRoot(isUpdate: Bool?) {
        self.setValue(isUpdate, forKey: "is_update_version_root")
        self.synchronize()
    }
    
    func getIsUpdateVersionRoot() -> Bool? {
        return self.value(forKey: "is_update_version_root") as? Bool
    }
    
    func removeIsUpdateVersionRoot() {
        self.removeObject(forKey: "is_update_version_root")
        self.synchronize()
    }
    
    func setListUpdateApp(list: String?) {
        self.setValue(list, forKey: "list_feature_update")
        self.synchronize()
    }
    
    func getListUpdate() -> String? {
        return self.value(forKey: "list_feature_update") as? String
    }
    
    func removeListUpdateModule() {
        self.removeObject(forKey: "list_feature_update")
        self.synchronize()
    }
    
    func setUpdateDescription(_ description: String?) {
        self.setValue(description, forKey: "update_description_value")
        self.synchronize()
    }
    
    func getUpdateDescription() -> String? {
        return self.value(forKey: "update_description_value") as? String
    }
    
    func removeGetUpdateDescription() {
        self.removeObject(forKey: "update_description_value")
        self.synchronize()
    }
}
