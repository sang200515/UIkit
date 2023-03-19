//
//  ThongTinThuHo.swift
//  mPOS
//
//  Created by tan on 9/4/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import SwiftyJSON
class ThongTinThuHo: NSObject {
    var soMpos:String
    var nhaThuocString:String
    var nhaThuocCode:String
    var nvNopTienString:String
    var nvNopTienCode:String
    
    var sotien:Int
    var sotienString:String
    var noiDung:String
    var sophieucrm:String
    var sdtNhanVien:String
    var diaChiNhaThuoc:String
    var billID:String
 init(soMpos:String,nhaThuoc:String,nvNopTien:String,sotien:Int,noiDung:String,nhaThuocCode:String,nvNopTienCode:String,sotienString:String,sophieucrm:String,sdtNhanVien:String,diaChiNhaThuoc:String,billID:String){
        self.soMpos = soMpos
        self.nhaThuocString = nhaThuoc
        self.nvNopTienString = nvNopTien
        self.sotien = sotien
        self.noiDung = noiDung
        self.nhaThuocCode = nhaThuocCode
        self.nvNopTienCode = nvNopTienCode
        self.sotienString = sotienString
        self.sophieucrm = sophieucrm
        self.sdtNhanVien = sdtNhanVien
        self.diaChiNhaThuoc = diaChiNhaThuoc
        self.billID = billID
    }
}
