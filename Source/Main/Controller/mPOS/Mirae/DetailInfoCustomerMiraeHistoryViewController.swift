//
//  DetailInfoCustomerMiraeHistoryViewController.swift
//  fptshop
//
//  Created by tan on 6/11/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import PopupDialog
import Toaster
class DetailInfoCustomerMiraeHistoryViewController: UIViewController,UITextFieldDelegate  {
    var imagePicker = UIImagePickerController()
    var lbShowTamTru:UILabel!
    var scrollView:UIScrollView!
    var detailViewDiaChi:UIView!
    var tfThanhPho:SearchTextField!
    var tfQuanHuyen:SearchTextField!
    var tfPhuongXa:SearchTextField!
    var tfSoNha:UITextField!
    var selectProvice:String = ""
    var selectDistrict:String = ""
    var selectPrecinct:String = ""
    var tfSDTKH:UITextField!
    var tfNgayCapCMND:UITextField!
    var tfNoiCapCMND:SearchTextField!
    var viewCMND:UIView!
    var selectProviceCMND:String = ""
    var tfThanhPhoTamTru:SearchTextField!
    var tfQuanHuyenTamTru:SearchTextField!
    var tfPhuongXaTamTru:SearchTextField!
    var tfSoNhaTamTru:UITextField!
    var selectProviceTamTru:String = ""
    var selectDistrictTamTru:String = ""
    var selectPrecinctTamTru:String = ""
    
    var detailViewNgheNghiep:UIView!
    var tfTenCongTy:UITextField!
    var tfViTri:UITextField!
    var tfSoNamLamViec:UITextField!
    var tfLuong:UITextField!
    var tfThanhPhoNgheNghiep:SearchTextField!
    var tfQuanHuyenNgheNghiep:SearchTextField!
    var tfPhuongXaNgheNghiep:SearchTextField!
    var tfSoNhaNgheNghiep:UITextField!
    var tfThongTinLHNgheNghiep:UITextField!
    var tfLoaiChungTu:SearchTextField!
    var tfCMNDCCCD:UITextField!
    var viewThongTinThamChieu:UIView!
    var tfHoTen:UITextField!
    var tfHoTen2:UITextField!
    var tfMoiQuanHe2:UITextField!
    var tfMoiQuanHe:UITextField!
    var tfThongTinLienLac:UITextField!
    var tfThongTinLienLac2:UITextField!
    var selectProviceNgheNghiep:String = ""
    var selectDistrictNgheNghiep:String = ""
    var selectPrecinctNgheNghiep:String = ""
    //--
    var viewInfoCMNDTruoc:UIView!
    var viewImageCMNDTruoc:UIView!
    var imgViewCMNDTruoc: UIImageView!
    var viewCMNDTruoc:UIView!
    //--
    
    //--
    var viewInfoCMNDSau:UIView!
    var viewImageCMNDSau:UIView!
    var imgViewCMNDSau: UIImageView!
    var viewCMNDSau:UIView!
    //--
    
    var viewInfoGPLXTruoc:UIView!
    var viewImageGPLXTruoc:UIView!
    var imgViewGPLXTruoc: UIImageView!
    var viewGPLXTruoc:UIView!
    //--
    
    //--
    var viewInfoGPLXSau:UIView!
    var viewImageGPLXSau:UIView!
    var imgViewGPLXSau: UIImageView!
    var viewGPLXSau:UIView!
    //--
    //--
    var viewInfoTheNV:UIView!
    var viewImageFormRegister:UIView!
    var imgViewFormRegister: UIImageView!
    var viewFormRegister:UIView!
    //--
    //--
    var viewInfoChanDungKH:UIView!
    var viewImageTrichNoTD:UIView!
    var imgViewTrichNoTD: UIImageView!
    var viewTrichNoTD:UIView!
    //--
    //--
    var viewInfoTrichNoTDTrang2:UIView!
    var viewImageTrichNoTDTrang2:UIView!
    var imgViewTrichNoTDTrang2: UIImageView!
    var viewTrichNoTDTrang2:UIView!
    //--
    //--
    var viewInfoSoHK:UIView!
    var viewImageSoHK:UIView!
    var imgViewSoHK: UIImageView!
    var viewSoHK:UIView!
    //--
    
    var lbInfoUploadMore:UILabel!
    
    //---
    var viewUploadMore:UIView!
    
    //--
    var viewInfoSoHKTrang2:UIView!
    var viewImageSoHKTrang2:UIView!
    var imgViewSoHKTrang2: UIImageView!
    var viewSoHKTrang2:UIView!
    //--
    //--
    var viewInfoSoHKTrang3:UIView!
    var viewImageSoHKTrang3:UIView!
    var imgViewSoHKTrang3: UIImageView!
    var viewSoHKTrang3:UIView!
    //--
    //--
    var viewInfoSoHKTrang4:UIView!
    var viewImageSoHKTrang4:UIView!
    var imgViewSoHKTrang4: UIImageView!
    var viewSoHKTrang4:UIView!
    //--
    //--
    var viewInfoSoHKTrang5:UIView!
    var viewImageSoHKTrang5:UIView!
    var imgViewSoHKTrang5: UIImageView!
    var viewSoHKTrang5:UIView!
    //--
    //--
    var viewInfoSoHKTrang6:UIView!
    var viewImageSoHKTrang6:UIView!
    var imgViewSoHKTrang6: UIImageView!
    var viewSoHKTrang6:UIView!
    //--
    //--
    var viewInfoSoHKTrang7:UIView!
    var viewImageSoHKTrang7:UIView!
    var imgViewSoHKTrang7: UIImageView!
    var viewSoHKTrang7:UIView!
    //--
    //--
    var viewInfoSoHKTrang8:UIView!
    var viewImageSoHKTrang8:UIView!
    var imgViewSoHKTrang8: UIImageView!
    var viewSoHKTrang8:UIView!
    //--
    //--
    var viewInfoSoHKTrang9:UIView!
    var viewImageSoHKTrang9:UIView!
    var imgViewSoHKTrang9: UIImageView!
    var viewSoHKTrang9:UIView!
    //--
    //--
    var viewInfoSim:UIView!
    var viewImageSim:UIView!
    var imgViewSim: UIImageView!
    var viewSim:UIView!
    //--
    var viewUpload:UIView!
    var btTaoDonHang:UIButton!
    var posImageUpload:Int = -1
    var heightUploadView:CGFloat = 0.0
    var heightUploadViewTamTru:CGFloat = 0.0
    var viewTamTru:UIView!
    var label2:UILabel!
    var label3:UILabel!
    var listProvices:[TinhThanhMirae] = []
    var listDistricts:[QuanHuyenMirae] = []
    var listPrecincts:[PhuongXaMirae] = []
    
    var listProvicesTamTru:[TinhThanhMirae] = []
    var listDistrictsTamTru:[QuanHuyenMirae] = []
    var listPrecinctsTamTru:[PhuongXaMirae] = []
    
    var listProvicesNgheNghiep:[TinhThanhMirae] = []
    var listDistrictsNgheNghiep:[QuanHuyenMirae] = []
    var listPrecinctsNgheNghiep:[PhuongXaMirae] = []
    
    var selectLoaiChungTu:String = ""
    var checkInfoCustomer:InfoCustomerMirae?
    var lblThongTinNgheNghiep:UILabel!
    var listLoaiChungTu:[MiraeLoaiChungTu] = []
    
    var tfNgayThanhToan:SearchTextField!
    var selectNgayThanhToan:String = ""
    var listNgayThanhToan:[DueDayMirae] = []
    
    var CRD_MT_CMND2:String = ""
    var CRD_MS_CMND2:String = ""
    var CRD_ChanDungKH2:String = ""
    var CRD_GPLX_MT2:String = ""
    var CRD_GPLX_MS2:String = ""
    var CRD_SHK_12:String = ""
    var CRD_SHK_22:String = ""
    var CRD_SHK_32:String = ""
    var CRD_SHK_42:String = ""
    var CRD_SHK_52:String = ""
    var CRD_SHK_62:String = ""
    var CRD_SHK_72:String = ""
    var getinfo_byContractNumber:Getinfo_byContractNumber?
    var listUploadImage:[UploadImageMirae] = []
    var historyMirae:HistoryOrderByID?
    var fullFlagArr:[String] = []
    var fullFlagInfo:[String] = []
    var tfNgaySinh:UITextField!
    var lbNgaySinh:UILabel!
    var lblThanhPho:UILabel!
    var lblQuanHuyen:UILabel!
    var lblPhuongXa:UILabel!
    var lblSoNha:UILabel!
    var lblThanhPhoTamTru:UILabel!
    var lblQuanHuyenTamTru:UILabel!
    var lblPhuongXaTamTru:UILabel!
    var lblSoNhaTamTru:UILabel!
    var lblTenCongTy:UILabel!
    var lblViTriCongTac:UILabel!
    var lblLuong:UILabel!
    var lblLoaiChungTu:UILabel!
    var lblCMNDCCCD:UILabel!
    var lblNgayThanhToan:UILabel!
//    var isShowCMND:Bool = false
//    var isShowCD:Bool = false
//    var isShowGPLXSHK:Bool = false
    var isShowCMND:Bool = true
    var isShowCD:Bool = true
    var isShowGPLXSHK:Bool = true
    var lbResendSMS:UILabel!
    var historyUser:HistoryOrderByUser?
    override func viewDidLoad() {
        self.title = "Cập nhật thông tin khách hàng"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(DetailInfoCustomerMiraeHistoryViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height )
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)
        
        
        if(self.getinfo_byContractNumber != nil){
            if(self.getinfo_byContractNumber!.Flag_Image != ""){
                self.fullFlagArr = self.getinfo_byContractNumber!.Flag_Image.components(separatedBy: ",")
            }
            if(self.getinfo_byContractNumber!.list_update_mirae != "" ){
                self.fullFlagInfo = self.getinfo_byContractNumber!.list_update_mirae.components(separatedBy: ",")
            }
        }
      
        
        let labelCMND = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        labelCMND.text = "CMND (*)"
        labelCMND.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(labelCMND)
        
        viewCMND = UIView()
        viewCMND.frame = CGRect(x: 0, y:labelCMND.frame.origin.y + labelCMND.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewCMND.backgroundColor = UIColor.white
        scrollView.addSubview(viewCMND)
        
        let lblNgayCapCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNgayCapCMND.textAlignment = .left
        lblNgayCapCMND.textColor = UIColor.black
        lblNgayCapCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNgayCapCMND.text = "Ngày cấp CMND (dd/mm/yyyy)"
        viewCMND.addSubview(lblNgayCapCMND)
        
        tfNgayCapCMND = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblNgayCapCMND.frame.origin.y + lblNgayCapCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfNgayCapCMND.placeholder = "Nhập ngày cấp cmnd"
        tfNgayCapCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgayCapCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfNgayCapCMND.autocorrectionType = UITextAutocorrectionType.no
        tfNgayCapCMND.keyboardType = UIKeyboardType.default
        tfNgayCapCMND.returnKeyType = UIReturnKeyType.done
        tfNgayCapCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNgayCapCMND.isEnabled = false
        tfNgayCapCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNgayCapCMND.delegate = self
        tfNgayCapCMND.addTarget(self, action: #selector(DetailInfoCustomerMiraeHistoryViewController.textFieldDidEndEditing), for: .editingDidEnd)
        viewCMND.addSubview(tfNgayCapCMND)
        
        let lblNoiCapCMND = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfNgayCapCMND.frame.size.height +  tfNgayCapCMND.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNoiCapCMND.textAlignment = .left
        lblNoiCapCMND.textColor = UIColor.black
        lblNoiCapCMND.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNoiCapCMND.text = "Nơi cấp CMND"
        viewCMND.addSubview(lblNoiCapCMND)
        
        tfNoiCapCMND = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblNoiCapCMND.frame.origin.y + lblNoiCapCMND.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfNoiCapCMND.placeholder = "Thành phố"
        tfNoiCapCMND.isEnabled = false
        tfNoiCapCMND.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNoiCapCMND.borderStyle = UITextField.BorderStyle.roundedRect
        tfNoiCapCMND.autocorrectionType = UITextAutocorrectionType.no
        tfNoiCapCMND.keyboardType = UIKeyboardType.default
        tfNoiCapCMND.returnKeyType = UIReturnKeyType.done
        tfNoiCapCMND.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNoiCapCMND.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNoiCapCMND.delegate = self
        viewCMND.addSubview(tfNoiCapCMND)
        
        // Start visible - Default: false
        tfNoiCapCMND.startVisible = true
        tfNoiCapCMND.theme.bgColor = UIColor.white
        tfNoiCapCMND.theme.fontColor = UIColor.black
        tfNoiCapCMND.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNoiCapCMND.theme.cellHeight = Common.Size(s:40)
        tfNoiCapCMND.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfNoiCapCMND.leftViewMode = UITextField.ViewMode.always
        let imageButtonNoiCap = UIImageView(frame: CGRect(x: tfNoiCapCMND.frame.size.height/4, y: tfNoiCapCMND.frame.size.height/4, width: tfNoiCapCMND.frame.size.height/2, height: tfNoiCapCMND.frame.size.height/2))
        imageButtonNoiCap.image = UIImage(named: "City-50")
        imageButtonNoiCap.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewNoiCapButton = UIView()
        leftViewNoiCapButton.addSubview(imageButtonNoiCap)
        leftViewNoiCapButton.frame = CGRect(x: 0, y: 0, width: tfNoiCapCMND.frame.size.height, height: tfNoiCapCMND.frame.size.height)
        tfNoiCapCMND.leftView = leftViewNoiCapButton
        
        tfNoiCapCMND.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfNoiCapCMND.text = item.title
            
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProviceCMND = "\(obj)"
                
            }
        }
        viewCMND.frame.size.height = tfNoiCapCMND.frame.origin.y + tfNoiCapCMND.frame.size.height + Common.Size(s:10)
       
        
        lbNgaySinh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewCMND.frame.origin.y + viewCMND.frame.size.height, width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbNgaySinh.text = "NGÀY SINH (DD/MM/YYYY)"
        lbNgaySinh.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(lbNgaySinh)
        
