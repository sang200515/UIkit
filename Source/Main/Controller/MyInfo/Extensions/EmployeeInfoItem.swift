//
//  EmployeeInfoItem.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

class EmployeeInfoElement: Codable {
    let employeeName, boPhan, ngayGanBo, tongThuNhap: String?
    let tongThuong, avatarImageLink: String?

    init(employeeName: String?, boPhan: String?, ngayGanBo: String?, tongThuNhap: String?, tongThuong: String?, avatarImageLink: String?) {
        self.employeeName = employeeName
        self.boPhan = boPhan
        self.ngayGanBo = ngayGanBo
        self.tongThuNhap = tongThuNhap
        self.tongThuong = tongThuong
        self.avatarImageLink = avatarImageLink
    }
}
