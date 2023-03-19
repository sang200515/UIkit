//
//  BaoHanhChiTietPhieuTableViewCell.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhChiTietPhieuTableViewCell: UITableViewCell {
    
    
    var imageCheck: UIImageView!
    var cellKHGiao: UILabel!
    var cellTenPhuKien: UILabel!
    
    var cellSeriNo:UILabel!
    
    var viewContent:UIView!
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellKHGiao = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3 , height: Common.Size(s:30)))
        cellKHGiao.textAlignment = .center
        cellKHGiao.textColor = UIColor.black
        cellKHGiao.backgroundColor = UIColor(netHex:0xffffff)
        cellKHGiao.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellKHGiao.text = "STT"
        cellKHGiao.numberOfLines = 1;
        
        
        ///////lbtextNCC
        
        
        
        
        cellTenPhuKien = UILabel(frame: CGRect(x: cellKHGiao.frame.width, y: 0, width: UIScreen.main.bounds.size.width / 3, height: Common.Size(s:30)))
        cellTenPhuKien.textAlignment = .center
        cellTenPhuKien.textColor = UIColor.black
        cellTenPhuKien.backgroundColor = UIColor(netHex:0xffffff)
        
        cellTenPhuKien.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTenPhuKien.text = ""
        cellTenPhuKien.numberOfLines = 6;
        
        
        
        
        
        
        
        
        cellSeriNo = UILabel(frame: CGRect(x: cellTenPhuKien.frame.size.width + cellTenPhuKien.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width - (cellKHGiao.frame.size.width + cellTenPhuKien.frame.size.width ) , height: Common.Size(s:30)))
        cellSeriNo.textAlignment = .center
        cellSeriNo.textColor = UIColor.black
        cellSeriNo.backgroundColor = UIColor(netHex:0xffffff)
        cellSeriNo.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSeriNo.text = "Serial No"
        cellSeriNo.numberOfLines = 1;
        
        
        
        
        
        
        
        
        
        
        contentView.addSubview(cellKHGiao)
        contentView.addSubview(cellTenPhuKien)
        contentView.addSubview(cellSeriNo)
        
        
        
        
        //
        
        
        
        
        
    }
    
    
    
    /////change sl xog goi delegate cua table view
    
    
}

