//
//  ItemVoucherCell.swift
//  fptshop
//
//  Created by Sang Trương on 24/08/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import DLRadioButton
protocol ItemVoucherCellDelegate {

    func tabClickView(voucher:VoucherNoPrice)
    func tabReloadViewRemoveVoucher(indexNum:Int)
}

class ItemVoucherCell: UITableViewCell {
    var radioCheck:DLRadioButton!
    var imgDelete:UIImageView!
    var lblIndex:UILabel!
    var estimateCellHeight: CGFloat = 0
    var delegate: ItemVoucherCellDelegate?
    var indexNum:Int = 0
    var lblNameVoucher:UILabel!
    var lblDateVoucher:UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
//        lblIndex.text = ""
        lblIndex.text = ""
        radioCheck.setTitle("", for: UIControl.State())
        lblNameVoucher.text = ""
        lblDateVoucher.text = ""
    }


    
    var so1:VoucherNoPrice?
    func setup(so:VoucherNoPrice,indexNum:Int,readOnly:Bool){
        self.backgroundColor = UIColor.white


        lblIndex = UILabel()
        lblIndex.textColor = UIColor.black
        lblIndex.numberOfLines = 0
        lblIndex.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lblIndex)

        radioCheck = DLRadioButton()
        radioCheck.titleLabel!.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))

        radioCheck.setTitleColor(UIColor.black, for: UIControl.State());
        radioCheck.iconColor = UIColor.black;
        radioCheck.isIconSquare = true
        radioCheck.indicatorColor = UIColor.black;
        radioCheck.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        contentView.addSubview(radioCheck)
        radioCheck.addTarget(self, action: #selector(ItemVoucherCell.logSelectedButtonGender), for: UIControl.Event.touchUpInside);

        imgDelete = UIImageView()
        imgDelete.image = #imageLiteral(resourceName: "delete_red")
        imgDelete.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(imgDelete)


        lblNameVoucher = UILabel()
        lblNameVoucher.textColor = UIColor.black
        lblNameVoucher.numberOfLines = 0
        lblNameVoucher.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lblNameVoucher)

        lblDateVoucher = UILabel()
        lblDateVoucher.textColor = UIColor.gray
        lblDateVoucher.numberOfLines = 0
        lblDateVoucher.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(lblDateVoucher)

        so1 = so
        self.indexNum = indexNum
        lblIndex.frame = CGRect(x: 0,y: Common.Size(s:10) , width: Common.Size(s: 20), height: Common.Size(s:15))
        lblIndex.text = "\(indexNum + 1)."

        radioCheck.frame = CGRect(x:lblIndex.frame.size.width + lblIndex.frame.origin.x + Common.Size(s:10),y: Common.Size(s:10) , width: Common.Size(s: 200), height: Common.Size(s:15))
        radioCheck.setTitle(so.VC_Code, for: UIControl.State())

        if(so.isSelected == true){
            radioCheck.isSelected = true
        }else{
            radioCheck.isSelected = false
        }

        imgDelete.frame = CGRect(x: radioCheck.frame.size.width + radioCheck.frame.origin.x ,y: Common.Size(s:10) , width: Common.Size(s: 20), height: Common.Size(s:15))
        let tapClick = UITapGestureRecognizer(target: self, action: #selector(ItemVoucherNoPriceTableViewCell.tabRemoveVoucher))
        imgDelete.isUserInteractionEnabled = true
        imgDelete.addGestureRecognizer(tapClick)


        lblNameVoucher.frame = CGRect(x:radioCheck.frame.origin.x,y: radioCheck.frame.size.height + radioCheck.frame.origin.y + Common.Size(s:10) , width: Common.Size(s: 200), height: Common.Size(s:15))
        lblNameVoucher.text = "\(so.VC_Name)"

        let lblNameVoucherValueHeight:CGFloat = lblNameVoucher.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblNameVoucher.optimalHeight

        lblNameVoucher.frame = CGRect(x: lblNameVoucher.frame.origin.x, y: lblNameVoucher.frame.origin.y, width: lblNameVoucher.frame.width, height: lblNameVoucherValueHeight)
        if(so.VC_Name == ""){
            lblNameVoucher.frame.size.height = 0
        }

        lblDateVoucher.frame = CGRect(x:radioCheck.frame.origin.x,y: lblNameVoucher.frame.size.height + lblNameVoucher.frame.origin.y + Common.Size(s:10) , width: Common.Size(s: 200), height: Common.Size(s:15))
        lblDateVoucher.text = "\(so.Endate)"
        if(so.Endate == ""){
            lblDateVoucher.frame.size.height = 0
        }

        if(readOnly == true){
            imgDelete.isUserInteractionEnabled = false
            radioCheck.isUserInteractionEnabled = false
        }
        self.estimateCellHeight = lblDateVoucher.frame.origin.y + lblDateVoucher.frame.height + Common.Size(s: 15)

    }
    @objc func tabRemoveVoucher(){
        delegate?.tabReloadViewRemoveVoucher(indexNum: self.indexNum)
    }

    @objc @IBAction fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            radioCheck.isSelected = false
            if(so1!.isSelected == true){

                so1!.isSelected = false


            }else{
                delegate?.tabClickView(voucher:so1!)
            }



        }
    }
}
