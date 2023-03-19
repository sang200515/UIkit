//
//  BaoHanhChiTietPhieuHangTableViewCell.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class BaoHanhChiTietPhieuHangTableViewCell: UITableViewCell {
    
    
    var imageCheck: UIImageView!
    var cellSoPhieuBH: UILabel!
    var cellTenSanPham: UILabel!
    
    var cellImei:UILabel!
    
    var viewContent:UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellSoPhieuBH = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width / 3 , height: Common.Size(s:30)))
        cellSoPhieuBH.textAlignment = .center
        cellSoPhieuBH.textColor = UIColor.black
        cellSoPhieuBH.backgroundColor = UIColor(netHex:0xffffff)
        cellSoPhieuBH.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellSoPhieuBH.text = "STT"
        cellSoPhieuBH.numberOfLines = 1;
        
        
        ///////lbtextNCC
        
        
        
        
        cellTenSanPham = UILabel(frame: CGRect(x: cellSoPhieuBH.frame.width, y: 0, width: UIScreen.main.bounds.size.width / 3, height: Common.Size(s:30)))
        cellTenSanPham.textAlignment = .center
        cellTenSanPham.textColor = UIColor.black
        cellTenSanPham.backgroundColor = UIColor(netHex:0xffffff)
        
        cellTenSanPham.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellTenSanPham.text = ""
        cellTenSanPham.numberOfLines = 1;
        
        
        
        
        
        
        
        
        cellImei = UILabel(frame: CGRect(x: cellTenSanPham.frame.size.width + cellTenSanPham.frame.origin.x , y: 0, width: UIScreen.main.bounds.size.width - (cellSoPhieuBH.frame.size.width + cellTenSanPham.frame.size.width ) , height: Common.Size(s:30)))
        cellImei.textAlignment = .center
        cellImei.textColor = UIColor.black
        cellImei.backgroundColor = UIColor(netHex:0xffffff)
        cellImei.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        cellImei.text = "Imei"
        cellImei.numberOfLines = 1;
        
        
        
        
        
        
        
        
        
        
        contentView.addSubview(cellSoPhieuBH)
        contentView.addSubview(cellTenSanPham)
        contentView.addSubview(cellImei)
        
        
        
        
        //
        
        
    }
    
}

