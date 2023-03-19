//
//  ChiTietDonHangTabDaGiaoViewController.swift
//  NewmDelivery
//
//  Created by sumi on 3/30/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import Toaster
import Alamofire

class ChiTietDonHangTabDaGiaoViewController: UIViewController ,InputTextViewDelegate,InputViewXacNhanDelegate,UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,InputViewXacNhanNhapKhoDelegate{
    func didClose(sender: InputViewXacNhanNhapKhoDelegate, mUser: String, mPass: String) {
        self.view.endEditing(true)
        let cryptoPass = PasswordEncrypter.encrypt(password: mPass)
        GetResultSetSOReturned(docNum: "\((mObjectData?.ID)!)", userCode:"\(mUser)", reason:"\(cryptoPass)",is_Returned:"1")
    }
    
    func didCancel(sender: InputViewXacNhanNhapKhoDelegate) {
        self.viewXacNhanNhapKho.isHidden = true
        self.viewXacNhanNhapKho.edtNameProduct.text = ""
        self.viewXacNhanNhapKho.edtNameProduct2.text = ""
        self.view.endEditing(true)
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mListSp.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return (Common.Size(s:60));
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemSPMuaTableViewCell", for: indexPath) as! ItemSPMuaTableViewCell
          
            cell.txtValueTenSP.text = "\(mListSp[indexPath.row].U_ItmName)"
            cell.txtValueImeiSP.text = "Imei :\(mListSp[indexPath.row].U_Imei)"
            cell.txtValueSLSP.text = "x\(mListSp[indexPath.row].U_Qutity)"
        
            let uMoney = Int(self.mListSp[indexPath.row].U_TMoney) ?? 0
            let money = "\(Common.convertCurrencyV2(value: uMoney)) đ"
            cell.txtValuePriceSP.text = money
        return cell
    }
    
    func didClose(sender: InputTextViewDelegate, mReason: String) {
         print("close")
    }
    
    func didClose(sender: InputViewXacNhanDelegate,mUser:String,mPass:String) {
        print("close didClose")
        self.view.endEditing(true)
        let cryptoPass = PasswordEncrypter.encrypt(password: mPass)
        self.GetDataSOPaid(docNum: "\((mObjectData?.ID)!)", userCode: "\(mUser)", password: "\(cryptoPass)")
    }
    
    func didCancel(sender: InputViewXacNhanDelegate) {
        print("cancel didCancel")
        print("cancel")
        self.viewXacNhan.isHidden = true
        self.viewXacNhan.edtNameProduct.text = ""
        self.view.endEditing(true)
    }
    
    
    
    func didCancel(sender: InputTextViewDelegate) {
        print("cancel")
        self.viewInput.isHidden = true
        self.viewInput.edtNameProduct.text = ""
        self.view.endEditing(true)
    }
    
    var isClickFrombtn:Bool = false
    var mTongTien:Int = 0
    var mListSp = [getSODetailsResult]()
    var tableViewSP: UITableView  =   UITableView()
    var mObjectData:GetSOByUserResult?
    var  btnCall:UIButton!
    var viewNgMua:UIView!
    var viewNgNhan:UIView!
    var viewPhanCong:UIView!
    var viewThongTin:UIView!
    
    var labelNgMua:UILabel!
    var imageNgMua:UIImageView!
    var labelValueNameNgMua:UILabel!
    var labelValuePhoneNumNgMua:UILabel!
    var labelValueAddrNgMua:UILabel!
    
    
    var labelNgNhan:UILabel!
    var imageNgNhan:UIImageView!
    var labelValueNameNgNhan:UILabel!
    var labelValuePhoneNumNgNhan:UILabel!
    var labelValueAddrNgNhan:UILabel!
    
    var labelPhanCong:UILabel!
    var labelNV:UILabel!
    var labelThuKho:UILabel!
    var imagePhanCong:UIImageView!
    var labelValueNV:UITextField!
    
    
    var labelThongTinn:UILabel!
    var imageThongTin:UIImageView!
    var labelDH:UILabel!
    var labelValueDH:UILabel!
    var labelEcom:UILabel!
    var labelValueEcom:UILabel!
    var labelTime:UILabel!
    var labelValueTime:UILabel!
    var labelValueTimeLest:UILabel!
    var labelGhiChu:UILabel!
    var viewGhiChu:UIView!
    var txtValueGhiChu: UILabel!
    
    
    var viewItemDH:UIView!
    var labelItemDHName:UILabel!
    var labelItemDHImei:UILabel!
    var labelItemDHSL:UILabel!
    var labelItemDHGia:UILabel!
    
    var viewTongDH:UIView!
    var labelTongDHText:UILabel!
    var labelTienGiamText:UILabel!
    var labelDatCocText:UILabel!
    var labelPhaiThuText:UILabel!
    
    var labelTongDHValue:UILabel!
    var labelTienGiamValue:UILabel!
    var labelDatCocValue:UILabel!
    var labelPhaiThuValue:UILabel!
    
    var btnXacNhan:UIButton!
    
    var scrollView:UIScrollView!
    
    var viewLine1:UIView!
    var viewLine2:UIView!
    var viewLine3:UIView!
    
    var companyButton: SearchTextField!
    var companyButton2: SearchTextField!
    
    var arrGetEmPloyeesResult = [GetEmPloyeesResult]()
    
    var barSearchRight : UIBarButtonItem!
    
    
    var mViewOptionMenu:UIView!
    var mTitleMenu1:UILabel!
    var mViewLine1:UIView!
    var mTitleMenu2:UILabel!
    var viewInput:InputTextView!
    var viewXacNhan:InputViewXacNhan!
    var viewXacNhanNhapKho:InputViewXacNhanNhapKho!
    var mJobtitle:String = ""
    
    
    
    var mViewLine2:UIView!
    var lbHinhAnh:UILabel!
    var lbHinhAnh1:UILabel!
    var lbHinhAnh2:UILabel!
    var lbHinhAnh3:UILabel!
    var lbHinhAnh4:UILabel!
    
    var viewImagePic:UIView!
    var viewCMNDTruocButton3:UIImageView!
    
    
    var viewImagePic2:UIView!
    var viewCMNDTruocButton4:UIImageView!
    
    var viewImagePic3:UIView!
    var viewCMNDTruocButton5:UIImageView!
    
    var viewImagePic4:UIView!
    var viewCMNDTruocButton6:UIImageView!
    
    var viewProcess:ProcessView!
    
    var isSelectedPic:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor  = UIColor.white
        initView()
      
        ShowOptionMenu()
        
        GetDataUserDelivery(shopCode: "\(Cache.user!.ShopCode)", jobtitle:"\(Cache.user!.JobTitle)")
        LoadThongTinData()
         GetDataSODetails(docNum: "\((mObjectData?.ID)!)")
        mJobtitle = Cache.user!.JobTitle
       
        
        self.viewInput.isHidden = true
        self.viewXacNhan.isHidden = true
        self.viewXacNhanNhapKho.isHidden = true
        self.btnXacNhan.addTarget(self, action: #selector(self.ClickXacNhan), for: .touchUpInside)
        
        
       
        if("\((mObjectData?.OrderStatus)!)" != "6")
        {
//            let tapChoosenPic = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick1))
//            self.viewImagePic.isUserInteractionEnabled = true
//            self.viewImagePic.addGestureRecognizer(tapChoosenPic)
            
            let tapChoosenPic2 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick2))
            self.viewImagePic2.isUserInteractionEnabled = true
            self.viewImagePic2.addGestureRecognizer(tapChoosenPic2)
            
//            let tapChoosenPic4 = UITapGestureRecognizer(target: self, action: #selector(self.tapShowImagePick3))
//            self.viewImagePic4.isUserInteractionEnabled = true
//            self.viewImagePic4.addGestureRecognizer(tapChoosenPic4)
        }
        