        let viewNgaySinh = UIView()
        viewNgaySinh.frame = CGRect(x: 0, y:lbNgaySinh.frame.origin.y + lbNgaySinh.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewNgaySinh.backgroundColor = UIColor.white
        scrollView.addSubview(viewNgaySinh)
        
 
 
        
        tfNgaySinh = UITextField(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfNgaySinh.placeholder = "Nhập ngày sinh khách hàng!"
        tfNgaySinh.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgaySinh.borderStyle = UITextField.BorderStyle.roundedRect
        tfNgaySinh.autocorrectionType = UITextAutocorrectionType.no
        tfNgaySinh.keyboardType = UIKeyboardType.default
        tfNgaySinh.returnKeyType = UIReturnKeyType.done
        tfNgaySinh.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNgaySinh.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNgaySinh.delegate = self
        tfNgaySinh.isEnabled = false
        viewNgaySinh.addSubview(tfNgaySinh)
        
        let lbSDTKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: tfNgaySinh.frame.origin.y + tfNgaySinh.frame.size.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbSDTKH.text = "SĐT Khách Hàng"
        lbSDTKH.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        viewNgaySinh.addSubview(lbSDTKH)
        
        
        tfSDTKH = UITextField(frame: CGRect(x: Common.Size(s:15), y: lbSDTKH.frame.origin.y + lbSDTKH.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSDTKH.placeholder = "Số SĐT KH"
        tfSDTKH.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSDTKH.borderStyle = UITextField.BorderStyle.roundedRect
        tfSDTKH.autocorrectionType = UITextAutocorrectionType.no
        tfSDTKH.keyboardType = UIKeyboardType.numberPad
        tfSDTKH.returnKeyType = UIReturnKeyType.done
        tfSDTKH.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSDTKH.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSDTKH.delegate = self
        tfSDTKH.isEnabled = false
        viewNgaySinh.addSubview(tfSDTKH)
        
        viewNgaySinh.frame.size.height = tfSDTKH.frame.origin.y + tfSDTKH.frame.size.height  + Common.Size(s: 10)
        
        let label1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewNgaySinh.frame.size.height + viewNgaySinh.frame.origin.y + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label1.text = "ĐỊA CHỈ THƯỜNG TRÚ (*)"
        label1.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label1)
        
        detailViewDiaChi = UIView()
        detailViewDiaChi.frame = CGRect(x: 0, y:label1.frame.origin.y + label1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailViewDiaChi.backgroundColor = UIColor.white
        scrollView.addSubview(detailViewDiaChi)
        
        lblThanhPho = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThanhPho.textAlignment = .left
        lblThanhPho.textColor = UIColor.black
        lblThanhPho.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblThanhPho.text = "Thành Phố"
        detailViewDiaChi.addSubview(lblThanhPho)
        
        tfThanhPho = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblThanhPho.frame.origin.y + lblThanhPho.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfThanhPho.placeholder = "Thành phố"
        tfThanhPho.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThanhPho.borderStyle = UITextField.BorderStyle.roundedRect
        tfThanhPho.autocorrectionType = UITextAutocorrectionType.no
        tfThanhPho.keyboardType = UIKeyboardType.default
        tfThanhPho.returnKeyType = UIReturnKeyType.done
        tfThanhPho.clearButtonMode = UITextField.ViewMode.whileEditing
        tfThanhPho.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfThanhPho.delegate = self
        tfThanhPho.isEnabled = false
        detailViewDiaChi.addSubview(tfThanhPho)
        
        // Start visible - Default: false
        tfThanhPho.startVisible = true
        tfThanhPho.theme.bgColor = UIColor.white
        tfThanhPho.theme.fontColor = UIColor.black
        tfThanhPho.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThanhPho.theme.cellHeight = Common.Size(s:40)
        tfThanhPho.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfThanhPho.leftViewMode = UITextField.ViewMode.always
        let imageButton = UIImageView(frame: CGRect(x: tfThanhPho.frame.size.height/4, y: tfThanhPho.frame.size.height/4, width: tfThanhPho.frame.size.height/2, height: tfThanhPho.frame.size.height/2))
        imageButton.image = UIImage(named: "City-50")
        imageButton.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCityButton = UIView()
        leftViewCityButton.addSubview(imageButton)
        leftViewCityButton.frame = CGRect(x: 0, y: 0, width: tfThanhPho.frame.size.height, height: tfThanhPho.frame.size.height)
        tfThanhPho.leftView = leftViewCityButton
        
        tfThanhPho.itemSelectionHandler = { filteredResults, itemPosition in
            //Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfThanhPho.text = item.title
            
            self.selectDistrict = ""
            self.tfQuanHuyen.text = ""
            
            self.selectPrecinct = ""
            self.tfPhuongXa.text = ""
            self.listDistricts.removeAll()
            self.listPrecincts.removeAll()
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProvice = "\(obj)"
                MPOSAPIManager.mpos_FRT_SP_Mirae_loadDistrict(ProvinceCode: self.selectProvice, handler: { (results, error) in
                    self.listDistricts = results
                    var listDistrictTemp:[String] = []
                    for item in results {
                        listDistrictTemp.append(item.Text)
                    }
                    self.tfQuanHuyen.filterStrings(listDistrictTemp)
                    self.tfQuanHuyen.becomeFirstResponder()
                })
            }
        }
        
        lblQuanHuyen = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfThanhPho.frame.size.height + tfThanhPho.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblQuanHuyen.textAlignment = .left
        lblQuanHuyen.textColor = UIColor.black
        lblQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblQuanHuyen.text = "Quận Huyện"
        detailViewDiaChi.addSubview(lblQuanHuyen)
        
        tfQuanHuyen = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblQuanHuyen.frame.origin.y + lblQuanHuyen.frame.size.height + Common.Size(s:10), width: tfThanhPho.frame.size.width , height: tfThanhPho.frame.size.height ));
        tfQuanHuyen.placeholder = "Quận/Huyện"
        tfQuanHuyen.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyen.borderStyle = UITextField.BorderStyle.roundedRect
        tfQuanHuyen.autocorrectionType = UITextAutocorrectionType.no
        tfQuanHuyen.keyboardType = UIKeyboardType.default
        tfQuanHuyen.returnKeyType = UIReturnKeyType.done
        tfQuanHuyen.clearButtonMode = UITextField.ViewMode.whileEditing
        tfQuanHuyen.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfQuanHuyen.delegate = self
        tfQuanHuyen.isEnabled = false
        detailViewDiaChi.addSubview(tfQuanHuyen)
        
        // Start visible - Default: false
        tfQuanHuyen.startVisible = true
        tfQuanHuyen.theme.bgColor = UIColor.white
        tfQuanHuyen.theme.fontColor = UIColor.black
        tfQuanHuyen.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyen.theme.cellHeight = Common.Size(s:40)
        tfQuanHuyen.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfQuanHuyen.leftViewMode = UITextField.ViewMode.always
        let imageButtonDistrict = UIImageView(frame: CGRect(x: tfQuanHuyen.frame.size.height/4, y: tfQuanHuyen.frame.size.height/4, width: tfQuanHuyen.frame.size.height/2, height: tfQuanHuyen.frame.size.height/2))
        imageButtonDistrict.image = UIImage(named: "German House-50")
        imageButtonDistrict.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDistrictButton = UIView()
        leftViewDistrictButton.addSubview(imageButtonDistrict)
        leftViewDistrictButton.frame = CGRect(x: 0, y: 0, width: tfQuanHuyen.frame.size.height, height: tfQuanHuyen.frame.size.height)
        tfQuanHuyen.leftView = leftViewDistrictButton
        
        tfQuanHuyen.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfQuanHuyen.text = item.title
            let obj =  self.listDistricts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectDistrict = "\(obj)"
                self.selectPrecinct = ""
                self.tfPhuongXa.text = ""
                self.listPrecincts.removeAll()
                MPOSAPIManager.mpos_FRT_SP_Mirae_loadPrecinct(ProvinceCode:self.selectProvice, DistrictCode: self.selectDistrict, handler: { (results, error) in
                    self.listPrecincts = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfPhuongXa.filterStrings(list)
                    self.tfPhuongXa.becomeFirstResponder()
                })
            }
        }
        
        
        lblPhuongXa = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfQuanHuyen.frame.size.height + tfQuanHuyen.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhuongXa.textAlignment = .left
        lblPhuongXa.textColor = UIColor.black
        lblPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhuongXa.text = "Phường Xã"
        detailViewDiaChi.addSubview(lblPhuongXa)
        
        tfPhuongXa = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblPhuongXa.frame.origin.y + lblPhuongXa.frame.size.height + Common.Size(s:10), width: tfQuanHuyen.frame.size.width , height: tfQuanHuyen.frame.size.height ));
        tfPhuongXa.placeholder = "Phường/Xã"
        tfPhuongXa.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhuongXa.autocorrectionType = UITextAutocorrectionType.no
        tfPhuongXa.keyboardType = UIKeyboardType.default
        tfPhuongXa.returnKeyType = UIReturnKeyType.done
        tfPhuongXa.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhuongXa.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhuongXa.delegate = self
        tfPhuongXa.isEnabled = false
        detailViewDiaChi.addSubview(tfPhuongXa)
        
        // Start visible - Default: false
        tfPhuongXa.startVisible = true
        tfPhuongXa.theme.bgColor = UIColor.white
        tfPhuongXa.theme.fontColor = UIColor.black
        tfPhuongXa.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXa.theme.cellHeight = Common.Size(s:40)
        tfPhuongXa.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfPhuongXa.leftViewMode = UITextField.ViewMode.always
        let imageButtonWards = UIImageView(frame: CGRect(x: tfPhuongXa.frame.size.height/4, y: tfPhuongXa.frame.size.height/4, width: tfPhuongXa.frame.size.height/2, height: tfPhuongXa.frame.size.height/2))
        imageButtonWards.image = UIImage(named: "Visit-50")
        imageButtonWards.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewWardsButton = UIView()
        leftViewWardsButton.addSubview(imageButtonWards)
        leftViewWardsButton.frame = CGRect(x: 0, y: 0, width: tfPhuongXa.frame.size.height, height: tfPhuongXa.frame.size.height)
        tfPhuongXa.leftView = leftViewWardsButton
        tfPhuongXa.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfPhuongXa.text = item.title
            let obj =  self.listPrecincts.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinct = "\(obj)"
            }
            self.tfSoNha.becomeFirstResponder()
        }
        
        
        lblSoNha = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhuongXa.frame.size.height + tfPhuongXa.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoNha.textAlignment = .left
        lblSoNha.textColor = UIColor.black
        lblSoNha.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoNha.text = "Số Nhà"
        detailViewDiaChi.addSubview(lblSoNha)
        
        tfSoNha = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblSoNha.frame.origin.y + lblSoNha.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSoNha.placeholder = "Số nhà!"
        tfSoNha.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoNha.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoNha.autocorrectionType = UITextAutocorrectionType.no
        tfSoNha.keyboardType = UIKeyboardType.default
        tfSoNha.returnKeyType = UIReturnKeyType.done
        tfSoNha.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoNha.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoNha.delegate = self
        tfSoNha.isEnabled = false
        detailViewDiaChi.addSubview(tfSoNha)
        
        detailViewDiaChi.frame.size.height = tfSoNha.frame.size.height + tfSoNha.frame.origin.y + Common.Size(s:10)
        
        
        
        
        label2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: detailViewDiaChi.frame.origin.y + detailViewDiaChi.frame.size.height , width: self.view.frame.width - Common.Size(s: 180), height: Common.Size(s: 35)))
        label2.text = "ĐỊA CHỈ TẠM TRÚ (*)"
        label2.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label2)
        
