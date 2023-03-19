//
//  ViewTabDangGiao.swift
//  NewmDelivery
//
//  Created by sumi on 3/27/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewTabDangGiao: UIView {

    
    
    
    var scrollView:UIScrollView!
    var mapView:GMSMapView!
    var mCamera:GMSCameraPosition!
    var viewGoogleMap:UIView!
    
    var mViewTop:UIView!
    var lbName:UILabel!
    var lbTime:UILabel!
    var mViewLine1:UIView!
    var mViewInfo:UIView!
    
    var lbPhaiThu:UILabel!
    var lbValuePhaiThu:UILabel!
    var imageViewCall:UIImageView!
    var lbCall:UILabel!
    var lbGhiChu:UILabel!
    var lbValueGhiChu:UILabel!
    var btnXacNhan:UIButton!
    
    var btnKGoiDuoc:UIButton!
    var btnKhachDoiGio:UIButton!
    var btnKhachTraHang:UIButton!
    var btnXemLaiDonHang:UIButton!
    
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
    
    var viewImagePic21:UIView!
    var viewCMNDTruocButton41:UIImageView!
    
    var viewImagePic3:UIView!
    var viewCMNDTruocButton5:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let navigationHeight:CGFloat = 0
        
        scrollView = UIScrollView(frame: CGRect(x: 0,y: 0 ,width:UIScreen.main.bounds.size.width , height:  UIScreen.main.bounds.size.height - navigationHeight))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height  + navigationHeight )
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
     
        
      
        
       
