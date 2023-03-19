//
//  ItemHistoryInstallRecordCell.swift
//  fptshop
//
//  Created by Ngo Dang tan on 11/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ItemHistoryInstallRecordCell: UITableViewCell {

   
    // MARK: - Properties
    var item: InstallationReceiptData? {
        didSet {
            configure()
        }
    }
    private var lbIMEI: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(netHex: 0x04AB6E)
        return label
    }()
    
    private var lbCreateDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        label.textColor = UIColor(netHex: 0xbababa)
        return label
    }()
    private var lbCustomerNameText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    private var lbSdtKHText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    private var lbProductText: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    private var lbNVText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    var estimateHeight:CGFloat = 0
    // MARR: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
      
  
        let viewItem = UIView(frame: CGRect(x: Common.Size(s: 20), y: Common.Size(s: 5), width: frame.size.width, height: Common.Size(s: 8)))
        viewItem.backgroundColor = UIColor(netHex: 0xFAFAFA)
        addSubview(viewItem)
        let width = viewItem.frame.width/3 + Common.Size(s: 13)
        
        
        lbIMEI.frame = CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: (viewItem.frame.width - Common.Size(s: 10))/2, height: Common.Size(s: 20))
 
        viewItem.addSubview(lbIMEI)
        
        lbCreateDate.frame = CGRect(x: lbIMEI.frame.origin.x + lbIMEI.frame.width, y: Common.Size(s: 5), width: lbIMEI.frame.width, height: Common.Size(s: 20))

        viewItem.addSubview(lbCreateDate)
        
        let line1 = UIView(frame: CGRect(x: Common.Size(s: 5), y: lbCreateDate.frame.origin.y + lbCreateDate.frame.height + Common.Size(s: 2), width: self.frame.width - Common.Size(s: 10), height: Common.Size(s: 0.6)))
        line1.backgroundColor = .lightGray
        viewItem.addSubview(line1)
        
        let lbCustomerName = UILabel(frame: CGRect(x: Common.Size(s: 5), y: line1.frame.origin.y + line1.frame.height + Common.Size(s: 2), width: viewItem.frame.width/3 + Common.Size(s: 13), height: Common.Size(s: 20)))
        lbCustomerName.text = "Tên KH:"
        lbCustomerName.font = UIFont.systemFont(ofSize: 14)
        lbCustomerName.textColor = UIColor(netHex: 0xbababa)
        viewItem.addSubview(lbCustomerName)
        
        lbCustomerNameText.frame = CGRect(x: lbCustomerName.frame.origin.x + lbCustomerName.frame.width, y: lbCustomerName.frame.origin.y, width: (viewItem.frame.width - Common.Size(s: 10)) - width, height: Common.Size(s: 20))

        viewItem.addSubview(lbCustomerNameText)
        
        let lbCustomerNameTextHeight: CGFloat = lbCustomerNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbCustomerNameText.optimalHeight + Common.Size(s: 5))
        lbCustomerNameText.numberOfLines = 0
        lbCustomerNameText.frame = CGRect(x: lbCustomerNameText.frame.origin.x, y: lbCustomerNameText.frame.origin.y, width: lbCustomerNameText.frame.width, height: lbCustomerNameTextHeight)
        
        
        let lbSdtKH = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbCustomerNameText.frame.origin.y + lbCustomerNameTextHeight, width: width, height: Common.Size(s: 20)))
        lbSdtKH.text = "Sđt khách hàng:"
        lbSdtKH.font = UIFont.systemFont(ofSize: 14)
        lbSdtKH.textColor = UIColor(netHex: 0xbababa)
        viewItem.addSubview(lbSdtKH)
        
        lbSdtKHText.frame = CGRect(x: lbSdtKH.frame.origin.x + lbSdtKH.frame.width, y: lbSdtKH.frame.origin.y, width: lbCustomerNameText.frame.width, height: Common.Size(s: 20))

        viewItem.addSubview(lbSdtKHText)
        
        let lbProduct = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbSdtKHText.frame.origin.y + lbSdtKHText.frame.height, width: width, height: Common.Size(s: 20)))
        lbProduct.text = "Tên SP:"
        lbProduct.font = UIFont.systemFont(ofSize: 14)
        lbProduct.textColor = UIColor(netHex: 0xbababa)
        viewItem.addSubview(lbProduct)
        
        lbProductText.frame = CGRect(x: lbProduct.frame.origin.x + lbProduct.frame.width, y: lbProduct.frame.origin.y, width: (viewItem.frame.width - Common.Size(s: 10)) - width, height: Common.Size(s: 20))
    
        viewItem.addSubview(lbProductText)
        
        let lbProductTextHeight: CGFloat = lbProductText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbProductText.optimalHeight + Common.Size(s: 5))
        lbProductText.numberOfLines = 0
        lbProductText.frame = CGRect(x: lbProductText.frame.origin.x, y: lbProductText.frame.origin.y, width: lbProductText.frame.width, height: lbProductTextHeight)
        
        let lbNV = UILabel(frame: CGRect(x: Common.Size(s: 5), y: lbProductText.frame.origin.y + lbProductText.frame.height, width: width, height: Common.Size(s: 20)))
        lbNV.text = "Nhân viên:"
        lbNV.font = UIFont.systemFont(ofSize: 14)
        lbNV.textColor = UIColor(netHex: 0xbababa)
        viewItem.addSubview(lbNV)
        
        lbNVText.frame = CGRect(x: lbNV.frame.origin.x + lbNV.frame.width, y: lbNV.frame.origin.y, width: (viewItem.frame.width - Common.Size(s: 10)) - width, height: Common.Size(s: 20))
    
        viewItem.addSubview(lbNVText)
        
        let lbNVTextHeight: CGFloat = lbNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbNVText.optimalHeight + Common.Size(s: 5))
        lbNVText.numberOfLines = 0
        lbNVText.frame = CGRect(x: lbNVText.frame.origin.x, y: lbNVText.frame.origin.y, width: lbNVText.frame.width, height: lbNVTextHeight)
        
        viewItem.frame.size.height = lbNVText.frame.origin .y + lbNVText.frame.height + Common.Size(s: 5)
        
        estimateHeight = viewItem.frame.origin.y + viewItem.frame.height + Common.Size(s: 10)
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configure(){
        guard let item = item else {return}
        lbIMEI.text = item.imei
        lbCreateDate.text = item.createDate
        lbCustomerNameText.text = item.custFullname
        lbSdtKHText.text = item.phoneNumber
        lbProductText.text = item.itemName
        lbNVText.text = item.updatedBy
        
        
    }
    
}
