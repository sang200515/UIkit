//
//  TraMayGetInfoController.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import PopupDialog
//import EPSignature

class TraMayGetInfoController: UIViewController ,EPSignatureDelegate{
    
    var mArrayBaoHanhUploadImageNewObject  = [BaoHanhUploadImageNewObject]()
    var txtSoPhieu:UILabel!
    var mSoDH:String?
    var mString64Custom:String = ""
    var mString64Employ:String = ""
    var ImageChuKyNVImage:UIImageView!
    var viewChuKyNV:UIView!
    var ImageChuKyNV:UIView!
    var ImageChuKyKHImage:UIImageView!
    var ImageChuKyKH:UIView!
    var viewChuKyKH:UIView!
    var arrPhieuInfo = [TraMay_LoadThongTinBBTraMayResult]()
    
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    var scrollView:UIScrollView!
    var edtTenKH:UITextField!
    var edtSDT:UITextField!
    var edtNgayTiepNhan:UITextField!
    var edtNgayHenTra:UITextField!
    var edtTenSP:UITextField!
    var edtImei:UITextField!
    var edtSPTra:UITextField!
    var edtImeiSPTra:UITextField!
    var edtThongTinXuLy:UITextField!
    var edtTongChiPhiSua:UITextField!
    var edtMay:UITextField!
    
    
    var isSysKnox:Bool = false
    var btnCheckKnox:UIButton!
    var btnDone:UIButton!
    var mSigned:Int = 0
    
    var isImageNV = true
    var isImageKH = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        intitView()
        
        GetDataLoadThongTinBBTraMay(p_MaPhieuBH: "\(mSoDH!)")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    func GetDataLoadThongTinBBTraMay(p_MaPhieuBH: String)
    {
        loadingView.isHidden = false
        MPOSAPIManager.GetLoadThongTinBBTraMay(p_MaPhieuBH: p_MaPhieuBH){ (error: Error? , success: Bool,result: TraMay_LoadThongTinBBTraMayResult!) in
            self.loadingView.isHidden = true
            if success
            {
                if(result != nil  )
                {
                    //self.ShowDialog(mMess: "ok")
                    
                    self.edtImei.text = result.Imei
                    self.edtTenSP.text = result.TenSanPhamChinh
                    self.edtImeiSPTra.text = result.ImeiTraMay
                    self.edtSPTra.text = result.TenSanPhamTra
                    self.edtSDT.text = result.SDTLienHe
                    self.edtThongTinXuLy.text = result.ThongTinXuLy
                    self.edtTongChiPhiSua.text = result.TongChiPhiSua
                    self.edtNgayTiepNhan.text = result.NgayTaoPhieu
                    self.edtNgayHenTra.text = result.NgayDuKienTra
                    self.edtTenKH.text = result.TenNguoiLienHe
                    self.edtMay.text = result.TenPK
                    self.txtSoPhieu.text = "Số phiếu \(result.MaPhieuBH)"
                    if(result.Knox == "-1")
                    {
                        self.btnCheckKnox.isHidden = true
                        self.btnDone.frame.origin.x = self.btnCheckKnox.frame.origin.x
                        self.btnDone.frame.size.width = UIScreen.main.bounds.size.width - 20
                    }
                    ///KNOX = -1 K CO KNOX
                    ///MUON MAY 0 - K MUON 1 - MUON
                    self.arrPhieuInfo.append(result)
                }
                else
                {
                    self.ShowDialog(mMess: "Không tìm thấy kết quả, vui lòng tìm kiếm từ khóa khác")
                }
                
            }
            else
            {
                self.ShowDialog(mMess: "Không tìm thấy kết quả, vui lòng tìm kiếm từ khóa khác")
            }
        }
    }
    
    
    ////
    
