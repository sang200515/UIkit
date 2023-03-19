//
//  ReportDataCollectionViewCell.swift
//  mSM
//
//  Created by Trần Thành Phương Đăng on 6/25/18.
//  Copyright © 2018 FPT. All rights reserved.
//

import UIKit

class ReportDataCollectionViewCell: UICollectionViewCell {

    @IBOutlet var title: UILabel!;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupLeftRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        title.textColor = .red
        //        title.sizeToFit()
        addSubview(title)
        
    }
    
    func setupBold(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
    }
    func setupRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.textColor = .red
        title.numberOfLines = 0
        addSubview(title)
    }
    func setupName(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center;
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupLink(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        //        title.text = item
        
        //        title.sizeToFit()
        
        let textRange = NSMakeRange(0, item.count)
        let attributedText = NSMutableAttributedString(string: item)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        // Add other attributes if needed
        title.attributedText = attributedText
        title.numberOfLines = 0
        title.textColor = .blue
        addSubview(title)
        
    }
    
    func setupNameLeft(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s: 3), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
        
    }
    
    func setupNameBold(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: Common.Size(s: 3), y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .left
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupNameRed(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        title.textColor = .red
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupPrice(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - 10, height: self.frame.size.height))
        title.textAlignment = .right
        title.font = UIFont.systemFont(ofSize: 10)
        title.text = "\(item)"
        title.numberOfLines = 0
        //        title.sizeToFit()
        addSubview(title)
        
    }
    func setupHeader(item:String){
        self.subviews.forEach { $0.removeFromSuperview() }
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        title.textAlignment = .center
        title.font = UIFont.boldSystemFont(ofSize: 10)
        title.text = item
        title.numberOfLines = 0
        addSubview(title)
        
    }
}
