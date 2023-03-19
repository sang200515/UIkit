//
//  TermInstallLaptopCell.swift
//  fptshop
//
//  Created by Ngo Dang tan on 18/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import WebKit
import Foundation
import DLRadioButton
protocol TermInstallLaptopCellDelegate: AnyObject {
    func handleTerm(_ id: Int)
}
class TermInstallLaptopCell: UITableViewCell {
    
    // MARK: - Properties
    var itemDataInstallLaptop: ItemDataInstallLaptop? {
        didSet {
            configure()
        }
    }
    
    var config: DataInstallLaptopConfiguration!

    

    
    private var radCheck: DLRadioButton = {
        let rad = DLRadioButton()
        rad.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16))
        rad.setTitle("", for: UIControl.State())
        rad.setTitleColor(.black, for: UIControl.State())
        rad.iconColor = .black
        rad.isIconSquare = true
        rad.indicatorColor = .black
        rad.titleLabel?.numberOfLines = 0
        rad.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
     
        return rad
    }()
    
    private var label: WKWebView = {
        let webview = WKWebView()
       
        return webview
    }()
    
    var estimateCellHeight: CGFloat = 0
    // MARK: - Lifecycle
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        addSubview(radCheck)
        addSubview(label)
        radCheck.frame = CGRect(x: 0, y: 10, width: 20, height: 20)
        
        
        label.frame = CGRect(x: radCheck.frame.size.width + radCheck.frame.origin.x, y: 0, width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
   
    
    // MARK: - Helpers
    func configure(){
        guard let item = itemDataInstallLaptop else {return}
        if item.isSelected {
            radCheck.isSelected = true
        }else {
            radCheck.isSelected = false
        }
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        self.label.loadHTMLString(headerString + item.name, baseURL: nil)
        label.scrollView.isScrollEnabled = false
    
        label.frame = CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.width, height: contentView.frame.size.height)
//        estimateCellHeight = label.frame.origin.y + label.frame.height + Common.Size(s: 5)
    }
    
    
}