//        lbShowTamTru = UILabel(frame: CGRect(x: label2.frame.origin.x + label2.frame.size.width, y: detailViewDiaChi.frame.origin.y + detailViewDiaChi.frame.size.height + Common.Size(s: 5) , width:scrollView.frame.size.width/2 - Common.Size(s:15), height: Common.Size(s: 14)))
//        lbShowTamTru.textAlignment = .right
//        lbShowTamTru.textColor = UIColor(netHex:0x04AB6E)
//        lbShowTamTru.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
//        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
//        let underlineAttributedString = NSAttributedString(string: "Ẩn/Hiện", attributes: underlineAttribute)
//        lbShowTamTru.attributedText = underlineAttributedString
//        scrollView.addSubview(lbShowTamTru)
//        let tapShowTamTru = UITapGestureRecognizer(target: self, action: #selector(DetailInfoCustomerMiraeViewController.tapAnHienTamTru))
//        lbShowTamTru.isUserInteractionEnabled = true
//        lbShowTamTru.addGestureRecognizer(tapShowTamTru)
        
        viewTamTru = UIView()
        viewTamTru.frame = CGRect(x: 0, y:label2.frame.origin.y + label2.frame.size.height + Common.Size(s: 5) , width: scrollView.frame.size.width, height: 0)
        viewTamTru.backgroundColor = UIColor.white
        scrollView.addSubview(viewTamTru)
        
        
        lblThanhPhoTamTru = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblThanhPhoTamTru.textAlignment = .left
        lblThanhPhoTamTru.textColor = UIColor.black
        lblThanhPhoTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblThanhPhoTamTru.text = "Thành Phố"
        viewTamTru.addSubview(lblThanhPhoTamTru)
        
        tfThanhPhoTamTru = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblThanhPhoTamTru.frame.origin.y + lblThanhPhoTamTru.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40) ));
        
        tfThanhPhoTamTru.placeholder = "Thành phố"
        tfThanhPhoTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThanhPhoTamTru.borderStyle = UITextField.BorderStyle.roundedRect
        tfThanhPhoTamTru.autocorrectionType = UITextAutocorrectionType.no
        tfThanhPhoTamTru.keyboardType = UIKeyboardType.default
        tfThanhPhoTamTru.returnKeyType = UIReturnKeyType.done
        tfThanhPhoTamTru.clearButtonMode = UITextField.ViewMode.whileEditing
        tfThanhPhoTamTru.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfThanhPhoTamTru.delegate = self
        tfThanhPhoTamTru.isEnabled = false
        viewTamTru.addSubview(tfThanhPhoTamTru)
        
        // Start visible - Default: false
        tfThanhPhoTamTru.startVisible = true
        tfThanhPhoTamTru.theme.bgColor = UIColor.white
        tfThanhPhoTamTru.theme.fontColor = UIColor.black
        tfThanhPhoTamTru.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThanhPhoTamTru.theme.cellHeight = Common.Size(s:40)
        tfThanhPhoTamTru.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        tfThanhPhoTamTru.leftViewMode = UITextField.ViewMode.always
        let imageButton1 = UIImageView(frame: CGRect(x: tfThanhPhoTamTru.frame.size.height/4, y: tfThanhPhoTamTru.frame.size.height/4, width: tfThanhPhoTamTru.frame.size.height/2, height: tfThanhPhoTamTru.frame.size.height/2))
        imageButton1.image = UIImage(named: "City-50")
        imageButton1.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewCityButton1 = UIView()
        leftViewCityButton1.addSubview(imageButton1)
        leftViewCityButton1.frame = CGRect(x: 0, y: 0, width: tfThanhPhoTamTru.frame.size.height, height: tfThanhPhoTamTru.frame.size.height)
        tfThanhPhoTamTru.leftView = leftViewCityButton1
        
        tfThanhPhoTamTru.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfThanhPhoTamTru.text = item.title
            
            self.selectDistrictTamTru = ""
            self.tfQuanHuyenTamTru.text = ""
            
            self.selectPrecinctTamTru = ""
            self.tfPhuongXaTamTru.text = ""
            
            let obj =  self.listProvices.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectProviceTamTru = "\(obj)"
                MPOSAPIManager.mpos_FRT_SP_Mirae_loadDistrict(ProvinceCode: self.selectProviceTamTru, handler: { (results, error) in
                    self.listDistrictsTamTru.removeAll()
                    self.listPrecinctsTamTru.removeAll()
                    self.listDistrictsTamTru = results
                    var listDistrictTemp:[String] = []
                    for item in results {
                        listDistrictTemp.append(item.Text)
                    }
                    self.tfQuanHuyenTamTru.filterStrings(listDistrictTemp)
                    self.tfQuanHuyenTamTru.becomeFirstResponder()
                })
            }
        }
        
        lblQuanHuyenTamTru = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfThanhPhoTamTru.frame.size.height + tfThanhPhoTamTru.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblQuanHuyenTamTru.textAlignment = .left
        lblQuanHuyenTamTru.textColor = UIColor.black
        lblQuanHuyenTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblQuanHuyenTamTru.text = "Quận Huyện"
        viewTamTru.addSubview(lblQuanHuyenTamTru)
        
        tfQuanHuyenTamTru = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblQuanHuyenTamTru.frame.origin.y + lblQuanHuyenTamTru.frame.size.height + Common.Size(s:10), width: tfThanhPho.frame.size.width , height: tfThanhPho.frame.size.height ));
        tfQuanHuyenTamTru.placeholder = "Quận/Huyện"
        tfQuanHuyenTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyenTamTru.borderStyle = UITextField.BorderStyle.roundedRect
        tfQuanHuyenTamTru.autocorrectionType = UITextAutocorrectionType.no
        tfQuanHuyenTamTru.keyboardType = UIKeyboardType.default
        tfQuanHuyenTamTru.returnKeyType = UIReturnKeyType.done
        tfQuanHuyenTamTru.clearButtonMode = UITextField.ViewMode.whileEditing
        tfQuanHuyenTamTru.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfQuanHuyenTamTru.delegate = self
        tfQuanHuyenTamTru.isEnabled = false
        viewTamTru.addSubview(tfQuanHuyenTamTru)
        
        // Start visible - Default: false
        tfQuanHuyenTamTru.startVisible = true
        tfQuanHuyenTamTru.theme.bgColor = UIColor.white
        tfQuanHuyenTamTru.theme.fontColor = UIColor.black
        tfQuanHuyenTamTru.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfQuanHuyenTamTru.theme.cellHeight = Common.Size(s:40)
        tfQuanHuyenTamTru.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfQuanHuyenTamTru.leftViewMode = UITextField.ViewMode.always
        let imageButtonDistrict2 = UIImageView(frame: CGRect(x: tfQuanHuyen.frame.size.height/4, y: tfQuanHuyen.frame.size.height/4, width: tfQuanHuyen.frame.size.height/2, height: tfQuanHuyen.frame.size.height/2))
        imageButtonDistrict2.image = UIImage(named: "German House-50")
        imageButtonDistrict2.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewDistrictButton2 = UIView()
        leftViewDistrictButton2.addSubview(imageButtonDistrict2)
        leftViewDistrictButton2.frame = CGRect(x: 0, y: 0, width: tfQuanHuyen.frame.size.height, height: tfQuanHuyen.frame.size.height)
        tfQuanHuyenTamTru.leftView = leftViewDistrictButton2
        
        tfQuanHuyenTamTru.itemSelectionHandler = { filteredResults, itemPosition in
            // Just in case you need the item position
            let item = filteredResults[itemPosition]
            
            self.tfQuanHuyenTamTru.text = item.title
            let obj =  self.listDistrictsTamTru.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectDistrictTamTru = "\(obj)"
                self.selectPrecinctTamTru = ""
                self.tfPhuongXaTamTru.text = ""
                MPOSAPIManager.mpos_FRT_SP_Mirae_loadPrecinct(ProvinceCode:self.selectProviceTamTru, DistrictCode: self.selectDistrictTamTru, handler: { (results, error) in
                    self.listPrecinctsTamTru.removeAll()
                    self.listPrecinctsTamTru = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfPhuongXaTamTru.filterStrings(list)
                    self.tfPhuongXaTamTru.becomeFirstResponder()
                })
            }
        }
        
        
        lblPhuongXaTamTru = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfQuanHuyenTamTru.frame.size.height + tfQuanHuyenTamTru.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblPhuongXaTamTru.textAlignment = .left
        lblPhuongXaTamTru.textColor = UIColor.black
        lblPhuongXaTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblPhuongXaTamTru.text = "Phường Xã"
        viewTamTru.addSubview(lblPhuongXaTamTru)
        
        tfPhuongXaTamTru = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblPhuongXaTamTru.frame.origin.y + lblPhuongXaTamTru.frame.size.height + Common.Size(s:10), width: tfQuanHuyen.frame.size.width , height: tfQuanHuyen.frame.size.height ));
        tfPhuongXaTamTru.placeholder = "Phường/Xã"
        tfPhuongXaTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXaTamTru.borderStyle = UITextField.BorderStyle.roundedRect
        tfPhuongXaTamTru.autocorrectionType = UITextAutocorrectionType.no
        tfPhuongXaTamTru.keyboardType = UIKeyboardType.default
        tfPhuongXaTamTru.returnKeyType = UIReturnKeyType.done
        tfPhuongXaTamTru.clearButtonMode = UITextField.ViewMode.whileEditing
        tfPhuongXaTamTru.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfPhuongXaTamTru.delegate = self
        tfPhuongXaTamTru.isEnabled = false
        viewTamTru.addSubview(tfPhuongXaTamTru)
        
        // Start visible - Default: false
        tfPhuongXaTamTru.startVisible = true
        tfPhuongXaTamTru.theme.bgColor = UIColor.white
        tfPhuongXaTamTru.theme.fontColor = UIColor.black
        tfPhuongXaTamTru.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfPhuongXaTamTru.theme.cellHeight = Common.Size(s:40)
        tfPhuongXaTamTru.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfPhuongXaTamTru.leftViewMode = UITextField.ViewMode.always
        let imageButtonWards3 = UIImageView(frame: CGRect(x: tfPhuongXaTamTru.frame.size.height/4, y: tfPhuongXaTamTru.frame.size.height/4, width: tfPhuongXaTamTru.frame.size.height/2, height: tfPhuongXa.frame.size.height/2))
        imageButtonWards3.image = UIImage(named: "Visit-50")
        imageButtonWards3.contentMode = UIView.ContentMode.scaleAspectFit
        
        let leftViewWardsButton3 = UIView()
        leftViewWardsButton3.addSubview(imageButtonWards3)
        leftViewWardsButton3.frame = CGRect(x: 0, y: 0, width: tfPhuongXaTamTru.frame.size.height, height: tfPhuongXaTamTru.frame.size.height)
        tfPhuongXaTamTru.leftView = leftViewWardsButton3
        tfPhuongXaTamTru.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfPhuongXaTamTru.text = item.title
            let obj =  self.listPrecinctsTamTru.filter{ $0.Text == "\(item.title)" }.first
            if let obj = obj?.Value {
                self.selectPrecinctTamTru = "\(obj)"
            }
            self.tfSoNhaTamTru.becomeFirstResponder()
        }
        
        lblSoNhaTamTru = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfPhuongXaTamTru.frame.size.height + tfPhuongXaTamTru.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSoNhaTamTru.textAlignment = .left
        lblSoNhaTamTru.textColor = UIColor.black
        lblSoNhaTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSoNhaTamTru.text = "Số nhà"
        viewTamTru.addSubview(lblSoNhaTamTru)
        
        tfSoNhaTamTru = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblSoNhaTamTru.frame.origin.y + lblSoNhaTamTru.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfSoNhaTamTru.placeholder = "Số nhà!"
        tfSoNhaTamTru.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfSoNhaTamTru.borderStyle = UITextField.BorderStyle.roundedRect
        tfSoNhaTamTru.autocorrectionType = UITextAutocorrectionType.no
        tfSoNhaTamTru.keyboardType = UIKeyboardType.default
        tfSoNhaTamTru.returnKeyType = UIReturnKeyType.done
        tfSoNhaTamTru.clearButtonMode = UITextField.ViewMode.whileEditing
        tfSoNhaTamTru.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfSoNhaTamTru.delegate = self
        tfSoNhaTamTru.isEnabled = false
        viewTamTru.addSubview(tfSoNhaTamTru)
        
        
  
        
        viewTamTru.frame.size.height = tfSoNhaTamTru.frame.size.height + tfSoNhaTamTru.frame.origin.y + Common.Size(s: 10)
        heightUploadViewTamTru = viewTamTru.frame.size.height
        //viewTamTru.frame.size.height = 0
        
        lblThongTinNgheNghiep = UILabel(frame: CGRect(x: Common.Size(s: 15), y: viewTamTru.frame.origin.y + viewTamTru.frame.size.height  , width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lblThongTinNgheNghiep.text = "THÔNG TIN NGHỀ NGHIỆP (*)"
        lblThongTinNgheNghiep.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        lblThongTinNgheNghiep.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView.addSubview(lblThongTinNgheNghiep)
        
        
        detailViewNgheNghiep = UIView()
        detailViewNgheNghiep.frame = CGRect(x: 0, y:lblThongTinNgheNghiep.frame.origin.y + lblThongTinNgheNghiep.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        detailViewNgheNghiep.backgroundColor = UIColor.white
        scrollView.addSubview(detailViewNgheNghiep)
        
        lblTenCongTy = UILabel(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTenCongTy.textAlignment = .left
        lblTenCongTy.textColor = UIColor.black
        lblTenCongTy.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblTenCongTy.text = "Tên Công Ty"
        detailViewNgheNghiep.addSubview(lblTenCongTy)
        
        
        
        tfTenCongTy = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblTenCongTy.frame.origin.y + lblTenCongTy.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfTenCongTy.placeholder = "Số nhà!"
        tfTenCongTy.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfTenCongTy.borderStyle = UITextField.BorderStyle.roundedRect
        tfTenCongTy.autocorrectionType = UITextAutocorrectionType.no
        tfTenCongTy.keyboardType = UIKeyboardType.default
        tfTenCongTy.returnKeyType = UIReturnKeyType.done
        tfTenCongTy.clearButtonMode = UITextField.ViewMode.whileEditing
        tfTenCongTy.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfTenCongTy.delegate = self
        tfTenCongTy.isEnabled = false
        detailViewNgheNghiep.addSubview(tfTenCongTy)
        
        lblViTriCongTac = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfTenCongTy.frame.size.height + tfTenCongTy.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblViTriCongTac.textAlignment = .left
        lblViTriCongTac.textColor = UIColor.black
        lblViTriCongTac.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblViTriCongTac.text = "Chức vụ"
        detailViewNgheNghiep.addSubview(lblViTriCongTac)
        
        
        tfViTri = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblViTriCongTac.frame.origin.y + lblViTriCongTac.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfViTri.placeholder = "Nhập Chức vụ!"
        tfViTri.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfViTri.borderStyle = UITextField.BorderStyle.roundedRect
        tfViTri.autocorrectionType = UITextAutocorrectionType.no
        tfViTri.keyboardType = UIKeyboardType.default
        tfViTri.returnKeyType = UIReturnKeyType.done
        tfViTri.clearButtonMode = UITextField.ViewMode.whileEditing
        tfViTri.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfViTri.delegate = self
        tfViTri.isEnabled = false
        detailViewNgheNghiep.addSubview(tfViTri)
        
        //        let lblSoNamLamViec = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfViTri.frame.size.height + tfViTri.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        //        lblSoNamLamViec.textAlignment = .left
        //        lblSoNamLamViec.textColor = UIColor.black
        //        lblSoNamLamViec.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        //        lblSoNamLamViec.text = "Số Năm Làm Việc"
        //        detailViewNgheNghiep.addSubview(lblSoNamLamViec)
        //
        //        tfSoNamLamViec = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblSoNamLamViec.frame.origin.y + lblSoNamLamViec.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        //        tfSoNamLamViec.placeholder = "Nhập Số Năm Làm Việc!"
        //        tfSoNamLamViec.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        //        tfSoNamLamViec.borderStyle = UITextField.BorderStyle.roundedRect
        //        tfSoNamLamViec.autocorrectionType = UITextAutocorrectionType.no
        //        tfSoNamLamViec.keyboardType = UIKeyboardType.numberPad
        //        tfSoNamLamViec.returnKeyType = UIReturnKeyType.done
        //        tfSoNamLamViec.clearButtonMode = UITextField.ViewMode.whileEditing
        //        tfSoNamLamViec.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        //        tfSoNamLamViec.delegate = self
        //        detailViewNgheNghiep.addSubview(tfSoNamLamViec)
        
        
        lblLuong = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfViTri.frame.size.height + tfViTri.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblLuong.textAlignment = .left
        lblLuong.textColor = UIColor.black
        lblLuong.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblLuong.text = "Lương"
        detailViewNgheNghiep.addSubview(lblLuong)
        
        tfLuong = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblLuong.frame.origin.y + lblLuong.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfLuong.placeholder = "Nhập Lương !"
        tfLuong.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLuong.borderStyle = UITextField.BorderStyle.roundedRect
        tfLuong.autocorrectionType = UITextAutocorrectionType.no
        tfLuong.keyboardType = UIKeyboardType.numberPad
        tfLuong.returnKeyType = UIReturnKeyType.done
        tfLuong.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLuong.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLuong.delegate = self
        tfLuong.isEnabled = false
        tfLuong.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
        detailViewNgheNghiep.addSubview(tfLuong)
        

        
        
        
        
        lblLoaiChungTu = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfLuong.frame.size.height + tfLuong.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblLoaiChungTu.textAlignment = .left
        lblLoaiChungTu.textColor = UIColor.black
        lblLoaiChungTu.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblLoaiChungTu.text = "Loại Chứng Từ"
        detailViewNgheNghiep.addSubview(lblLoaiChungTu)
        
        
        tfLoaiChungTu = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblLoaiChungTu.frame.origin.y + lblLoaiChungTu.frame.size.height + Common.Size(s:10), width: tfQuanHuyen.frame.size.width , height: tfQuanHuyen.frame.size.height ));
        tfLoaiChungTu.placeholder = "Loại Chứng Từ"
        tfLoaiChungTu.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLoaiChungTu.borderStyle = UITextField.BorderStyle.roundedRect
        tfLoaiChungTu.autocorrectionType = UITextAutocorrectionType.no
        tfLoaiChungTu.keyboardType = UIKeyboardType.default
        tfLoaiChungTu.returnKeyType = UIReturnKeyType.done
        tfLoaiChungTu.clearButtonMode = UITextField.ViewMode.whileEditing
        tfLoaiChungTu.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfLoaiChungTu.delegate = self
        tfLoaiChungTu.isEnabled = false
        detailViewNgheNghiep.addSubview(tfLoaiChungTu)
        
        // Start visible - Default: false
        tfLoaiChungTu.startVisible = true
        tfLoaiChungTu.theme.bgColor = UIColor.white
        tfLoaiChungTu.theme.fontColor = UIColor.black
        tfLoaiChungTu.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfLoaiChungTu.theme.cellHeight = Common.Size(s:40)
        tfLoaiChungTu.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfLoaiChungTu.leftViewMode = UITextField.ViewMode.always
        
        tfLoaiChungTu.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfLoaiChungTu.text = item.title
            let obj =  self.listLoaiChungTu.filter{ $0.name == "\(item.title)" }.first
            if let obj = obj?.code {
                self.selectLoaiChungTu = "\(obj)"
            }
            if(self.selectLoaiChungTu == "FB"){
                
                
                self.hideGPLX()
            }else{
                self.hideSHK()
            }
            self.tfNgayThanhToan.becomeFirstResponder()
        }
        
//        lblCMNDCCCD = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfLoaiChungTu.frame.size.height + tfLoaiChungTu.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
//        lblCMNDCCCD.textAlignment = .left
//        lblCMNDCCCD.textColor = UIColor.black
//        lblCMNDCCCD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
//        lblCMNDCCCD.text = "Số CMND/CCCD khác (nếu có)!"
//        detailViewNgheNghiep.addSubview(lblCMNDCCCD)
//
//        tfCMNDCCCD = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblCMNDCCCD.frame.origin.y + lblCMNDCCCD.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
//        tfCMNDCCCD.placeholder = "Số CMND/CCCD khác (nếu có)!"
//        tfCMNDCCCD.font = UIFont.systemFont(ofSize: Common.Size(s:15))
//        tfCMNDCCCD.borderStyle = UITextField.BorderStyle.roundedRect
//        tfCMNDCCCD.autocorrectionType = UITextAutocorrectionType.no
//        tfCMNDCCCD.keyboardType = UIKeyboardType.numberPad
//        tfCMNDCCCD.returnKeyType = UIReturnKeyType.done
//        tfCMNDCCCD.clearButtonMode = UITextField.ViewMode.whileEditing
//        tfCMNDCCCD.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        tfCMNDCCCD.delegate = self
//        tfCMNDCCCD.isEnabled = false
//        detailViewNgheNghiep.addSubview(tfCMNDCCCD)
        
        
        lblNgayThanhToan = UILabel(frame: CGRect(x: Common.Size(s:15), y: tfLoaiChungTu.frame.size.height + tfLoaiChungTu.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblNgayThanhToan.textAlignment = .left
        lblNgayThanhToan.textColor = UIColor.black
        lblNgayThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblNgayThanhToan.text = "Ngày thanh toán tiếp theo"
        detailViewNgheNghiep.addSubview(lblNgayThanhToan)
        
        tfNgayThanhToan = SearchTextField(frame: CGRect(x: Common.Size(s:15), y: lblNgayThanhToan.frame.origin.y + lblNgayThanhToan.frame.size.height + Common.Size(s:10), width: tfQuanHuyen.frame.size.width , height: tfQuanHuyen.frame.size.height ));
        tfNgayThanhToan.placeholder = "Ngày thanh toán tiếp theo"
        tfNgayThanhToan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgayThanhToan.borderStyle = UITextField.BorderStyle.roundedRect
        tfNgayThanhToan.autocorrectionType = UITextAutocorrectionType.no
        tfNgayThanhToan.keyboardType = UIKeyboardType.default
        tfNgayThanhToan.returnKeyType = UIReturnKeyType.done
        tfNgayThanhToan.clearButtonMode = UITextField.ViewMode.whileEditing
        tfNgayThanhToan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfNgayThanhToan.delegate = self
        tfNgayThanhToan.isEnabled  = false
        detailViewNgheNghiep.addSubview(tfNgayThanhToan)
        
        // Start visible - Default: false
        tfNgayThanhToan.startVisible = true
        tfNgayThanhToan.theme.bgColor = UIColor.white
        tfNgayThanhToan.theme.fontColor = UIColor.black
        tfNgayThanhToan.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfNgayThanhToan.theme.cellHeight = Common.Size(s:40)
        tfNgayThanhToan.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        
        tfNgayThanhToan.leftViewMode = UITextField.ViewMode.always
        
        tfNgayThanhToan.itemSelectionHandler = { filteredResults, itemPosition in
            let item = filteredResults[itemPosition]
            self.tfNgayThanhToan.text = item.title
            let obj =  self.listNgayThanhToan.filter{ $0.Name == "\(item.title)" }.first
            if let obj = obj?.Code {
                self.selectNgayThanhToan = "\(obj)"
            }
            self.tfHoTen.becomeFirstResponder()
        }
        
        detailViewNgheNghiep.frame.size.height = tfNgayThanhToan.frame.size.height + tfNgayThanhToan.frame.origin.y + Common.Size(s:10)
        
        label3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: detailViewNgheNghiep.frame.origin.y + detailViewNgheNghiep.frame.size.height + Common.Size(s:10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        label3.text = "THÔNG TIN THAM CHIẾU (*)"
        label3.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
        scrollView.addSubview(label3)
        
        viewThongTinThamChieu = UIView()
        viewThongTinThamChieu.frame = CGRect(x: 0, y:label3.frame.origin.y + label3.frame.size.height + Common.Size(s: 10) , width: scrollView.frame.size.width, height: Common.Size(s: 300))
        viewThongTinThamChieu.backgroundColor = UIColor.white
        scrollView.addSubview(viewThongTinThamChieu)
        
        let lblHoTenTTTC = UILabel(frame: CGRect(x: Common.Size(s:15), y:  Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHoTenTTTC.textAlignment = .left
        lblHoTenTTTC.textColor = UIColor.black
        lblHoTenTTTC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHoTenTTTC.text = "Họ và tên"
        viewThongTinThamChieu.addSubview(lblHoTenTTTC)
        
        tfHoTen = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblHoTenTTTC.frame.origin.y + lblHoTenTTTC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfHoTen.placeholder = "Họ và tên"
        tfHoTen.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTen.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTen.autocorrectionType = UITextAutocorrectionType.no
        tfHoTen.keyboardType = UIKeyboardType.default
        tfHoTen.returnKeyType = UIReturnKeyType.done
        tfHoTen.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTen.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTen.delegate = self
        tfHoTen.isEnabled = false
        viewThongTinThamChieu.addSubview(tfHoTen)
        
        let lblMoiQuanHeTTTC = UILabel(frame: CGRect(x: Common.Size(s:15), y:  tfHoTen.frame.size.height + tfHoTen.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMoiQuanHeTTTC.textAlignment = .left
        lblMoiQuanHeTTTC.textColor = UIColor.black
        lblMoiQuanHeTTTC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMoiQuanHeTTTC.text = "Mối quan hệ"
        viewThongTinThamChieu.addSubview(lblMoiQuanHeTTTC)
        
        tfMoiQuanHe = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblMoiQuanHeTTTC.frame.origin.y + lblMoiQuanHeTTTC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfMoiQuanHe.placeholder = "Mối quan hệ"
        tfMoiQuanHe.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoiQuanHe.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoiQuanHe.autocorrectionType = UITextAutocorrectionType.no
        tfMoiQuanHe.keyboardType = UIKeyboardType.default
        tfMoiQuanHe.returnKeyType = UIReturnKeyType.done
        tfMoiQuanHe.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoiQuanHe.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoiQuanHe.delegate = self
        tfMoiQuanHe.isEnabled = false
        viewThongTinThamChieu.addSubview(tfMoiQuanHe)
        
        let lblSDTTTTC = UILabel(frame: CGRect(x: Common.Size(s:15), y:  tfMoiQuanHe.frame.size.height + tfMoiQuanHe.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSDTTTTC.textAlignment = .left
        lblSDTTTTC.textColor = UIColor.black
        lblSDTTTTC.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSDTTTTC.text = "Số điện thoại"
        viewThongTinThamChieu.addSubview(lblSDTTTTC)
        
        tfThongTinLienLac = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblSDTTTTC.frame.origin.y + lblSDTTTTC.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfThongTinLienLac.placeholder = "Mối quan hệ"
        tfThongTinLienLac.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThongTinLienLac.borderStyle = UITextField.BorderStyle.roundedRect
        tfThongTinLienLac.autocorrectionType = UITextAutocorrectionType.no
        tfThongTinLienLac.keyboardType = UIKeyboardType.numberPad
        tfThongTinLienLac.returnKeyType = UIReturnKeyType.done
        tfThongTinLienLac.clearButtonMode = UITextField.ViewMode.whileEditing
        tfThongTinLienLac.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfThongTinLienLac.delegate = self
        tfThongTinLienLac.isEnabled = false
        viewThongTinThamChieu.addSubview(tfThongTinLienLac)
        
        let lblHoTenTTTC2 = UILabel(frame: CGRect(x: Common.Size(s:15), y:  tfThongTinLienLac.frame.origin.y + tfThongTinLienLac.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblHoTenTTTC2.textAlignment = .left
        lblHoTenTTTC2.textColor = UIColor.black
        lblHoTenTTTC2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblHoTenTTTC2.text = "Họ và tên người thân 2"
        viewThongTinThamChieu.addSubview(lblHoTenTTTC2)
        
        tfHoTen2 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblHoTenTTTC2.frame.origin.y + lblHoTenTTTC2.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfHoTen2.placeholder = "Họ và tên"
        tfHoTen2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfHoTen2.borderStyle = UITextField.BorderStyle.roundedRect
        tfHoTen2.autocorrectionType = UITextAutocorrectionType.no
        tfHoTen2.keyboardType = UIKeyboardType.default
        tfHoTen2.returnKeyType = UIReturnKeyType.done
        tfHoTen2.clearButtonMode = UITextField.ViewMode.whileEditing
        tfHoTen2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfHoTen2.delegate = self
        tfHoTen2.isEnabled = false
        viewThongTinThamChieu.addSubview(tfHoTen2)
        
        
        let lblMoiQuanHeTTTC2 = UILabel(frame: CGRect(x: Common.Size(s:15), y:  tfHoTen2.frame.size.height + tfHoTen2.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblMoiQuanHeTTTC2.textAlignment = .left
        lblMoiQuanHeTTTC2.textColor = UIColor.black
        lblMoiQuanHeTTTC2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblMoiQuanHeTTTC2.text = "Mối quan hệ người thân 2"
        viewThongTinThamChieu.addSubview(lblMoiQuanHeTTTC2)
        
        tfMoiQuanHe2 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblMoiQuanHeTTTC2.frame.origin.y + lblMoiQuanHeTTTC2.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
        tfMoiQuanHe2.placeholder = "Mối quan hệ"
        tfMoiQuanHe2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfMoiQuanHe2.borderStyle = UITextField.BorderStyle.roundedRect
        tfMoiQuanHe2.autocorrectionType = UITextAutocorrectionType.no
        tfMoiQuanHe2.keyboardType = UIKeyboardType.default
        tfMoiQuanHe2.returnKeyType = UIReturnKeyType.done
        tfMoiQuanHe2.clearButtonMode = UITextField.ViewMode.whileEditing
        tfMoiQuanHe2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfMoiQuanHe2.delegate = self
        tfMoiQuanHe2.isEnabled = false
        viewThongTinThamChieu.addSubview(tfMoiQuanHe2)
        
        let lblSDTTTTC2 = UILabel(frame: CGRect(x: Common.Size(s:15), y:  tfMoiQuanHe2.frame.size.height + tfMoiQuanHe2.frame.origin.y + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblSDTTTTC2.textAlignment = .left
        lblSDTTTTC2.textColor = UIColor.black
        lblSDTTTTC2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lblSDTTTTC2.text = "Số điện thoại người liên hệ 2"
        viewThongTinThamChieu.addSubview(lblSDTTTTC2)
        
        tfThongTinLienLac2 = UITextField(frame: CGRect(x: Common.Size(s:15), y: lblSDTTTTC2.frame.origin.y + lblSDTTTTC2.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:30) , height: Common.Size(s:40)));
     
        tfThongTinLienLac2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        tfThongTinLienLac2.borderStyle = UITextField.BorderStyle.roundedRect
        tfThongTinLienLac2.autocorrectionType = UITextAutocorrectionType.no
        tfThongTinLienLac2.keyboardType = UIKeyboardType.numberPad
        tfThongTinLienLac2.returnKeyType = UIReturnKeyType.done
        tfThongTinLienLac2.clearButtonMode = UITextField.ViewMode.whileEditing
        tfThongTinLienLac2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        tfThongTinLienLac2.delegate = self
        tfThongTinLienLac2.isEnabled = false
        viewThongTinThamChieu.addSubview(tfThongTinLienLac2)
 
        viewThongTinThamChieu.frame.size.height = tfThongTinLienLac2.frame.origin.y + tfThongTinLienLac2.frame.size.height + Common.Size(s:10)
        
        if(self.fullFlagInfo.count > 0){
            for item in self.fullFlagInfo{
                if(item == "1"){
                    isShowCMND = true
                    tfNoiCapCMND.isEnabled = true
                    tfNgayCapCMND.isEnabled = true
                    
                }
                if(item == "2"){
                    isShowGPLXSHK = true
                    
                }
                if(item == "3"){
                    isShowCD = true
                }
                if(item == "4"){
                    
                    //tfNgaySinh.isEnabled = true
                   // lbNgaySinh.textColor = .red
                    
                }
                if(item == "5"){
                    lblThanhPho.textColor = .red
                    tfThanhPho.isEnabled = true
                    
                    lblQuanHuyen.textColor = .red
                    tfQuanHuyen.isEnabled = true
                    
                    lblPhuongXa.textColor = .red
                    tfPhuongXa.isEnabled = true
                    
                    lblSoNha.textColor = .red
                    tfSoNha.isEnabled = true
                    
                    lblThanhPhoTamTru.textColor = .red
                    tfThanhPhoTamTru.isEnabled = true
                    
                    lblQuanHuyenTamTru.textColor = .red
                    tfQuanHuyenTamTru.isEnabled = true
                    
                    lblPhuongXaTamTru.textColor = .red
                    tfPhuongXaTamTru.isEnabled = true
                    
                    lblSoNhaTamTru.textColor = .red
                    tfSoNhaTamTru.isEnabled = true
                }
                if(item == "6"){
//                    tfSDTKH.isEnabled = true
//                    lbSDTKH.textColor = .red
                }
                if(item == "7"){
                    lblTenCongTy.textColor = .red
                    tfTenCongTy.isEnabled = true
                    
                    lblViTriCongTac.textColor = .red
                    tfViTri.isEnabled = true
                    
                    lblLuong.textColor = .red
                    tfLuong.isEnabled = true
                    
                    lblLoaiChungTu.textColor = .red
                    tfLoaiChungTu.isEnabled = true
                    //  tfCMNDCCCD.isEnabled = true
                    
                    tfNgayThanhToan.isEnabled  = true
                    
                    
                }
                if(item == "8"){
                   
                    tfHoTen.isEnabled = true
                    tfMoiQuanHe.isEnabled = true
                    tfThongTinLienLac.isEnabled = true
                    
                    tfHoTen2.isEnabled = true
                    tfMoiQuanHe2.isEnabled = true
                    tfThongTinLienLac2.isEnabled = true
                    
                    
                }
                
                
            }
        }

        
        viewUpload = UIView(frame: CGRect(x: 0, y: viewThongTinThamChieu.frame.origin.y + viewThongTinThamChieu.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: 0 ))
        viewUpload.backgroundColor = UIColor.white
        scrollView.addSubview(viewUpload)
        
        //---CMND TRUOC
        viewInfoCMNDTruoc = UIView(frame: CGRect(x:0,y:Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDTruoc)
        
        let lbTextCMNDTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDTruoc.textAlignment = .left
        lbTextCMNDTruoc.textColor = UIColor.black
        lbTextCMNDTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDTruoc.text = "Mặt trước CMND (*)"
        viewInfoCMNDTruoc.addSubview(lbTextCMNDTruoc)
        
        viewImageCMNDTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDTruoc.frame.origin.y + lbTextCMNDTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDTruoc.layer.borderWidth = 0.5
        viewImageCMNDTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDTruoc.layer.cornerRadius = 3.0
        viewInfoCMNDTruoc.addSubview(viewImageCMNDTruoc)
        
        let viewCMNDTruocButton = UIImageView(frame: CGRect(x: viewImageCMNDTruoc.frame.size.width/2 - (viewImageCMNDTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDTruoc.frame.size.height * 2/3, height: viewImageCMNDTruoc.frame.size.height * 2/3))
        viewCMNDTruocButton.image = UIImage(named:"AddImage")
        viewCMNDTruocButton.contentMode = .scaleAspectFit
        viewImageCMNDTruoc.addSubview(viewCMNDTruocButton)
        
        
        let lbCMNDTruocButton = UILabel(frame: CGRect(x: 0, y: viewCMNDTruocButton.frame.size.height + viewCMNDTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDTruoc.frame.size.height/3))
        lbCMNDTruocButton.textAlignment = .center
        lbCMNDTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDTruocButton.text = "Thêm hình ảnh"
        viewImageCMNDTruoc.addSubview(lbCMNDTruocButton)
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        
        let tapShowCMNDTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDTruoc))
        viewImageCMNDTruoc.isUserInteractionEnabled = true
        viewImageCMNDTruoc.addGestureRecognizer(tapShowCMNDTruoc)
        
        if(fullFlagArr[0] != "1"){
            viewInfoCMNDTruoc.frame.size.height = 0
            lbTextCMNDTruoc.frame.size.height = 0
            viewImageCMNDTruoc.frame.size.height = 0
            viewCMNDTruocButton.frame.size.height = 0
            lbCMNDTruocButton.frame.size.height = 0
            
        }
        if(isShowCMND == false){
            viewInfoCMNDTruoc.frame.size.height = 0
            lbTextCMNDTruoc.frame.size.height = 0
            viewImageCMNDTruoc.frame.size.height = 0
            viewCMNDTruocButton.frame.size.height = 0
            lbCMNDTruocButton.frame.size.height = 0
        }
        
        
        //---------
        
        //---CMND SAU
        viewInfoCMNDSau = UIView(frame: CGRect(x:0,y:viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoCMNDSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoCMNDSau)
        
        let lbTextCMNDSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextCMNDSau.textAlignment = .left
        lbTextCMNDSau.textColor = UIColor.black
        lbTextCMNDSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextCMNDSau.text = "Mặt sau CMND (*)"
        viewInfoCMNDSau.addSubview(lbTextCMNDSau)
        
        viewImageCMNDSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextCMNDSau.frame.origin.y + lbTextCMNDSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageCMNDSau.layer.borderWidth = 0.5
        viewImageCMNDSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageCMNDSau.layer.cornerRadius = 3.0
        viewInfoCMNDSau.addSubview(viewImageCMNDSau)
        
        let viewCMNDSauButton = UIImageView(frame: CGRect(x: viewImageCMNDSau.frame.size.width/2 - (viewImageCMNDSau.frame.size.height * 2/3)/2, y: 0, width: viewImageCMNDSau.frame.size.height * 2/3, height: viewImageCMNDSau.frame.size.height * 2/3))
        viewCMNDSauButton.image = UIImage(named:"AddImage")
        viewCMNDSauButton.contentMode = .scaleAspectFit
        viewImageCMNDSau.addSubview(viewCMNDSauButton)
        
        let lbCMNDSauButton = UILabel(frame: CGRect(x: 0, y: viewCMNDSauButton.frame.size.height + viewCMNDSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageCMNDSau.frame.size.height/3))
        lbCMNDSauButton.textAlignment = .center
        lbCMNDSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbCMNDSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbCMNDSauButton.text = "Thêm hình ảnh"
        viewImageCMNDSau.addSubview(lbCMNDSauButton)
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        
        let tapShowCMNDSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowCMNDSau))
        viewImageCMNDSau.isUserInteractionEnabled = true
        viewImageCMNDSau.addGestureRecognizer(tapShowCMNDSau)
        if(fullFlagArr[1] != "1"){
            viewInfoCMNDTruoc.frame.size.height = 0
            lbTextCMNDSau.frame.size.height = 0
            viewImageCMNDSau.frame.size.height = 0
            viewCMNDSauButton.frame.size.height = 0
            lbCMNDSauButton.frame.size.height = 0
            
        }
        if(isShowCMND == false){
            viewInfoCMNDTruoc.frame.size.height = 0
            lbTextCMNDSau.frame.size.height = 0
            viewImageCMNDSau.frame.size.height = 0
            viewCMNDSauButton.frame.size.height = 0
            lbCMNDSauButton.frame.size.height = 0
        }
        //
        viewInfoSim = UIView(frame: CGRect(x:0,y:viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoSim.clipsToBounds = true
        viewUpload.addSubview(viewInfoSim)
        
        let lbTextSim = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSim.textAlignment = .left
        lbTextSim.textColor = UIColor.black
        lbTextSim.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSim.text = "Thông Tin Thuê Bao (*)"
        viewInfoSim.addSubview(lbTextSim)
        
        viewImageSim = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSim.frame.origin.y + lbTextSim.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSim.layer.borderWidth = 0.5
        viewImageSim.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSim.layer.cornerRadius = 3.0
        viewInfoSim.addSubview(viewImageSim)
        
        let viewSimButton = UIImageView(frame: CGRect(x: viewImageSim.frame.size.width/2 - (viewImageSim.frame.size.height * 2/3)/2, y: 0, width: viewImageSim.frame.size.height * 2/3, height: viewImageSim.frame.size.height * 2/3))
        viewSimButton.image = UIImage(named:"AddImage")
        viewSimButton.contentMode = .scaleAspectFit
        viewImageSim.addSubview(viewSimButton)
        
        let lbSimButton = UILabel(frame: CGRect(x: 0, y: viewSimButton.frame.size.height + viewSimButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSim.frame.size.height/3))
        lbSimButton.textAlignment = .center
        lbSimButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSimButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSimButton.text = "Thêm hình ảnh"
        viewImageSim.addSubview(lbSimButton)
        viewInfoSim.frame.size.height = viewImageSim.frame.size.height + viewImageSim.frame.origin.y
        
        let tapShowSim = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSim))
        viewImageSim.isUserInteractionEnabled = true
        viewImageSim.addGestureRecognizer(tapShowSim)
        if(fullFlagArr[14] != "1"){
            viewInfoSim.frame.size.height = 0
            lbTextSim.frame.size.height = 0
            viewImageSim.frame.size.height = 0
            viewSimButton.frame.size.height = 0
            lbSimButton.frame.size.height = 0
            
        }
        //
        //---Form TRICH NO TINH DUNG
        viewInfoChanDungKH = UIView(frame: CGRect(x:0,y:viewInfoSim.frame.size.height + viewInfoSim.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoChanDungKH.clipsToBounds = true
        viewUpload.addSubview(viewInfoChanDungKH)
        
        let lbTextTrichNoTD = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextTrichNoTD.textAlignment = .left
        lbTextTrichNoTD.textColor = UIColor.black
        lbTextTrichNoTD.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextTrichNoTD.text = "Chân dung KH chụp tại shop thấy rõ mặt(*)"
        viewInfoChanDungKH.addSubview(lbTextTrichNoTD)
        
        viewImageTrichNoTD = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextTrichNoTD.frame.origin.y + lbTextTrichNoTD.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageTrichNoTD.layer.borderWidth = 0.5
        viewImageTrichNoTD.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageTrichNoTD.layer.cornerRadius = 3.0
        viewInfoChanDungKH.addSubview(viewImageTrichNoTD)
        
        let viewTrichNoTDButton = UIImageView(frame: CGRect(x: viewImageTrichNoTD.frame.size.width/2 - (viewImageTrichNoTD.frame.size.height * 2/3)/2, y: 0, width: viewImageTrichNoTD.frame.size.height * 2/3, height: viewImageTrichNoTD.frame.size.height * 2/3))
        viewTrichNoTDButton.image = UIImage(named:"AddImage")
        viewTrichNoTDButton.contentMode = .scaleAspectFit
        viewImageTrichNoTD.addSubview(viewTrichNoTDButton)
        
        let lbTrichNoTDButton = UILabel(frame: CGRect(x: 0, y: viewTrichNoTDButton.frame.size.height + viewTrichNoTDButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageTrichNoTD.frame.size.height/3))
        lbTrichNoTDButton.textAlignment = .center
        lbTrichNoTDButton.textColor = UIColor(netHex:0xc2c2c2)
        lbTrichNoTDButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTrichNoTDButton.text = "Thêm hình ảnh"
        viewImageTrichNoTD.addSubview(lbTrichNoTDButton)
        viewInfoChanDungKH.frame.size.height = viewImageTrichNoTD.frame.size.height + viewImageTrichNoTD.frame.origin.y
        
        let tapShowTrichNoTD = UITapGestureRecognizer(target: self, action: #selector(self.tapShowChanDungKH))
        viewImageTrichNoTD.isUserInteractionEnabled = true
        viewImageTrichNoTD.addGestureRecognizer(tapShowTrichNoTD)
        
        if(fullFlagArr[2] != "1"){
            viewInfoChanDungKH.frame.size.height = 0
            lbTextTrichNoTD.frame.size.height = 0
            viewImageTrichNoTD.frame.size.height = 0
            viewTrichNoTDButton.frame.size.height = 0
            lbTrichNoTDButton.frame.size.height = 0
            
        }
        if(self.isShowCD == false){
            viewInfoChanDungKH.frame.size.height = 0
            lbTextTrichNoTD.frame.size.height = 0
            viewImageTrichNoTD.frame.size.height = 0
            viewTrichNoTDButton.frame.size.height = 0
            lbTrichNoTDButton.frame.size.height = 0
        }
        
        //---GPLX TRUOC
        viewInfoGPLXTruoc = UIView(frame: CGRect(x:0,y:viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoGPLXTruoc.clipsToBounds = true
        viewUpload.addSubview(viewInfoGPLXTruoc)
        
        let lbTextGPLXTruoc = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGPLXTruoc.textAlignment = .left
        lbTextGPLXTruoc.textColor = UIColor.black
        lbTextGPLXTruoc.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGPLXTruoc.text = "Giấy phép lái xe (mặt trước)"
        viewInfoGPLXTruoc.addSubview(lbTextGPLXTruoc)
        
        viewImageGPLXTruoc = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextGPLXTruoc.frame.origin.y + lbTextGPLXTruoc.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageGPLXTruoc.layer.borderWidth = 0.5
        viewImageGPLXTruoc.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageGPLXTruoc.layer.cornerRadius = 3.0
        viewInfoGPLXTruoc.addSubview(viewImageGPLXTruoc)
        
        let viewGPLXTruocButton = UIImageView(frame: CGRect(x: viewImageGPLXTruoc.frame.size.width/2 - (viewImageGPLXTruoc.frame.size.height * 2/3)/2, y: 0, width: viewImageGPLXTruoc.frame.size.height * 2/3, height: viewImageGPLXTruoc.frame.size.height * 2/3))
        viewGPLXTruocButton.image = UIImage(named:"AddImage")
        viewGPLXTruocButton.contentMode = .scaleAspectFit
        viewImageGPLXTruoc.addSubview(viewGPLXTruocButton)
        
        let lbGPLXTruocButton = UILabel(frame: CGRect(x: 0, y: viewGPLXTruocButton.frame.size.height + viewGPLXTruocButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbGPLXTruocButton.textAlignment = .center
        lbGPLXTruocButton.textColor = UIColor(netHex:0xc2c2c2)
        lbGPLXTruocButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGPLXTruocButton.text = "Thêm hình ảnh"
        viewImageGPLXTruoc.addSubview(lbGPLXTruocButton)
        viewInfoGPLXTruoc.frame.size.height = viewImageGPLXTruoc.frame.size.height + viewImageGPLXTruoc.frame.origin.y
        
        let tapShowGPLXTruoc = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXTruoc))
        viewImageGPLXTruoc.isUserInteractionEnabled = true
        viewImageGPLXTruoc.addGestureRecognizer(tapShowGPLXTruoc)
        
        if(self.selectNgayThanhToan == "FB"){
            viewInfoGPLXTruoc.frame.size.height = 0
            lbTextGPLXTruoc.frame.size.height = 0
            viewImageGPLXTruoc.frame.size.height = 0
            viewGPLXTruocButton.frame.size.height = 0
            lbGPLXTruocButton.frame.size.height = 0
            
        }
        if(fullFlagArr[3] != "1"){
            viewInfoGPLXTruoc.frame.size.height = 0
            lbTextGPLXTruoc.frame.size.height = 0
            viewImageGPLXTruoc.frame.size.height = 0
            viewGPLXTruocButton.frame.size.height = 0
            lbGPLXTruocButton.frame.size.height = 0
            
        }
        if(self.isShowGPLXSHK == false){
            viewInfoGPLXTruoc.frame.size.height = 0
            lbTextGPLXTruoc.frame.size.height = 0
            viewImageGPLXTruoc.frame.size.height = 0
            viewGPLXTruocButton.frame.size.height = 0
            lbGPLXTruocButton.frame.size.height = 0
        }
        
        //---GPLX Sau
        viewInfoGPLXSau = UIView(frame: CGRect(x:0,y:viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoGPLXSau.clipsToBounds = true
        viewUpload.addSubview(viewInfoGPLXSau)
        
        let lbTextGPLXSau = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextGPLXSau.textAlignment = .left
        lbTextGPLXSau.textColor = UIColor.black
        lbTextGPLXSau.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextGPLXSau.text = "Giấy phép lái xe (mặt sau)"
        viewInfoGPLXSau.addSubview(lbTextGPLXSau)
        
        viewImageGPLXSau = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextGPLXSau.frame.origin.y + lbTextGPLXSau.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageGPLXSau.layer.borderWidth = 0.5
        viewImageGPLXSau.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageGPLXSau.layer.cornerRadius = 3.0
        viewInfoGPLXSau.addSubview(viewImageGPLXSau)
        
        let viewGPLXSauButton = UIImageView(frame: CGRect(x: viewImageGPLXSau.frame.size.width/2 - (viewImageGPLXSau.frame.size.height * 2/3)/2, y: 0, width: viewImageGPLXSau.frame.size.height * 2/3, height: viewImageGPLXSau.frame.size.height * 2/3))
        viewGPLXSauButton.image = UIImage(named:"AddImage")
        viewGPLXSauButton.contentMode = .scaleAspectFit
        viewImageGPLXSau.addSubview(viewGPLXSauButton)
        
        let lbGPLXSauButton = UILabel(frame: CGRect(x: 0, y: viewGPLXSauButton.frame.size.height + viewGPLXSauButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbGPLXSauButton.textAlignment = .center
        lbGPLXSauButton.textColor = UIColor(netHex:0xc2c2c2)
        lbGPLXSauButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbGPLXSauButton.text = "Thêm hình ảnh"
        viewImageGPLXSau.addSubview(lbGPLXSauButton)
        viewInfoGPLXSau.frame.size.height = viewImageGPLXSau.frame.size.height + viewImageGPLXSau.frame.origin.y
        
        let tapShowGPLXSau = UITapGestureRecognizer(target: self, action: #selector(self.tapShowGPLXSau))
        viewImageGPLXSau.isUserInteractionEnabled = true
        viewImageGPLXSau.addGestureRecognizer(tapShowGPLXSau)
        
        if(self.selectNgayThanhToan == "FB"){
            viewInfoGPLXSau.frame.size.height = 0
            lbTextGPLXSau.frame.size.height = 0
            viewImageGPLXSau.frame.size.height = 0
            viewGPLXSauButton.frame.size.height = 0
            lbGPLXSauButton.frame.size.height = 0
            
        }
        if(fullFlagArr[4] != "1"){
            viewInfoGPLXSau.frame.size.height = 0
            lbTextGPLXSau.frame.size.height = 0
            viewImageGPLXSau.frame.size.height = 0
            viewGPLXSauButton.frame.size.height = 0
            lbGPLXSauButton.frame.size.height = 0
            
        }
        if(self.isShowGPLXSHK == false){
            viewInfoGPLXSau.frame.size.height = 0
            lbTextGPLXSau.frame.size.height = 0
            viewImageGPLXSau.frame.size.height = 0
            viewGPLXSauButton.frame.size.height = 0
            lbGPLXSauButton.frame.size.height = 0
        }
        
        
        //---SO HO KHAU
        viewInfoSoHK = UIView(frame: CGRect(x:0,y:viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHK.clipsToBounds = true
        viewUpload.addSubview(viewInfoSoHK)
        
        let lbTextSoHK = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHK.textAlignment = .left
        lbTextSoHK.textColor = UIColor.black
        lbTextSoHK.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHK.text = "Sổ hộ khẩu (Trang 1)"
        viewInfoSoHK.addSubview(lbTextSoHK)
        
        viewImageSoHK = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHK.frame.origin.y + lbTextSoHK.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHK.layer.borderWidth = 0.5
        viewImageSoHK.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHK.layer.cornerRadius = 3.0
        viewInfoSoHK.addSubview(viewImageSoHK)
        
        let viewSoHKButton = UIImageView(frame: CGRect(x: viewImageSoHK.frame.size.width/2 - (viewImageSoHK.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHK.frame.size.height * 2/3, height: viewImageSoHK.frame.size.height * 2/3))
        viewSoHKButton.image = UIImage(named:"AddImage")
        viewSoHKButton.contentMode = .scaleAspectFit
        viewImageSoHK.addSubview(viewSoHKButton)
        
        let lbSoHKButton = UILabel(frame: CGRect(x: 0, y: viewSoHKButton.frame.size.height + viewSoHKButton.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHK.frame.size.height/3))
        lbSoHKButton.textAlignment = .center
        lbSoHKButton.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKButton.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKButton.text = "Thêm hình ảnh"
        viewImageSoHK.addSubview(lbSoHKButton)
        viewInfoSoHK.frame.size.height = viewImageSoHK.frame.size.height + viewImageSoHK.frame.origin.y
        let tapShowSoHK = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK))
        viewImageSoHK.isUserInteractionEnabled = true
        viewImageSoHK.addGestureRecognizer(tapShowSoHK)
        
        if(self.selectNgayThanhToan == "FB"){
            viewInfoSoHK.frame.size.height = 0
            lbTextSoHK.frame.size.height = 0
            viewImageSoHK.frame.size.height = 0
            viewSoHKButton.frame.size.height = 0
            lbSoHKButton.frame.size.height = 0
            
        }
        if(fullFlagArr[5] != "1"){
            viewInfoSoHK.frame.size.height = 0
            lbTextSoHK.frame.size.height = 0
            viewImageSoHK.frame.size.height = 0
            viewSoHKButton.frame.size.height = 0
            lbSoHKButton.frame.size.height = 0
            
        }
        if(self.isShowGPLXSHK == false){
            viewInfoSoHK.frame.size.height = 0
            lbTextSoHK.frame.size.height = 0
            viewImageSoHK.frame.size.height = 0
            viewSoHKButton.frame.size.height = 0
            lbSoHKButton.frame.size.height = 0
        }
        
        //---
        
        lbInfoUploadMore = UILabel(frame: CGRect(x: tfThongTinLienLac.frame.origin.x, y: viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s: 14)))
        lbInfoUploadMore.textAlignment = .right
        lbInfoUploadMore.textColor = UIColor(netHex:0x47B054)
        lbInfoUploadMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute1 = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString1 = NSAttributedString(string: "Upload thêm hình", attributes: underlineAttribute1)
        lbInfoUploadMore.attributedText = underlineAttributedString1
        viewUpload.addSubview(lbInfoUploadMore)
        let tapShowUploadMore = UITapGestureRecognizer(target: self, action: #selector(DetailInfoCustomerMiraeViewController.tapShowUploadMore))
        lbInfoUploadMore.isUserInteractionEnabled = true
        lbInfoUploadMore.addGestureRecognizer(tapShowUploadMore)
        
        viewUploadMore = UIView(frame: CGRect(x: 0, y: lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10), width: scrollView.frame.size.width, height: Common.Size(s:100) ))
        viewUploadMore.clipsToBounds = true
        //                viewUploadMore.backgroundColor = .red
        viewUpload.addSubview(viewUploadMore)
        if(self.isShowGPLXSHK == false){
            lbInfoUploadMore.frame.size.height = 0
        }
        
        
        
        //---SO HO KHAU Trang 2
        viewInfoSoHKTrang2 = UIView(frame: CGRect(x:0,y: 0,width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang2.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang2)
        
        let lbTextSoHKTrang2 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang2.textAlignment = .left
        lbTextSoHKTrang2.textColor = UIColor.black
        lbTextSoHKTrang2.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang2.text = "Sổ hộ khẩu (Trang 2)"
        viewInfoSoHKTrang2.addSubview(lbTextSoHKTrang2)
        
        viewImageSoHKTrang2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang2.frame.origin.y + lbTextSoHKTrang2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang2.layer.borderWidth = 0.5
        viewImageSoHKTrang2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang2.layer.cornerRadius = 3.0
        viewInfoSoHKTrang2.addSubview(viewImageSoHKTrang2)
        
        let viewSoHKTrang2Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang2.frame.size.width/2 - (viewImageSoHKTrang2.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang2.frame.size.height * 2/3, height: viewImageSoHKTrang2.frame.size.height * 2/3))
        viewSoHKTrang2Button.image = UIImage(named:"AddImage")
        viewSoHKTrang2Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang2.addSubview(viewSoHKTrang2Button)
        
        let lbSoHKTrang2Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang2Button.frame.size.height + viewSoHKTrang2Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang2.frame.size.height/3))
        lbSoHKTrang2Button.textAlignment = .center
        lbSoHKTrang2Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang2Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang2Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang2.addSubview(lbSoHKTrang2Button)
        viewInfoSoHKTrang2.frame.size.height = viewImageSoHKTrang2.frame.size.height + viewImageSoHKTrang2.frame.origin.y
        
        let tapShowSoHK2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK2))
        viewImageSoHKTrang2.isUserInteractionEnabled = true
        viewImageSoHKTrang2.addGestureRecognizer(tapShowSoHK2)
        
        if(fullFlagArr[6] != "1"){
            viewInfoSoHKTrang2.frame.size.height = 0
            lbTextSoHKTrang2.frame.size.height = 0
            viewImageSoHKTrang2.frame.size.height = 0
            viewSoHKTrang2Button.frame.size.height = 0
            lbSoHKTrang2Button.frame.size.height = 0
            
        }
        
        if(self.isShowGPLXSHK == false){
            viewInfoSoHKTrang2.frame.size.height = 0
            lbTextSoHKTrang2.frame.size.height = 0
            viewImageSoHKTrang2.frame.size.height = 0
            viewSoHKTrang2Button.frame.size.height = 0
            lbSoHKTrang2Button.frame.size.height = 0
        }
        
        
        //---SO HO KHAU Trang 3
        viewInfoSoHKTrang3 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang2.frame.origin.y + viewInfoSoHKTrang2.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang3.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang3)
        
        let lbTextSoHKTrang3 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang3.textAlignment = .left
        lbTextSoHKTrang3.textColor = UIColor.black
        lbTextSoHKTrang3.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang3.text = "Sổ hộ khẩu (Trang 3)"
        viewInfoSoHKTrang3.addSubview(lbTextSoHKTrang3)
        
        viewImageSoHKTrang3 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang3.frame.origin.y + lbTextSoHKTrang3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang3.layer.borderWidth = 0.5
        viewImageSoHKTrang3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang3.layer.cornerRadius = 3.0
        viewInfoSoHKTrang3.addSubview(viewImageSoHKTrang3)
        
        let viewSoHKTrang3Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang3.frame.size.width/2 - (viewImageSoHKTrang3.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang3.frame.size.height * 2/3, height: viewImageSoHKTrang3.frame.size.height * 2/3))
        viewSoHKTrang3Button.image = UIImage(named:"AddImage")
        viewSoHKTrang3Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang3.addSubview(viewSoHKTrang3Button)
        
        let lbSoHKTrang3Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang3Button.frame.size.height + viewSoHKTrang3Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbSoHKTrang3Button.textAlignment = .center
        lbSoHKTrang3Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang3Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang3Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang3.addSubview(lbSoHKTrang3Button)
        viewInfoSoHKTrang3.frame.size.height = viewImageSoHKTrang3.frame.size.height + viewImageSoHKTrang3.frame.origin.y
        let tapShowSoHK3 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK3))
        viewImageSoHKTrang3.isUserInteractionEnabled = true
        viewImageSoHKTrang3.addGestureRecognizer(tapShowSoHK3)
        
        if(fullFlagArr[7] != "1"){
            viewInfoSoHKTrang3.frame.size.height = 0
            lbTextSoHKTrang3.frame.size.height = 0
            viewImageSoHKTrang3.frame.size.height = 0
            viewSoHKTrang3Button.frame.size.height = 0
            lbSoHKTrang3Button.frame.size.height = 0
            
        }
        //---SO HO KHAU Trang 4
        viewInfoSoHKTrang4 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang4.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang4)
        
        let lbTextSoHKTrang4 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang4.textAlignment = .left
        lbTextSoHKTrang4.textColor = UIColor.black
        lbTextSoHKTrang4.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang4.text = "Sổ hộ khẩu (Trang 4)"
        viewInfoSoHKTrang4.addSubview(lbTextSoHKTrang4)
        
        viewImageSoHKTrang4 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang4.frame.origin.y + lbTextSoHKTrang4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang4.layer.borderWidth = 0.5
        viewImageSoHKTrang4.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang4.layer.cornerRadius = 3.0
        viewInfoSoHKTrang4.addSubview(viewImageSoHKTrang4)
        
        let viewSoHKTrang4Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang4.frame.size.width/2 - (viewImageSoHKTrang4.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang4.frame.size.height * 2/3, height: viewImageSoHKTrang4.frame.size.height * 2/3))
        viewSoHKTrang4Button.image = UIImage(named:"AddImage")
        viewSoHKTrang4Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang4.addSubview(viewSoHKTrang4Button)
        
        let lbSoHKTrang4Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang4Button.frame.size.height + viewSoHKTrang4Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang4.frame.size.height/3))
        lbSoHKTrang4Button.textAlignment = .center
        lbSoHKTrang4Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang4Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang4Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang4.addSubview(lbSoHKTrang4Button)
        viewInfoSoHKTrang4.frame.size.height = viewImageSoHKTrang4.frame.size.height + viewImageSoHKTrang4.frame.origin.y
        let tapShowSoHK4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK4))
        viewImageSoHKTrang4.isUserInteractionEnabled = true
        viewImageSoHKTrang4.addGestureRecognizer(tapShowSoHK4)
        //---SO HO KHAU Trang 5
        viewInfoSoHKTrang5 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang5.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang5)
        
        let lbTextSoHKTrang5 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang5.textAlignment = .left
        lbTextSoHKTrang5.textColor = UIColor.black
        lbTextSoHKTrang5.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang5.text = "Sổ hộ khẩu (Trang 5)"
        viewInfoSoHKTrang5.addSubview(lbTextSoHKTrang5)
        
        viewImageSoHKTrang5 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang5.frame.origin.y + lbTextSoHKTrang5.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang5.layer.borderWidth = 0.5
        viewImageSoHKTrang5.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang5.layer.cornerRadius = 3.0
        viewInfoSoHKTrang5.addSubview(viewImageSoHKTrang5)
        
        let viewSoHKTrang5Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang5.frame.size.width/2 - (viewImageSoHKTrang5.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang5.frame.size.height * 2/3, height: viewImageSoHKTrang5.frame.size.height * 2/3))
        viewSoHKTrang5Button.image = UIImage(named:"AddImage")
        viewSoHKTrang5Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang5.addSubview(viewSoHKTrang5Button)
        
        let lbSoHKTrang5Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang5Button.frame.size.height + viewSoHKTrang5Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageGPLXTruoc.frame.size.height/3))
        lbSoHKTrang5Button.textAlignment = .center
        lbSoHKTrang5Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang5Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang5Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang5.addSubview(lbSoHKTrang5Button)
        viewInfoSoHKTrang5.frame.size.height = viewImageSoHKTrang5.frame.size.height + viewImageSoHKTrang5.frame.origin.y
        let tapShowSoHK5 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK5))
        viewImageSoHKTrang5.isUserInteractionEnabled = true
        viewImageSoHKTrang5.addGestureRecognizer(tapShowSoHK5)
        //---SO HO KHAU Trang 6
        viewInfoSoHKTrang6 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang6.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang6)
        
        let lbTextSoHKTrang6 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang6.textAlignment = .left
        lbTextSoHKTrang6.textColor = UIColor.black
        lbTextSoHKTrang6.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang6.text = "Sổ hộ khẩu (Trang 6)"
        viewInfoSoHKTrang6.addSubview(lbTextSoHKTrang6)
        
        viewImageSoHKTrang6 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang6.frame.origin.y + lbTextSoHKTrang6.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang6.layer.borderWidth = 0.5
        viewImageSoHKTrang6.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang6.layer.cornerRadius = 3.0
        viewInfoSoHKTrang6.addSubview(viewImageSoHKTrang6)
        
        let viewSoHKTrang6Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang6.frame.size.width/2 - (viewImageSoHKTrang6.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang6.frame.size.height * 2/3, height: viewImageSoHKTrang6.frame.size.height * 2/3))
        viewSoHKTrang6Button.image = UIImage(named:"AddImage")
        viewSoHKTrang6Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang6.addSubview(viewSoHKTrang6Button)
        
        let lbSoHKTrang6Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang6Button.frame.size.height + viewSoHKTrang6Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang6.frame.size.height/3))
        lbSoHKTrang6Button.textAlignment = .center
        lbSoHKTrang6Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang6Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang6Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang6.addSubview(lbSoHKTrang6Button)
        viewInfoSoHKTrang6.frame.size.height = viewImageSoHKTrang6.frame.size.height + viewImageSoHKTrang6.frame.origin.y
        let tapShowSoHK6 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK6))
        viewImageSoHKTrang6.isUserInteractionEnabled = true
        viewImageSoHKTrang6.addGestureRecognizer(tapShowSoHK6)
        //---SO HO KHAU Trang 7
        viewInfoSoHKTrang7 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang7.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang7)
        
        let lbTextSoHKTrang7 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang7.textAlignment = .left
        lbTextSoHKTrang7.textColor = UIColor.black
        lbTextSoHKTrang7.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang7.text = "Sổ hộ khẩu (Trang 7)"
        viewInfoSoHKTrang7.addSubview(lbTextSoHKTrang7)
        
        viewImageSoHKTrang7 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang7.frame.origin.y + lbTextSoHKTrang7.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang7.layer.borderWidth = 0.5
        viewImageSoHKTrang7.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang7.layer.cornerRadius = 3.0
        viewInfoSoHKTrang7.addSubview(viewImageSoHKTrang7)
        
        let viewSoHKTrang7Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang7.frame.size.width/2 - (viewImageSoHKTrang7.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang7.frame.size.height * 2/3, height: viewImageSoHKTrang7.frame.size.height * 2/3))
        viewSoHKTrang7Button.image = UIImage(named:"AddImage")
        viewSoHKTrang7Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang7.addSubview(viewSoHKTrang7Button)
        
        let lbSoHKTrang7Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang7Button.frame.size.height + viewSoHKTrang7Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang7.frame.size.height/3))
        lbSoHKTrang7Button.textAlignment = .center
        lbSoHKTrang7Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang7Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang7Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang7.addSubview(lbSoHKTrang7Button)
        viewInfoSoHKTrang7.frame.size.height = viewImageSoHKTrang7.frame.size.height + viewImageSoHKTrang7.frame.origin.y
        let tapShowSoHK7 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK7))
        viewImageSoHKTrang7.isUserInteractionEnabled = true
        viewImageSoHKTrang7.addGestureRecognizer(tapShowSoHK7)
        //---SO HO KHAU Trang 8
        viewInfoSoHKTrang8 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang8.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang8)
        
        let lbTextSoHKTrang8 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang8.textAlignment = .left
        lbTextSoHKTrang8.textColor = UIColor.black
        lbTextSoHKTrang8.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang8.text = "Sổ hộ khẩu (Trang 8)"
        viewInfoSoHKTrang8.addSubview(lbTextSoHKTrang8)
        
        viewImageSoHKTrang8 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang8.frame.origin.y + lbTextSoHKTrang8.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang8.layer.borderWidth = 0.5
        viewImageSoHKTrang8.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang8.layer.cornerRadius = 3.0
        viewInfoSoHKTrang8.addSubview(viewImageSoHKTrang8)
        
        let viewSoHKTrang8Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang8.frame.size.width/2 - (viewImageSoHKTrang8.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang8.frame.size.height * 2/3, height: viewImageSoHKTrang8.frame.size.height * 2/3))
        viewSoHKTrang8Button.image = UIImage(named:"AddImage")
        viewSoHKTrang8Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang8.addSubview(viewSoHKTrang8Button)
        
        let lbSoHKTrang8Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang8Button.frame.size.height + viewSoHKTrang8Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang8.frame.size.height/3))
        lbSoHKTrang8Button.textAlignment = .center
        lbSoHKTrang8Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang8Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang8Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang8.addSubview(lbSoHKTrang8Button)
        viewInfoSoHKTrang8.frame.size.height = viewImageSoHKTrang8.frame.size.height + viewImageSoHKTrang8.frame.origin.y
        let tapShowSoHK8 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK8))
        viewImageSoHKTrang8.isUserInteractionEnabled = true
        viewImageSoHKTrang8.addGestureRecognizer(tapShowSoHK8)
        
        //---SO HO KHAU Trang 9
        viewInfoSoHKTrang9 = UIView(frame: CGRect(x:0,y: viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10),width:scrollView.frame.size.width, height: 100))
        viewInfoSoHKTrang9.clipsToBounds = true
        viewUploadMore.addSubview(viewInfoSoHKTrang9)
        
        let lbTextSoHKTrang9 = UILabel(frame: CGRect(x: Common.Size(s:15), y: 0, width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTextSoHKTrang9.textAlignment = .left
        lbTextSoHKTrang9.textColor = UIColor.black
        lbTextSoHKTrang9.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTextSoHKTrang9.text = "Sổ hộ khẩu (Trang 9)"
        viewInfoSoHKTrang9.addSubview(lbTextSoHKTrang9)
        
        viewImageSoHKTrang9 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbTextSoHKTrang9.frame.origin.y + lbTextSoHKTrang9.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:60)))
        viewImageSoHKTrang9.layer.borderWidth = 0.5
        viewImageSoHKTrang9.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImageSoHKTrang9.layer.cornerRadius = 3.0
        viewInfoSoHKTrang9.addSubview(viewImageSoHKTrang9)
        
        let viewSoHKTrang9Button = UIImageView(frame: CGRect(x: viewImageSoHKTrang9.frame.size.width/2 - (viewImageSoHKTrang9.frame.size.height * 2/3)/2, y: 0, width: viewImageSoHKTrang9.frame.size.height * 2/3, height: viewImageSoHKTrang9.frame.size.height * 2/3))
        viewSoHKTrang9Button.image = UIImage(named:"AddImage")
        viewSoHKTrang9Button.contentMode = .scaleAspectFit
        viewImageSoHKTrang9.addSubview(viewSoHKTrang9Button)
        
        let lbSoHKTrang9Button = UILabel(frame: CGRect(x: 0, y: viewSoHKTrang9Button.frame.size.height + viewSoHKTrang9Button.frame.origin.y, width: scrollView.frame.size.width - Common.Size(s:30), height: viewImageSoHKTrang9.frame.size.height/3))
        lbSoHKTrang9Button.textAlignment = .center
        lbSoHKTrang9Button.textColor = UIColor(netHex:0xc2c2c2)
        lbSoHKTrang9Button.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSoHKTrang9Button.text = "Thêm hình ảnh"
        viewImageSoHKTrang9.addSubview(lbSoHKTrang9Button)
        viewInfoSoHKTrang9.frame.size.height = viewImageSoHKTrang9.frame.size.height + viewImageSoHKTrang9.frame.origin.y
        let tapShowSoHK9 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowSoHK9))
        viewImageSoHKTrang9.isUserInteractionEnabled = true
        viewImageSoHKTrang9.addGestureRecognizer(tapShowSoHK9)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y + Common.Size(s:10)
        heightUploadView = viewUploadMore.frame.size.height
        viewUploadMore.frame.size.height = 0
        
        //
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        
        lbResendSMS = UILabel(frame: CGRect(x: tfHoTen.frame.origin.x , y: viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:10), width:tfHoTen.frame.size.width, height: 0))
        lbResendSMS.textAlignment = .right
        lbResendSMS.textColor = UIColor(netHex:0x04AB6E)
        lbResendSMS.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Gửi SMS", attributes: underlineAttribute)
        lbResendSMS.attributedText = underlineAttributedString
        scrollView.addSubview(lbResendSMS)
        let tapSendSMS = UITapGestureRecognizer(target: self, action: #selector(DetailInfoCustomerMiraeHistoryViewController.actionResendSMS))
        lbResendSMS.isUserInteractionEnabled = true
        lbResendSMS.addGestureRecognizer(tapSendSMS)
        if(self.historyMirae!.is_SMS == 1){
            self.lbResendSMS.frame.size.height = Common.Size(s:14)
        }
       
        
        
        btTaoDonHang = UIButton()
        btTaoDonHang.frame = CGRect(x: tfHoTen.frame.origin.x, y:lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:10), width: tfHoTen.frame.size.width, height: tfHoTen.frame.size.height * 1.2)
        btTaoDonHang.backgroundColor = UIColor(netHex:0x00955E)
        btTaoDonHang.setTitle("Cập nhật", for: .normal)
        btTaoDonHang.clipsToBounds = true
        btTaoDonHang.addTarget(self, action: #selector(actionTaoDonHang), for: .touchUpInside)
        btTaoDonHang.layer.borderWidth = 0.5
        btTaoDonHang.layer.borderColor = UIColor.white.cgColor
        btTaoDonHang.layer.cornerRadius = 3
        scrollView.addSubview(btTaoDonHang)
        
        
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        

        
        
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_loadTypeDoc() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                if(err.count <= 0){
                    self.listLoaiChungTu = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.name)
                    }
                    self.tfLoaiChungTu.filterStrings(list)
                    MPOSAPIManager.mpos_FRT_SP_mirae_loadDueDay() { (results, err) in
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            if(err.count <= 0){
                                self.listNgayThanhToan = results
                                var list:[String] = []
                                for item in results {
                                    list.append(item.Name)
                                }
                                self.tfNgayThanhToan.filterStrings(list)
                                self.getProvince()
                                
                            }else{
                                
                            }
                        }
                        
                        
                    }
                    
                }else{
                    let alert = UIAlertController(title: "mpos_FRT_SP_Mirae_loadTypeDoc", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
            
            
        }
        
        
        
        
        
        
    }
    
    @objc func actionTaoDonHang(){
        if(self.tfSDTKH.text! != ""){
            if (self.tfSDTKH.text!.hasPrefix("01") && self.tfSDTKH.text!.count == 11){
                
            }else if (self.tfSDTKH.text!.hasPrefix("0") && !self.tfSDTKH.text!.hasPrefix("01") && self.tfSDTKH.text!.count == 10){
                
            }else{
                let alert = UIAlertController(title: "Thông báo", message: "Số điện thoại KH không hợp lệ!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                    self.tfSDTKH.becomeFirstResponder()
                })
                self.present(alert, animated: true)
                return
            }
            
        }
        

        
        
        
        var money = self.tfLuong.text!
        money = money.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        money = money.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lưu thông tin khách hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_Insert_image_contract(base64Xmlimage:self.parseXMLURL().toBase64(),Docentry: "\(self.historyMirae!.Docentry)",processId:"\(self.historyMirae!.processId_Mirae)",IsUpdate:"1") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results[0].p_status == 0){
                        let alert = UIAlertController(title: "Thông báo", message: results[0].p_messagess, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.present(alert, animated: true)
                        return
                    }
                    
                    MPOSAPIManager.mpos_ReSubmitAplication(IDMPOS: "\(self.historyMirae!.Docentry)",
                        P_ProvinceCode: self.selectProvice,
                        P_DistrictCode: self.selectDistrict,
                        P_PrecinctCode: self.selectPrecinct,
                        P_Address: self.tfSoNha.text!,
                        CompanyName: self.tfTenCongTy.text!,
                        JobTilte: self.tfViTri.text!,
                        Seniority: "",
                        Salary: "\(money)",
                        C_ProvinceCode: self.selectProviceNgheNghiep,
                        C_DistrictCode: self.selectDistrictNgheNghiep,
                        C_PrecinctCode: self.selectPrecinctNgheNghiep,
                        C_Address: "",
                        IDcard_old: "",
                        C_PhoneNumber:"",
                        C_TypeDoc: "\(self.selectLoaiChungTu)",
                        Ref_FullName: self.tfHoTen.text!,
                        Ref_relationship: self.tfMoiQuanHe.text!,
                        Ref_phonenumber: self.tfThongTinLienLac.text!,
                        processId:"\(self.historyMirae!.processId_Mirae)",
                        activityId: "\(self.historyMirae!.activityId_Mirae)",
                        DeviceID: "2",
                        WorkYear:"",
                        dueday:self.selectNgayThanhToan,
                        FirstImei_day:"",
                        Birthday:"\(self.tfNgaySinh.text!)",
                        PhoneNumber:"\(self.tfSDTKH.text!)",
                        idIssuedBy:"\(self.selectProviceCMND)",
                        idIssuedDate:"\(self.tfNgayCapCMND.text!)",
                    Ref_phonenumber_2:"\(self.tfThongTinLienLac2.text!)",refName_2:"\(self.tfHoTen2.text!)",refRelationship_2:"\(self.tfMoiQuanHe2.text!)",P_ProvinceCode_2:"\(self.selectProviceTamTru)",P_DistrictCode_2:"\(self.selectDistrictTamTru)",P_PrecinctCode_2:"\(self.selectPrecinctTamTru)",P_Address_2:"\(self.tfSoNhaTamTru.text!)") { (message, err) in
                            let when = DispatchTime.now() + 0.5
                            DispatchQueue.main.asyncAfter(deadline: when) {
                                
                                if(err.count <= 0){
                       
                                    
                                    let alert = UIAlertController(title: "Thông báo", message: message , preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                                 self.navigationController?.popViewController(animated: true)
                                    })
                                    self.present(alert, animated: true)
                                    
                                    
                                    
                                }else{
                                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                                    
                                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                        
                                    })
                                    self.present(alert, animated: true)
                                }
                            }
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
        
        
        
        //
    }
    @objc func actionResendSMS(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang gửi lại SMS..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_mirae_sendsms(cmnd:self.historyMirae!.IDCard,phone:self.historyMirae!.PhoneNumber,processId:"\(self.historyMirae!.processId_Mirae)",partnerId: PARTNERIDORDER) { (p_status,p_message, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    let alert = UIAlertController(title: "Thông báo", message: p_message, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                    
                    
                    
                    
                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                        
                    })
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc func tapShowUploadMore(sender:UITapGestureRecognizer) {
        if(viewUploadMore.frame.size.height != 0){
            viewUploadMore.frame.size.height = 0
        }else{
            viewUploadMore.frame.size.height = heightUploadView
        }
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
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
            self.tfLuong.text = str
        }else{
            textField.text = ""
            self.tfLuong.text = ""
        }
        
    }
    func getProvince(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin  ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_loadProvince() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listProvices = results
                    self.listProvicesNgheNghiep = results
                    var list:[String] = []
                    for item in results {
                        list.append(item.Text)
                    }
                    self.tfThanhPho.filterStrings(list)
                    self.tfThanhPhoTamTru.filterStrings(list)
                    self.tfNoiCapCMND.filterStrings(list)
                    //self.tfThanhPhoNgheNghiep.filterStrings(list)
                    
                    
                    
                    MPOSAPIManager.mpos_FRT_SP_mirae_Getinfo_byContractNumber(IDMPOS: "\(self.historyMirae!.Docentry)") { (result, err) in
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            if(err.count <= 0){
                                if(result != nil){
                                    self.tfSDTKH.text = result!.mobile
                                    self.tfNgaySinh.text = result!.BirthDay
                                    self.getinfo_byContractNumber = result
                                   // self.tfCMNDCCCD.text = "\(result!.addIdentification)"
                                    self.tfSoNha.text = result!.address
                                    self.tfSoNhaTamTru.text = result!.address_2
                                    // self.tfSoNhaNgheNghiep.text = result!.empAddress
                                    self.tfHoTen.text = result!.refName
                                    self.tfMoiQuanHe.text = result!.refRelationship
                                    self.tfThongTinLienLac.text = result!.refContact
                                    self.tfHoTen2.text = result!.refName_2
                                    self.tfMoiQuanHe2.text = result!.refRelationship_2
                                    self.tfThongTinLienLac2.text = result!.phone1
                                    // self.tfSoNamLamViec.text = "\(result!.empYear)"
                                    self.tfLuong.text = Common.convertCurrencyV2(value: result!.empSalary)
                                    self.tfTenCongTy.text = result!.empName
                                    self.tfViTri.text = result!.empPosition
                                    self.tfNgayCapCMND.text = result!.idIssuedDate
                                    //   self.tfThongTinLHNgheNghiep.text = result!.empPhone
                                    let objNoiCap =  self.listProvices.filter{ $0.Value == "\(result!.idIssuedBy)" }.first
                                    if let objNoiCap1 = objNoiCap?.Text {
                                        self.tfNoiCapCMND.text = objNoiCap1
                                        self.selectProviceCMND = "\(objNoiCap!.Value)"
                                        
                                    }
                                    let obj =  self.listProvices.filter{ $0.Value == "\(result!.stateId)" }.first
                                    if let obj1 = obj?.Text {
                                        self.tfThanhPho.text = obj1
                                        self.selectProvice = "\(obj!.Value)"
                                        
                                    }
                                    let objTamTru =  self.listProvices.filter{ $0.Value == "\(result!.stateId_2)" }.first
                                    if let obj1TamTru = objTamTru?.Text {
                                        self.tfThanhPhoTamTru.text = obj1TamTru
                                        self.selectProviceTamTru = "\(objTamTru!.Value)"
                                        
                                    }
                                    //                                    let objTinhThanhNgheNghiep =  self.listProvicesNgheNghiep.filter{ $0.Value == "\(result!.empStateId)" }.first
                                    //                                    if let objNameTinhThanhNgheNghiep = objTinhThanhNgheNghiep?.Text {
                                    //                                        self.tfThanhPhoNgheNghiep.text = objNameTinhThanhNgheNghiep
                                    //                                        self.selectProviceNgheNghiep = "\(objTinhThanhNgheNghiep!.Value)"
                                    //
                                    //                                    }
                                    let objLoaiChungTu =  self.listLoaiChungTu.filter{ $0.code == "\(result!.additionalIdType)" }.first
                                    if let objNameLoaiChungTu = objLoaiChungTu?.name {
                                        self.tfLoaiChungTu.text = objNameLoaiChungTu
                                        self.selectLoaiChungTu = "\(objLoaiChungTu!.code)"
                                        if(self.selectLoaiChungTu == "FB"){
                                            
                                            
                                            self.hideGPLX()
                                        }else{
                                            self.hideSHK()
                                        }
                                        
                                    }
                                    let objNgayThanhToan =  self.listNgayThanhToan.filter{ $0.Code == "\(result!.dueDate)" }.first
                                    if let objNameNgayThanhToan = objNgayThanhToan?.Name {
                                        self.tfNgayThanhToan.text = objNameNgayThanhToan
                                        self.selectNgayThanhToan = "\(objNgayThanhToan!.Code)"
                                        
                                    }
                                    if(result!.is_update_info == 0){
                                        self.viewUpload.frame.size.height = 0
                                        self.btTaoDonHang.frame.origin.y = self.viewUpload.frame.size.height + self.viewUpload.frame.origin.y
                                        self.btTaoDonHang.frame.size.height = 0
                                        self.btTaoDonHang.isEnabled = false
                                        self.scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: self.btTaoDonHang.frame.origin.y + self.btTaoDonHang.frame.size.height + Common.Size(s:100))
                                    }
                                    MPOSAPIManager.mpos_FRT_SP_Mirae_loadDistrict(ProvinceCode: self.selectProvice, handler: { (results, error) in
                                        self.listDistricts.removeAll()
                                        self.listDistricts = results
                                        var listDistrictTemp:[String] = []
                                        for item in results {
                                            listDistrictTemp.append(item.Text)
                                        }
                                        self.tfQuanHuyen.filterStrings(listDistrictTemp)
                                        
                                        let objDistrict =  self.listDistricts.filter{ $0.Value == "\(result!.city)" }.first
                                        if let objNameDistrict = objDistrict?.Text {
                                            self.tfQuanHuyen.text = objNameDistrict
                                            self.selectDistrict = "\(objDistrict!.Value)"
                                            
                                        }
                                    
                                        
                                        
                                        MPOSAPIManager.mpos_FRT_SP_Mirae_loadPrecinct(ProvinceCode:self.selectProvice, DistrictCode: self.selectDistrict, handler: { (resultsPhuongXa, error) in
                                            self.listPrecincts.removeAll()
                                            self.listPrecincts = resultsPhuongXa
                                            var list:[String] = []
                                            for item in resultsPhuongXa {
                                                list.append(item.Text)
                                            }
                                            self.tfPhuongXa.filterStrings(list)
                                            
                                            
                                            let objPrecinct =  self.listPrecincts.filter{ $0.Value == "\(result!.zipcode)" }.first
                                            if let objNamePrecinct = objPrecinct?.Text {
                                                self.tfPhuongXa.text = objNamePrecinct
                                                self.selectPrecinct = "\(objPrecinct!.Value)"
                                                
                                            }
                                         
                                            
                                            
                                        })
                                        
                                    })
                                    
                                    MPOSAPIManager.mpos_FRT_SP_Mirae_loadDistrict(ProvinceCode: self.selectProviceTamTru, handler: { (results, error) in
                                        self.listDistrictsTamTru.removeAll()
                                        self.listDistrictsTamTru = results
                                        var listDistrictTemp:[String] = []
                                        for item in results {
                                            listDistrictTemp.append(item.Text)
                                        }
                                        self.tfQuanHuyenTamTru.filterStrings(listDistrictTemp)
                                        
                                     
                                        let objDistrictTamTru =  self.listDistrictsTamTru.filter{ $0.Value == "\(result!.city_2)" }.first
                                        if let objNameDistrictTamTru = objDistrictTamTru?.Text {
                                            self.tfQuanHuyenTamTru.text = objNameDistrictTamTru
                                            self.selectDistrictTamTru = "\(objDistrictTamTru!.Value)"
                                            
                                        }
                                        
                                        
                                        MPOSAPIManager.mpos_FRT_SP_Mirae_loadPrecinct(ProvinceCode:self.selectProviceTamTru, DistrictCode: self.selectDistrictTamTru, handler: { (resultsPhuongXa, error) in
                                            self.listPrecinctsTamTru.removeAll()
                                            self.listPrecinctsTamTru = resultsPhuongXa
                                            var list:[String] = []
                                            for item in resultsPhuongXa {
                                                list.append(item.Text)
                                            }
                                            self.tfPhuongXaTamTru.filterStrings(list)
                                            
                                     
                                            let objPrecinctTamTru =  self.listPrecinctsTamTru.filter{ $0.Value == "\(result!.zipcode_2)" }.first
                                            if let objNamePrecinctTamTru = objPrecinctTamTru?.Text {
                                                self.tfPhuongXaTamTru.text = objNamePrecinctTamTru
                                                self.selectPrecinctTamTru = "\(objPrecinctTamTru!.Value)"
                                                
                                            }
                                            
                                            
                                        })
                                        
                                    })
                                    
                                    
                                    
                                    
                                    MPOSAPIManager.mpos_FRT_SP_Mirae_loadDistrict(ProvinceCode: self.selectProviceNgheNghiep, handler: { (results, error) in
                                        self.listDistrictsNgheNghiep.removeAll()
                                        self.listDistrictsNgheNghiep = results
                                        var listDistrictTemp:[String] = []
                                        for item in results {
                                            listDistrictTemp.append(item.Text)
                                        }
                                        //  self.tfQuanHuyenNgheNghiep.filterStrings(listDistrictTemp)
                                        
                                        //                                        let objQuanHuyenNgheNghiep =  self.listDistrictsNgheNghiep.filter{ $0.Value == "\(result!.empCity)" }.first
                                        //                                        if let objNameQuanHuyenNgheNghiep = objQuanHuyenNgheNghiep?.Text {
                                        //                                            self.tfQuanHuyenNgheNghiep.text = objNameQuanHuyenNgheNghiep
                                        //                                            self.selectDistrictNgheNghiep = "\(objQuanHuyenNgheNghiep!.Value)"
                                        //
                                        //                                        }
                                        
                                        MPOSAPIManager.mpos_FRT_SP_Mirae_loadPrecinct(ProvinceCode:self.selectProviceNgheNghiep, DistrictCode: self.selectDistrictNgheNghiep, handler: { (resultsPhuongXaNgheNghiep, error) in
                                            self.listPrecinctsNgheNghiep.removeAll()
                                            self.listPrecinctsNgheNghiep = resultsPhuongXaNgheNghiep
                                            var list:[String] = []
                                            for item in resultsPhuongXaNgheNghiep {
                                                list.append(item.Text)
                                            }
                                            //  self.tfPhuongXaNgheNghiep.filterStrings(list)
                                            
                                            
                                            
                                            
                                            //                                            let objPhuongXaNgheNghiep =  self.listPrecinctsNgheNghiep.filter{ $0.Value == "\(result!.empZipcode)" }.first
                                            //                                            if let objNamePhuongXaNgheNghiep = objPhuongXaNgheNghiep?.Text {
                                            //                                                self.tfPhuongXaNgheNghiep.text = objNamePhuongXaNgheNghiep
                                            //                                                self.selectPrecinctNgheNghiep = "\(objPhuongXaNgheNghiep!.Value)"
                                            //
                                            //                                            }
                                        })
                                        
                                    })
                                    
                                    
                                    
                                    
                                }
                                
                                
                            }else{
                                
                            }
                        }
                        
                        
                    }
                    
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == tfNgayCapCMND){
            guard var number = textField.text else {
                return true
            }
            // If user try to delete, remove the char manually
            if string == "" {
                number.remove(at: number.index(number.startIndex, offsetBy: range.location))
            }
            // Remove all mask characters
            number = number.replacingOccurrences(of: "/", with: "")
            number = number.replacingOccurrences(of: "D", with: "")
            number = number.replacingOccurrences(of: "M", with: "")
            number = number.replacingOccurrences(of: "Y", with: "")
            
            // Set the position of the cursor
            var cursorPosition = number.count+1
            if string == "" {
                //if it's delete, just take the position given by the delegate
                cursorPosition = range.location
            } else {
                // If not, take into account the slash
                if cursorPosition > 2 && cursorPosition < 5 {
                    cursorPosition += 1
                } else if cursorPosition > 4 {
                    cursorPosition += 2
                }
            }
            // Stop editing if we have rich the max numbers
            if number.count == 8 { return false }
            // Readd all mask char
            number += string
            while number.count < 8 {
                if number.count < 2 {
                    number += "D"
                } else if number.count < 4 {
                    number += "M"
                } else {
                    number += "Y"
                }
            }
            number.insert("/", at: number.index(number.startIndex, offsetBy: 4))
            number.insert("/", at: number.index(number.startIndex, offsetBy: 2))
            
            // Some styling
            let enteredTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            let maskTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)]
            
            let partOne = NSMutableAttributedString(string: String(number.prefix(cursorPosition)), attributes: enteredTextAttribute)
            let partTwo = NSMutableAttributedString(string: String(number.suffix(number.count-cursorPosition)), attributes: maskTextAttribute)
            
            let combination = NSMutableAttributedString()
            
            combination.append(partOne)
            combination.append(partTwo)
            
            textField.attributedText = combination
            textField.setCursor(position: cursorPosition)
            return false
            
            
        }
        return true
        
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == tfNgayCapCMND){
            if let text = textField.text, text != "" && text != "DD/MM/YYYY" {
                // Do something with your value
            } else {
                textField.text = ""
            }
        }
        
    }
    func hideGPLX(){
        viewInfoGPLXTruoc.frame.size.height = 0
        viewInfoGPLXSau.frame.size.height = 0
        viewInfoSoHK.frame.size.height = Common.Size(s: 100)
        viewInfoSoHK.frame.origin.y = viewInfoChanDungKH.frame.origin.y + viewInfoChanDungKH.frame.size.height
        lbInfoUploadMore.frame.size.height = Common.Size(s: 14)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        
        if(self.isShowGPLXSHK == false){
            if(self.isShowCD == false){
                if(self.isShowCMND == false){
                    viewUpload.frame.size.height = 0
                }else{
                    //viewUpload.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
                    viewUpload.frame.size.height = viewInfoSim.frame.size.height + viewInfoSim.frame.origin.y
                }
                
            }else{
                if(self.isShowCMND == false){
                    viewInfoChanDungKH.frame.origin.y = Common.Size(s: 10)
                    viewUpload.frame.size.height = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s: 10)
                }else{
                    viewUpload.frame.size.height = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y
                }
           
            }
            
        }else{
            
            viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        }
        
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        if(self.historyMirae!.is_SMS == 1){
            self.lbResendSMS.frame.size.height = Common.Size(s:14)
        }
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height  + Common.Size(s:100))
    }
    func hideSHK(){
        
        
        viewInfoGPLXTruoc.frame.size.height = Common.Size(s:100)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y
        viewInfoGPLXSau.frame.size.height = Common.Size(s:100)
        viewInfoSoHK.frame.size.height = 0
        lbInfoUploadMore.frame.size.height = 0
        viewUploadMore.frame.size.height = 0
        
        viewUpload.frame.size.height = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y
        
        
        if(self.isShowGPLXSHK == false){
            if(self.isShowCD == false){
                if(self.isShowCMND == false){
                    viewUpload.frame.size.height = 0
                }else{
                    //viewUpload.frame.size.height = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y
                    viewUpload.frame.size.height = viewInfoSim.frame.size.height + viewInfoSim.frame.origin.y
                }
                
            }else{
                if(self.isShowCMND == false){
                    viewInfoChanDungKH.frame.origin.y = Common.Size(s: 10)
                    viewUpload.frame.size.height = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s: 10)
                }else{
                    viewUpload.frame.size.height = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y
                }
            }
            
        }else{
            
            viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        }
        
        
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        if(self.historyMirae!.is_SMS == 1){
            self.lbResendSMS.frame.size.height = Common.Size(s:14)
        }
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height  + Common.Size(s:100))
    }
    @objc func tapAnHienTamTru(sender:UITapGestureRecognizer) {
        if(viewTamTru.frame.size.height != 0){
            viewTamTru.frame.size.height = 0
            lblThongTinNgheNghiep.frame.origin.y = label2.frame.size.height + label2.frame.origin.y
            detailViewNgheNghiep.frame.origin.y = lblThongTinNgheNghiep.frame.origin.y + lblThongTinNgheNghiep.frame.size.height
            label3.frame.origin.y = detailViewNgheNghiep.frame.origin.y + detailViewNgheNghiep.frame.size.height + Common.Size(s: 10)
            viewThongTinThamChieu.frame.origin.y = label3.frame.origin.y + label3.frame.size.height + Common.Size(s: 10)
            viewUpload.frame.origin.y = viewThongTinThamChieu.frame.origin.y + viewThongTinThamChieu.frame.size.height + Common.Size(s: 10)
            
            lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
            btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }else{
            viewTamTru.frame.size.height = heightUploadViewTamTru
            lblThongTinNgheNghiep.frame.origin.y = viewTamTru.frame.size.height + viewTamTru.frame.origin.y
            detailViewNgheNghiep.frame.origin.y = lblThongTinNgheNghiep.frame.origin.y + lblThongTinNgheNghiep.frame.size.height + Common.Size(s: 10)
            label3.frame.origin.y = detailViewNgheNghiep.frame.origin.y + detailViewNgheNghiep.frame.size.height + Common.Size(s: 10)
            viewThongTinThamChieu.frame.origin.y = label3.frame.origin.y + label3.frame.size.height + Common.Size(s: 10)
            viewUpload.frame.origin.y = viewThongTinThamChieu.frame.origin.y + viewThongTinThamChieu.frame.size.height + Common.Size(s: 10)
            
            lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
            btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        }
        
    }
    func parseXMLURL()->String{
        var rs:String = "<Data>"
        for item in self.listUploadImage {
            var name = item.url
            name = name.replace(target: "&", withString:"&#38;")
            name = name.replace(target: "<", withString:"&#60;")
            name = name.replace(target: ">", withString:"&#62;")
            name = name.replace(target: "\"", withString:"&#34;")
            name = name.replace(target: "'", withString:"&#39;")
            
            
            item.url =  item.url.replace(target: "&", withString:"&#38;")
            item.url =  item.url.replace(target: "<", withString:"&#60;")
            item.url =  item.url.replace(target: ">", withString:"&#62;")
            item.url =  item.url.replace(target: "\"", withString:"&#34;")
            item.url =  item.url.replace(target: "'", withString:"&#39;")
            
            rs = rs + "<item urlimage=\"\(item.url)\" contentType=\"\(item.type)\"/>"
        }
        rs = rs + "</Data>"
        print(rs)
        return rs
    }
    func uploadImageV2(type:String,image:UIImage){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        
        let nc = NotificationCenter.default
        
        if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?{
            let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            //            if(strBase64 == ""){
            //                let alert = UIAlertController(title: "Thông báo", message: "Lỗi convert Base64!", preferredStyle: .alert)
            //
            //                alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
            //
            //                })
            //                self.present(alert, animated: true)
            //                return
            //            }
            MPOSAPIManager.UploadImage_Mirae(base64:"\(strBase64)",processId:"\(self.getinfo_byContractNumber!.processId)",IdCardNo:"\(self.historyMirae!.IDCard)",contentType:"\(type)",DirectoryMirae:"\(self.getinfo_byContractNumber!.ftpPathDC_Mirae)") { (result, err) in
                
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        
                      
                        
                        let uploadImage = UploadImageMirae(url:result
                            , type:type)
                        
                        if(self.listUploadImage.count > 0){
                            let obj =  self.listUploadImage.filter{ $0.type == "\(uploadImage.type)" }.first
                            
                            if(obj != nil){
                                if let index = self.listUploadImage.firstIndex(of: obj!) {
                                    self.listUploadImage.remove(at: index)
                                }
                            }
                            
                        }
                        
                        self.listUploadImage.append(uploadImage)
                        
                        
                        
                    }else{
                        let title = "THÔNG BÁO(1)"
                        let popup = PopupDialog(title: title, message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
                
            }
        }
        
    }
    
    
    @objc func tapShowCMNDTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowCMNDSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 2
        self.thisIsTheFunctionWeAreCalling()
    }
    
    @objc  func tapShowChanDungKH(sender:UITapGestureRecognizer) {
        self.posImageUpload = 3
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowGPLXTruoc(sender:UITapGestureRecognizer) {
        self.posImageUpload = 4
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowGPLXSau(sender:UITapGestureRecognizer) {
        self.posImageUpload = 5
        self.thisIsTheFunctionWeAreCalling()
    }
    
    
    @objc  func tapShowSoHK(sender:UITapGestureRecognizer) {
        self.posImageUpload = 6
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK2(sender:UITapGestureRecognizer) {
        self.posImageUpload = 7
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK3(sender:UITapGestureRecognizer) {
        self.posImageUpload = 8
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK4(sender:UITapGestureRecognizer) {
        self.posImageUpload = 9
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK5(sender:UITapGestureRecognizer) {
        self.posImageUpload = 10
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK6(sender:UITapGestureRecognizer) {
        self.posImageUpload = 11
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK7(sender:UITapGestureRecognizer) {
        self.posImageUpload = 12
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK8(sender:UITapGestureRecognizer) {
        self.posImageUpload = 13
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc  func tapShowSoHK9(sender:UITapGestureRecognizer) {
        self.posImageUpload = 14
        self.thisIsTheFunctionWeAreCalling()
    }
    @objc func tapShowSim(sender:UITapGestureRecognizer) {
        self.posImageUpload = 15
        self.thisIsTheFunctionWeAreCalling()
    }
    
    func imageCMNDTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDTruoc.frame.size.width / sca
        viewImageCMNDTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDTruoc.frame.size.width, height: heightImage))
        imgViewCMNDTruoc.contentMode = .scaleAspectFit
        imgViewCMNDTruoc.image = image
        viewImageCMNDTruoc.addSubview(imgViewCMNDTruoc)
        viewImageCMNDTruoc.frame.size.height = imgViewCMNDTruoc.frame.size.height + imgViewCMNDTruoc.frame.origin.y
        viewInfoCMNDTruoc.frame.size.height = viewImageCMNDTruoc.frame.size.height + viewImageCMNDTruoc.frame.origin.y
        viewInfoCMNDSau.frame.origin.y = viewInfoCMNDTruoc.frame.size.height + viewInfoCMNDTruoc.frame.origin.y + Common.Size(s:10)
        viewInfoSim.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoChanDungKH.frame.origin.y = viewInfoSim.frame.size.height + viewInfoSim.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXTruoc.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        
        viewInfoSoHK.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "1", image: self.imgViewCMNDTruoc.image!)
            
        }
        
    }
    func imageCMNDSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageCMNDSau.frame.size.width / sca
        viewImageCMNDSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewCMNDSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageCMNDSau.frame.size.width, height: heightImage))
        imgViewCMNDSau.contentMode = .scaleAspectFit
        imgViewCMNDSau.image = image
        viewImageCMNDSau.addSubview(imgViewCMNDSau)
        viewImageCMNDSau.frame.size.height = imgViewCMNDSau.frame.size.height + imgViewCMNDSau.frame.origin.y
        viewInfoCMNDSau.frame.size.height = viewImageCMNDSau.frame.size.height + viewImageCMNDSau.frame.origin.y
        viewInfoSim.frame.origin.y = viewInfoCMNDSau.frame.size.height + viewInfoCMNDSau.frame.origin.y + Common.Size(s:10)
        viewInfoChanDungKH.frame.origin.y = viewInfoSim.frame.size.height + viewInfoSim.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXTruoc.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        
        viewInfoSoHK.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "2", image: self.imgViewCMNDSau.image!)
            
        }
        
    }
    func imageSim(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSim.frame.size.width / sca
        viewImageSim.subviews.forEach { $0.removeFromSuperview() }
        imgViewSim  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSim.frame.size.width, height: heightImage))
        imgViewSim.contentMode = .scaleAspectFit
        imgViewSim.image = image
        viewImageSim.addSubview(imgViewSim)
        viewImageSim.frame.size.height = imgViewSim.frame.size.height + imgViewSim.frame.origin.y
        viewInfoSim.frame.size.height = viewImageSim.frame.size.height + viewImageSim.frame.origin.y
        viewInfoChanDungKH.frame.origin.y = viewInfoSim.frame.size.height + viewInfoSim.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXTruoc.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        
        viewInfoSoHK.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        btTaoDonHang.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "23", image: self.imgViewSim.image!)
            
        }
        
    }
    
    func imageChanDungKH(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageTrichNoTD.frame.size.width / sca
        viewImageTrichNoTD.subviews.forEach { $0.removeFromSuperview() }
        imgViewTrichNoTD  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageTrichNoTD.frame.size.width, height: heightImage))
        imgViewTrichNoTD.contentMode = .scaleAspectFit
        imgViewTrichNoTD.image = image
        viewImageTrichNoTD.addSubview(imgViewTrichNoTD)
        viewImageTrichNoTD.frame.size.height = imgViewTrichNoTD.frame.size.height + imgViewTrichNoTD.frame.origin.y
        viewInfoChanDungKH.frame.size.height = viewImageTrichNoTD.frame.size.height + viewImageTrichNoTD.frame.origin.y
        
        viewInfoGPLXTruoc.frame.origin.y = viewInfoChanDungKH.frame.size.height + viewInfoChanDungKH.frame.origin.y + Common.Size(s:10)
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        
        viewInfoSoHK.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "3", image: self.imgViewTrichNoTD.image!)
            
        }
    }
    
    
    func imageGPLXTruoc(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageGPLXTruoc.frame.size.width / sca
        viewImageGPLXTruoc.subviews.forEach { $0.removeFromSuperview() }
        imgViewGPLXTruoc  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageGPLXTruoc.frame.size.width, height: heightImage))
        imgViewGPLXTruoc.contentMode = .scaleAspectFit
        imgViewGPLXTruoc.image = image
        viewImageGPLXTruoc.addSubview(imgViewGPLXTruoc)
        viewImageGPLXTruoc.frame.size.height = imgViewGPLXTruoc.frame.size.height + imgViewGPLXTruoc.frame.origin.y
        viewInfoGPLXTruoc.frame.size.height = viewImageGPLXTruoc.frame.size.height + viewImageGPLXTruoc.frame.origin.y
        viewInfoGPLXSau.frame.origin.y = viewInfoGPLXTruoc.frame.size.height + viewInfoGPLXTruoc.frame.origin.y + Common.Size(s:10)
        
        viewInfoSoHK.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "4", image: self.imgViewGPLXTruoc.image!)
            
        }
    }
    
    func imageGPLXSau(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageGPLXSau.frame.size.width / sca
        viewImageGPLXSau.subviews.forEach { $0.removeFromSuperview() }
        imgViewGPLXSau  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageGPLXSau.frame.size.width, height: heightImage))
        imgViewGPLXSau.contentMode = .scaleAspectFit
        imgViewGPLXSau.image = image
        viewImageGPLXSau.addSubview(imgViewGPLXSau)
        viewImageGPLXSau.frame.size.height = imgViewGPLXSau.frame.size.height + imgViewGPLXSau.frame.origin.y
        viewInfoGPLXSau.frame.size.height = viewImageGPLXSau.frame.size.height + viewImageGPLXSau.frame.origin.y
        
        viewInfoSoHK.frame.origin.y = viewInfoGPLXSau.frame.size.height + viewInfoGPLXSau.frame.origin.y + Common.Size(s:10)
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "5", image: self.imgViewGPLXSau.image!)
            
        }
    }
    
    
    
    func imageSoHK(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHK.frame.size.width / sca
        viewImageSoHK.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHK  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHK.frame.size.width, height: heightImage))
        imgViewSoHK.contentMode = .scaleAspectFit
        imgViewSoHK.image = image
        viewImageSoHK.addSubview(imgViewSoHK)
        viewImageSoHK.frame.size.height = imgViewSoHK.frame.size.height + imgViewSoHK.frame.origin.y
        viewInfoSoHK.frame.size.height = viewImageSoHK.frame.size.height + viewImageSoHK.frame.origin.y
        lbInfoUploadMore.frame.origin.y = viewInfoSoHK.frame.size.height + viewInfoSoHK.frame.origin.y
            + Common.Size(s:10)
        viewUploadMore.frame.origin.y = lbInfoUploadMore.frame.origin.y + lbInfoUploadMore.frame.size.height + Common.Size(s:10)
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "6", image: self.imgViewSoHK.image!)
            
        }
    }
    func imageSoHK2(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang2.frame.size.width / sca
        viewImageSoHKTrang2.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang2  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang2.frame.size.width, height: heightImage))
        imgViewSoHKTrang2.contentMode = .scaleAspectFit
        imgViewSoHKTrang2.image = image
        viewImageSoHKTrang2.addSubview(imgViewSoHKTrang2)
        viewImageSoHKTrang2.frame.size.height = imgViewSoHKTrang2.frame.size.height + imgViewSoHKTrang2.frame.origin.y
        viewInfoSoHKTrang2.frame.size.height = viewImageSoHKTrang2.frame.size.height + viewImageSoHKTrang2.frame.origin.y
        
        viewInfoSoHKTrang3.frame.origin.y = viewInfoSoHKTrang2.frame.origin.y + viewInfoSoHKTrang2.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang4.frame.origin.y = viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "7", image: self.imgViewSoHKTrang2.image!)
            
        }
    }
    
    func imageSoHK3(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang3.frame.size.width / sca
        viewImageSoHKTrang3.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang3  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang3.frame.size.width, height: heightImage))
        imgViewSoHKTrang3.contentMode = .scaleAspectFit
        imgViewSoHKTrang3.image = image
        viewImageSoHKTrang3.addSubview(imgViewSoHKTrang3)
        viewImageSoHKTrang3.frame.size.height = imgViewSoHKTrang3.frame.size.height + imgViewSoHKTrang3.frame.origin.y
        viewInfoSoHKTrang3.frame.size.height = viewImageSoHKTrang3.frame.size.height + viewImageSoHKTrang3.frame.origin.y
        viewInfoSoHKTrang4.frame.origin.y = viewInfoSoHKTrang3.frame.origin.y + viewInfoSoHKTrang3.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "8", image: self.imgViewSoHKTrang3.image!)
            
        }
    }
    func imageSoHK4(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang4.frame.size.width / sca
        viewImageSoHKTrang4.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang4  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang4.frame.size.width, height: heightImage))
        imgViewSoHKTrang4.contentMode = .scaleAspectFit
        imgViewSoHKTrang4.image = image
        viewImageSoHKTrang4.addSubview(imgViewSoHKTrang4)
        viewImageSoHKTrang4.frame.size.height = imgViewSoHKTrang4.frame.size.height + imgViewSoHKTrang4.frame.origin.y
        viewInfoSoHKTrang4.frame.size.height = viewImageSoHKTrang4.frame.size.height + viewImageSoHKTrang4.frame.origin.y
        viewInfoSoHKTrang5.frame.origin.y = viewInfoSoHKTrang4.frame.origin.y + viewInfoSoHKTrang4.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "9", image: self.imgViewSoHKTrang4.image!)
            
        }
    }
    func imageSoHK5(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang5.frame.size.width / sca
        viewImageSoHKTrang5.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang5  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang5.frame.size.width, height: heightImage))
        imgViewSoHKTrang5.contentMode = .scaleAspectFit
        imgViewSoHKTrang5.image = image
        viewImageSoHKTrang5.addSubview(imgViewSoHKTrang5)
        viewImageSoHKTrang5.frame.size.height = imgViewSoHKTrang5.frame.size.height + imgViewSoHKTrang5.frame.origin.y
        viewInfoSoHKTrang5.frame.size.height = viewImageSoHKTrang5.frame.size.height + viewImageSoHKTrang5.frame.origin.y
        viewInfoSoHKTrang6.frame.origin.y = viewInfoSoHKTrang5.frame.origin.y + viewInfoSoHKTrang5.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "10", image: self.imgViewSoHKTrang5.image!)
            
        }
    }
    func imageSoHK6(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang6.frame.size.width / sca
        viewImageSoHKTrang6.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang6  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang6.frame.size.width, height: heightImage))
        imgViewSoHKTrang6.contentMode = .scaleAspectFit
        imgViewSoHKTrang6.image = image
        viewImageSoHKTrang6.addSubview(imgViewSoHKTrang6)
        viewImageSoHKTrang6.frame.size.height = imgViewSoHKTrang6.frame.size.height + imgViewSoHKTrang6.frame.origin.y
        viewInfoSoHKTrang6.frame.size.height = viewImageSoHKTrang6.frame.size.height + viewImageSoHKTrang6.frame.origin.y
        viewInfoSoHKTrang7.frame.origin.y = viewInfoSoHKTrang6.frame.origin.y + viewInfoSoHKTrang6.frame.size.height + Common.Size(s: 10)
        
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "11", image: self.imgViewSoHKTrang6.image!)
            
        }
    }
    func imageSoHK7(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang7.frame.size.width / sca
        viewImageSoHKTrang7.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang7  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang7.frame.size.width, height: heightImage))
        imgViewSoHKTrang7.contentMode = .scaleAspectFit
        imgViewSoHKTrang7.image = image
        viewImageSoHKTrang7.addSubview(imgViewSoHKTrang7)
        viewImageSoHKTrang7.frame.size.height = imgViewSoHKTrang7.frame.size.height + imgViewSoHKTrang7.frame.origin.y
        viewInfoSoHKTrang7.frame.size.height = viewImageSoHKTrang7.frame.size.height + viewImageSoHKTrang7.frame.origin.y
        
        viewInfoSoHKTrang8.frame.origin.y = viewInfoSoHKTrang7.frame.origin.y + viewInfoSoHKTrang7.frame.size.height + Common.Size(s: 10)
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "12", image: self.imgViewSoHKTrang7.image!)
            
        }
    }
    func imageSoHK8(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang8.frame.size.width / sca
        viewImageSoHKTrang8.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang8  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang8.frame.size.width, height: heightImage))
        imgViewSoHKTrang8.contentMode = .scaleAspectFit
        imgViewSoHKTrang8.image = image
        viewImageSoHKTrang8.addSubview(imgViewSoHKTrang8)
        viewImageSoHKTrang8.frame.size.height = imgViewSoHKTrang8.frame.size.height + imgViewSoHKTrang8.frame.origin.y
        viewInfoSoHKTrang8.frame.size.height = viewImageSoHKTrang8.frame.size.height + viewImageSoHKTrang8.frame.origin.y
        
   
        viewInfoSoHKTrang9.frame.origin.y = viewInfoSoHKTrang8.frame.origin.y + viewInfoSoHKTrang8.frame.size.height + Common.Size(s: 10)
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "17", image: self.imgViewSoHKTrang8.image!)
            
        }
    }
    func imageSoHK9(image:UIImage){
        let sca:CGFloat = image.size.width / image.size.height
        let heightImage:CGFloat = viewImageSoHKTrang9.frame.size.width / sca
        viewImageSoHKTrang9.subviews.forEach { $0.removeFromSuperview() }
        imgViewSoHKTrang9  = UIImageView(frame: CGRect(x: 0, y: 0, width: viewImageSoHKTrang9.frame.size.width, height: heightImage))
        imgViewSoHKTrang9.contentMode = .scaleAspectFit
        imgViewSoHKTrang9.image = image
        viewImageSoHKTrang9.addSubview(imgViewSoHKTrang9)
        viewImageSoHKTrang9.frame.size.height = imgViewSoHKTrang9.frame.size.height + imgViewSoHKTrang9.frame.origin.y
        viewInfoSoHKTrang9.frame.size.height = viewImageSoHKTrang9.frame.size.height + viewImageSoHKTrang9.frame.origin.y
        
        viewUploadMore.frame.size.height = viewInfoSoHKTrang9.frame.size.height + viewInfoSoHKTrang9.frame.origin.y
        heightUploadView = viewUploadMore.frame.size.height
        
        viewUpload.frame.size.height = viewUploadMore.frame.size.height + viewUploadMore.frame.origin.y
        lbResendSMS.frame.origin.y = viewUpload.frame.size.height + viewUpload.frame.origin.y + Common.Size(s:20)
        btTaoDonHang.frame.origin.y = lbResendSMS.frame.size.height + lbResendSMS.frame.origin.y + Common.Size(s:20)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btTaoDonHang.frame.origin.y + btTaoDonHang.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s:20))
        
        
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.uploadImageV2(type: "18", image: self.imgViewSoHKTrang9.image!)
            
        }
    }

}
extension DetailInfoCustomerMiraeHistoryViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
           self.openCamera()
