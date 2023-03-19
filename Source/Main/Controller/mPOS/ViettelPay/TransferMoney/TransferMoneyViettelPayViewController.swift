//
//  TransferMoneyViettelPayViewController.swift
//  fptshop
//
//  Created by tan on 6/25/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
//import EPSignature
import Toaster
class TransferMoneyViettelPayViewController: UIViewController,UITextFieldDelegate,EPSignatureDelegate {
    
    var scrollView:UIScrollView!
    var viewTTNC:UIView!
    var viewTTNN:UIView!
    var viewDiaChi:UIView!
    var viewTTCT:UIView!
    var viewRadioHTCT:UIView!
    var viewFee:UIView!
    
    var tfHoTenTTNC:UITextField!
    var tfPhoneTTNC:UITextField!
    var tfCMNDTTNC:UITextField!
    
    var tfHoTenTTNN:UITextField!
    var tfPhoneTTNN:UITextField!
    var tfCMNDTTNN:UITextField!
    
    var tfMoney:UITextField!
    
    var tfDiaChi:UITextField!
    var tfTinhTP:SearchTextField!
    var tfQuanHuyen:SearchTextField!
    var tfPhuongXa:SearchTextField!
    
    var tfFee:UITextField!
    var tfTongTien:UITextField!
    
    var viewFacade: UIView!
    var imgViewFacade:UIImageView!
    var viewImages:UIView!
    var viewImage1:UIView!
    var imgViewImage1:UIImageView!
     var posImageUpload:Int = 0
      var imagePicker = UIImagePickerController()
    
    var label2:UILabel!
    var label3:UILabel!
    
    var radioNGD:DLRadioButton!
    var radioNTN:DLRadioButton!
    
    var radioCTT:DLRadioButton!
    var radioCTN:DLRadioButton!
    var typeNT :Int = -1
    var typeCT:Int = -1
    var btGetFee:UIButton!
    var lblHTCT:UILabel!
    var heightViewDiaChi:CGFloat = 0.0
    var heightViewRadio:CGFloat = 0.0
    var heightViewFee:CGFloat = 0.0
    var listProvices:[Province] = []
    var listDistricts:[District] = []
    var listPrecincts:[Precinct] = []
    
    var selectProvice:String = ""
    var selectDistrict:String = ""
    var selectPrecinct:String = ""
    
    var imgUpload1: UIImage!
    var imgUpload2: UIImage!

    var feeEx:FeeEx?
    var transferDetail:TransferDetails?
    
    var imgViewSignature: UIImageView!
    var viewImageSign:UIView!
    var viewSign:UIView!

