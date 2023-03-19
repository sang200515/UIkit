//
//  Jsonable.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 08/11/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import SwiftyJSON;

protocol Jsonable {
    init?(json: JSON);
}