//        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
//            self.openCamera()
//        }))
//
//        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
//            self.openGallary()
//        }))
//
//        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
//
//        /*If you want work actionsheet on ipad
//         then you have to use popoverPresentationController to present the actionsheet,
//         otherwise app will crash on iPad */
//        switch UIDevice.current.userInterfaceIdiom {
//        case .pad:
//            //            alert.popoverPresentationController?.sourceView = sender
//            //            alert.popoverPresentationController?.sourceRect = sender.bounds
//            alert.popoverPresentationController?.permittedArrowDirections = .up
//        default:
//            break
//        }
//        self.present(alert, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        if (self.posImageUpload == 1){
            
            self.imageCMNDTruoc(image: image)
        }else if (self.posImageUpload == 2){
            
            self.imageCMNDSau(image: image)
        }else if (self.posImageUpload == 3){
            
            self.imageChanDungKH(image: image)
        }else if (self.posImageUpload == 4){
            self.imageGPLXTruoc(image: image)
        }else if (self.posImageUpload == 5){
            self.imageGPLXSau(image: image)
        }else if (self.posImageUpload == 6){
            self.imageSoHK(image: image)
        }else if (self.posImageUpload == 7){
            self.imageSoHK2(image: image)
        }else if (self.posImageUpload == 8){
            self.imageSoHK3(image: image)
        }else if (self.posImageUpload == 9){
            self.imageSoHK4(image: image)
        }else if (self.posImageUpload == 10){
            self.imageSoHK5(image: image)
        }else if (self.posImageUpload == 11){
            self.imageSoHK6(image: image)
        }else if (self.posImageUpload == 12){
            self.imageSoHK7(image: image)
        }else if (self.posImageUpload == 13){
            self.imageSoHK8(image: image)
        }else if (self.posImageUpload == 14){
            self.imageSoHK9(image: image)
        }else if (self.posImageUpload == 15){
            self.imageSim(image: image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
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
    
}

