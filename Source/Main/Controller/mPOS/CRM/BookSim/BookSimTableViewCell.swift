//
//  BookSimTableViewCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BookSimTableViewCell: UITableViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var ngoaimangView: UIView!
    @IBOutlet weak var packageNameLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var disCountLabel: UILabel!
    @IBOutlet weak var phiGoiNgoaiMang: UILabel!
    @IBOutlet weak var stackPromotion: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var banchayIcon: UIImageView!
    
    let listCOdeBanchay = ["00751219","00751221","00722917","00726249"]
    let listCOdeBanchay1 = ["00751221","00751219"]
    let listCOdeKhuyenMai = ["00758319","00758318","00802266","00802408"]
        let listSimNormal:[String] = ["00833004", "00833005"]
        let listEsim:[String] = ["00802266", "00802408","00833018", "00833019"]
    var delegate: ItemGoiCuocV3TableViewCellDelegate?
    var so1:GoiCuocEcom?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    
    func setup(so:GoiCuocEcom){
        self.so1 = so
        banchayIcon.isHidden = !listCOdeBanchay.contains(so.Code)
        stackPromotion.removeFullyAllArrangedSubviews()
        packageNameLabel.textColor = .white
        packageNameLabel.text = so.Name
        if(so.Provider == "VietnamMobile"){
            topView.backgroundColor = UIColor(netHex: 0xFF6600)
        }
        if(so.Provider == "Vinaphone"){
            topView.backgroundColor = UIColor(netHex: 0x0099FF)
        }
        if(so.Provider == "Mobifone"){
            if so.Code == "00722917" || so.Code == "00726249" {
                topView.backgroundColor = UIColor(netHex: 0x3300CC)
                banchayIcon.isHidden = true
            }else {
                topView.backgroundColor = UIColor(netHex: 0x3300CC)
                for i in listCOdeBanchay1 {
                    if so.Code == i{
                        banchayIcon.isHidden = true
                    }
                }
                for i in listCOdeKhuyenMai {
                    if so.Code == i{
                        banchayIcon.isHidden = false
                        banchayIcon.image = UIImage(named: "ic_km_mobi")

                    }
                }
                for i in listSimNormal {
                    if so.Code == i{
                        banchayIcon.isHidden = false
                        banchayIcon.image = UIImage(named: "best_seller")

                    }
                }
                for i in listEsim {
                    if so.Code == i{
                        banchayIcon.isHidden = false
                        banchayIcon.image = UIImage(named: "best_seller")

                    }
                }
            }

        }
        if(so.Provider == "Viettel"){
            topView.backgroundColor = UIColor(netHex: 0x006666)
        }
        if(so.Provider == "Itelecom"){
            topView.backgroundColor = UIColor.red
        }
        dataLabel.text = "\(so.Data1Home) \(so.Data1HomeDes)"
        disCountLabel.text = "\(so.CallInsideHome) \(so.CallInsideHomeDes)"
        phiGoiNgoaiMang.text = "\(so.CallOutHome) \(so.CallOutsideHomeDes)"
        
        ngoaimangView.isHidden = so.CallOutHome == ""
        
        discountView.isHidden = so.CallInsideHome == ""
        
        let listString = so.NoteHome.components(separatedBy: ";")
         
        for value in listString {
            if value.trim() == "" {continue}
            let newview = UIView()
            newview.translatesAutoresizingMaskIntoConstraints = false
            newview.backgroundColor = .white
            let image = UIImageView.init(image: UIImage(named: "check-booksim"))
            image.contentMode = .scaleAspectFit
            image.translatesAutoresizingMaskIntoConstraints = false
            newview.addSubview(image)
            image.heightAnchor.constraint(equalToConstant: Common.Size(s:16)).isActive = true
            image.widthAnchor.constraint(equalToConstant: Common.Size(s:16)).isActive = true
            image.leadingAnchor.constraint(equalTo: newview.leadingAnchor, constant: 0).isActive = true
            image.centerYAnchor.constraint(equalTo: newview.centerYAnchor, constant: 0).isActive = true
            
            let newLabel = UILabel()
            newLabel.text = value.replacingOccurrences(of: "\r\n", with: "")
            newLabel.numberOfLines = 0
            newLabel.font = UIFont.systemFont(ofSize: 13)
            newLabel.translatesAutoresizingMaskIntoConstraints = false
            newview.addSubview(newLabel)
            newLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 3).isActive = true
            newLabel.trailingAnchor.constraint(equalTo: newview.trailingAnchor, constant: 0).isActive = true
            newLabel.topAnchor.constraint(equalTo: newview.topAnchor, constant: 0).isActive = true
            newLabel.bottomAnchor.constraint(equalTo: newview.bottomAnchor, constant: 0).isActive = true
            stackPromotion.addArrangedSubview(newview)
            stackPromotion.spacing = 3
        }
        priceLabel.text = "Giá: \(Common.convertCurrencyV2(value:  so.Price))"
        priceLabel.textColor = UIColor.red
        let tapXemChiTiet = UITapGestureRecognizer(target: self, action: #selector(tapXemChiTiet))
        detailLabel.isUserInteractionEnabled = true
        detailLabel.addGestureRecognizer(tapXemChiTiet)
    }
    
    @objc func tapXemChiTiet(){
        delegate?.tapXemChiTiet(goiCuocEcom: so1!)
    }
    
}
extension UIStackView {
    
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
    
}