    override func viewDidLoad() {
        self.title = "Chuyển Tiền"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(TransferMoneyViettelPayViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "THÔNG TIN NGƯỜI CHUYỂN"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        viewTTNC = UIView()
        viewTTNC.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTNC.backgroundColor = UIColor.white
        scrollView.addSubview(viewTTNC)
        
        let lbHoTenTTNC = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNC.textAlignment = .left
        lbHoTenTTNC.textColor = UIColor.black
        lbHoTenTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNC.text = "Họ tên"
        viewTTNC.addSubview(lbHoTenTTNC)
        
        tfHoTenTTNC = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenTTNC.frame.origin.y + lbHoTenTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfHoTenTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenTTNC.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenTTNC.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenTTNC.keyboardType = UIKeyboardType.default
        tfHoTenTTNC.returnKeyType = UIReturnKeyType.done
        tfHoTenTTNC.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenTTNC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenTTNC.delegate = self
        viewTTNC.addSubview(tfHoTenTTNC)
        
        let lbTextPhoneTTNC = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfHoTenTTNC.frame.origin.y + tfHoTenTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhoneTTNC.textAlignment = .left
        lbTextPhoneTTNC.textColor = UIColor.black
        lbTextPhoneTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhoneTTNC.text = "Số điện thoại"
        viewTTNC.addSubview(lbTextPhoneTTNC)
        
        tfPhoneTTNC = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhoneTTNC.frame.origin.y + lbTextPhoneTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhoneTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneTTNC.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneTTNC.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneTTNC.keyboardType = UIKeyboardType.numberPad
        tfPhoneTTNC.returnKeyType = UIReturnKeyType.done
        tfPhoneTTNC.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneTTNC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneTTNC.delegate = self
        viewTTNC.addSubview(tfPhoneTTNC)
        
        let lbCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneTTNC.frame.origin.y + tfPhoneTTNC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbCMND.textAlignment = .left
        lbCMND.textColor = UIColor.black
        lbCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMND.text = "CMND/Căn Cước"
        viewTTNC.addSubview(lbCMND)
        
        tfCMNDTTNC = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbCMND.frame.origin.y + lbCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfCMNDTTNC.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfCMNDTTNC.borderStyle = UITextField.BorderStyle.roundedRect
        tfCMNDTTNC.autocorrectionType = UITextAutocorrectionType.no
        tfCMNDTTNC.keyboardType = UIKeyboardType.numberPad
        tfCMNDTTNC.returnKeyType = UIReturnKeyType.done
        tfCMNDTTNC.clearButtonMode = UITextField.ViewMode.whileEditing
        tfCMNDTTNC.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfCMNDTTNC.delegate = self
        viewTTNC.addSubview(tfCMNDTTNC)
        viewTTNC.frame.size.height = tfCMNDTTNC.frame.origin.y + tfCMNDTTNC.frame.size.height + Common.Size(s: 10)
        
//        viewFacade = UIView(frame: CGRect(x: 0, y: viewTTNC.frame.origin.y + viewTTNC.frame.size.height , width: scrollView.frame.size.width, height: 0))
//        viewFacade.clipsToBounds = true
//        viewFacade.backgroundColor = .white
//        scrollView.addSubview(viewFacade)
//
//        let lbTextFacade = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s:15), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:20)))
//        lbTextFacade.textAlignment = .left
//        lbTextFacade.textColor = UIColor.black
//        lbTextFacade.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbTextFacade.text = "Hình ảnh CMND"
//        lbTextFacade.sizeToFit()
//        viewFacade.addSubview(lbTextFacade)
//
//        imgViewFacade = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: lbTextFacade.frame.origin.y + lbTextFacade.frame.size.height + Common.Size(s:5), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
//        imgViewFacade.image = UIImage(named:"CMNDmatrc")
//        imgViewFacade.contentMode = .scaleAspectFit
//        viewFacade.addSubview(imgViewFacade)
//        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
//
//        let tapShowFacade = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDT))
//        viewFacade.isUserInteractionEnabled = true
//        viewFacade.addGestureRecognizer(tapShowFacade)
//
//        viewImages = UIView(frame: CGRect(x: 0, y: viewFacade.frame.origin.y + viewFacade.frame.size.height , width: scrollView.frame.size.width, height: 0))
//        viewImages.clipsToBounds = true
//        viewImages.backgroundColor = .white
//        scrollView.addSubview(viewImages)
//
//        viewImage1 = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: 0))
//        viewImage1.clipsToBounds = true
//        viewImages.addSubview(viewImage1)
//
//
//        imgViewImage1 = UIImageView(frame: CGRect(x:Common.Size(s: 15), y: Common.Size(s:10), width: viewFacade.frame.size.width - Common.Size(s:30), height: (viewFacade.frame.size.width - Common.Size(s:30)) / 2.6))
//        imgViewImage1.image = UIImage(named:"CMNDmatsau")
//        imgViewImage1.contentMode = .scaleAspectFit
//        viewImage1.addSubview(imgViewImage1)
//        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
//        viewImage1.tag = 2
//        let tapShowImage = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDS))
//        viewImage1.isUserInteractionEnabled = true
//        viewImage1.addGestureRecognizer(tapShowImage)
//        viewImages.frame.size.height = viewImage1.frame.origin.y + viewImage1.frame.size.height + Common.Size(s:10)
        
        label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTTNC.frame.origin.y + viewTTNC.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label2.text = "THÔNG TIN NGƯỜI NHẬN"
        
        label2.clipsToBounds = true
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
        viewTTNN = UIView()
        viewTTNN.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewTTNN.backgroundColor = UIColor.white
        viewTTNN.clipsToBounds = true
        scrollView.addSubview(viewTTNN)
        
        
        let lbHTNT = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHTNT.textAlignment = .left
        lbHTNT.textColor = UIColor.black
        lbHTNT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHTNT.text = "Hình thức nhận tiền"
        viewTTNN.addSubview(lbHTNT)
        
        radioNGD = createRadioButtonNT(CGRect(x: Common.Size(s:15),y:lbHTNT.frame.origin.y + lbHTNT.frame.size.height + Common.Size(s:10) , width: lbHTNT.frame.size.width - Common.Size(s:110), height: Common.Size(s:15)), title: "Nhận tại điểm giao dịch", color: UIColor.black);
        viewTTNN.addSubview(radioNGD)
        
        radioNTN = createRadioButtonNT(CGRect(x: radioNGD.frame.origin.x + radioNGD.frame.size.width + Common.Size(s: 10) ,y:radioNGD.frame.origin.y, width: radioNGD.frame.size.width, height: radioNGD.frame.size.height), title: "Nhận tại nhà", color: UIColor.black);
        viewTTNN.addSubview(radioNTN)
        
        radioNGD.isSelected = true
        radioNTN.isSelected = false
        typeNT = 1

        
        let lbHoTenTTNN = UILabel(frame: CGRect(x: Common.Size(s:15), y: radioNGD.frame.origin.y + radioNGD.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHoTenTTNN.textAlignment = .left
        lbHoTenTTNN.textColor = UIColor.black
        lbHoTenTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHoTenTTNN.text = "Họ tên"
        viewTTNN.addSubview(lbHoTenTTNN)
        
        tfHoTenTTNN = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbHoTenTTNN.frame.origin.y + lbHoTenTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfHoTenTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTenTTNN.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTenTTNN.autocorrectionType = UITextAutocorrectionType.no
        tfHoTenTTNN.keyboardType = UIKeyboardType.default
        tfHoTenTTNN.returnKeyType = UIReturnKeyType.done
        tfHoTenTTNN.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTenTTNN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTenTTNN.delegate = self
        viewTTNN.addSubview(tfHoTenTTNN)
        
        let lbTextPhoneTTNN = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfHoTenTTNN.frame.origin.y + tfHoTenTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextPhoneTTNN.textAlignment = .left
        lbTextPhoneTTNN.textColor = UIColor.black
        lbTextPhoneTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextPhoneTTNN.text = "Số điện thoại"
        viewTTNN.addSubview(lbTextPhoneTTNN)
        
        tfPhoneTTNN = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextPhoneTTNN.frame.origin.y + lbTextPhoneTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfPhoneTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhoneTTNN.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhoneTTNN.autocorrectionType = UITextAutocorrectionType.no
        tfPhoneTTNN.keyboardType = UIKeyboardType.numberPad
        tfPhoneTTNN.returnKeyType = UIReturnKeyType.done
        tfPhoneTTNN.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhoneTTNN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhoneTTNN.delegate = self
        viewTTNN.addSubview(tfPhoneTTNN)
        
//        let lbCMNDTTNN = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhoneTTNN.frame.origin.y + tfPhoneTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//        lbCMNDTTNN.textAlignment = .left
//        lbCMNDTTNN.textColor = UIColor.black
//        lbCMNDTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbCMNDTTNN.text = "CMND/Căn Cước"
//        viewTTNN.addSubview(lbCMNDTTNN)
//
//        tfCMNDTTNN = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbCMNDTTNN.frame.origin.y + lbCMNDTTNN.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
//        //        tfPhone.placeholder = "Nhập SĐT người nhận"
//        tfCMNDTTNN.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        tfCMNDTTNN.borderStyle = UITextField.BorderStyle.roundedRect
//        tfCMNDTTNN.autocorrectionType = UITextAutocorrectionType.no
//        tfCMNDTTNN.keyboardType = UIKeyboardType.numberPad
//        tfCMNDTTNN.returnKeyType = UIReturnKeyType.done
//        tfCMNDTTNN.clearButtonMode = UITextField.ViewMode.whileEditing
//        tfCMNDTTNN.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tfCMNDTTNN.delegate = self
//        viewTTNN.addSubview(tfCMNDTTNN)
        
        viewTTNN.frame.size.height = tfPhoneTTNN.frame.origin.y + tfPhoneTTNN.frame.size.height + Common.Size(s:10)
        
        viewDiaChi = UIView()
        viewDiaChi.frame = CGRect(x: 0, y: viewTTNN.frame.origin.y + viewTTNN.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewDiaChi.backgroundColor = UIColor.white
        viewDiaChi.clipsToBounds = true
        scrollView.addSubview(viewDiaChi)
        
        let lblThanhPho = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThanhPho.textAlignment = .left
        lblThanhPho.textColor = UIColor.black
        lblThanhPho.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblThanhPho.text = "Thành Phố"
        viewDiaChi.addSubview(lblThanhPho)
        
 
        
        tfTinhTP = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblThanhPho.frame.origin.y + lblThanhPho.frame.size.height + Common.Size(s:10) , width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfTinhTP.placeholder = "Vui lòng chọn Thành Phố"
        tfTinhTP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTinhTP.borderStyle = UITextField.BorderStyle.roundedRect
        tfTinhTP.autocorrectionType = UITextAutocorrectionType.no
        tfTinhTP.keyboardType = UIKeyboardType.default
        tfTinhTP.returnKeyType = UIReturnKeyType.done
        tfTinhTP.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTinhTP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTinhTP.delegate = self
        viewDiaChi.addSubview(tfTinhTP)
        
        // Start visible - Default: false
        tfTinhTP.startVisible = true
        tfTinhTP.theme.bgColor = UIColor.white
        tfTinhTP.theme.fontColor = UIColor.black
        tfTinhTP.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTinhTP.theme.cellHeight = Common.Size(s:40)
        tfTinhTP.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfTinhTP.leftViewMode = UITextField.ViewMode.always
  
        
        tfTinhTP.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfTinhTP.text = item.title

            self.selectDistrict = ""
            self.tfQuanHuyen.text = ""

            self.selectPrecinct = ""
            self.tfPhuongXa.text = ""
            self.listDistricts.removeAll()
            self.listPrecincts.removeAll()

            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvice = "\(obj)"
                MPOSAPIManager.GetDistricts(MaCodeTinh: "\(self.selectProvice)", NhaMang: "Viettel", handler: { (results, error) in
                    self.listDistricts = results
                    var listDistrictTemp:[String] = []
                    for item in results {
                        listDistrictTemp.append(item.Text)
                    }
                    self.tfQuanHuyen.filterStrings(listDistrictTemp)
                    
                })
            }
            //self.tfQuanHuyen.becomeFirstResponder()
        }
        
        let lblQuanHuyen = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTinhTP.frame.origin.y + tfTinhTP.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblQuanHuyen.textAlignment = .left
        lblQuanHuyen.textColor = UIColor.black
        lblQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblQuanHuyen.text = "Quận Huyện"
        viewDiaChi.addSubview(lblQuanHuyen)
        
        
        tfQuanHuyen = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblQuanHuyen.frame.origin.y + lblQuanHuyen.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfQuanHuyen.placeholder = "Vui lòng chọn Quận Huyện"
        tfQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyen.borderStyle = UITextField.BorderStyle.roundedRect
        tfQuanHuyen.autocorrectionType = UITextAutocorrectionType.no
        tfQuanHuyen.keyboardType = UIKeyboardType.default
        tfQuanHuyen.returnKeyType = UIReturnKeyType.done
        tfQuanHuyen.clearButtonMode = UITextField.ViewMode.whileEditing
        tfQuanHuyen.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfQuanHuyen.delegate = self
        viewDiaChi.addSubview(tfQuanHuyen)
        
        // Start visible - Default: false
        tfQuanHuyen.startVisible = true
        tfQuanHuyen.theme.bgColor = UIColor.white
        tfQuanHuyen.theme.fontColor = UIColor.black
        tfQuanHuyen.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyen.theme.cellHeight = Common.Size(s:40)
        tfQuanHuyen.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfQuanHuyen.leftViewMode = UITextField.ViewMode.always
        
        
        tfQuanHuyen.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfQuanHuyen.text = item.title

            
            self.selectPrecinct = ""
            self.tfPhuongXa.text = ""

            self.listPrecincts.removeAll()
            
            let obj =  self.listDistricts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectDistrict = "\(obj)"
                MPOSAPIManager.GetPrecincts(MaCodeHUyen:  "\(obj)", MaCodeTinh: "\(self.selectProvice)", NhaMang: "Viettel", handler: { (results, error) in
                    self.listPrecincts = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfPhuongXa.filterStrings(list)
                    //self.tfPhuongXa.becomeFirstResponder()
                })
            }
        }
        
        let lblPhuongXa = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfQuanHuyen.frame.origin.y + tfQuanHuyen.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhuongXa.textAlignment = .left
        lblPhuongXa.textColor = UIColor.black
        lblPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhuongXa.text = "Phường Xã"
        viewDiaChi.addSubview(lblPhuongXa)
        
        tfPhuongXa = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblPhuongXa.frame.origin.y + lblPhuongXa.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfPhuongXa.placeholder = "Vui lòng chọn Phường Xã"
        tfPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhuongXa.autocorrectionType = UITextAutocorrectionType.no
        tfPhuongXa.keyboardType = UIKeyboardType.default
        tfPhuongXa.returnKeyType = UIReturnKeyType.done
        tfPhuongXa.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhuongXa.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhuongXa.delegate = self
        viewDiaChi.addSubview(tfPhuongXa)
        
        // Start visible - Default: false
        tfPhuongXa.startVisible = true
        tfPhuongXa.theme.bgColor = UIColor.white
        tfPhuongXa.theme.fontColor = UIColor.black
        tfPhuongXa.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.theme.cellHeight = Common.Size(s:40)
        tfPhuongXa.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfPhuongXa.leftViewMode = UITextField.ViewMode.always
        
        
        tfPhuongXa.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position

            let item = filteredResults[itemPosition]
            self.tfPhuongXa.text = item.title
            let obj =  self.listPrecincts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinct = "\(obj)"
                self.tfDiaChi.becomeFirstResponder()
            }
        }
        
        let lblDiaChi = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhuongXa.frame.origin.y + tfPhuongXa.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblDiaChi.textAlignment = .left
        lblDiaChi.textColor = UIColor.black
        lblDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblDiaChi.text = "Địa chỉ"
        viewDiaChi.addSubview(lblDiaChi)
        
        tfDiaChi = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblDiaChi.frame.origin.y + lblDiaChi.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        tfDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfDiaChi.borderStyle = UITextField.BorderStyle.roundedRect
        tfDiaChi.autocorrectionType = UITextAutocorrectionType.no
        tfDiaChi.keyboardType = UIKeyboardType.default
        tfDiaChi.returnKeyType = UIReturnKeyType.done
        tfDiaChi.clearButtonMode = UITextField.ViewMode.whileEditing
        tfDiaChi.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfDiaChi.delegate = self
        viewDiaChi.addSubview(tfDiaChi)
        

        viewDiaChi.frame.size.height = tfDiaChi.frame.origin.y + tfDiaChi.frame.size.height + Common.Size(s:10)
        heightViewDiaChi = viewDiaChi.frame.size.height
         viewDiaChi.frame.size.height = 0
        
        
        label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewDiaChi.frame.origin.y + viewDiaChi.frame.size.height , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN CHUYỂN TIỀN"
         label3.clipsToBounds = true
          label3.backgroundColor = UIColor(netHex: 0xEEEEEE)
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        
        viewTTCT = UIView()
        viewTTCT.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewTTCT.backgroundColor = UIColor.white
          viewTTCT.clipsToBounds = true
        scrollView.addSubview(viewTTCT)
        
        
        
        let lbTextMoney = UILabel(frame: CGRect(x: Common.Size(s:15), y:Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextMoney.textAlignment = .left
        lbTextMoney.textColor = UIColor.black
        lbTextMoney.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextMoney.text = "Số tiền"
        viewTTCT.addSubview(lbTextMoney)
        
        tfMoney = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbTextMoney.frame.origin.y + lbTextMoney.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfMoney.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoney.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoney.autocorrectionType = UITextAutocorrectionType.no
        tfMoney.keyboardType = UIKeyboardType.numberPad
        tfMoney.returnKeyType = UIReturnKeyType.done
        tfMoney.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoney.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoney.delegate = self
          tfMoney.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        viewTTCT.addSubview(tfMoney)
        
     
        
        
      
        viewTTCT.frame.size.height = tfMoney.frame.origin.y + tfMoney.frame.size.height + Common.Size(s:15)
        
        viewRadioHTCT = UIView()
        viewRadioHTCT.frame = CGRect(x: 0, y: viewTTCT.frame.origin.y + viewTTCT.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewRadioHTCT.backgroundColor = UIColor.white
        viewRadioHTCT.clipsToBounds = true
        scrollView.addSubview(viewRadioHTCT)
        
        
        lblHTCT = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHTCT.textAlignment = .left
        lblHTCT.textColor = UIColor.black
        lblHTCT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHTCT.text = "Hình thức chuyển tiền"
        viewRadioHTCT.addSubview(lblHTCT)
        
        radioCTT = createRadioButtonCT(CGRect(x: tfMoney.frame.origin.x,y:lblHTCT.frame.origin.y + lblHTCT.frame.size.height + Common.Size(s:10) , width: lbHTNT.frame.size.width/2, height: radioNGD.frame.size.height), title: "Chuyển tiền thường", color: UIColor.black);
        viewRadioHTCT.addSubview(radioCTT)
        
        radioCTN = createRadioButtonCT(CGRect(x: radioCTT.frame.origin.x + radioCTT.frame.size.width + Common.Size(s: 10) ,y:radioCTT.frame.origin.y, width: radioCTT.frame.size.width, height: radioCTT.frame.size.height), title: "Chuyển tiền nhanh", color: UIColor.black);
        
        
        radioCTT.isSelected = false
        radioCTN.isSelected = false
        typeCT = 2
        
        viewRadioHTCT.addSubview(radioCTN)
        viewRadioHTCT.frame.size.height = radioCTT.frame.origin.y + radioCTT.frame.size.height + Common.Size(s:10)
        heightViewRadio = viewRadioHTCT.frame.size.height
        viewRadioHTCT.frame.size.height = 0
        
        viewFee = UIView()
        viewFee.frame = CGRect(x: 0, y: viewRadioHTCT.frame.origin.y + viewRadioHTCT.frame.size.height , width: scrollView.frame.size.width, height: 0)
        viewFee.backgroundColor = UIColor.white
        viewFee.clipsToBounds = true
        scrollView.addSubview(viewFee)
        
        
        
        let lblFee = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblFee.textAlignment = .left
        lblFee.textColor = UIColor.black
        lblFee.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblFee.text = "Phí giao dịch"
        viewFee.addSubview(lblFee)
        
        tfFee = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblFee.frame.origin.y + lblFee.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfFee.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfFee.borderStyle = UITextField.BorderStyle.roundedRect
        tfFee.autocorrectionType = UITextAutocorrectionType.no
        tfFee.keyboardType = UIKeyboardType.numberPad
        tfFee.returnKeyType = UIReturnKeyType.done
        tfFee.clearButtonMode = UITextField.ViewMode.whileEditing
        tfFee.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfFee.delegate = self
        viewFee.addSubview(tfFee)
        
        
        
        let lblTongTien = UILabel(frame: CGRect(x: Common.Size(s:15), y:tfFee.frame.origin.y + tfFee.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTongTien.textAlignment = .left
        lblTongTien.textColor = UIColor.black
        lblTongTien.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTongTien.text = "Tổng tiền:"
        viewFee.addSubview(lblTongTien)
        
        tfTongTien = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblTongTien.frame.origin.y + lblTongTien.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:35)))
        //        tfPhone.placeholder = "Nhập SĐT người nhận"
        tfTongTien.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTongTien.borderStyle = UITextField.BorderStyle.roundedRect
        tfTongTien.autocorrectionType = UITextAutocorrectionType.no
        tfTongTien.keyboardType = UIKeyboardType.numberPad
        tfTongTien.returnKeyType = UIReturnKeyType.done
        tfTongTien.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTongTien.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTongTien.delegate = self
        viewFee.addSubview(tfTongTien)
        
        viewFee.frame.size.height = tfTongTien.frame.origin.y + tfTongTien.frame.size.height + Common.Size(s:10)
        heightViewFee = viewFee.frame.size.height
        viewFee.frame.size.height = 0
        //
//        viewSign = UIView(frame: CGRect(x: 0, y: viewFee.frame.origin.y + viewFee.frame.size.height, width: scrollView.frame.size.width , height: 0))
//        viewSign.clipsToBounds = true
//        viewSign.backgroundColor = .white
//        scrollView.addSubview(viewSign)
//
//        let lbTextSign = UILabel(frame: CGRect(x:  Common.Size(s:20), y: 0, width: (scrollView.frame.size.width - Common.Size(s:40))/2, height: Common.Size(s:20)))
//        lbTextSign.textAlignment = .left
//        lbTextSign.textColor = UIColor(netHex:0x47B054)
//        lbTextSign.font = UIFont.systemFont(ofSize: Common.Size(s:18))
//        lbTextSign.text = "Chữ ký"
//        lbTextSign.sizeToFit()
//        viewSign.addSubview(lbTextSign)
//
//        viewImageSign = UIView(frame: CGRect(x: Common.Size(s:20), y: lbTextSign.frame.origin.y + lbTextSign.frame.size.height + Common.Size(s:5), width: viewSign.frame.size.width - Common.Size(s: 40), height: Common.Size(s:60)))
//        viewImageSign.layer.borderWidth = 0.5
//        viewImageSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
//        viewImageSign.layer.cornerRadius = 3.0
//        viewSign.addSubview(viewImageSign)
//
//        let VS23 = viewImageSign.frame.size.height * 2/3
//        let xViewVS  = viewImageSign.frame.size.width/2 - VS23/2
//        let viewSignButton = UIImageView(frame: CGRect(x: xViewVS, y: 0, width: viewImageSign.frame.size.height * 2/3, height: viewImageSign.frame.size.height * 2/3))
//        viewSignButton.image = UIImage(named:"Sign Up-50")
//        viewSignButton.contentMode = .scaleAspectFit
//        viewImageSign.addSubview(viewSignButton)
//
//        let lbSignButton = UILabel(frame: CGRect(x: 0, y: viewSignButton.frame.size.height + viewSignButton.frame.origin.y, width: viewImageSign.frame.size.width, height: viewImageSign.frame.size.height/3))
//        lbSignButton.textAlignment = .center
//        lbSignButton.textColor = UIColor(netHex:0xc2c2c2)
//        lbSignButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lbSignButton.text = "Thêm chữ ký"
//        viewImageSign.addSubview(lbSignButton)
//
//        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height + Common.Size(s:10)
        
//        let tapShowSign = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSign))
//        viewSign.isUserInteractionEnabled = true
//        viewSign.addGestureRecognizer(tapShowSign)
        

        btGetFee = UIButton()
        btGetFee.frame = CGRect(x: Common.Size(s:15), y: viewFee.frame.size.height + viewFee.frame.origin.y + Common.Size(s:10), width: tfMoney.frame.size.width, height: tfMoney.frame.size.height * 1.2)
        btGetFee.backgroundColor = UIColor(netHex:0x00955E)
        btGetFee.setTitle("Lấy phí", for: .normal)
        btGetFee.addTarget(self, action: #selector(actionGetFee), for: .touchUpInside)
        btGetFee.layer.borderWidth = 0.5
        btGetFee.layer.borderColor = UIColor.white.cgColor
        btGetFee.layer.cornerRadius = 3
        scrollView.addSubview(btGetFee)
        

    
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
        
//        let newViewController = LoadingViewController()
//        newViewController.content = "Đang lấy thông tin  ..."
//        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        self.navigationController?.present(newViewController, animated: true, completion: nil)
//        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.GetProvinces(NhaMang: "Viettel") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
               // nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listProvices = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfTinhTP.filterStrings(list)
                
  
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        
    }
    
    
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @objc func actionHoanTat(){
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang thực hiện giao dịch chuyển tiền ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
 
        
        MPOSAPIManager.makeTransfer(order_id: "",service_code:"TRANSFER",receiver_name:self.tfHoTenTTNN.text!,receiver_msisdn:self.tfPhoneTTNN.text!,receiver_id_number: "",receiver_province: self.selectProvice,receiver_district:self.selectDistrict,receiver_precinct:self.selectPrecinct,receiver_address:self.tfDiaChi.text!,amount:"\(self.feeEx!.amount)",transfer_type:"\(self.typeNT)",transfer_form:"\(self.typeCT)",sender_name:self.tfHoTenTTNC.text!,sender_msisdn:self.tfPhoneTTNC.text!,sender_id_number:self.tfCMNDTTNC.text!,expected_province:self.selectProvice,expected_district:self.selectDistrict,expected_precinct:self.selectPrecinct,expected_address:self.tfDiaChi.text!,image_cmtmt:"",image_cmtms:"",image_pct:"",cust_fee:self.feeEx!.cust_fee) { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    if(result.error_code == "00"){
                        let alert = UIAlertController(title: "Thông báo", message: result.error_msg, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            self.transferDetail = TransferDetails(   docentry: Int(result.order_id)!
                                , TransactionCode:""
                                , trans_id_viettel:"\(result.trans_id)"
                                , billcode:""
                                , amount: Int(self.feeEx!.amount)!
                                , cust_fee: Int(self.feeEx!.cust_fee)!
                                , receiver_name: result.nameReceiver
                                , receiver_msisdn:result.phoneReceiver
                                , receiver_id_number: result.id_numberReceiver
                                , receiver_province:""
                                , receiver_district:""
                                , receiver_precinct:""
                                , receiver_address:self.tfDiaChi.text!
                                , sender_name: result.nameSender
                                , sender_msisdn:result.phoneSender
                                , sender_id_number:result.id_numberSender
                                , transfer_type: self.typeCT
                                , transfer_form: self.typeNT
                                , CMND_mattruoc:""
                                , CMND_matsau:""
                                , transfer_typeName:""
                                , transfer_formName:"", trangthai: "Đã gửi", NgayGiaoDich: "")
                            let newViewController = ResultTransferMoneyViettelPayViewController()
                            newViewController.transferDetail = self.transferDetail
                            self.navigationController?.pushViewController(newViewController, animated: true)
                            
                            
                        })
                        self.present(alert, animated: true)
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: result.error_msg, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                    
                    
                    
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
        //
        
     
        
//        let imageSign:UIImage = self.resizeImage(image: imgViewSignature.image!,newHeight: 80)!
//
//        if let imageDataSign:NSData = imageSign.pngData() as NSData?{
//
//            //base chữ ký
//            let strBase64Sign = imageDataSign.base64EncodedString(options: .endLineWithLineFeed)
//
//
//
//
//        }
        

        
//        if let imageDataCMNDT:NSData = imgViewFacade.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
//            let strBase64CMNDT = imageDataCMNDT.base64EncodedString(options: .endLineWithLineFeed)
//            if let imageDataCMNDS:NSData = imgViewImage1.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
//                let strBase64CMNDS = imageDataCMNDS.base64EncodedString(options: .endLineWithLineFeed)
//
//
//
//
//
//
//
//
//            }
//
//
//
//        }
        
        
    }
    @objc func actionGetFee(){
        if(self.btGetFee.currentTitle == "Lấy phí"){
            if(self.tfHoTenTTNC.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ tên người chuyển tiền!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfPhoneTTNC.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người chuyển tiền!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfCMNDTTNC.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số CMND người chuyển tiền!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            if (self.tfCMNDTTNC.text!.count < 9 || self.tfCMNDTTNC.text!.count > 12){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập đúng số cmnd khách hàng", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            let phone = tfPhoneTTNC.text!
            if (phone.hasPrefix("01") && phone.count == 11){
                
            }else if (phone.hasPrefix("0") && !phone.hasPrefix("01") && phone.count == 10){
                
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại người chuyển tiền không hợp lệ!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
//            if (imgViewFacade == nil){
//
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa có ảnh CMND mặt trước !", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
//            if(imgViewImage1 == nil){
//                let alert = UIAlertController(title: "Thông báo", message: "Chưa có ảnh CMND mặt sau !", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
            if(self.tfHoTenTTNN.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập họ tên người nhận tiền!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
            if(self.tfPhoneTTNN.text! == ""){
                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số điện thoại người nhận tiền!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    
                })
                self.present(alert, animated: true)
                return
            }
//            if(self.tfCMNDTTNN.text! == ""){
//                let alert = UIAlertController(title: "Thông báo", message: "Vui lòng nhập số CMND người nhận tiền!", preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//                })
//                self.present(alert, animated: true)
//                return
//            }
            var money = tfMoney.text!
            money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMddHHmmss"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lấy thông tin  ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            MPOSAPIManager.getFeeEx(order_id:"frt-getfee-\(dateString)"
                ,service_code:"TRANSFER"
                ,receiver_name:"\(self.tfHoTenTTNN.text!)"
                ,receiver_msisdn:"\(self.tfPhoneTTNN.text!)"
                ,receiver_id_number:""
                ,receiver_province:"\(self.selectProvice)"
                ,receiver_district:"\(self.selectDistrict)"
                ,receiver_precinct:"\(self.selectPrecinct)"
                ,receiver_address:"\(self.tfDiaChi.text!)"
                ,amount:money
                ,transfer_type:"\(self.typeNT)"
            ,transfer_form:"\(self.typeCT)") { (feeEX, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        Toast.init(text: "Lấy phí thành công.").show()
                        self.feeEx = feeEX
                        self.viewFee.frame.size.height = self.heightViewFee
                        self.tfFee.text = Common.convertCurrency(value: Int(feeEX.cust_fee)!)
                        let tongtienAmount = Int(feeEX.cust_fee)! + Int(feeEX.amount)!
                        self.tfTongTien.text = Common.convertCurrency(value: tongtienAmount)
                        self.tfHoTenTTNN.isEnabled = false
                        self.tfPhoneTTNN.isEnabled = false
                       // self.tfCMNDTTNN.isEnabled = false
                        
                        self.tfHoTenTTNC.isEnabled = false
                        self.tfPhoneTTNC.isEnabled = false
                        self.tfCMNDTTNC.isEnabled = false
                        
                        self.tfMoney.isEnabled = false
                        self.tfTinhTP.isEnabled = false
                        self.tfQuanHuyen.isEnabled = false
                        self.tfPhuongXa.isEnabled = false
                        self.tfDiaChi.isEnabled = false
                        self.tfFee.isEnabled = false
                        self.tfTongTien.isEnabled = false
                        self.radioCTN.isUserInteractionEnabled = false
                        self.radioCTT.isUserInteractionEnabled = false
                        self.radioNGD.isUserInteractionEnabled = false
                        self.radioNTN.isUserInteractionEnabled = false
                        if(self.typeNT == 1){
                            self.radioNGD.isSelected = true
                        }
                        if(self.typeNT == 2){
                            self.radioNTN.isSelected = true
                        }
                        
//                        self.viewFacade.isUserInteractionEnabled = false
//                        self.viewImage1.isUserInteractionEnabled = false
                        self.viewFee.frame.size.height = self.heightViewFee
              
                        self.btGetFee.frame.origin.y = self.viewFee.frame.origin.y + self.viewFee.frame.size.height + Common.Size(s:10)
                        
                        self.btGetFee.setTitle("Hoàn tất", for: .normal)
                        // self.btGetFee.addTarget(self, action: #selector(self.actionHoanTat), for: .touchUpInside)
                        self.scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.btGetFee.frame.origin.y + self.btGetFee.frame.size.height + (self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:45))
                        
//                        let alert = UIAlertController(title: "Thông báo", message: feeEX.error_msg, preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
//
//
//                        })
//                        self.present(alert, animated: true)
                        
                        
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                    }
                }
            }
        }else{
            self.actionHoanTat()
        }

    }
    
    fileprivate func createRadioButtonNT(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(TransferMoneyViettelPayViewController.logSelectedButtonNT), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    fileprivate func createRadioButtonCT(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:12));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(TransferMoneyViettelPayViewController.logSelectedButtonCT), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        
        return radioButton;
    }
    
    
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
            self.tfMoney.text = str
        }else{
            textField.text = ""
            self.tfMoney.text = ""
        }
        
    }
    
    @objc @IBAction fileprivate func logSelectedButtonNT(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            radioNGD.isSelected = false
            radioNTN.isSelected = false
           
            switch temp {
            case "Nhận tại điểm giao dịch":
                typeNT = 1
     
                radioNGD.isSelected = true
                self.viewDiaChi.frame.size.height = 0
                
                self.label3.frame.origin.y = self.viewDiaChi.frame.origin.y + self.viewDiaChi.frame.size.height
                
                self.viewTTCT.frame.origin.y = self.label3.frame.origin.y + self.label3.frame.size.height
                
                self.viewRadioHTCT.frame.size.height  = 0
                self.viewRadioHTCT.frame.origin.y = viewTTCT.frame.origin.y + viewTTCT.frame.size.height
                
                self.viewFee.frame.origin.y = viewRadioHTCT.frame.size.height + viewRadioHTCT.frame.origin.y
           
                self.btGetFee.frame.origin.y = self.viewFee.frame.origin.y + self.viewFee.frame.size.height + Common.Size(s:10)
                 scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
                break
            case "Nhận tại nhà":
                typeNT = 2
           
                radioNTN.isSelected = true
     

                
                self.viewDiaChi.frame.size.height = self.heightViewDiaChi
         
                self.label3.frame.origin.y = self.viewDiaChi.frame.origin.y + self.viewDiaChi.frame.size.height
                
                self.viewTTCT.frame.origin.y = self.label3.frame.origin.y + self.label3.frame.size.height
                
                self.viewRadioHTCT.frame.size.height  = self.heightViewRadio
                self.viewRadioHTCT.frame.origin.y = viewTTCT.frame.origin.y + viewTTCT.frame.size.height
                
                self.viewFee.frame.origin.y = viewRadioHTCT.frame.size.height + viewRadioHTCT.frame.origin.y
            
                self.btGetFee.frame.origin.y = self.viewFee.frame.origin.y + self.viewFee.frame.size.height + Common.Size(s:10)
                scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
                
                break
       
 
            default:
                typeNT = 1
             
                break
            }
        }
    }
    
    @objc @IBAction fileprivate func logSelectedButtonCT(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
    
            radioCTT.isSelected = false
            radioCTN.isSelected = false
            switch temp {
   
            case "Chuyển tiền thường":
                typeCT = 2
                
                radioCTT.isSelected = true
                break
            case "Chuyển tiền nhanh":
                typeCT = 1
                
                radioCTN.isSelected = true
                break
                
            default:
                typeCT = 2
                
                break
            }
        }
    }

    
    @objc func tapShowCMNDS() {
        posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc func tapShowCMNDT() {
        posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func image1(image:UIImage){
        imgUpload1 = image

        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewFacade.frame.size.width / sca
        imgViewFacade.image = image
        imgViewFacade.frame.size.height = heightImage
        viewFacade.frame.size.height = imgViewFacade.frame.origin.y + imgViewFacade.frame.size.height
        viewImages.frame.origin.y = viewFacade.frame.origin.y + viewFacade.frame.size.height 
        
        label2.frame.origin.y = viewImages.frame.origin.y + viewImages.frame.size.height
        viewTTNN.frame.origin.y  = label2.frame.origin.y + label2.frame.size.height
        viewDiaChi.frame.origin.y  =  viewTTNN.frame.origin.y + viewTTNN.frame.size.height
     
        self.label3.frame.origin.y = self.viewDiaChi.frame.origin.y + self.viewDiaChi.frame.size.height
        
        self.viewTTCT.frame.origin.y = self.label3.frame.origin.y + self.label3.frame.size.height
        
        
        self.viewRadioHTCT.frame.origin.y = viewTTCT.frame.origin.y + viewTTCT.frame.size.height
        
        self.viewFee.frame.origin.y = viewRadioHTCT.frame.size.height + viewRadioHTCT.frame.origin.y
        
        self.btGetFee.frame.origin.y = self.viewFee.frame.size.height + self.viewFee.frame.origin.y + Common.Size(s:10)
  
       
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
    }
    func image2(image:UIImage){
        imgUpload2 = image
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = imgViewImage1.frame.size.width / sca
        imgViewImage1.image = image
        imgViewImage1.frame.size.height = heightImage
        viewImage1.frame.size.height = imgViewImage1.frame.origin.y + imgViewImage1.frame.size.height
        viewImages.frame.size.height = viewImage1.frame.size.height + viewImage1.frame.origin.y
        label2.frame.origin.y = viewImages.frame.origin.y + viewImages.frame.size.height
        viewTTNN.frame.origin.y  = label2.frame.origin.y + label2.frame.size.height
        viewDiaChi.frame.origin.y  =  viewTTNN.frame.origin.y + viewTTNN.frame.size.height
        
        self.label3.frame.origin.y = self.viewDiaChi.frame.origin.y + self.viewDiaChi.frame.size.height
        
        self.viewTTCT.frame.origin.y = self.label3.frame.origin.y + self.label3.frame.size.height
        
        
        self.viewRadioHTCT.frame.origin.y = viewTTCT.frame.origin.y + viewTTCT.frame.size.height
        
        self.viewFee.frame.origin.y = viewRadioHTCT.frame.size.height + viewRadioHTCT.frame.origin.y
        self.btGetFee.frame.origin.y = self.viewFee.frame.size.height + self.viewFee.frame.origin.y + Common.Size(s:10)
    
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = viewImageSign.frame.size.width - Common.Size(s:10)
        
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        
        viewImageSign.subviews.forEach { $0.removeFromSuperview() }
        imgViewSignature  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        //        imgViewSignature.backgroundColor = .red
        imgViewSignature.contentMode = .scaleAspectFit
        viewImageSign.addSubview(imgViewSignature)
        imgViewSignature.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewImageSign.frame.size.height = imgViewSignature.frame.size.height + imgViewSignature.frame.origin.y + Common.Size(s:5)
        viewSign.frame.size.height = viewImageSign.frame.origin.y + viewImageSign.frame.size.height
        
  
        
        self.btGetFee.frame.origin.y = self.viewSign.frame.size.height + self.viewSign.frame.origin.y + Common.Size(s:10)
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btGetFee.frame.origin.y + btGetFee.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:40))
        
        _ = self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
      
    }
    
}
extension TransferMoneyViettelPayViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Chọn hình ảnh", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Chụp ảnh", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Thư viện", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Huỷ", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
        if (self.posImageUpload == 1){
            self.image1(image: image)
        }else if (self.posImageUpload == 2){
            self.image2(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
