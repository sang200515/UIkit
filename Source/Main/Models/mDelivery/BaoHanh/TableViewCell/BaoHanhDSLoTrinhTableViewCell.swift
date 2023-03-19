//
//  BaoHanhDSLoTrinhTableViewCell.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhDSLoTrinhTableViewCell: UITableViewCell {
    
    var imageCheck: UIImageView!
    var cellKHGiao: UILabel!
    var cellTenPhuKien: UILabel!
    
    
    var cellSLGiao:UILabel!
    var cellSLNhan:UILabel!
    
    var cellSeriNo:UILabel!
    var cellCheckin:UILabel!
    var viewContent:UIView!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellKHGiao = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 4 - 20 , height: Common.Size(s:30) * 2))
        cellKHGiao.textAlignment = .center
        cellKHGiao.textColor = UIColor.black
        
        cellKHGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellKHGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellKHGiao.text = "STT"
        cellKHGiao.numberOfLines = 1;
        cellKHGiao.layer.borderWidth = 0.25
        
        
        ///////lbtextNCC
        
        
        
        
        cellTenPhuKien = UILabel(frame: CGRect(x: cellKHGiao.frame.width , y: 0, width: UIScreen.main.bounds.size.width / 4 + 20, height: Common.Size(s:30) * 2))
        cellTenPhuKien.textAlignment = .center
        cellTenPhuKien.textColor = UIColor.black
        cellTenPhuKien.backgroundColor = UIColor(netHex:0xffffff)
        
        cellTenPhuKien.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTenPhuKien.text = ""
        cellTenPhuKien.numberOfLines = 0;
        cellTenPhuKien.lineBreakMode = .byWordWrapping
        cellTenPhuKien.layer.borderWidth = 0.25
        
        
        cellSLGiao = UILabel(frame: CGRect(x: cellTenPhuKien.frame.width + cellTenPhuKien.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5, height: Common.Size(s:30) * 2))
        cellSLGiao.textAlignment = .center
        cellSLGiao.textColor = UIColor.black
        cellSLGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellSLGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSLGiao.text = ""
        cellSLGiao.numberOfLines = 0;
        cellSLGiao.lineBreakMode = .byWordWrapping
        cellSLGiao.layer.borderWidth = 0.25
        
        
        cellSLNhan = UILabel(frame: CGRect(x: cellSLGiao.frame.width + cellSLGiao.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 5, height: Common.Size(s:30) * 2))
        cellSLNhan.textAlignment = .center
        cellSLNhan.textColor = UIColor.black
        cellSLNhan.backgroundColor = UIColor(netHex:0xffffff)
        cellSLNhan.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSLNhan.text = ""
        cellSLNhan.numberOfLines = 0;
        cellSLNhan.lineBreakMode = .byWordWrapping
        cellSLNhan.layer.borderWidth = 0.25
        
        
        
        cellSeriNo = UILabel(frame: CGRect(x: cellSLNhan.frame.size.width + cellSLNhan.frame.origin.x  , y: 0, width: UIScreen.main.bounds.size.width / 4, height: Common.Size(s:30) * 2))
        cellSeriNo.textAlignment = .center
        cellSeriNo.textColor = UIColor.black
        cellSeriNo.backgroundColor = UIColor(netHex:0xffffff)
        cellSeriNo.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSeriNo.text = "Serial No"
        cellSeriNo.numberOfLines = 1;
        cellSeriNo.layer.borderWidth = 0.25
        
        cellCheckin = UILabel(frame: CGRect(x: cellSeriNo.frame.size.width + cellSeriNo.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width / 4, height: Common.Size(s:30) * 2))
        cellCheckin.textAlignment = .center
        cellCheckin.textColor = UIColor.black
        cellCheckin.backgroundColor = UIColor(netHex:0xffffff)
        cellCheckin.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellCheckin.text = "cellCheckin"
        cellCheckin.numberOfLines = 1;
        cellCheckin.layer.borderWidth = 0.25
        
        
        
        
        
        
        contentView.addSubview(cellKHGiao)
        contentView.addSubview(cellTenPhuKien)
        contentView.addSubview(cellSeriNo)
        contentView.addSubview(cellCheckin)
        
        contentView.addSubview(cellSLNhan)
        contentView.addSubview(cellSLGiao)
        
        //
        
        
        
        
        
    }
    
    
    
    /////change sl xog goi delegate cua table view
    
    
}


