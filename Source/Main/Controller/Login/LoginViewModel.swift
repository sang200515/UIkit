//
//  LoginViewModel.swift
//  fptshop
//
//  Created by Ngo Dang tan on 19/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
struct LoginViewModel {
    // MARK:- Properties
    
    private static var _manager = Config.manager
    
    // MARK: - Init
    
    init(){
        
    }
    // MARK: - Function
    
    func handleLogout(){
        loadCache(is_getaway: 1)
    }
    func loadCache(is_getaway:Int){
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "Username")
        defaults.set(nil, forKey: "password")
        defaults.set(nil, forKey: "CRMCode")
        defaults.synchronize()
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.goToLogin(is_getaway: is_getaway)
        })
    }
    func goToLogin(is_getaway: Int){
        let mainViewController = LoginViewController()
        UIApplication.shared.keyWindow?.rootViewController = mainViewController
    }
    
    
}
