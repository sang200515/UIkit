//
//  ReturnedData.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 09/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;

class Response<T>{
    var Error: String?;
    var Data: T?;
}
