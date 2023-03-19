//
//  BaoHanhLichSuGiaoNhanTableViewCell.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhLichSuGiaoNhanTableViewCell: UITableViewCell {
    
    var imageCheck: UIImageView!
    var cellKHGiao: UILabel!
    var cellTenPhuKien: UILabel!
    var cellLoai: UILabel!
    var cellNgay: UILabel!
    var cellKm: UILabel!
    var cellXem: UILabel!
    var cellSeriNo:UILabel!
     var cellSLNhan:UILabel!
    var viewContent:UIView!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellKHGiao = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 5 -  Common.Size(s:30), height: Common.Size(s:30) * 2))
        cellKHGiao.textAlignment = .center
        cellKHGiao.textColor = UIColor.black
        cellKHGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellKHGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellKHGiao.text = "STT"
        cellKHGiao.numberOfLines = 1;
        
        
        ///////lbtextNCC
        
        
        
        
        cellTenPhuKien = UILabel(frame: CGRect(x: cellKHGiao.frame.width, y: 0, width: UIScreen.main.bounds.size.width / 5 + Common.Size(s:30), height: Common.Size(s:30) * 2))
        cellTenPhuKien.textAlignment = .center
        cellTenPhuKien.textColor = UIColor.black
        cellTenPhuKien.backgroundColor = UIColor(netHex:0xffffff)
        
        cellTenPhuKien.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTenPhuKien.text = "Dia Diem"
        cellTenPhuKien.numberOfLines = 0;
        cellTenPhuKien.lineBreakMode = .byWordWrapping
        
        
        
        
        
        
        
        
        cellSeriNo = UILabel(frame: CGRect(x: cellTenPhuKien.frame.size.width + cellTenPhuKien.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5  , height: Common.Size(s:30) * 2))
        cellSeriNo.textAlignment = .center
        cellSeriNo.textColor = UIColor.black
        cellSeriNo.backgroundColor = UIColor(netHex:0xffffff)
        cellSeriNo.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSeriNo.text = "So Luong"
        cellSeriNo.numberOfLines = 0;
        cellSeriNo.lineBreakMode = .byWordWrapping
        
        
        cellSLNhan = UILabel(frame: CGRect(x: cellSeriNo.frame.size.width + cellSeriNo.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5  , height: Common.Size(s:30) * 2))
        cellSLNhan.textAlignment = .center
        cellSLNhan.textColor = UIColor.black
        cellSLNhan.backgroundColor = UIColor(netHex:0xffffff)
        cellSLNhan.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSLNhan.text = "So Luong"
        cellSLNhan.numberOfLines = 0;
        cellSLNhan.lineBreakMode = .byWordWrapping
        
        
        cellLoai = UILabel(frame: CGRect(x: cellSLNhan.frame.size.width + cellSLNhan.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5  , height: Common.Size(s:30) * 2))
        cellLoai.textAlignment = .center
        cellLoai.textColor = UIColor.black
        cellLoai.backgroundColor = UIColor(netHex:0xffffff)
        cellLoai.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellLoai.text = "Loai"
        cellLoai.numberOfLines = 0;
        cellLoai.lineBreakMode = .byWordWrapping
        
        cellNgay = UILabel(frame: CGRect(x: cellLoai.frame.size.width + cellLoai.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5  , height: Common.Size(s:30) * 2))
        cellNgay.textAlignment = .center
        cellNgay.textColor = UIColor.black
        cellNgay.backgroundColor = UIColor(netHex:0xffffff)
        cellNgay.font = UIFont.systemFont(ofSize: Common.Size(s:10))
        cellNgay.text = "cellLoai"
        cellNgay.numberOfLines = 0;
        cellNgay.lineBreakMode = .byWordWrapping
        
        cellXem = UILabel(frame: CGRect(x: cellNgay.frame.size.width + cellNgay.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5  , height: Common.Size(s:30) * 2))
        cellXem.textAlignment = .center
        cellXem.textColor = UIColor.black
        cellXem.backgroundColor = UIColor(netHex:0xffffff)
        cellXem.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellXem.text = "cellXem"
        cellXem.numberOfLines = 1;
        
        cellKm = UILabel(frame: CGRect(x: cellNgay.frame.size.width + cellNgay.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5  , height: Common.Size(s:30) * 2))
        cellKm.textAlignment = .center
        cellKm.textColor = UIColor.black
        cellKm.backgroundColor = UIColor(netHex:0xffffff)
        cellKm.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellKm.text = "cellKm"
        cellKm.numberOfLines = 1;
        
        
        
        
        
        contentView.addSubview(cellKHGiao)
        contentView.addSubview(cellTenPhuKien)
        contentView.addSubview(cellSeriNo)
        contentView.addSubview(cellLoai)
        contentView.addSubview(cellNgay)
        contentView.addSubview(cellKm)
        contentView.addSubview(cellSLNhan)
        
        
        //
        
        
        
        
        
    }
    
    
    
    /////change sl xog goi delegate cua table view
    
    
}


