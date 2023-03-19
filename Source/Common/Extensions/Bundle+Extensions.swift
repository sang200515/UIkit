//
//  Bundle+Extensions.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 09/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

public extension Bundle {
    static var versionNumber: String {
        return (main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "1.0.0") as! String
    }

    static var buildNumber: String {
        return (main.object(forInfoDictionaryKey: "CFBundleVersion") ?? "1") as! String
    }
}
