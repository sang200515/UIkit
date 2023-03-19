//
//  ChamdiemCell.swift
//  fptshop
//
//  Created by Ngoc Bao on 05/10/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Kingfisher
//535
class ChamdiemCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var imgViewHinhMau: UIImageView!
    @IBOutlet weak var imgViewHinhThucTe: UIImageView!
    @IBOutlet weak var tvDienGiaiLoiText: UITextView!
    
    @IBOutlet weak var imgsai: UIImageView!
    @IBOutlet weak var imgdung: UIImageView!
    

    var cellIndexPath:IndexPath?
    var strBase64 = ""
    var urlImgThucTe = ""
    
    var delegate:DetailChamDiemCellDelagate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func onradio(button:UIButton) {
        setImage(img: imgdung, isSelect: button.tag == 1)
        setImage(img: imgsai, isSelect: button.tag == 2)
        self.delegate?.updatePoint(at: cellIndexPath!, radioType: button.tag)
    }
    
    func setImage(img: UIImageView, isSelect: Bool) {
        img.image = isSelect ? UIImage(named: "mdi_check_circle_gr_2") : UIImage(named: "mdi_check_circle_gr")
    }
    
    func setUpCell(item:ImageContent) {
        imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
        //set url img
        guard let urlImg = URL(string: "\(item.UrlImageSample)") else {
            imgViewHinhMau.image = #imageLiteral(resourceName: "Hinhanh")
            return
        }
        
        imgViewHinhMau.kf.indicatorType = .activity
        imgViewHinhMau.kf.setImage(with: urlImg)
        
        imgViewHinhThucTe.image = #imageLiteral(resourceName: "Hinhanh")
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewHinhThucTe.isUserInteractionEnabled = true
        imgViewHinhThucTe.addGestureRecognizer(tapTakePhoto)
        
        tvDienGiaiLoiText.returnKeyType = .done
        tvDienGiaiLoiText.delegate = self
        setImage(img: imgdung, isSelect: item.radioType == "1")
        setImage(img: imgsai, isSelect: item.radioType == "2")
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
            tvDienGiaiLoiText.text = textView.text
            debugPrint("tvDienGiaiLoiText.text: \(tvDienGiaiLoiText.text ?? "")")
            self.delegate?.updateTvDienGiaiLoi(at: cellIndexPath!, text: tvDienGiaiLoiText.text)
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.resignFirstResponder()
        tvDienGiaiLoiText.text = textView.text
        debugPrint("tvDienGiaiLoiText.text: \(tvDienGiaiLoiText.text ?? "")")
        self.delegate?.updateTvDienGiaiLoi(at: cellIndexPath!, text: tvDienGiaiLoiText.text)
    }
    
    
    
    @objc func takePhoto(){
        self.delegate?.showCamera(at: cellIndexPath!)
    }
    
}
