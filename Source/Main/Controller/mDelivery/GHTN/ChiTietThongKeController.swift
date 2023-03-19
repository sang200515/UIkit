//
//  ChiTietThongKeController.swift
//  NewmDelivery
//
//  Created by sumi on 4/27/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class ChiTietThongKeController: UIViewController {

    var viewThongTin:UIView!
    var lbSoDHPOS:UILabel!
    var lbSoDH:UILabel!
    var lbTinhDungHan:UILabel!
    var lbTinhTrangSD:UILabel!
    var lbINC:UILabel!
    var lbThoiGianGiao:UILabel!
    var lbThoiGianCamKet:UILabel!
    var lbTTGiaoHang:UILabel!
    var lbKhoangCachGiaoHang:UILabel!
    var lbDatKhoangCach:UILabel!
    
  
    var lbSoDHValue:UILabel!
    var lbTinhDungHanValue:UILabel!
    var lbTinhTrangSDValue:UILabel!
    var lbINCValue:UILabel!
    var lbThoiGianGiaoValue:UILabel!
    var lbThoiGianCamKetValue:UILabel!
    var lbTTGiaoHangValue:UILabel!
    var lbKhoangCachGiaoHangValue:UILabel!
    var lbDatKhoangCachValue:UILabel!
    
    var mListThongke : ReportDeliveryHeaderOrderListResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor  = UIColor.white
        
        initView()
        self.GetDataDetails(p_SoDonHangPOS: "\((mListThongke?.SoDHPOS)!)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func GetDataDetails(p_SoDonHangPOS: String)
    {
        MDeliveryAPIService.Get_ReportDeliveryDetail(p_SoDonHangPOS: p_SoDonHangPOS){ (error: Error?, success: Bool, result: ReportDeliveryDetailResult!) in
            if success
            {
                if(result != nil)
                {
                    
                    self.lbSoDHValue.text = "\(result.SoDHEcom)"
                    self.lbTinhDungHanValue.text = "\(result.TinhDungHen)"
                    self.lbTinhTrangSDValue.text = "\(result.TinhTrangSDmDelivery)"
                    self.lbINCValue.text = "\(result.INC)"
                    self.lbThoiGianGiaoValue.text = "\(result.ThoiGianGiaoHangChoKhach)"
                    self.lbThoiGianCamKetValue.text = "\(result.ThoiGianCamKetGiaoHang)"
                    self.lbTTGiaoHangValue.text = "\(result.TinhTrangGiaoHangApp)"
                    self.lbKhoangCachGiaoHangValue.text = "\(result.KhoangCachGiaoHang)"
                    self.lbDatKhoangCachValue.text = "0"
                    self.lbSoDHPOS.text = "Số ĐH Pos : \(result.SoSHPOS)"
                }

            }
            else
            {
                
            }
        }
    }
    

    func initView()
    {
         let navigationHeight:CGFloat = (self.navigationController?.navigationBar.frame.size.height)!
        
        lbSoDHPOS = UILabel(frame: CGRect(x: 5, y:  navigationHeight + Common.Size(s:20) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbSoDHPOS.textAlignment = .left
        lbSoDHPOS.textColor = UIColor.black
        lbSoDHPOS.font = UIFont.boldSystemFont(ofSize:Common.Size(s:11))
        lbSoDHPOS.text = "Số ĐH Pos :"
        
        
        viewThongTin = UIView(frame: CGRect(x:5,y: lbSoDHPOS.frame.size.height + lbSoDHPOS.frame.origin.y + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - 10, height: UIScreen.main.bounds.size.height / 2 + Common.Size(s:40)))
        viewThongTin.backgroundColor = .white
        viewThongTin.layer.borderWidth = 0.5
        viewThongTin.layer.borderColor = UIColor(netHex:0x000000).cgColor
        
        
        
        
        
        lbSoDH = UILabel(frame: CGRect(x: 5, y: Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbSoDH.textAlignment = .left
        lbSoDH.textColor = UIColor.black
        lbSoDH.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbSoDH.text = "Số đơn Hàng Ecom :"
        
        lbSoDHValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbSoDHValue.textAlignment = .right
        lbSoDHValue.textColor = UIColor.black
        lbSoDHValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbSoDHValue.text = "0"
        
        lbTinhDungHan = UILabel(frame: CGRect(x: 5 , y: lbSoDH.frame.origin.y + lbSoDH.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbTinhDungHan.textAlignment = .left
        lbTinhDungHan.textColor = UIColor.black
        lbTinhDungHan.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbTinhDungHan.text = "Tính đúng hẹn :"
        
        lbTinhDungHanValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbTinhDungHan.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbTinhDungHanValue.textAlignment = .right
        lbTinhDungHanValue.textColor = UIColor.black
        lbTinhDungHanValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbTinhDungHanValue.text = "0"
        
        
        lbTinhTrangSD = UILabel(frame: CGRect(x: 5, y: lbTinhDungHan.frame.origin.y + lbTinhDungHan.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbTinhTrangSD.textAlignment = .left
        lbTinhTrangSD.textColor = UIColor.black
        lbTinhTrangSD.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbTinhTrangSD.text = "Tình trạng SD mDelivery :"
        
        
        lbTinhTrangSDValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbTinhTrangSD.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbTinhTrangSDValue.textAlignment = .right
        lbTinhTrangSDValue.textColor = UIColor.black
        lbTinhTrangSDValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbTinhTrangSDValue.text = "0"
        
        
        lbINC = UILabel(frame: CGRect(x: 5, y: lbTinhTrangSD.frame.origin.y + lbTinhTrangSD.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbINC.textAlignment = .left
        lbINC.textColor = UIColor.black
        lbINC.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbINC.text = "INC :"
        
        
        lbINCValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbINC.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbINCValue.textAlignment = .right
        lbINCValue.textColor = UIColor.black
        lbINCValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbINCValue.text = "0"
        
        
        lbThoiGianGiao = UILabel(frame: CGRect(x: 5, y: lbINC.frame.origin.y + lbINC.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbThoiGianGiao.textAlignment = .left
        lbThoiGianGiao.textColor = UIColor.black
        lbThoiGianGiao.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbThoiGianGiao.text = "Thời gian giao hàng cho khách :"
        
        lbThoiGianGiaoValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbThoiGianGiao.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbThoiGianGiaoValue.textAlignment = .right
        lbThoiGianGiaoValue.textColor = UIColor.black
        lbThoiGianGiaoValue.font = UIFont.systemFont(ofSize: Common.Size(s: 8))
        lbThoiGianGiaoValue.text = "0"
        
        lbThoiGianCamKet = UILabel(frame: CGRect(x: 5, y: lbThoiGianGiao.frame.origin.y + lbThoiGianGiao.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbThoiGianCamKet.textAlignment = .left
        lbThoiGianCamKet.textColor = UIColor.black
        lbThoiGianCamKet.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbThoiGianCamKet.text = "Thời gian cam kết giao hàng :"
        
        
        lbThoiGianCamKetValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbThoiGianCamKet.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbThoiGianCamKetValue.textAlignment = .right
        lbThoiGianCamKetValue.textColor = UIColor.black
        lbThoiGianCamKetValue.font = UIFont.systemFont(ofSize: Common.Size(s: 8))
        lbThoiGianCamKetValue.text = "0"
        
        
        lbTTGiaoHang = UILabel(frame: CGRect(x: 5, y: lbThoiGianCamKet.frame.origin.y + lbThoiGianCamKet.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbTTGiaoHang.textAlignment = .left
        lbTTGiaoHang.textColor = UIColor.black
        lbTTGiaoHang.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbTTGiaoHang.text = "TT giao hàng :"
        
        lbTTGiaoHangValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbTTGiaoHang.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbTTGiaoHangValue.textAlignment = .right
        lbTTGiaoHangValue.textColor = UIColor.black
        lbTTGiaoHangValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbTTGiaoHangValue.text = "0"
        
        
        lbKhoangCachGiaoHang = UILabel(frame: CGRect(x: 5, y: lbTTGiaoHang.frame.origin.y + lbTTGiaoHang.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbKhoangCachGiaoHang.textAlignment = .left
        lbKhoangCachGiaoHang.textColor = UIColor.black
        lbKhoangCachGiaoHang.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbKhoangCachGiaoHang.text = "Khoảng cách giao hàng :"
        
        lbKhoangCachGiaoHangValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbKhoangCachGiaoHang.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbKhoangCachGiaoHangValue.textAlignment = .right
        lbKhoangCachGiaoHangValue.textColor = UIColor.black
        lbKhoangCachGiaoHangValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbKhoangCachGiaoHangValue.text = "0"
        
        lbDatKhoangCach = UILabel(frame: CGRect(x: 5, y: lbKhoangCachGiaoHang.frame.origin.y + lbKhoangCachGiaoHang.frame.size.height + Common.Size(s:5) , width: UIScreen.main.bounds.size.width / 3 * 2, height:Common.Size(s:16) + 15))
        lbDatKhoangCach.textAlignment = .left
        lbDatKhoangCach.textColor = UIColor.black
        lbDatKhoangCach.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbDatKhoangCach.text = "Đạt Khoảng cách giao hàng :"
        
        lbDatKhoangCachValue = UILabel(frame: CGRect(x: lbSoDH.frame.size.width + 5 , y: lbDatKhoangCach.frame.origin.y , width: UIScreen.main.bounds.size.width / 3 - 20, height:Common.Size(s:16) + 15))
        lbDatKhoangCachValue.textAlignment = .right
        lbDatKhoangCachValue.textColor = UIColor.black
        lbDatKhoangCachValue.font = UIFont.systemFont(ofSize:Common.Size(s:11))
        lbDatKhoangCachValue.text = "0"
        
        
        self.view.addSubview(viewThongTin)
        self.view.addSubview(lbSoDHPOS)
        viewThongTin.addSubview(lbSoDH)
        viewThongTin.addSubview(lbTinhDungHan)
        viewThongTin.addSubview(lbTTGiaoHang)
        viewThongTin.addSubview(lbTinhTrangSD)
        viewThongTin.addSubview(lbINC)
        viewThongTin.addSubview(lbThoiGianGiao)
        viewThongTin.addSubview(lbThoiGianCamKet)
        viewThongTin.addSubview(lbKhoangCachGiaoHang)
        viewThongTin.addSubview(lbDatKhoangCach)
        
        viewThongTin.addSubview(lbSoDHValue)
        viewThongTin.addSubview(lbTinhDungHanValue)
        viewThongTin.addSubview(lbTTGiaoHangValue)
        viewThongTin.addSubview(lbTinhTrangSDValue)
        viewThongTin.addSubview(lbINCValue)
        viewThongTin.addSubview(lbThoiGianGiaoValue)
        viewThongTin.addSubview(lbThoiGianCamKetValue)
        viewThongTin.addSubview(lbKhoangCachGiaoHangValue)
        viewThongTin.addSubview(lbDatKhoangCachValue)
        
       
    }

}