    func GetDataDongBoKnox(p_MaPhieuBH: String,p_Imei:String,p_ImeiNew:String,p_UserCode:String)
    {
        loadingView.isHidden = false
        MPOSAPIManager.GetDongBoKnox(p_MaPhieuBH: p_MaPhieuBH,p_Imei:p_Imei,p_ImeiNew:p_ImeiNew,p_UserCode:p_UserCode){ (error: Error? , success: Bool,result: String!,resultMessage:String!) in
            self.loadingView.isHidden = true
            if success
            {
                self.isSysKnox = true
                if(result != nil  )
                {
                    //self.ShowDialog(mMess: "ok")
                    if("\(result!)" == "1")
                    {
                        self.ShowDialog(mMess: "Đồng bộ thành công !!")
                        self.isSysKnox = true
                    }
                    else
                    {
                        self.ShowDialog(mMess: "\(resultMessage!)")
                    }
                    
                }
                else
                {
                    self.ShowDialog(mMess: "Không tìm thấy kết quả")
                }
                
            }
            else
            {
                self.ShowDialog(mMess: "Không tìm thấy kết quả")
            }
        }
    }
    
    
//    func CallAPIUPAnhChuKi(p_mString64Custom:String,p_mString64Employ:String,p_MaPhieuBH:String)
//    {
//        loadingView.isHidden = false
//        let mObjectNV = BaoHanhUploadImageNewObject(p_FileName:"ios_chukinv.png", p_Base64: p_mString64Employ, p_IsSign:"4")
//        let mObjectKH = BaoHanhUploadImageNewObject(p_FileName:"ios_chukiKH.png", p_Base64: p_mString64Custom, p_IsSign:"5")
//        mArrayBaoHanhUploadImageNewObject.append(mObjectNV)
//        mArrayBaoHanhUploadImageNewObject.append(mObjectKH)
//
//        let mObjectParam = BaoHanhUploadImageNewParamObject(p_UserCode:"\(Cache.user!.UserName)", p_UserName: "\(Cache.user!.EmployeeName)",p_MaPhieuBH:"\(self.mSoDH!)",mObject: mArrayBaoHanhUploadImageNewObject)
//
//
//        MPOSAPIManager.BaoHanhUploadImageNew(mListObject:mObjectParam){ (error: Error? , success: Bool,result: String!,resultMessage:String!) in
//            self.loadingView.isHidden = true
//            if success
//            {
//                self.ShowDialog(mMess: "\(p_MaPhieuBH) - Thành công")
//            }
//            else
//            {
//                self.ShowDialog(mMess: "Lưu hình ảnh thất bại")
//            }
//        }
//    }
    
    
    ////
    func GetDataImageBienBanBH(p_MaPhieuBH:String,  p_Base64_CusSign:String,p_Base64_EplSign
        : String, p_Type:String, p_UserCode:String, p_UserName:String,p_Manager: String,p_ManagerSignature: String)
    {
        loadingView.isHidden = false
        MPOSAPIManager.GetImageBienBanBH(p_MaPhieuBH:p_MaPhieuBH,  p_Base64_CusSign:p_Base64_CusSign,p_Base64_EplSign
        : p_Base64_EplSign, p_Type:p_Type, p_UserCode:p_UserCode, p_UserName:p_UserName,p_Manager: "",p_ManagerSignature : ""){ (error: Error? , success: Bool,result: String!,resultMessage:String!) in
            self.loadingView.isHidden = true
            
            if success
            {
                self.btnDone.isEnabled = true
                if(result != nil  )
                {
                    //self.ShowDialog(mMess: "ok")
                    if(result == "1")
                    {
                          // self.ShowDialog(mMess: "Trả phiếu  \(resultMessage!) - Thành công")
                        //  self.ShowDialog(mMess: "Trả phiếu thành công")
//                        self.CallAPIUPAnhChuKi(p_mString64Custom:self.mString64Custom,p_mString64Employ:self.mString64Employ, p_MaPhieuBH: "\(resultMessage!)")
                        let alert = UIAlertController(title: "Thông Báo", message: "Trả phiếu thành công", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler:{ action in
                          
                                  self.navigationController?.popToRootViewController(animated: true)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    }
                    else
                    {
                        self.ShowDialog(mMess: "\(resultMessage!)")
                    }
                    
                }
                else
                {
                    self.ShowDialog(mMess: "Không tìm thấy kết quả")
                }
                
            }
            else
            {
                self.btnDone.isEnabled = true
                self.ShowDialog(mMess: "Không tìm thấy kết quả")
            }
        }
    }
    //
//    func CallAPIUPAnhChuKi(p_MaPhieuBH:String,  p_Base64_CusSign:String,p_Base64_EplSign
//        : String, p_Type:String, p_UserCode:String, p_UserName:String,p_Manager: String,p_ManagerSignature: String)
//    {
//        loadingView.isHidden = false
//        let mObjectNV = BaoHanhUploadImageNewObject(p_FileName:"ios_chukinv.png", p_Base64: self.mString64Employ, p_IsSign:"4")
//        let mObjectKH = BaoHanhUploadImageNewObject(p_FileName:"ios_chukiKH.png", p_Base64: self.mString64Custom, p_IsSign:"5")
//        mArrayBaoHanhUploadImageNewObject.append(mObjectNV)
//        mArrayBaoHanhUploadImageNewObject.append(mObjectKH)
//
//        let mObjectParam = BaoHanhUploadImageNewParamObject(p_UserCode:"\(Cache.user!.UserName)", p_UserName: "\(Cache.user!.EmployeeName)",p_MaPhieuBH:"\(self.mSoDH!)",mObject: mArrayBaoHanhUploadImageNewObject)
//
//
//        MPOSAPIManager.BaoHanhUploadImageNew(mListObject:mObjectParam){ (error: Error? , success: Bool,result: String!,resultMessage:String!) in
//            self.loadingView.isHidden = true
//            if success
//            {
//              //  self.ShowDialog(mMess: "\(p_MaPhieuBH) - Thành công")
//               self.GetDataImageBienBanBH(p_MaPhieuBH: p_MaPhieuBH,  p_Base64_CusSign:p_Base64_CusSign,p_Base64_EplSign
//                    : p_Base64_EplSign, p_Type: p_Type, p_UserCode: "\(Cache.user!.UserName)", p_UserName:"\(Cache.user!.EmployeeName)",p_Manager: p_Manager ,p_ManagerSignature: p_ManagerSignature)
//            }
//            else
//            {
//                self.ShowDialog(mMess: "Lưu hình ảnh thất bại")
//            }
//        }
//
//    }
    
    func CallAPIUPAnhChuKi(p_MaPhieuBH:String,  p_Base64_CusSign:String,p_Base64_EplSign
        : String, p_Type:String, p_UserCode:String, p_UserName:String,p_Manager: String,p_ManagerSignature: String)
    {
        loadingView.isHidden = false
        if(isImageNV == true){
            isImageNV = false
            self.uploadImage2(p_FileName: "ios_chukinv.png", p_Base64:  self.mString64Employ, p_IsSign: "4", isType: "NV")
            return
        }
        if(isImageKH == true){
            isImageKH = false
            self.uploadImage2(p_FileName: "ios_chukiKH.png", p_Base64:  self.mString64Custom, p_IsSign: "5", isType: "KH")
            return
        }
 
        
    }
    
    func uploadImage2(p_FileName:String,p_Base64:String,p_IsSign:String,isType:String){
        MPOSAPIManager.UpLoadImageSingle_TaoPhieuBH(p_MaPhieuBH: "\(self.mSoDH!)", p_FileName: p_FileName, p_Base64: p_Base64, p_IsSign: p_IsSign){ (err, success,result,resultMessage) in
            
            if success
            {
             
                if(isType == "NV"){
                    print("isType NV")
                  
                    self.CallAPIUPAnhChuKi(p_MaPhieuBH: self.arrPhieuInfo[0].MaPhieuBH,  p_Base64_CusSign:"\(self.mString64Custom)",p_Base64_EplSign
                        : "\(self.mString64Employ)", p_Type:"1", p_UserCode:"\(Cache.user!.UserName)", p_UserName:"\(Cache.user!.EmployeeName)",p_Manager: "",p_ManagerSignature: "")
                }
         
                if(isType == "KH"){
                    print("isType KH")
                    self.GetDataImageBienBanBH(p_MaPhieuBH: "\(self.mSoDH!)",  p_Base64_CusSign:"\(self.mString64Custom)",p_Base64_EplSign
                                        : "\(self.mString64Employ)", p_Type: "1", p_UserCode: "\(Cache.user!.UserName)", p_UserName:"\(Cache.user!.EmployeeName)",p_Manager: "" ,p_ManagerSignature: "")
               
                }
                
                
                
            }
            else
            {
                if(err != ""){
                    self.ShowDialog(mMess: err)
                }else{
                    self.ShowDialog(mMess: "Kết nối api thất bại !!")
                }
                
            }
        }
    }
    //
    
    
    
    @objc func ClickCheckKnox()
    {
        if((self.arrPhieuInfo.count) > 0)
        {
            self.GetDataDongBoKnox(p_MaPhieuBH: "\(arrPhieuInfo[0].MaPhieuBH)",p_Imei:"\(arrPhieuInfo[0].Imei)",p_ImeiNew:"\(arrPhieuInfo[0].ImeiTraMay)", p_UserCode: "\(Cache.user!.UserName)")
            
        }
        print("ClickCheckKnox")
    }
    
    @objc func ClickDone()
    {
        print("ClickDone")
        if(mString64Employ == "")
        {
            self.ShowDialog(mMess: "Vui lòng xác nhận chữ ký của nhân viên")
            return
        }
        if(mString64Custom == "")
        {
            self.ShowDialog(mMess: "Vui lòng xác nhận chữ ký của khách hàng")
            return
        }
        if(self.arrPhieuInfo[0].Knox != "-1" && self.isSysKnox == false)
        {
            self.ShowDialog(mMess: "Vui lòng đồng bộ knox")
            return
        }
        btnDone.isEnabled = false
        
        self.CallAPIUPAnhChuKi(p_MaPhieuBH: self.arrPhieuInfo[0].MaPhieuBH,  p_Base64_CusSign:"\(self.mString64Custom)",p_Base64_EplSign
            : "\(self.mString64Employ)", p_Type:"1", p_UserCode:"\(Cache.user!.UserName)", p_UserName:"\(Cache.user!.EmployeeName)",p_Manager: "",p_ManagerSignature: "")
        
        
        
    }
    
    func ShowDialog(mMess:String)
    {
        let title = "THÔNG BÁO"
        let message = "\(mMess)"
     
        let popup = PopupDialog(title: title, message: message, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
            print("Completed")
        }
        let buttonOne = DefaultButton(title: "OK") {
            
        }
        popup.addButtons([buttonOne])
        self.present(popup, animated: true, completion: nil)
    }
    
    
    
    
    
    
    @objc func tapSigningKH(sender:UITapGestureRecognizer) {
        self.mSigned = 1
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    @objc func tapSigningNV(sender:UITapGestureRecognizer) {
        self.mSigned = 2
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
//        let nav = UINavigationController(rootViewController: signatureVC)
//        present(nav, animated: true, completion: nil)
         self.navigationController?.pushViewController(signatureVC, animated: true)
    }
    
    
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        print("User canceled")
        _ = self.navigationController?.popViewController(animated: true)
           self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        
        let width = viewChuKyKH.frame.size.width - Common.Size(s: 10)
        let mHeight = ImageChuKyKHImage.frame.size.height
        if(self.mSigned == 1)
        {
            ImageChuKyKH.subviews.forEach { $0.removeFromSuperview() }
            ImageChuKyKHImage  = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: width, height: mHeight))
            ImageChuKyKHImage.contentMode = .scaleAspectFit
            ImageChuKyKH.addSubview(ImageChuKyKHImage)
            ImageChuKyKHImage.image = cropImage(image: signatureImage, toRect: boundingRect)
            viewChuKyKH.frame.size.height =  ImageChuKyKHImage.frame.size.height
            
            let imageDataPic1:NSData = (ImageChuKyKHImage.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
            mString64Custom = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            
            
            
        }else if(self.mSigned == 2)
        {
            ImageChuKyNV.subviews.forEach { $0.removeFromSuperview() }
            ImageChuKyNVImage  = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: Common.Size(s: 5), width: width, height: mHeight))
            ImageChuKyNVImage.contentMode = .scaleAspectFit
            ImageChuKyNV.addSubview(ImageChuKyNVImage)
            ImageChuKyNVImage.image = cropImage(image: signatureImage, toRect: boundingRect)
            viewChuKyNV.frame.size.height =  ImageChuKyNVImage.frame.size.height
            
            let imageDataPic2:NSData = (ImageChuKyNVImage.image!.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
            mString64Employ = imageDataPic2.base64EncodedString(options: .endLineWithLineFeed)
        }
        
        self.mSigned = 0
        
        _ = self.navigationController?.popViewController(animated: true)
           self.dismiss(animated: true, completion: nil)
    }
    
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    
    
    
    
