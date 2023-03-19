//
//  ItemTabThongKeTableViewCell.swift
//  NewmDelivery
//
//  Created by sumi on 4/27/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class ItemTabThongKeTableViewCell: UITableViewCell {

    var cellTenSP: UILabel!
    var cellSLPO: UILabel!
    var cellDVT: UILabel!
    var cellSLNhap: UILabel!
    var viewContent:UIView!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor(netHex:0xd5eef1)
        
        
        cellTenSP = UILabel(frame: CGRect(x: 0, y: 1, width: UIScreen.main.bounds.size.width / 4 , height: Common.Size(s: 16) + 15))
        cellTenSP.textAlignment = .center
        cellTenSP.textColor = UIColor.black
        cellTenSP.backgroundColor = UIColor(netHex:0xffffff)
        cellTenSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        cellTenSP.text = "Tên Sản Phẩm"
        cellTenSP.numberOfLines = 1;
        
        
        
        cellSLPO = UILabel(frame: CGRect(x: cellTenSP.frame.size.width + 1, y: 1, width: UIScreen.main.bounds.size.width / 4 , height: Common.Size(s: 16) + 15))
        cellSLPO.textAlignment = .center
        cellSLPO.textColor = UIColor.black
        cellSLPO.backgroundColor = UIColor(netHex:0xffffff)
        cellSLPO.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        cellSLPO.text = "SL PO"
        cellSLPO.numberOfLines = 1;
        
        
        cellDVT = UILabel(frame: CGRect(x: cellSLPO.frame.origin.x + cellSLPO.frame.size.width, y: 1, width: UIScreen.main.bounds.size.width / 4 - 1, height: Common.Size(s: 16) + 15))
        cellDVT.textAlignment = .center
        cellDVT.textColor = UIColor.black
        cellDVT.backgroundColor = UIColor(netHex:0xffffff)
        cellDVT.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 12))
        cellDVT.text = "ĐVT"
        cellDVT.numberOfLines = 1;
        
        
        
        
        cellSLNhap = UILabel(frame: CGRect(x: cellDVT.frame.origin.x + cellSLPO.frame.size.width, y: 1, width: UIScreen.main.bounds.size.width / 4, height: Common.Size(s: 16) + 15))
        cellSLNhap.textAlignment = .center
        cellSLNhap.textColor = UIColor.black
        cellSLNhap.backgroundColor = UIColor(netHex:0xffffff)
        cellSLNhap.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        cellSLNhap.text = "ĐVT"
        cellSLNhap.numberOfLines = 1;

        contentView.addSubview(cellTenSP)
        contentView.addSubview(cellSLPO)
        contentView.addSubview(cellDVT)
        contentView.addSubview(cellSLNhap)
    }
}