//        viewGoogleMap = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: 200))
//        viewGoogleMap.backgroundColor = UIColor.black
//
//        mCamera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width , height: 200), camera: mCamera)
//
//        viewGoogleMap = mapView
        
        
        //mViewTop = UIView(frame: CGRect(x:Common.Size(s: 10),y: viewGoogleMap.frame.origin.y + viewGoogleMap.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 20), height: Common.Size(s:15) ))
        mViewTop = UIView(frame: CGRect(x:Common.Size(s: 10),y: Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 20), height: Common.Size(s:15) ))
        mViewTop.backgroundColor = UIColor(netHex:0xffffff)
        
        let strTitle = "Nguyễn Văn A "
        let _: CGSize = strTitle.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Common.Size(s:13))])
        lbName = UILabel(frame: CGRect(x: 0, y: Common.Size(s: 5) , width: mViewTop.frame.size.width  , height: Common.Size(s:13)))
        lbName.textAlignment = .left
        lbName.textColor = UIColor(netHex: 0x4aaef9)
        lbName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbName.text = strTitle
        
        
      
        lbTime = UILabel(frame: CGRect(x:  mViewTop.frame.size.width / 3 * 2 , y: lbName.frame.origin.y  , width: mViewTop.frame.size.width / 2 , height: Common.Size(s:13)))
        lbTime.textAlignment = .left
        lbTime.textColor = UIColor(netHex: 0x000000)
        lbTime.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        lbTime.text = "8:00 - 23/11"
        
        
        mViewLine1 = UIView(frame: CGRect(x: 0,y: mViewTop.frame.origin.y + mViewTop.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width , height: 1 ))
        mViewLine1.backgroundColor = UIColor(netHex:0x000000)
        
        mViewInfo = UIView(frame: CGRect(x:Common.Size(s: 10),y: mViewLine1.frame.origin.y + mViewLine1.frame.size.height + Common.Size(s: 5) ,width:UIScreen.main.bounds.size.width - Common.Size(s: 20), height: Common.Size(s:80) ))
        mViewInfo.backgroundColor = UIColor(netHex:0xffffff)
        
        
        lbPhaiThu = UILabel(frame: CGRect(x: 0 , y: lbName.frame.origin.y  , width: mViewTop.frame.size.width / 5 , height: Common.Size(s:13)))
        lbPhaiThu.textAlignment = .left
        lbPhaiThu.textColor = UIColor.gray
        lbPhaiThu.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbPhaiThu.text = "Phải thu:"
        
        lbValuePhaiThu = UILabel(frame: CGRect(x: lbPhaiThu.frame.origin.x + lbPhaiThu.frame.size.width + Common.Size(s:5), y: lbPhaiThu.frame.origin.y  , width: mViewTop.frame.size.width / 2 , height: Common.Size(s:13)))
        lbValuePhaiThu.textAlignment = .left
        lbValuePhaiThu.textColor = UIColor.red
        lbValuePhaiThu.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        lbValuePhaiThu.text = "10.000"
        
        
        imageViewCall = UIImageView(frame: CGRect(x: mViewTop.frame.size.width / 3 * 2 , y: lbValuePhaiThu.frame.origin.y , width: Common.Size(s: 20) , height: Common.Size(s: 20) ));
        imageViewCall.image = UIImage(named:"call")
        imageViewCall.contentMode = UIView.ContentMode.scaleToFill
        
        lbCall = UILabel(frame: CGRect(x: mViewTop.frame.size.width / 3 * 2 + Common.Size(s:25), y: imageViewCall.frame.origin.y  , width: mViewTop.frame.size.width / 2 , height: Common.Size(s:13)))
        lbCall.textAlignment = .left
        lbCall.textColor = UIColor(netHex: 0x000000)
        lbCall.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbCall.text = "Gọi ngay"
        
        lbGhiChu = UILabel(frame: CGRect(x: 0 , y: lbCall.frame.origin.y + lbCall.frame.size.height + Common.Size(s: 20)  , width: mViewTop.frame.size.width / 5 , height: Common.Size(s:30)))
        lbGhiChu.textAlignment = .left
        lbGhiChu.textColor = UIColor.gray
        lbGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbGhiChu.text = "Ghi chú:"
        
        lbValueGhiChu = UILabel(frame: CGRect(x: lbGhiChu.frame.origin.x + lbGhiChu.frame.size.width + Common.Size(s: 5) , y: lbGhiChu.frame.origin.y   , width: UIScreen.main.bounds.size.width - Common.Size(s: 20), height: Common.Size(s:50)))
        lbValueGhiChu.textAlignment = .left
          lbValueGhiChu.contentMode = .scaleToFill
        lbValueGhiChu.numberOfLines = 0
      
   
        lbValueGhiChu.textColor = UIColor.gray
        lbValueGhiChu.font = UIFont.systemFont(ofSize: Common.Size(s:9))
        lbValueGhiChu.text = ""
        
        
        btnXacNhan = UIButton(frame: CGRect(x: (UIScreen.main.bounds.size.width - (UIScreen.main.bounds.size.width * 7 / 8)) / 2, y: mViewInfo.frame.origin.y + mViewInfo.bounds.size.height + Common.Size(s: 5)  , width: UIScreen.main.bounds.size.width * 7 / 8 , height: Common.Size(s:40)));
        btnXacNhan.backgroundColor = UIColor(netHex:0x106eb4)
        btnXacNhan.layer.cornerRadius = 10
        btnXacNhan.layer.borderWidth = 1
        btnXacNhan.layer.borderColor = UIColor.white.cgColor
        btnXacNhan.setTitle("Giao hàng cho khách",for: .normal)
        btnXacNhan.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        btnKGoiDuoc = UIButton(frame: CGRect(x: btnXacNhan.frame.origin.x, y: btnXacNhan.frame.origin.y + btnXacNhan.bounds.size.height + Common.Size(s: 15)  , width: UIScreen.main.bounds.size.width * 7 / 8 / 2 , height: Common.Size(s:40)));
        btnKGoiDuoc.backgroundColor = UIColor(netHex:0xffffff)
        btnKGoiDuoc.layer.cornerRadius = 15
        btnKGoiDuoc.layer.borderWidth = 1
        btnKGoiDuoc.layer.borderColor = UIColor.black.cgColor
        btnKGoiDuoc.setTitle("Không gọi được",for: .normal)
        btnKGoiDuoc.setTitleColor(UIColor(netHex:0x106eb4), for: .normal)
        
        btnKhachDoiGio = UIButton(frame: CGRect(x: btnKGoiDuoc.frame.origin.x + btnKGoiDuoc.frame.size.width + Common.Size(s: 5), y: btnXacNhan.frame.origin.y + btnXacNhan.bounds.size.height + Common.Size(s: 15)  , width: UIScreen.main.bounds.size.width * 7 / 8 / 2 , height: Common.Size(s:40)));
        btnKhachDoiGio.backgroundColor = UIColor(netHex:0xffffff)
        btnKhachDoiGio.layer.cornerRadius = 15
        btnKhachDoiGio.layer.borderWidth = 1
        btnKhachDoiGio.layer.borderColor = UIColor.black.cgColor
        btnKhachDoiGio.setTitle("Khách đổi giờ",for: .normal)
        btnKhachDoiGio.setTitleColor(UIColor(netHex:0x106eb4), for: .normal)
        
        
        btnKhachTraHang = UIButton(frame: CGRect(x: btnKGoiDuoc.frame.origin.x , y: btnKhachDoiGio.frame.origin.y + btnKhachDoiGio.bounds.size.height + Common.Size(s: 5)  , width: UIScreen.main.bounds.size.width * 7 / 8 / 2 , height: Common.Size(s:40)));
        btnKhachTraHang.backgroundColor = UIColor(netHex:0xffffff)
        btnKhachTraHang.layer.cornerRadius = 15
        btnKhachTraHang.layer.borderWidth = 1
        btnKhachTraHang.layer.borderColor = UIColor.black.cgColor
        btnKhachTraHang.setTitle("Khách trả hàng",for: .normal)
        btnKhachTraHang.setTitleColor(UIColor(netHex:0x106eb4), for: .normal)
        
        btnXemLaiDonHang = UIButton(frame: CGRect(x: btnKhachDoiGio.frame.origin.x, y: btnKhachTraHang.frame.origin.y  , width: UIScreen.main.bounds.size.width * 7 / 8 / 2 , height: Common.Size(s:40)));
        btnXemLaiDonHang.backgroundColor = UIColor(netHex:0x106eb4)
        btnXemLaiDonHang.layer.cornerRadius = 15
        btnXemLaiDonHang.layer.borderWidth = 1
        btnXemLaiDonHang.layer.borderColor = UIColor.white.cgColor
        btnXemLaiDonHang.setTitle("Xem lại đơn hàng",for: .normal)
        btnXemLaiDonHang.setTitleColor(UIColor(netHex:0xffffff), for: .normal)
        
        
        mViewLine2 = UIView(frame: CGRect(x: 0,y: btnXemLaiDonHang.frame.origin.y + btnXemLaiDonHang.frame.size.height + Common.Size(s: 10) ,width:UIScreen.main.bounds.size.width , height: 1 ))
        mViewLine2.backgroundColor = UIColor.gray
        
        lbHinhAnh = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: mViewLine2.frame.origin.y + mViewLine2.frame.size.height + Common.Size(s: 10)  , width: mViewTop.frame.size.width  , height: Common.Size(s:15)))
        lbHinhAnh.textAlignment = .left
        lbHinhAnh.textColor = UIColor.gray
        lbHinhAnh.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh.text = "Hình ảnh giao hàng"
        
        lbHinhAnh1 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: lbHinhAnh.frame.origin.y + lbHinhAnh.frame.size.height + Common.Size(s: 10)  , width: mViewTop.frame.size.width  , height: Common.Size(s:15)))
        lbHinhAnh1.textAlignment = .left
        lbHinhAnh1.textColor = UIColor.gray
        lbHinhAnh1.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh1.text = "Trước khi giao"
        
        viewImagePic = UIView(frame: CGRect(x:Common.Size(s:15), y: lbHinhAnh1.frame.origin.y + lbHinhAnh1.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
        viewImagePic.layer.borderWidth = 0.5
        viewImagePic.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePic.layer.cornerRadius = 3.0
        
        lbHinhAnh2 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: viewImagePic.frame.origin.y + viewImagePic.frame.size.height + Common.Size(s: 10)  , width: mViewTop.frame.size.width  , height: Common.Size(s:15)))
        lbHinhAnh2.textAlignment = .left
        lbHinhAnh2.textColor = UIColor.gray
        lbHinhAnh2.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh2.text = "Tại nhà khách"
        
        
        viewCMNDTruocButton3 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: 0, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
        viewCMNDTruocButton3.image = UIImage(named:"Add Image-51")
        viewCMNDTruocButton3.contentMode = .scaleAspectFit
        
        
        viewImagePic2 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbHinhAnh2.frame.origin.y + lbHinhAnh2.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
        viewImagePic2.layer.borderWidth = 0.5
        viewImagePic2.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePic2.layer.cornerRadius = 3.0
        
        lbHinhAnh3 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: viewImagePic2.frame.origin.y + viewImagePic2.frame.size.height + Common.Size(s: 10)  , width: mViewTop.frame.size.width  , height: Common.Size(s:15)))
        lbHinhAnh3.textAlignment = .left
        lbHinhAnh3.textColor = UIColor.gray
        lbHinhAnh3.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh3.text = "Ảnh khách hàng"
        
        
        viewCMNDTruocButton4 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: 0, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
        viewCMNDTruocButton4.image = UIImage(named:"Add Image-51")
        viewCMNDTruocButton4.contentMode = .scaleAspectFit
        
        //new
        viewImagePic21 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbHinhAnh3.frame.origin.y + lbHinhAnh3.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
        viewImagePic21.layer.borderWidth = 0.5
        viewImagePic21.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePic21.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton41 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: 0, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
        viewCMNDTruocButton41.image = UIImage(named:"Add Image-51")
        viewCMNDTruocButton41.contentMode = .scaleAspectFit
        
        lbHinhAnh4 = UILabel(frame: CGRect(x: Common.Size(s: 10) , y: viewImagePic21.frame.origin.y + viewImagePic21.frame.size.height + Common.Size(s: 10)  , width: mViewTop.frame.size.width  , height: Common.Size(s:15)))
        lbHinhAnh4.textAlignment = .left
        lbHinhAnh4.textColor = UIColor.gray
        lbHinhAnh4.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lbHinhAnh4.text = "Chữ kí khách hàng"
        //end new
        
        viewImagePic3 = UIView(frame: CGRect(x:Common.Size(s:15), y: lbHinhAnh4.frame.origin.y + lbHinhAnh4.frame.size.height + Common.Size(s:5), width: scrollView.frame.size.width - Common.Size(s:30), height: Common.Size(s:100) * 1.5) )
        viewImagePic3.layer.borderWidth = 0.5
        viewImagePic3.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        viewImagePic3.layer.cornerRadius = 3.0
        
        
        viewCMNDTruocButton5 = UIImageView(frame: CGRect(x: viewImagePic.frame.size.width/2 - (viewImagePic.frame.size.height * 2/3)/2, y: 0, width: viewImagePic.frame.size.height * 2/3, height: viewImagePic.frame.size.height * 2/3))
        viewCMNDTruocButton5.image = UIImage(named:"Add Image-51")
        viewCMNDTruocButton5.contentMode = .scaleAspectFit
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewImagePic.frame.origin.y + viewImagePic.frame.size.height + 400)
        
        addSubview(scrollView)
        //scrollView.addSubview(viewGoogleMap)
        
        scrollView.addSubview(mViewTop)
        mViewTop.addSubview(lbName)
        mViewTop.addSubview(lbTime)
        scrollView.addSubview(mViewLine1)
        scrollView.addSubview(mViewInfo)
        mViewInfo.addSubview(lbValuePhaiThu)
        mViewInfo.addSubview(lbPhaiThu)
        mViewInfo.addSubview(imageViewCall)
        mViewInfo.addSubview(lbCall)
        
        mViewInfo.addSubview(lbValueGhiChu)
        mViewInfo.addSubview(lbGhiChu)
        scrollView.addSubview(btnXacNhan)
        scrollView.addSubview(btnKGoiDuoc)
        scrollView.addSubview(btnKhachDoiGio)
        scrollView.addSubview(btnKhachTraHang)
        scrollView.addSubview(btnXemLaiDonHang)
        scrollView.addSubview(mViewLine2)
        scrollView.addSubview(lbHinhAnh)
        scrollView.addSubview(lbHinhAnh1)
        scrollView.addSubview(lbHinhAnh2)
        scrollView.addSubview(lbHinhAnh3)
        scrollView.addSubview(lbHinhAnh4)
        scrollView.addSubview(viewImagePic)
        viewImagePic.addSubview(viewCMNDTruocButton3)
        
        scrollView.addSubview(viewImagePic2)
        scrollView.addSubview(viewImagePic21)
        viewImagePic21.addSubview(viewCMNDTruocButton41)
        viewImagePic2.addSubview(viewCMNDTruocButton4)
        
        scrollView.addSubview(viewImagePic3)
        viewImagePic3.addSubview(viewCMNDTruocButton5)
        
        
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }

}