    func intitView()
    {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        
        txtSoPhieu = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: 0  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtSoPhieu.textAlignment = .left
        txtSoPhieu.textColor = UIColor(netHex:0x07922d)
        txtSoPhieu.backgroundColor = UIColor(netHex:0xffffff)
        txtSoPhieu.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtSoPhieu.text = "Số phiếu"
        
        
        let txtThongTinKhachHang = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: txtSoPhieu.frame.size.height + Common.Size(s: 10)  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtThongTinKhachHang.textAlignment = .left
        txtThongTinKhachHang.textColor = UIColor(netHex:0x07922d)
        txtThongTinKhachHang.backgroundColor = UIColor(netHex:0xffffff)
        txtThongTinKhachHang.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtThongTinKhachHang.text = "THÔNG TIN KHÁCH HÀNG"
        
        
        
        
        /////
        let lbTenKH = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtThongTinKhachHang.frame.origin.y + txtThongTinKhachHang.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTenKH.textAlignment = .left
        lbTenKH.textColor = UIColor.black
        lbTenKH.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenKH.text = "Họ tên KH (*)"
        
        
        ///sdt
        
        edtTenKH = UITextField(frame: CGRect(x: 15 , y: lbTenKH.frame.origin.y + lbTenKH.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTenKH.placeholder = ""
        edtTenKH.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTenKH.borderStyle = UITextField.BorderStyle.roundedRect
        edtTenKH.autocorrectionType = UITextAutocorrectionType.no
        edtTenKH.keyboardType = UIKeyboardType.default
        edtTenKH.returnKeyType = UIReturnKeyType.done
        edtTenKH.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTenKH.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTenKH.isEnabled = false
        
        //////////
        
        ////rightview Spinner NCC
        //edtTenKH.rightViewMode = UITextFieldViewMode.always
        
        let imageMaHD = UIImageView(frame: CGRect(x: edtTenKH.frame.size.height/4, y: edtTenKH.frame.size.height/4, width: edtTenKH.frame.size.height/2, height: edtTenKH.frame.size.height/2))
        imageMaHD.image = UIImage(named: "Search-50-black")
        imageMaHD.contentMode = UIView.ContentMode.scaleAspectFit
        let rightViewMaHD = UIView()
        rightViewMaHD.addSubview(imageMaHD)
        rightViewMaHD.frame = CGRect(x: 0, y: 0, width: edtTenKH.frame.size.height, height: edtTenKH.frame.size.height)
        edtTenKH.rightView = rightViewMaHD
        
        
        
        
        
        let lbSDT = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTenKH.frame.origin.y + edtTenKH.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbSDT.textAlignment = .left
        lbSDT.textColor = UIColor.black
        lbSDT.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbSDT.text = "Số điện thoại (*)"
        
        
        
        ///sdt
        
        edtSDT = UITextField(frame: CGRect(x: 15 , y: lbSDT.frame.origin.y + lbSDT.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSDT.placeholder = ""
        
        edtSDT.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSDT.borderStyle = UITextField.BorderStyle.roundedRect
        edtSDT.autocorrectionType = UITextAutocorrectionType.no
        edtSDT.keyboardType = .numberPad
        edtSDT.returnKeyType = UIReturnKeyType.done
        edtSDT.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSDT.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        edtSDT.isEnabled = false
        
        
        
        ///////
        let lbNgayTiepNhan = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtSDT.frame.origin.y + edtSDT.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbNgayTiepNhan.textAlignment = .left
        lbNgayTiepNhan.textColor = UIColor.black
        lbNgayTiepNhan.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbNgayTiepNhan.text = "Ngày tiếp nhận(*)"
        
        
        
        ///sdt
        
        edtNgayTiepNhan = UITextField(frame: CGRect(x: 15 , y: lbNgayTiepNhan.frame.origin.y + lbNgayTiepNhan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtNgayTiepNhan.placeholder = ""
        edtNgayTiepNhan.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtNgayTiepNhan.borderStyle = UITextField.BorderStyle.roundedRect
        edtNgayTiepNhan.autocorrectionType = UITextAutocorrectionType.no
        edtNgayTiepNhan.keyboardType = UIKeyboardType.default
        edtNgayTiepNhan.returnKeyType = UIReturnKeyType.done
        edtNgayTiepNhan.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNgayTiepNhan.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNgayTiepNhan.isEnabled = false
        
        
        
        
        let lbHenTra = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtNgayTiepNhan.frame.origin.y + edtNgayTiepNhan.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbHenTra.textAlignment = .left
        lbHenTra.textColor = UIColor.black
        lbHenTra.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbHenTra.text = "Ngày hẹn trả (*)"
        
        
        
        
        
        edtNgayHenTra = UITextField(frame: CGRect(x: 15 , y: lbHenTra.frame.origin.y + lbHenTra.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtNgayHenTra.placeholder = ""
        edtNgayHenTra.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtNgayHenTra.borderStyle = UITextField.BorderStyle.roundedRect
        edtNgayHenTra.autocorrectionType = UITextAutocorrectionType.no
        edtNgayHenTra.keyboardType = UIKeyboardType.default
        edtNgayHenTra.returnKeyType = UIReturnKeyType.done
        edtNgayHenTra.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtNgayHenTra.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtNgayHenTra.isEnabled = false
        
        
        
        
        
        let txtThongTinSP = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: edtNgayHenTra.frame.origin.y + edtNgayHenTra.frame.size.height + Common.Size(s: 10)  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtThongTinSP.textAlignment = .left
        txtThongTinSP.textColor = UIColor(netHex:0x07922d)
        txtThongTinSP.backgroundColor = UIColor(netHex:0xffffff)
        txtThongTinSP.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtThongTinSP.text = "THÔNG TIN SẢN PHẨM"
        
        
        
        
        
        let tenSP = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtThongTinSP.frame.origin.y + txtThongTinSP.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        tenSP.textAlignment = .left
        tenSP.textColor = UIColor.black
        tenSP.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        tenSP.text = "Tên SP (*)"
        
        
        
        
        
        edtTenSP = UITextField(frame: CGRect(x: 15 , y: tenSP.frame.origin.y + tenSP.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTenSP.placeholder = ""
        edtTenSP.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTenSP.borderStyle = UITextField.BorderStyle.roundedRect
        edtTenSP.autocorrectionType = UITextAutocorrectionType.no
        edtTenSP.keyboardType = UIKeyboardType.default
        edtTenSP.returnKeyType = UIReturnKeyType.done
        edtTenSP.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTenSP.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTenSP.isEnabled = false
        
        
        
        
        let lbImei = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtTenSP.frame.origin.y + edtTenSP.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImei.textAlignment = .left
        lbImei.textColor = UIColor.black
        lbImei.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImei.text = "Số Imei/Serial (*)"
        
        
        
        
        
        
        edtImei = UITextField(frame: CGRect(x: 15 , y: lbImei.frame.origin.y + lbImei.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtImei.placeholder = ""
        edtImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtImei.borderStyle = UITextField.BorderStyle.roundedRect
        edtImei.autocorrectionType = UITextAutocorrectionType.no
        edtImei.keyboardType = UIKeyboardType.default
        edtImei.returnKeyType = UIReturnKeyType.done
        edtImei.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtImei.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtImei.isEnabled = false
        
        
        
        let lbMay = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtImei.frame.origin.y + edtImei.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbMay.textAlignment = .left
        lbMay.textColor = UIColor.black
        lbMay.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbMay.text = "Phụ kiện theo máy (*)"
        
        
        edtMay = UITextField(frame: CGRect(x: 15 , y: lbMay.frame.origin.y + lbMay.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtMay.placeholder = ""
        edtMay.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtMay.borderStyle = UITextField.BorderStyle.roundedRect
        edtMay.autocorrectionType = UITextAutocorrectionType.no
        edtMay.keyboardType = UIKeyboardType.default
        edtMay.returnKeyType = UIReturnKeyType.done
        edtMay.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtMay.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtMay.isEnabled = false
        
        let txtThongTinTra = UILabel(frame: CGRect(x: Common.Size(s:15)  , y: edtMay.frame.origin.y + edtMay.frame.size.height + Common.Size(s: 10)  , width: UIScreen.main.bounds.size.width , height: Common.Size(s:40)));
        txtThongTinTra.textAlignment = .left
        txtThongTinTra.textColor = UIColor(netHex:0x07922d)
        txtThongTinTra.backgroundColor = UIColor(netHex:0xffffff)
        txtThongTinTra.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        txtThongTinTra.text = "THÔNG TIN TRẢ"
        
        
        
        
        let lbTenSPTra = UILabel(frame: CGRect(x: Common.Size(s:15), y: txtThongTinTra.frame.origin.y + txtThongTinTra.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTenSPTra.textAlignment = .left
        lbTenSPTra.textColor = UIColor.black
        lbTenSPTra.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTenSPTra.text = "Tên sp trả (*)"
        
        
        
        edtSPTra = UITextField(frame: CGRect(x: 15 , y: lbTenSPTra.frame.origin.y + lbTenSPTra.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtSPTra.placeholder = ""
        edtSPTra.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtSPTra.borderStyle = UITextField.BorderStyle.roundedRect
        edtSPTra.autocorrectionType = UITextAutocorrectionType.no
        edtSPTra.keyboardType = UIKeyboardType.default
        edtSPTra.returnKeyType = UIReturnKeyType.done
        edtSPTra.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtSPTra.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtSPTra.isEnabled = false
        
        let lbImeiSPTra = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtSPTra.frame.origin.y + edtSPTra.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbImeiSPTra.textAlignment = .left
        lbImeiSPTra.textColor = UIColor.black
        lbImeiSPTra.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbImeiSPTra.text = "Số Imei/Serial (*)"
        
        edtImeiSPTra = UITextField(frame: CGRect(x: 15 , y: lbImeiSPTra.frame.origin.y + lbImeiSPTra.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtImeiSPTra.placeholder = ""
        edtImeiSPTra.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtImeiSPTra.borderStyle = UITextField.BorderStyle.roundedRect
        edtImeiSPTra.autocorrectionType = UITextAutocorrectionType.no
        edtImeiSPTra.keyboardType = UIKeyboardType.default
        edtImeiSPTra.returnKeyType = UIReturnKeyType.done
        edtImeiSPTra.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtImeiSPTra.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtImeiSPTra.isEnabled = false
        
        
        
        ///sdt
        let lbThongTinXuLy = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtImeiSPTra.frame.origin.y + edtImeiSPTra.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbThongTinXuLy.textAlignment = .left
        lbThongTinXuLy.textColor = UIColor.black
        lbThongTinXuLy.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbThongTinXuLy.text = "Thông tin xử lý"
        
        
        
        
        edtThongTinXuLy = UITextField(frame: CGRect(x: 15 , y: lbThongTinXuLy.frame.origin.y + lbThongTinXuLy.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtThongTinXuLy.placeholder = ""
        edtThongTinXuLy.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtThongTinXuLy.borderStyle = UITextField.BorderStyle.roundedRect
        edtThongTinXuLy.autocorrectionType = UITextAutocorrectionType.no
        edtThongTinXuLy.keyboardType = UIKeyboardType.default
        edtThongTinXuLy.returnKeyType = UIReturnKeyType.done
        edtThongTinXuLy.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtThongTinXuLy.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtThongTinXuLy.isEnabled = false
        
        let lbTongChiPhiSua = UILabel(frame: CGRect(x: Common.Size(s:15), y: edtThongTinXuLy.frame.origin.y + edtThongTinXuLy.frame.size.height  + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lbTongChiPhiSua.textAlignment = .left
        lbTongChiPhiSua.textColor = UIColor.black
        lbTongChiPhiSua.font = UIFont.systemFont(ofSize: Common.Size(s:12))
        lbTongChiPhiSua.text = "Tổng chi phí sửa"
        
        
        edtTongChiPhiSua = UITextField(frame: CGRect(x: 15 , y: lbTongChiPhiSua.frame.origin.y + lbTongChiPhiSua.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width - 30  , height: Common.Size(s:40)));
        edtTongChiPhiSua.placeholder = ""
        edtTongChiPhiSua.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        edtTongChiPhiSua.borderStyle = UITextField.BorderStyle.roundedRect
        edtTongChiPhiSua.autocorrectionType = UITextAutocorrectionType.no
        edtTongChiPhiSua.keyboardType = UIKeyboardType.default
        edtTongChiPhiSua.returnKeyType = UIReturnKeyType.done
        edtTongChiPhiSua.clearButtonMode = UITextField.ViewMode.whileEditing;
        edtTongChiPhiSua.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        edtTongChiPhiSua.isEnabled = false
        
        
        viewChuKyKH = UIView(frame: CGRect(x: 0,y: edtTongChiPhiSua.frame.origin.y +  edtTongChiPhiSua.frame.size.height + Common.Size(s: 20) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s: 120) * 2))
        viewChuKyKH.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextChuKyKH = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 14)))
        lbTextChuKyKH.textAlignment = .left
        lbTextChuKyKH.textColor = UIColor.black
        lbTextChuKyKH.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        lbTextChuKyKH.text = "Chữ ký KH"
        viewChuKyKH.addSubview(lbTextChuKyKH)
        
        ImageChuKyKH = UIView(frame: CGRect(x:Common.Size(s: 15), y: lbTextChuKyKH.frame.origin.y + lbTextChuKyKH.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 100) * 2) )
        ImageChuKyKH.layer.borderWidth = 0.5
        ImageChuKyKH.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        ImageChuKyKH.layer.cornerRadius = 3.0
        viewChuKyKH.addSubview(ImageChuKyKH)
        
        ImageChuKyKHImage = UIImageView(frame: CGRect(x: ImageChuKyKH.frame.size.width/2 - (ImageChuKyKH.frame.size.height * 2/3)/2, y: 0, width: ImageChuKyKH.frame.size.height * 2/3, height: ImageChuKyKH.frame.size.height * 2/3))
        ImageChuKyKHImage.image = #imageLiteral(resourceName: "AddImage51")
        ImageChuKyKHImage.contentMode = .scaleAspectFit
        ImageChuKyKH.addSubview(ImageChuKyKHImage)
        
        
        
        
        let tapSigningKH = UITapGestureRecognizer(target: self, action: #selector(self.tapSigningKH))
        viewChuKyKH.isUserInteractionEnabled = true
        viewChuKyKH.addGestureRecognizer(tapSigningKH)
        
        
        viewChuKyNV = UIView(frame: CGRect(x: 0,y: viewChuKyKH.frame.origin.y +  viewChuKyKH.frame.size.height + Common.Size(s: 20) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s: 120) * 2))
        viewChuKyNV.backgroundColor = UIColor(netHex:0xffffff)
        
        let lbTextChuKyNV = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 14)))
        lbTextChuKyNV.textAlignment = .left
        lbTextChuKyNV.textColor = UIColor.black
        lbTextChuKyNV.font = UIFont.systemFont(ofSize: Common.Size(s: 11))
        lbTextChuKyNV.text = "Chữ ký NV trả máy"
        viewChuKyNV.addSubview(lbTextChuKyNV)
        
        ImageChuKyNV = UIView(frame: CGRect(x:Common.Size(s: 15), y: lbTextChuKyNV.frame.origin.y + lbTextChuKyNV.frame.size.height + Common.Size(s: 5), width: scrollView.frame.size.width - Common.Size(s: 30), height: Common.Size(s: 100) * 2) )
        ImageChuKyNV.layer.borderWidth = 0.5
        ImageChuKyNV.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        ImageChuKyNV.layer.cornerRadius = 3.0
        viewChuKyNV.addSubview(ImageChuKyNV)
        
        
        ImageChuKyNVImage = UIImageView(frame: CGRect(x: ImageChuKyNV.frame.size.width/2 - (ImageChuKyNV.frame.size.height * 2/3)/2, y: 0, width: ImageChuKyNV.frame.size.height * 2/3, height: ImageChuKyNV.frame.size.height * 2/3))
        ImageChuKyNVImage.image = #imageLiteral(resourceName: "AddImage51")
        ImageChuKyNVImage.contentMode = .scaleAspectFit
        ImageChuKyNV.addSubview(ImageChuKyNVImage)
        
        let tapSigningNV = UITapGestureRecognizer(target: self, action: #selector(self.tapSigningNV))
        viewChuKyNV.isUserInteractionEnabled = true
        viewChuKyNV.addGestureRecognizer(tapSigningNV)
        
        btnCheckKnox = UIButton(frame: CGRect(x: Common.Size(s: 15), y: viewChuKyNV.frame.origin.y + viewChuKyNV.frame.size.height + 10, width: UIScreen.main.bounds.size.width / 2 - Common.Size(s: 15) , height: Common.Size(s:40)));
        
        btnCheckKnox.setTitle("Đồng bộ knox",for: .normal)
        
        btnCheckKnox.backgroundColor = UIColor(netHex:0xdb474f)
        btnCheckKnox.layer.cornerRadius = 5
        btnCheckKnox.layer.borderWidth = 1
        btnCheckKnox.layer.borderColor = UIColor.white.cgColor
        
        btnCheckKnox.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        btnCheckKnox.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        btnCheckKnox.addTarget(self, action: #selector(ClickCheckKnox), for: UIControl.Event.touchDown)
        
        
        btnDone = UIButton(frame: CGRect(x: btnCheckKnox.frame.origin.x + btnCheckKnox.frame.size.width + Common.Size(s: 5), y: viewChuKyNV.frame.origin.y + viewChuKyNV.frame.size.height + 10, width: btnCheckKnox.frame.size.width , height: Common.Size(s:40)));
        
        
        btnDone.setTitle("Hoàn Tất",for: .normal)
        btnDone.titleLabel!.font =  UIFont(name: "Helvetica", size: 20)
        btnDone.backgroundColor = UIColor(netHex:0x47B054)
        btnDone.layer.cornerRadius = 5
        btnDone.layer.borderWidth = 1
        btnDone.layer.borderColor = UIColor.white.cgColor
        btnDone.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        btnDone.addTarget(self, action: #selector(ClickDone), for: UIControl.Event.touchDown)
        
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(txtSoPhieu)
        self.scrollView.addSubview(txtThongTinKhachHang)
        self.scrollView.addSubview(lbTenKH)
        self.scrollView.addSubview(edtTenKH)
        self.scrollView.addSubview(lbSDT)
        self.scrollView.addSubview(edtSDT)
        self.scrollView.addSubview(lbNgayTiepNhan)
        self.scrollView.addSubview(edtNgayTiepNhan)
        self.scrollView.addSubview(lbHenTra)
        self.scrollView.addSubview(edtNgayHenTra)
        self.scrollView.addSubview(txtThongTinSP)
        self.scrollView.addSubview(tenSP)
        self.scrollView.addSubview(edtTenSP)
        self.scrollView.addSubview(lbImei)
        self.scrollView.addSubview(edtImei)
        self.scrollView.addSubview(lbMay)
        self.scrollView.addSubview(edtMay)
        self.scrollView.addSubview(txtThongTinTra)
        self.scrollView.addSubview(lbTenSPTra)
        self.scrollView.addSubview(edtSPTra)
        self.scrollView.addSubview(lbImeiSPTra)
        self.scrollView.addSubview(edtImeiSPTra)
        self.scrollView.addSubview(lbThongTinXuLy)
        self.scrollView.addSubview(edtThongTinXuLy)
        self.scrollView.addSubview(lbTongChiPhiSua)
        self.scrollView.addSubview(edtTongChiPhiSua)
        self.scrollView.addSubview(viewChuKyKH)
        self.scrollView.addSubview(viewChuKyNV)
        self.scrollView.addSubview(btnCheckKnox)
        self.scrollView.addSubview(btnDone)
        
        loadingView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        
        
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        loadingView.isHidden = true
        self.view.addSubview(loadingView)
        self.hideKeyboardWhenTappedAround()
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btnDone.frame.size.height + btnDone.frame.origin.y + 100)
        
    }
    
    
}
