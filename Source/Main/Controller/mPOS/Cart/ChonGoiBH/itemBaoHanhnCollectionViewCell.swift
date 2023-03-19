

//  cell.swift
//  fptshop
//
//  Created by Sang Truong on 3/7/22.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class itemBaoHanhnCollectionViewCell: UICollectionViewCell {
    
    private var viewBounds:UIView = {
        let view = UIView()
        return view
    }()
    private var image:UIImageView = {
        let view = UIImageView()
        return view
    }()
    var imageCheck:UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 1
        view.layer.masksToBounds = true
        view.image = UIImage(named: "check-2")
        return view
    }()
    
    private var lbltitle:UILabel = {
        let view = UILabel()
        //        view.textColor = UIColor(netHex: #dc5666).cgColo
        view.textColor = .red
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textAlignment = .center
        view.sizeToFit()
        view.numberOfLines = 0
        view.lineBreakMode = .byWordWrapping
        return view
    }()
    private var lblSku:UILabel = {
        let view = UILabel()
        view.textColor = .blue
        view.font = UIFont.boldSystemFont(ofSize: 15)
        return view
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupCell(dataMaSp: String,dataNameSP:String,brand:String) {
        contentView.backgroundColor = .white
        contentView.addSubview(viewBounds)
        viewBounds.addSubview(image)
        viewBounds.addSubview(imageCheck)
        viewBounds.addSubview(lblSku)
        viewBounds.addSubview(lbltitle)
        viewBounds.layer.cornerRadius = 5
        if brand == "1" {
            image.image = UIImage(named: "icbaohanh")
        }else {
            image.image = UIImage(named: "icBoltech")
        }
        viewBounds.backgroundColor = UIColor.init(red: 243, green: 239, blue: 239)
        viewBounds.snp.makeConstraints({(make) in
            make.width.height.equalTo(Common.heightWidthCLV)
            make.center.equalToSuperview()
        })
        image.snp.makeConstraints({(make) in
            make.width.height.equalTo(90)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(5)
        })
        imageCheck.snp.makeConstraints({(make) in
            make.width.height.equalTo(22)
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        })
        lbltitle.snp.makeConstraints({(make) in
            make.top.equalTo(image.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        })
        lblSku.snp.makeConstraints({(make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-5)
        })
        lblSku.text = "SKU: \(dataMaSp)"
        lbltitle.text =  "\(dataNameSP)"
    }

}