//        let tapChoosenPic3 = UITapGestureRecognizer(target: self, action: #selector(self.tapOpenUrlPic))
//        self.viewImagePic3.isUserInteractionEnabled = true
//        self.viewImagePic3.addGestureRecognizer(tapChoosenPic3)
        
        if("\((mObjectData?.ImgUrl_TGH)!)" == "" && "\((mObjectData?.ImgUrl_NKH)!)" == "" && "\((mObjectData?.ImgUrl_PGH)!)" == "")
        {
            
            
        }
        else
        {
            if("\((mObjectData?.ImgUrl_TGH)!)" != "")
            {
               print("sadasdsadsadsad \((mObjectData?.ImgUrl_TGH)!)")
               
              //  GetHinhAnhOne(mUrl: "http://\((mObjectData?.ImgUrl_TGH)!)")
                 GetHinhAnhOne(mUrl: "\((mObjectData?.ImgUrl_TGH)!)")
            }
            
            if("\((mObjectData?.ImgUrl_NKH)!)" != "")
            {
                print("sadasdsadsadsad \((mObjectData?.ImgUrl_NKH)!)")
             //   GetHinhAnhTwo(mUrl: "http://\((mObjectData?.ImgUrl_NKH)!)")
                 GetHinhAnhTwo(mUrl: "\((mObjectData?.ImgUrl_NKH)!)")
            }
            if("\((mObjectData?.ImgUrl_XNGH)!)" != "")
            {
                
                print("sadasdsadsadsad \((mObjectData?.ImgUrl_PGH)!)")
                GetHinhAnhThree(mUrl: "\((mObjectData?.ImgUrl_XNGH)!)")
                
                
            }
            if("\((mObjectData?.ImgUrl_PGH)!)" != "")
            {
               // GetHinhAnhFour(mUrl: "http://\((mObjectData?.ImgUrl_PGH)!)")
                GetHinhAnhFour(mUrl: "\((mObjectData?.ImgUrl_PGH)!)")
            }
        }
        
    }
    
    
    
    @objc func tapShowImagePick1(sender:UITapGestureRecognizer)
    {
        self.isSelectedPic = 1
        self.thisIsTheFunctionWeAreCalling2()
    }
   
    @objc func tapShowImagePick2(sender:UITapGestureRecognizer)
    {
        self.isSelectedPic = 2
        self.thisIsTheFunctionWeAreCalling2()
    }
    
    @objc func tapShowImagePick3(sender:UITapGestureRecognizer)
    {
        self.isSelectedPic = 3
        self.thisIsTheFunctionWeAreCalling2()
    }
    
    func GetHinhAnhOne(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.viewCMNDTruocButton3.image = image
                
               
            }
        }
    }
    
    func GetHinhAnhTwo(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                self.viewCMNDTruocButton4.image = image
            }
        }
    }
    
    func GetHinhAnhThree(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                 self.viewCMNDTruocButton5.image = image
                //self.viewCMNDTruocButton5.image = image
               
            }
        }
    }
    
    func GetHinhAnhFour(mUrl: String)
    {
        AF.request(mUrl).responseData { response in
            if let data = response.data {
                let image = UIImage(data: data)
                //self.viewCMNDTruocButton6.image = image
                 self.viewCMNDTruocButton6.image = image
                 self.btnXacNhan.setTitle("Hoàn tất",for: .normal)
                //self.btnXacNhan.setTitle("Hoàn tất",for: .normal)
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func showProcessView(mShow:Bool)
    {
        self.viewProcess.isHidden = !mShow
    }
    
    func GetResultSetSOReturned(docNum: String, userCode:String, reason:String,is_Returned:String)
    {
        self.showProcessView(mShow: true)
        MDeliveryAPIService.GetDataSetSOReturned(docNum: docNum, userCode:userCode, reason:reason, is_Returned:is_Returned){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil )
                {
                    self.showProcessView(mShow: false)
                    Toast(text: "\(result.Descriptionn)").show()
                    if(result.Result == "1")
                    {
                        Toast(text: "\(result.Descriptionn)").show()
                       
                        let newViewController = GHTNViewController()
                        newViewController.mLat = "0"
                        newViewController.mLong = "0"
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                }
                
                
                
            }
            else
            {
                
            }
        }
    }
    
    func ShowHuyDonHangView()
    {
        self.viewInput.isHidden = !self.viewInput.isHidden
        mViewOptionMenu.isHidden = true
    }
    
    
    
    func ClickOptionMenu()
    {
        mViewOptionMenu.isHidden = !mViewOptionMenu.isHidden
        
    }
    
    func ShowOptionMenu()
    {
        
        print("asdsadsa")
        
        let navigationHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        mViewOptionMenu = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 2,y: navigationHeight * 1.4 ,width:UIScreen.main.bounds.size.width / 2, height: Common.Size(s:60)  ))
        mViewOptionMenu.backgroundColor = UIColor(netHex:0xffffff)
        mViewOptionMenu.layer.borderWidth = 0.5
        mViewOptionMenu.layer.borderColor = UIColor.black.cgColor
        
        mTitleMenu1 = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: mViewOptionMenu.frame.size.width , height: Common.Size(s:13)))
        mTitleMenu1.textAlignment = .left
        mTitleMenu1.textColor = UIColor.black
        mTitleMenu1.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        mTitleMenu1.text = "  Cập nhật thông tin"
        
        mViewLine1 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width - UIScreen.main.bounds.size.width / 2,y: mTitleMenu1.frame.size.height + mTitleMenu1.frame.origin.y + Common.Size(s: 10)  ,width:UIScreen.main.bounds.size.width / 2, height: 20  ))
        mViewLine1.backgroundColor = UIColor(netHex:0x000000)
        
        mTitleMenu2 = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 20) + mTitleMenu1.frame.size.height , width: mViewOptionMenu.frame.size.width , height: Common.Size(s:13)))
        mTitleMenu2.textAlignment = .left
        mTitleMenu2.textColor = UIColor.black
        mTitleMenu2.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        mTitleMenu2.text = "  Hủy đơn hàng"
        
        self.view.addSubview(mViewOptionMenu)
        mViewOptionMenu.addSubview(mTitleMenu1)
        mViewOptionMenu.addSubview(mTitleMenu2)
        mViewOptionMenu.addSubview(mViewLine1)
        
        mViewOptionMenu.isHidden = true
        
        
        let tapTitleMenu1 = UITapGestureRecognizer(target: self, action: #selector(self.TapCapNhat))
        mTitleMenu1.isUserInteractionEnabled = true
        mTitleMenu1.addGestureRecognizer(tapTitleMenu1)
        
        let tapTitleMenu2 = UITapGestureRecognizer(target: self, action: #selector(self.TapHuyDon))
        mTitleMenu2.isUserInteractionEnabled = true
        mTitleMenu2.addGestureRecognizer(tapTitleMenu2)
    }
    
    @objc func TapCapNhat()
    {
        print("cap nhat thong tin")
        let newViewController = CapNhatThongTinGiaoHangViewController()
        newViewController.mObjectData = self.mObjectData
        self.mViewOptionMenu.isHidden = true
        self.viewXacNhan.isHidden = true
        self.viewXacNhanNhapKho.isHidden = true
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @objc  func ClickXacNhan()
    {
        
        if(self.btnXacNhan.title(for: .normal) == "Hoàn tất")
        {
            viewXacNhan.isHidden = false
           
        }
        else if(self.btnXacNhan.title(for: .normal) == mObjectData?.btn_XacNhanNhapKho)
        {
            viewXacNhanNhapKho.isHidden = false
            print("sadsad")
        }
        else
        {
            self.isSelectedPic = 3
            self.isClickFrombtn = true
            self.thisIsTheFunctionWeAreCalling2()
        }
        
    }
    
    @objc func tapOpenUrlPic()
    {
        if("\((mObjectData?.ImgUrl_XNGH)!)" != "")
        {
            guard let url = URL(string: "\((mObjectData?.ImgUrl_XNGH)!)") else {
                return //be safe
            }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    @objc func TapHuyDon()
    {
        print("TapHuyDon")
        ShowHuyDonHangView()
    }
    
    
    func LoadThongTinData()
    {
        self.labelValueNameNgMua.text = self.mObjectData?.U_CrdName
        self.labelValuePhoneNumNgMua.text = self.mObjectData?.U_CPhone
        self.labelValueAddrNgMua.text = self.mObjectData?.U_AdrDel
        self.labelValueNameNgNhan.text = self.mObjectData?.p_ThongTinNguoiNhan_Name
        self.labelValuePhoneNumNgNhan.text = self.mObjectData?.p_ThongTinNguoiNhan_SDT
        self.labelValueAddrNgNhan.text = self.mObjectData?.p_ThongTinNguoiNhan_Address
      
        self.txtValueGhiChu.text = self.mObjectData?.U_Desc
        self.labelValueDH.text = self.mObjectData?.DocEntry
        self.labelValueEcom.text = self.mObjectData?.U_NumEcom
        self.labelValueTime.text = ""
        if(self.mObjectData?.FinishTime.isEmpty == false)
        {
            let fullString = self.mObjectData?.FinishTime.components(separatedBy: "T")
            let firstString: String = fullString![0]
            
           
            let fullStringMinutes = fullString![1].components(separatedBy: ":")
            self.labelValueTime.text = "\(firstString) \(fullStringMinutes[0]):\(fullStringMinutes[1])"

        }
       
       
        
        self.labelDatCocValue.text = Helper.FormatMoney(cost: Int((self.mObjectData?.SoTienTraTruoc)!)!)
        if(self.mObjectData?.U_PaidMoney.isEmpty == false)
        {
//            self.labelPhaiThuValue.text = Helper.FormatMoney(cost: Int((self.mObjectData?.U_PaidMoney)!)!)
//            self.labelItemDHGia.text = Helper.FormatMoney(cost: Int((self.mObjectData?.U_PaidMoney)!)!)
            self.labelPhaiThuValue.text = Helper.FormatMoney(cost: Int(self.mObjectData?.U_PaidMoney ?? "0") ?? 0)
            self.labelItemDHGia.text = Helper.FormatMoney(cost: Int(self.mObjectData?.U_PaidMoney ?? "0") ?? 0)
        }
        
        
        
       
        self.labelValueTimeLest.text = ""
        
        self.labelPhaiThuValue.text = Helper.FormatMoney(cost: Int(self.mObjectData?.U_PaidMoney ?? "0") ?? 0)
        
        if(self.mObjectData?.OrderStatus == "5")
        {
            self.btnXacNhan.setTitle("Xác nhận thu tiền", for: .normal)
            self.btnXacNhan.isHidden = false
            
        }
//        else if(self.mObjectData?.OrderStatus == "8")
//        {
//            self.btnXacNhan.setTitle("Xác nhận nhập kho", for: .normal)
//            self.btnXacNhan.isHidden = false
//            
//        }
        else
        {
            self.btnXacNhan.isHidden = true
        }
        if mObjectData?.btn_XacNhanNhapKho != "" {
            self.btnXacNhan.setTitle(mObjectData?.btn_XacNhanNhapKho, for: .normal)
            self.btnXacNhan.isHidden = false
        }
        
        self.companyButton.isEnabled = false
        self.companyButton2.isEnabled = false
        
    }
    
    
    func GetDataSOPaid(docNum: String, userCode:String, password:String)
    {
        MDeliveryAPIService.GetSetSOPaid(docNum: docNum, userCode:userCode , password:password){ (error: Error?, success: Bool, result: ConfirmThuKhoResult!) in
            if success
            {
                if(result != nil)
                {
                    
                    Toast(text: "\(result.Descriptionn)").show()
                    if(result.Result == "1")
                    {
                        self.viewXacNhan.isHidden = true
                        self.viewXacNhan.edtNameProduct.text = ""
                        self.viewXacNhan.edtNameProduct2.text = ""
                        self.navigationController?.popToRootViewController(animated: true)
//                        let newViewController = HomeController()
//                        self.navigationController?.pushViewController(newViewController, animated: true)
                    }
                    
                }
                
            }
            else
            {
                
            }
        }
        
    }
    
    func GetDataSODetails(docNum: String)
    {
        MDeliveryAPIService.GetSODetails(docNum: docNum){ (error: Error?, success: Bool, result: [getSODetailsResult]!) in
            if success
            {   self.showProcessView(mShow: false)
                if(result != nil && result.count > 0)
                {
                    self.mListSp = result
                    self.tableViewSP.reloadData()
                }
                
                for i in 0 ..< result.count
                {
                    let money = Int(result[i].U_TMoney) ?? 0
                    self.mTongTien = self.mTongTien + money
                }
                
                //self.labelPhaiThuValue.text = Helper.FormatMoney(cost: self.mTongTien)
                
                let def = UserDefaults.standard ;
                def.setValue(Helper.FormatMoney(cost: self.mTongTien), forKey: "PhaiThuCost") ;
                
                self.labelTongDHValue.text = Helper.FormatMoney(cost: self.mTongTien)
                if self.mObjectData?.mType == "11" {
                    self.labelPhaiThuValue.text = Helper.FormatMoney(cost: Int(self.mObjectData?.U_PaidMoney ?? "0") ?? 0)
                } else {                
                    self.labelPhaiThuValue.text =  Helper.FormatMoney(cost: Int(self.mTongTien) - Int((self.mObjectData?.SoTienTraTruoc)!)!)
                }
                
                //self.labelPhaiThuValue.text = "\((self.labelPhaiThuValue.text)!) đ"
                //self.labelTongDHValue.text = "\((self.labelTongDHValue.text)!) đ"
                
                
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
    
    
    /** func GetDataUserDelivery **/
    func GetDataUserDelivery(shopCode: String, jobtitle:String)
    {
        MDeliveryAPIService.GetUserDelivery(shopCode: shopCode, jobtitle:jobtitle){ (error: Error?, success: Bool, result: [GetEmPloyeesResult]!) in
            if success
            {
                if(result != nil && result.count > 0)
                {
                    print("get data GetDataUserDelivery is ok")
                    self.arrGetEmPloyeesResult = result
                    var listCom: [String] = []
                    print("ok")
                    for i in 0 ..< result.count
                    {
                        listCom.append("\(result[i].EmployeeName)")
                        
                        
                    }
                    
                    self.companyButton.filterStrings(listCom)
                    self.companyButton.text = "\(result[0].EmployeeName)"
                    
                    self.companyButton2.filterStrings(listCom)
                    self.companyButton2.text = "\(result[0].EmployeeName)"
                    
                    self.companyButton.text = "\((self.mObjectData?.EmpName)!)"
                    self.companyButton2.text = "\((self.mObjectData?._WHConfirmed_MaTen)!)"
                }
                
            }
            else
            {
                
            }
        }
        
        
        
    }
    
    
    func getDataUpAnh_GHTNResul(SoSO: String,FileName: String,Base64String: String,UserID: String,KH_Latitude: String,KH_Longitude: String,Type: String)
    {
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang upload hình ảnh vui lòng chờ..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MDeliveryAPIService.GetDatamDel_UpAnh_GHTNResult(SoSO: SoSO , FileName: FileName , Base64String: Base64String,UserID: UserID,KH_Latitude: KH_Latitude,KH_Longitude: KH_Longitude,Type: Type){ (error: Error?, success: Bool, result: mDel_UpAnh_GHTNResult!) in
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
            if success
            {
                if(result != nil )
                {
                    
                    Toast(text: "\(result.Msg)").show()
                    if(self.isClickFrombtn == true)
                    {
                        self.btnXacNhan.setTitle("Hoàn tất",for: .normal)
                    }
                    
                }
            }
            else
            {
                
            }
        }
    }
    
    
    
    
    
    
   
    
    
    
    
    
    func initView()
    {
        
        
        //scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0 ,width:UIScreen.main.bounds.size.width , height:  UIScreen.main.bounds.size.height - Common.Size(s:50) -  ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) ))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        
        
        
        viewNgMua = UIView(frame: CGRect(x: Common.Size(s: 20),y: 0 ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:20) * 4 ))
        viewNgMua.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLine1 = UIView(frame: CGRect(x:0,y: viewNgMua.frame.origin.y + viewNgMua.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width, height: Common.Size(s:1) ))
        viewLine1.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        imageNgMua = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageNgMua.image = UIImage(named:"ic-TTNM.png")
        imageNgMua.contentMode = UIView.ContentMode.scaleToFill
        
        let strTitleNgMua = "Thông tin người mua "
        labelNgMua = UILabel(frame: CGRect(x: imageNgMua.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewNgMua.frame.size.width , height: Common.Size(s:13)))
        labelNgMua.textAlignment = .left
        labelNgMua.textColor = UIColor.black
        labelNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelNgMua.text = strTitleNgMua
        
        labelValueNameNgMua = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: imageNgMua.frame.origin.y + imageNgMua.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelValueNameNgMua.textAlignment = .left
        labelValueNameNgMua.textColor = UIColor.gray
        labelValueNameNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueNameNgMua.text = "Ly Tam Hoan"
        
        labelValuePhoneNumNgMua = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValueNameNgMua.frame.origin.y + labelValueNameNgMua.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelValuePhoneNumNgMua.textAlignment = .left
        labelValuePhoneNumNgMua.textColor = UIColor.gray
        labelValuePhoneNumNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValuePhoneNumNgMua.text = "01208885656"
        
        labelValueAddrNgMua = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValuePhoneNumNgMua.frame.origin.y + labelValuePhoneNumNgMua.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width - Common.Size(s: 40), height: Common.Size(s:13)))
        labelValueAddrNgMua.textAlignment = .left
        labelValueAddrNgMua.textColor = UIColor.gray
        labelValueAddrNgMua.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueAddrNgMua.text = "82 trương định p9 quận 1 tp.hcm"
        
        
        
        
        //////////
        viewNgNhan = UIView(frame: CGRect(x: Common.Size(s: 20),y: viewLine1.frame.origin.y + viewLine1.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:20) * 4 ))
        viewNgNhan.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLine2 = UIView(frame: CGRect(x:0,y: viewNgNhan.frame.origin.y + viewNgNhan.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width, height: Common.Size(s:1) ))
        viewLine2.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        imageNgNhan = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageNgNhan.image = UIImage(named:"ic-TTNN.png")
        imageNgNhan.contentMode = UIView.ContentMode.scaleToFill
        
        let strTitleNgNhan = "Thông tin người nhận "
        labelNgNhan = UILabel(frame: CGRect(x: imageNgNhan.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelNgNhan.textAlignment = .left
        labelNgNhan.textColor = UIColor.black
        labelNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelNgNhan.text = strTitleNgNhan
        
        
        
        btnCall = UIButton(frame: CGRect(x:labelNgNhan.frame.origin.x + labelNgNhan.frame.size.width + Common.Size(s:5) , y: labelNgNhan.frame.origin.y   , width: viewNgMua.frame.size.width / 3 , height: Common.Size(s:20)));
        btnCall.backgroundColor = UIColor(netHex:0x16b88b)
        btnCall.layer.cornerRadius = 10
        btnCall.layer.borderWidth = 1
        btnCall.layer.borderColor = UIColor.white.cgColor
        btnCall.setTitle("Gọi nhanh",for: .normal)
        btnCall.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        labelValueNameNgNhan = UILabel(frame: CGRect(x: labelNgNhan.frame.origin.x , y: labelNgNhan.frame.origin.y + labelNgNhan.frame.size.height +  Common.Size(s:5) , width: viewNgNhan.frame.size.width / 2, height: Common.Size(s:13)))
        labelValueNameNgNhan.textAlignment = .left
        labelValueNameNgNhan.textColor = UIColor.gray
        labelValueNameNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueNameNgNhan.text = ""
        
        labelValuePhoneNumNgNhan = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValueNameNgNhan.frame.origin.y + labelValueNameNgNhan.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 2, height: Common.Size(s:13)))
        labelValuePhoneNumNgNhan.textAlignment = .left
        labelValuePhoneNumNgNhan.textColor = UIColor.gray
        labelValuePhoneNumNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValuePhoneNumNgNhan.text = ""
        
        labelValueAddrNgNhan = UILabel(frame: CGRect(x: labelNgMua.frame.origin.x , y: labelValuePhoneNumNgNhan.frame.origin.y + labelValuePhoneNumNgNhan.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width - Common.Size(s: 40), height: Common.Size(s:13)))
        labelValueAddrNgNhan.textAlignment = .left
        labelValueAddrNgNhan.textColor = UIColor.gray
        labelValueAddrNgNhan.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueAddrNgNhan.text = "82 trương định p9 quận 1 tp.hcm"
        
        ///////////////////
        
        viewPhanCong = UIView(frame: CGRect(x: Common.Size(s: 20),y: viewLine2.frame.origin.y + viewLine2.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:80)))
        viewPhanCong.backgroundColor = UIColor(netHex:0xffffff)
        
        viewLine3 = UIView(frame: CGRect(x:0,y: viewPhanCong.frame.origin.y + viewPhanCong.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width, height: Common.Size(s:1) ))
        viewLine3.backgroundColor = UIColor(netHex:0xe8e8e8)
        
        imagePhanCong = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imagePhanCong.image = UIImage(named:"ic-TTPC.png")
        imagePhanCong.contentMode = UIView.ContentMode.scaleToFill
        
        
        let strTitlePC = "Phân công "
        labelPhanCong = UILabel(frame: CGRect(x: imagePhanCong.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewPhanCong.frame.size.width , height: Common.Size(s:13)))
        labelPhanCong.textAlignment = .left
        labelPhanCong.textColor = UIColor.black
        labelPhanCong.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelPhanCong.text = strTitlePC
        
        labelNV = UILabel(frame: CGRect(x: labelPhanCong.frame.origin.x , y: labelPhanCong.frame.origin.y + labelPhanCong.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 6, height: Common.Size(s:13)))
        labelNV.textAlignment = .left
        labelNV.textColor = UIColor.gray
        labelNV.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelNV.text = "NV Giao:"
        
        
        
        
        companyButton = SearchTextField(frame: CGRect(x: labelNV.frame.origin.x + labelNV.frame.size.width + Common.Size(s: 5), y: labelNV.frame.origin.y , width: viewNgMua.frame.size.width - Common.Size(s:20) -  viewNgMua.frame.size.width / 6  , height: Common.Size(s:20) ));
        
        //companyButton.placeholder = "5387-Phan Thi Ngoc Huyen"
        companyButton.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton.autocorrectionType = UITextAutocorrectionType.no
        companyButton.keyboardType = UIKeyboardType.default
        companyButton.returnKeyType = UIReturnKeyType.done
        companyButton.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        companyButton.startVisible = true
        companyButton.theme.bgColor = UIColor.white
        companyButton.theme.fontColor = UIColor.black
        companyButton.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton.theme.cellHeight = Common.Size(s:40)
        
        labelThuKho = UILabel(frame: CGRect(x: labelNV.frame.origin.x , y: companyButton.frame.origin.y + companyButton.frame.size.height +  Common.Size(s:5) , width: viewNgMua.frame.size.width / 6, height: Common.Size(s:13)))
        labelThuKho.textAlignment = .left
        labelThuKho.textColor = UIColor.gray
        labelThuKho.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelThuKho.text = "NV TK:"
        
        
        companyButton2 = SearchTextField(frame: CGRect(x: labelNV.frame.origin.x + labelNV.frame.size.width + Common.Size(s: 5), y: labelThuKho.frame.origin.y , width: viewNgMua.frame.size.width - Common.Size(s:20) -  viewNgMua.frame.size.width / 6  , height: Common.Size(s:20) ));
        
        //companyButton2.placeholder = "5387-Phan Thi Ngoc Huyen"
        companyButton2.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton2.borderStyle = UITextField.BorderStyle.roundedRect
        companyButton2.autocorrectionType = UITextAutocorrectionType.no
        companyButton2.keyboardType = UIKeyboardType.default
        companyButton2.returnKeyType = UIReturnKeyType.done
        companyButton2.clearButtonMode = UITextField.ViewMode.whileEditing;
        companyButton2.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        companyButton2.startVisible = true
        companyButton2.theme.bgColor = UIColor.white
        companyButton2.theme.fontColor = UIColor.black
        companyButton2.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        companyButton2.theme.cellHeight = Common.Size(s:40)
        
        
        ///////////////
        viewThongTin = UIView(frame: CGRect(x: Common.Size(s: 20),y: viewLine3.frame.origin.y + viewLine3.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 40), height: Common.Size(s:150)))
        viewThongTin.backgroundColor = UIColor(netHex:0xffffff)
        
        
        imageThongTin = UIImageView(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageThongTin.image = UIImage(named:"ic-TTDH")
        imageThongTin.contentMode = UIView.ContentMode.scaleToFill
        
        
        let strTitleDH = "Thông tin đơn hàng "
        labelThongTinn = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5), y: Common.Size(s: 7) , width: viewPhanCong.frame.size.width , height: Common.Size(s:13)))
        labelThongTinn.textAlignment = .left
        labelThongTinn.textColor = UIColor.black
        labelThongTinn.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelThongTinn.text = strTitleDH
        
        
        labelDH = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5), y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 8 , height: Common.Size(s:13)))
        labelDH.textAlignment = .left
        labelDH.textColor = UIColor.gray
        labelDH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelDH.text = "ĐH :"
        
        labelValueDH = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5) + viewPhanCong.frame.size.width / 8 , y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 4  , height: Common.Size(s:13)))
        labelValueDH.textAlignment = .left
        labelValueDH.textColor = UIColor.black
        labelValueDH.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelValueDH.text = "1212323"
        
        labelEcom = UILabel(frame: CGRect(x: labelValueDH.frame.size.width + labelValueDH.frame.origin.x + Common.Size(s:5)  , y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 7 , height: Common.Size(s:13)))
        labelEcom.textAlignment = .left
        labelEcom.textColor = UIColor.gray
        labelEcom.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelEcom.text = "Ecom:"
        
        labelValueEcom = UILabel(frame: CGRect(x: labelEcom.frame.size.width + Common.Size(s:5) + labelEcom.frame.origin.x , y: labelThongTinn.frame.origin.y + labelThongTinn.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 4  , height: Common.Size(s:13)))
        labelValueEcom.textAlignment = .left
        labelValueEcom.textColor = UIColor.black
        labelValueEcom.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelValueEcom.text = "1212323"
        
        labelTime = UILabel(frame: CGRect(x: imageThongTin.frame.size.width + Common.Size(s:5), y: labelValueEcom.frame.origin.y + labelValueEcom.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 2  , height: Common.Size(s:13)))
        labelTime.textAlignment = .left
        labelTime.textColor = UIColor.gray
        labelTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        labelTime.text = "Thời gian đã giao :"
        
        labelValueTime  = UILabel(frame: CGRect(x: labelTime.frame.size.width, y: labelValueEcom.frame.origin.y + labelValueEcom.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 2  , height: Common.Size(s:13)))
        labelValueTime.textAlignment = .left
        labelValueTime.textColor = UIColor.black
        labelValueTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        labelValueTime.text = "20/02/2019"
        
        labelValueTimeLest  = UILabel(frame: CGRect(x: labelTime.frame.origin.x, y: labelValueTime.frame.origin.y + labelValueTime.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width   , height: Common.Size(s:13)))
        labelValueTimeLest.textAlignment = .left
        labelValueTimeLest.textColor = UIColor(netHex:0x439b6e)
        labelValueTimeLest.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelValueTimeLest.text = "Thời gian còn lại 20/02/2019"
        
        labelGhiChu  = UILabel(frame: CGRect(x: labelValueTimeLest.frame.origin.x, y: labelValueTimeLest.frame.origin.y + labelValueTimeLest.frame.size.height + Common.Size(s: 7) , width: viewPhanCong.frame.size.width / 2  , height: Common.Size(s:13)))
        labelGhiChu.textAlignment = .left
        labelGhiChu.textColor = UIColor.gray
        labelGhiChu.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        labelGhiChu.text = "Ghi Chú"
        
        viewGhiChu =  UIView(frame: CGRect(x: labelGhiChu.frame.origin.x  ,y: labelGhiChu.frame.origin.y + labelGhiChu.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width  - Common.Size(s: 50), height: Common.Size(s:50)))
        viewGhiChu.backgroundColor = UIColor.white
        viewGhiChu.layer.borderWidth = 0.5
        viewGhiChu.layer.borderColor = UIColor.black.cgColor
        viewGhiChu.layer.cornerRadius = 5
        
        txtValueGhiChu = UILabel(frame: CGRect(x: 0 ,y: 0 ,width:UIScreen.main.bounds.size.width - labelGhiChu.frame.size.width, height: Common.Size(s:50)))
        txtValueGhiChu.contentMode = .scaleToFill
        txtValueGhiChu.numberOfLines = 0
        txtValueGhiChu.text = ""
        txtValueGhiChu.textAlignment = .center
        txtValueGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        
        tableViewSP.frame = CGRect(x: 0 ,y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:100))
        tableViewSP.tableFooterView = UIView()
        tableViewSP.backgroundColor = UIColor.white
        
        
        viewItemDH =  UIView(frame: CGRect(x: 0 ,y: viewThongTin.frame.origin.y + viewThongTin.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:60)))
        viewItemDH.backgroundColor = UIColor(netHex:0xf2f2f2)
        
        labelItemDHName = UILabel(frame: CGRect(x: Common.Size(s: 10) ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelItemDHName.numberOfLines = 1
        labelItemDHName.text = "HuaWei P9 - Hong"
        labelItemDHName.textAlignment = .center
        labelItemDHName.textColor = UIColor.black
        labelItemDHName.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelItemDHImei = UILabel(frame: CGRect(x: Common.Size(s: 10) ,y: labelItemDHName.frame.origin.y +  labelItemDHName.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelItemDHImei.numberOfLines = 1
        labelItemDHImei.text = "02235234543534"
        labelItemDHImei.textAlignment = .center
        labelItemDHImei.textColor = UIColor.gray
        labelItemDHImei.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        labelItemDHSL = UILabel(frame: CGRect(x: labelItemDHName.frame.origin.x +  labelItemDHName.frame.size.width  ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 4, height: Common.Size(s:30)))
        labelItemDHSL.numberOfLines = 1
        labelItemDHSL.text = "x 2"
        labelItemDHSL.textAlignment = .center
        labelItemDHSL.textColor = UIColor.gray
        labelItemDHSL.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        labelItemDHGia = UILabel(frame: CGRect(x: labelItemDHSL.frame.origin.x +  labelItemDHSL.frame.size.width  ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 4, height: Common.Size(s:30)))
        labelItemDHGia.numberOfLines = 1
        labelItemDHGia.text = "20.0000"
        labelItemDHGia.textAlignment = .center
        labelItemDHGia.textColor = UIColor.red
        labelItemDHGia.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        viewTongDH =  UIView(frame: CGRect(x: 0 ,y: viewItemDH.frame.origin.y + viewItemDH.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: Common.Size(s:60)))
        viewTongDH.backgroundColor = UIColor(netHex:0xffffff)
        
        labelTongDHText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTongDHText.numberOfLines = 1
        labelTongDHText.text = "Tổng đơn hàng :"
        labelTongDHText.textAlignment = .left
        labelTongDHText.textColor = UIColor.gray
        labelTongDHText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelTienGiamText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: labelTongDHText.frame.origin.y + labelTongDHText.frame.size.height ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTienGiamText.numberOfLines = 1
        labelTienGiamText.text = "Tiền giảm :"
        labelTienGiamText.textAlignment = .left
        labelTienGiamText.textColor = UIColor.gray
        labelTienGiamText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelDatCocText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: labelTienGiamText.frame.origin.y + labelTienGiamText.frame.size.height ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelDatCocText.numberOfLines = 1
        labelDatCocText.text = "Đặt cọc :"
        labelDatCocText.textAlignment = .left
        labelDatCocText.textColor = UIColor.gray
        labelDatCocText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelPhaiThuText = UILabel(frame: CGRect(x: Common.Size(s:30)  ,y: labelDatCocText.frame.origin.y + labelDatCocText.frame.size.height ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelPhaiThuText.numberOfLines = 1
        labelPhaiThuText.text = "Phải thu :"
        labelPhaiThuText.textAlignment = .left
        labelPhaiThuText.textColor = UIColor.gray
        labelPhaiThuText.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        
        labelTongDHValue = UILabel(frame: CGRect(x: labelTongDHText.frame.origin.x + labelTongDHText.frame.size.width   ,y: labelTongDHText.frame.origin.y ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTongDHValue.numberOfLines = 1
        labelTongDHValue.text = "0 đ"
        labelTongDHValue.textAlignment = .left
        labelTongDHValue.textColor = UIColor.gray
        labelTongDHValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelTienGiamValue = UILabel(frame: CGRect(x: labelTienGiamText.frame.origin.x + labelTienGiamText.frame.size.width   ,y: labelTienGiamText.frame.origin.y  ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelTienGiamValue.numberOfLines = 1
        labelTienGiamValue.text = "0 đ"
        labelTienGiamValue.textAlignment = .left
        labelTienGiamValue.textColor = UIColor.gray
        labelTienGiamValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelDatCocValue = UILabel(frame: CGRect(x: labelDatCocText.frame.origin.x + labelDatCocText.frame.size.width   ,y: labelDatCocText.frame.origin.y  ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelDatCocValue.numberOfLines = 1
        labelDatCocValue.text = "0 đ"
        labelDatCocValue.textAlignment = .left
        labelDatCocValue.textColor = UIColor.gray
        labelDatCocValue.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        labelPhaiThuValue = UILabel(frame: CGRect(x: labelPhaiThuText.frame.origin.x + labelPhaiThuText.frame.size.width   ,y: labelPhaiThuText.frame.origin.y  ,width:UIScreen.main.bounds.size.width  / 2, height: Common.Size(s:15)))
        labelPhaiThuValue.numberOfLines = 1
        labelPhaiThuValue.text = "100.0000 đ"
        labelPhaiThuValue.textAlignment = .left
        labelPhaiThuValue.textColor = UIColor.red
        labelPhaiThuValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        
        
        
        /*  */
        mViewLine2 = UIView(frame: CGRect(x: 0,y: viewTongDH.frame.origin.y + viewTongDH.frame.size.height + Common.Size(s: 20) ,width:UIScreen.main.bounds.size.width , height: 1 ))
        mViewLine2.backgroundColor = UIColor.gray
        
        lbHinhAnh = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: mViewLine2.frame.origin.y + mViewLine2.frame.size.height + Common.Size(s: 10)  , width: viewItemDH.frame.size.width  , height: Common.Size(s:15)))
        lbHinhAnh.textAlignment = .left
        lbHinhAnh.textColor = UIColor.gray
        lbHinhAnh.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh.text = "Hình ảnh giao hàng"
        
        
//        lbHinhAnh1 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: lbHinhAnh.frame.origin.y + lbHinhAnh.frame.size.height + Common.Size(s: 10)  , width: viewItemDH.frame.size.width  , height: Common.Size(s:15)))
//        lbHinhAnh1.textAlignment = .left
//        lbHinhAnh1.textColor = UIColor.gray
//        lbHinhAnh1.font = UIFont.systemFont(ofSize: Common.Size(s:13))
//        lbHinhAnh1.text = "Trước khi giao"
//
//        viewImagePic = UIView(frame: CGRect(x:Common.Size(s:16), y: lbHinhAnh1.frame.origin.y + lbHinhAnh1.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
//        viewImagePic.layer.borderWidth = 0.5
//        viewImagePic.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
//        viewImagePic.layer.cornerRadius = 3.0
//
        lbHinhAnh2 = UILabel()
        lbHinhAnh2.textAlignment = .left
        lbHinhAnh2.textColor = UIColor.gray
        lbHinhAnh2.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh2.text = "Tại nhà khách"
//
//
////        viewCMNDTruocButton3 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y:(viewImagePic.frame.size.height - (viewImagePic.frame.size.height * 2/3))/2, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
//        viewCMNDTruocButton3 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y:(viewImagePic.frame.size.height - (viewImagePic.frame.size.height * 2/3))/12, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
//        viewCMNDTruocButton3.image = UIImage(named:"Add Image-51")
//        viewCMNDTruocButton3.contentMode = .scaleAspectFit
//
//
        viewImagePic2 = UIView()
        viewImagePic2.layer.borderWidth = 0.5
        viewImagePic2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePic2.layer.cornerRadius = 3.0
//
//        lbHinhAnh3 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: viewImagePic2.frame.origin.y + viewImagePic2.frame.size.height + Common.Size(s: 10)  , width: viewItemDH.frame.size.width  , height: Common.Size(s:15)))
//        lbHinhAnh3.textAlignment = .left
//        lbHinhAnh3.textColor = UIColor.gray
//        lbHinhAnh3.font = UIFont.systemFont(ofSize: Common.Size(s:13))
//        lbHinhAnh3.text = "Chữ ký KH"
//
////        viewCMNDTruocButton4 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: (viewImagePic.frame.size.height - (viewImagePic.frame.size.height * 2/3))/2, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
        viewCMNDTruocButton4 = UIImageView()
        viewCMNDTruocButton4.image = UIImage(named:"Add Image-51")
        viewCMNDTruocButton4.contentMode = .scaleAspectFit
//
//        viewImagePic3 = UIView(frame: CGRect(x:Common.Size(s:16), y: lbHinhAnh3.frame.origin.y + lbHinhAnh3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
//        viewImagePic3.layer.borderWidth = 0.5
//        viewImagePic3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
//        viewImagePic3.layer.cornerRadius = 3.0
//
//        lbHinhAnh4 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: viewImagePic3.frame.origin.y + viewImagePic3.frame.size.height + Common.Size(s: 10)  , width: viewItemDH.frame.size.width  , height: Common.Size(s:15)))
//        lbHinhAnh4.textAlignment = .left
//        lbHinhAnh4.textColor = UIColor.gray
//        lbHinhAnh4.font = UIFont.systemFont(ofSize: Common.Size(s:13))
//        lbHinhAnh4.text = "Tại shop"
//
//        viewCMNDTruocButton5 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: (viewImagePic.frame.size.height - (viewImagePic.frame.size.height * 2/3))/2, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
//        viewCMNDTruocButton5.image = UIImage(named:"Add Image-51")
//        viewCMNDTruocButton5.contentMode = .scaleAspectFit
//
//
//        viewImagePic4 = UIView(frame: CGRect(x:Common.Size(s:16), y: lbHinhAnh4.frame.origin.y + lbHinhAnh4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
//        viewImagePic4.layer.borderWidth = 0.5
//        viewImagePic4.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
//        viewImagePic4.layer.cornerRadius = 3.0
//
//
//        viewCMNDTruocButton6 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: (viewImagePic.frame.size.height - (viewImagePic.frame.size.height * 2/3))/2, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
//        viewCMNDTruocButton6.image = UIImage(named:"Add Image-51")
//        viewCMNDTruocButton6.contentMode = .scaleAspectFit
        btnXacNhan = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * 6 / 7)) / 2, y: scrollView.frame.origin.y + scrollView.bounds.size.height + Common.Size(s: 5)  , width: UIScreen.main.bounds.size.width * 6 / 7 , height: Common.Size(s:40)));
        btnXacNhan.backgroundColor = UIColor(netHex:0x107add)
        btnXacNhan.layer.cornerRadius = 10
        btnXacNhan.layer.borderWidth = 1
        btnXacNhan.layer.borderColor = UIColor.white.cgColor
        btnXacNhan.setTitle("Kế toán thu tiền",for: .normal)
        btnXacNhan.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        viewInput = InputTextView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewInput.inputTextViewDelegate = self
        
        viewXacNhan = InputViewXacNhan.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewXacNhan.inputViewXacNhanDelegate = self
        
        
        viewXacNhanNhapKho = InputViewXacNhanNhapKho.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        viewXacNhanNhapKho.inputViewXacNhanNhapKhoDelegate = self
        
        viewProcess = ProcessView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        
        
        self.tableViewSP.register(ItemSPMuaTableViewCell.self, forCellReuseIdentifier: "ItemSPMuaTableViewCell")
        self.tableViewSP.dataSource = self
        self.tableViewSP.delegate = self
        
        
        self.btnCall.addTarget(self, action: #selector(self.ClickCall), for: .touchUpInside)
        
        self.btnXacNhan.addTarget(self, action: #selector(self.ClickXacNhan), for: .touchUpInside)
        self.view.addSubview(viewXacNhan)
        self.view.addSubview(viewXacNhanNhapKho)
        self.view.addSubview(viewProcess)
        viewXacNhan.isHidden = true
        viewXacNhanNhapKho.isHidden = true
        viewXacNhan.labelTitle.text = "Xác nhận thu tiền"
        
        self.view.addSubview(scrollView)
        self.view.addSubview(btnXacNhan)
        self.scrollView.addSubview(viewNgMua)
        self.viewNgMua.addSubview(imageNgMua)
        self.viewNgMua.addSubview(labelNgMua)
        self.viewNgMua.addSubview(labelValueNameNgMua)
        self.viewNgMua.addSubview(labelValueAddrNgMua)
        self.viewNgMua.addSubview(labelValuePhoneNumNgMua)
        self.scrollView.addSubview(viewLine1)
        self.scrollView.addSubview(viewLine2)
        self.scrollView.addSubview(viewNgNhan)
        self.scrollView.addSubview(viewPhanCong)
        
        self.viewNgNhan.addSubview(imageNgNhan)
        self.viewNgNhan.addSubview(labelNgNhan)
        self.viewNgNhan.addSubview(labelValueNameNgNhan)
        self.viewNgNhan.addSubview(labelValueAddrNgNhan)
        self.viewNgNhan.addSubview(labelValuePhoneNumNgNhan)
        self.viewNgNhan.addSubview(btnCall)
        
        self.viewPhanCong.addSubview(imagePhanCong)
        self.viewPhanCong.addSubview(labelPhanCong)
        self.viewPhanCong.addSubview(labelNV)
        self.viewPhanCong.addSubview(companyButton)
        self.viewPhanCong.addSubview(labelThuKho)
        self.viewPhanCong.addSubview(companyButton2)
        self.scrollView.addSubview(viewLine3)
        
        self.scrollView.addSubview(viewThongTin)
        
        self.viewThongTin.addSubview(labelThongTinn)
        self.viewThongTin.addSubview(imageThongTin)
        self.viewThongTin.addSubview(labelDH)
        self.viewThongTin.addSubview(labelValueDH)
        self.viewThongTin.addSubview(labelEcom)
        
        self.viewThongTin.addSubview(labelValueEcom)
        self.viewThongTin.addSubview(labelTime)
        self.viewThongTin.addSubview(labelValueTime)
        self.viewThongTin.addSubview(labelValueTimeLest)
        self.viewThongTin.addSubview(labelGhiChu)
        self.viewThongTin.addSubview(viewGhiChu)
        self.viewGhiChu.addSubview(txtValueGhiChu)
        
        //self.scrollView.addSubview(viewItemDH)
        self.scrollView.addSubview(tableViewSP)
        self.viewItemDH.addSubview(labelItemDHName)
        
        self.viewItemDH.addSubview(labelItemDHImei)
        self.viewItemDH.addSubview(labelItemDHGia)
        self.viewItemDH.addSubview(labelItemDHSL)
        
        self.scrollView.addSubview(viewTongDH)
        self.viewTongDH.addSubview(labelPhaiThuText)
        self.viewTongDH.addSubview(labelDatCocText)
        self.viewTongDH.addSubview(labelTongDHText)
        self.viewTongDH.addSubview(labelTienGiamText)
        
        self.viewTongDH.addSubview(labelPhaiThuValue)
        self.viewTongDH.addSubview(labelDatCocValue)
        self.viewTongDH.addSubview(labelTongDHValue)
        self.viewTongDH.addSubview(labelTienGiamValue)
        
        
        self.scrollView.addSubview(mViewLine2)
        self.scrollView.addSubview(lbHinhAnh)
//        self.scrollView.addSubview(lbHinhAnh1)
//        self.scrollView.addSubview(viewImagePic)
//        self.scrollView.addSubview(lbHinhAnh2)
//        self.viewImagePic.addSubview(viewCMNDTruocButton3)
        
        self.scrollView.addSubview(viewImagePic2)
        self.scrollView.addSubview(lbHinhAnh2)
        self.viewImagePic2.addSubview(viewCMNDTruocButton4)
        
//        self.scrollView.addSubview(viewImagePic3)
//        self.scrollView.addSubview(lbHinhAnh4)
//        self.viewImagePic3.addSubview(viewCMNDTruocButton5)
//
//        self.scrollView.addSubview(viewImagePic4)
//        self.viewImagePic4.addSubview(viewCMNDTruocButton6)
        
        self.lbHinhAnh2.snp.makeConstraints { make in
            make.top.equalTo(self.lbHinhAnh.snp.bottom).offset(10)
            make.leading.equalTo(self.view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
        }
        
        self.viewImagePic2.snp.makeConstraints { make in
            make.top.equalTo(self.lbHinhAnh2.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.lbHinhAnh2)
            make.height.equalTo(250)
        }
        
        self.viewCMNDTruocButton4.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self.viewImagePic2)
        }
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.height + 200 )
        /* */
        
        
        
    }
    @objc func ClickCall()
    {
        if let phoneCallURL = URL(string: "tel://\((mObjectData?.U_Phone)!)") {
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    
}


extension ChiTietDonHangTabDaGiaoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling2() {
        let camera = DSCameraHandler(delegate_: self)
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        optionMenu.popoverPresentationController?.sourceView = self.view
        
        let takePhoto = UIAlertAction(title: "Chụp ảnh", style: .default) { (alert : UIAlertAction!) in
            camera.getCameraOn(self, canEdit: false)
        }
        let sharePhoto = UIAlertAction(title: "Chọn ảnh có sẵn", style: .default) { (alert : UIAlertAction!) in
            camera.getPhotoLibraryOn(self, canEdit: false)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in
        }
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let image = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        if(self.isSelectedPic == 1)
        {
            self.viewCMNDTruocButton3.frame.origin.x = self.viewImagePic.frame.width / 4
            self.viewCMNDTruocButton3.frame.size.width =  self.viewImagePic.frame.width / 2
            self.viewCMNDTruocButton3.frame.size.height = self.viewImagePic.frame.height
            self.viewCMNDTruocButton3.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.viewCMNDTruocButton3.image = squared
           
            
            ////upload Image
            
            let imageDataPic1:NSData = self.viewCMNDTruocButton3.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            self.getDataUpAnh_GHTNResul(SoSO: "\((mObjectData?.DocEntry)!)",FileName: "_ios.jpg",Base64String: "\(strBase64Pic1)",UserID: "\((Helper.getUserName()!))",KH_Latitude: "\((mObjectData?.FinishLatitude)!)",KH_Longitude: "\((mObjectData?.FinishLongitude)!)",Type: "1")
            
           picker.dismiss(animated: true, completion: nil)
        }
        if(self.isSelectedPic == 2)
        {
            self.viewCMNDTruocButton4.frame.origin.x = self.viewImagePic2.frame.width / 4
            self.viewCMNDTruocButton4.frame.size.width =  self.viewImagePic2.frame.width / 2
            self.viewCMNDTruocButton4.frame.size.height = self.viewImagePic2.frame.height
            self.viewCMNDTruocButton4.contentMode = UIView.ContentMode.scaleToFill
            let squared = image.squared
            self.viewCMNDTruocButton4.image = squared
            
            ////upload Image
            let imageDataPic1:NSData = self.viewCMNDTruocButton4.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            self.getDataUpAnh_GHTNResul(SoSO: "\((mObjectData?.DocEntry)!)",FileName: "_ios.jpg",Base64String: "\(strBase64Pic1)",UserID: "\((Cache.user!.UserName))",KH_Latitude: "\((mObjectData?.FinishLatitude)!)",KH_Longitude: "\((mObjectData?.FinishLongitude)!)",Type: "2")
             picker.dismiss(animated: true, completion: nil)
           
            
            //
            
        }
        if(self.isSelectedPic == 3)
        {
//            self.viewCMNDTruocButton6.frame.origin.x = self.viewImagePic3.frame.width / 4
//            self.viewCMNDTruocButton6.frame.size.width =  self.viewImagePic3.frame.width / 2
//            self.viewCMNDTruocButton6.frame.size.height = self.viewImagePic3.frame.height / 2
//            self.viewCMNDTruocButton6.contentMode = UIView.ContentMode.scaleToFill
//            let squared = image.squared
//            self.viewCMNDTruocButton6.image = squared
            
            
            ////upload Image
            let imageDataPic1:NSData = self.viewCMNDTruocButton6.image!.jpegData(compressionQuality: Helper.resizeImageValueFF)! as NSData
            let strBase64Pic1 = imageDataPic1.base64EncodedString(options: .endLineWithLineFeed)
            
            
            // image is our desired image
            
            
            
            
            picker.dismiss(animated: true, completion: nil)
            self.getDataUpAnh_GHTNResul(SoSO: "\((mObjectData?.DocEntry)!)",FileName: "_ios.jpg",Base64String: "\(strBase64Pic1)",UserID: "\((Cache.user!.UserName))",KH_Latitude: "\((mObjectData?.FinishLatitude)!)",KH_Longitude: "\((mObjectData?.FinishLongitude)!)",Type: "3")
        }
        
        
        
        
    }
    
   
}

