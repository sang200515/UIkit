//
//  PopUPDoneReceipt.swift
//  fptshop
//
//  Created by Sang Truong on 11/18/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import AVFoundation

import UIKit


class PopUPDoneReceipt: UIViewController {
    @IBOutlet weak var heightSignature: NSLayoutConstraint!
    var heightViewBounds:CGFloat = 450
    private var isSign:Bool = false
    var receiptID:Int = 0
    let widtd = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .green
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        
        return scrollView
    }()
    private var  contentView :UIView = {
        let view = UIView()
        
        return view
        
    }()
    private var  viewBounds :UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
        
    }()
    private var  tittleLabel :UILabel = {
        let lbl = UILabel()
        lbl.text = "Xác Nhận"
        lbl.font = UIFont.boldSystemFont(ofSize: 17)
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 10
        lbl.backgroundColor = .white
        
        return lbl
        
    }()
    private var  okButton :UIButton = {
        let bt = UIButton()
        bt.setTitle("HOÀN TẤT", for:   .normal)
        bt.backgroundColor = .mainGreen
        bt.layer.cornerRadius = 20
        bt.addTarget(self, action: #selector(okAction), for: .touchUpInside)
        bt.isUserInteractionEnabled = true
        bt.clipsToBounds = true
        
        return bt
        
    }()
    private var  blankBt :UIButton = {
        let bt = UIButton()
        bt.setTitle("", for:   .normal)
        bt.layer.cornerRadius = 20
        
        bt.clipsToBounds = true
        
        return bt
        
    }()
    private var  contentLabel :UILabel = {
        let lbl = UILabel()
        lbl.text = "KH cần ký tên để xác nhận những  thông tin trên là hoàn toàn chính xác."
        lbl.numberOfLines  = 2
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        lbl.font = UIFont.systemFont(ofSize: 15)
        lbl.textColor = .black
        return lbl
        
    }()
    private var  viewSign :UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    private var  closeButton :UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "ItemClose"), for: .normal)
        bt.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        bt.isUserInteractionEnabled = true
        return bt
        
    }()
    private var viewSignButton: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        return image
    }()
    private var imageCheck: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "check-1")
        
        return image
    }()
    private var  contentTerm :UILabel = {
        let lbl = UILabel()
        lbl.text = "Tôi đã kiểm tra và đồng ý với tình trạng của thiết bị sau khi được hỗ trợ phần mềm. Tôi cam kết miễn trừ trách nhiệm của FPT Shop nếu xảy ra bất cứ vấn đề nào liên quan đến tình trạng thiết bị, tình trạng phần mềm và các dữ liệu, tài khoản cá nhân."
        lbl.backgroundColor = .white
        lbl.AutoScaleHeightForLabel()
        return lbl
        
    }()
    
    private var  viewBoundslbl :UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    var onOKAction: (() -> Void)?
    
    var heightForSign = 140
    
    
    
    var dataPopup = (title:"Xác Nhận",content:"Nhập mã OTP đã được gửi về máy của KH",titleButton:"Xác Nhận",isShowClose: true,isShowOKButon:false,contentTermlbl:"Tôi đã kiểm tra và đồng ý với tình trạng của thiết bị sau khi được hỗ trợ phần mềm. Tôi cam kết miễn trừ trách nhiệm của FPT Shop nếu xảy ra bất cứ vấn đề nào liên quan đến tình trạng thiết bị, tình trạng phần mềm và các dữ liệu, tài khoản cá nhân.")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        scrollView.backgroundColor = .gray
        scrollView.frame = CGRect(x: 0, y: 0, width: widtd, height: height)
        
        //        blurView.alpha = 0.2
        scrollView.addSubview(contentView)
        contentView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: height)
        
        
        configureButtonView()
        
        
        //        contentTerm.AutoScaleHeightForLabel()
        //        let imageSign:UIImage = self.resizeImage(image: viewSignButton.image!,newHeight: 500)!
        //        if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
        //            let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)
        //
        //
        //        }
        configurUI()
        
        
    }
    func configureButtonView(){
        contentView.addSubview(viewBounds)
        viewBounds.frame = CGRect(x: 15, y: 100, width: widtd-30, height: heightViewBounds)
        viewBounds.addSubview(tittleLabel)
        tittleLabel.frame = CGRect(x: 0, y: 0, width: viewBounds.frame.size.width, height: 40)
        tittleLabel.addSubview(closeButton)
        closeButton.frame = CGRect(x: viewBounds.frame.size.width - 40, y: 0, width: 40, height: 40)
        viewBounds.addSubview(contentLabel)
        contentLabel.frame = CGRect(x: 0, y: 40, width: viewBounds.frame.size.width, height: 50 )
        viewBounds.addSubview(viewSign)
        viewSign.frame = CGRect(x: 0, y: 80, width: Int(viewBounds.frame.size.width), height: heightForSign)
        viewSign.addSubview(viewSignButton)
        viewSignButton.frame = viewSign.bounds
        viewBounds.backgroundColor = .clear
        
        viewBounds.addSubview(viewBoundslbl)
        
        viewBoundslbl.frame = CGRect(x: 0, y: viewSignButton.frame.size.height +  viewSignButton.frame.origin.y + 80, width: viewSign.frame.size.width, height: 230)
        
        viewBoundslbl.addSubview(imageCheck)
        imageCheck.frame = CGRect(x:16   , y: 20 , width: 20, height: 20)
        viewBoundslbl.addSubview(contentTerm)
        
        contentTerm.frame = CGRect(x: 40, y: 15, width: viewBoundslbl.frame.size.width - 55, height: 150)
        viewBoundslbl.addSubview(okButton)
        okButton.frame = CGRect(x: 60, y: contentTerm.frame.size.height + contentTerm.frame.origin.y + 10, width: viewBounds.frame.size.width - 120, height: 40)
        configureBlankButton()
        scrollView.addSubview(blankBt)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewBoundslbl.frame.origin.y + viewBoundslbl.frame.size.height + 200)
        contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: viewBoundslbl.frame.origin.y + viewBoundslbl.frame.size.height + 200)
    }
    func configurUI(){
        viewSign.layer.borderWidth = 0.5
        
        scrollView.addSubview(viewBounds)
        viewSign.layer.borderColor = UIColor(netHex:0xc2c2c2).cgColor
        
        
        
        
        viewSignButton =  UIImageView(frame: CGRect(x:Common.Size(s: 15), y:  Common.Size(s:5), width: Common.standardWidth - Common.Size(s:30), height: 120))
        viewSignButton.image = #imageLiteral(resourceName: "Chuky")
        
        viewSignButton.contentMode = .scaleAspectFit
        viewSignButton.tag = 0
        viewSign.addSubview(viewSignButton)
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
        viewSignButton.isUserInteractionEnabled = true
        viewSignButton.addGestureRecognizer(tapShowSignature)
        
        
        
    }
    @objc func tapShowSign(sender:UITapGestureRecognizer) {
        let signatureVC = EPSignatureViewController(signatureDelegate: self, showsDate: true, showsSaveSignatureOption: false)
        signatureVC.subtitleText = "Không ký qua vạch này!"
        signatureVC.title = "Chữ ký"
        self.navigationController?.pushViewController(signatureVC, animated: true)
        
        
    }
    @objc func okAction(){
        if isSign == false{
            
            self.showPopUp("Chưa có chữ ký khách hàng", "Thông báo", buttonTitle: "OK")
            return
        }
        
                 let imageSign:UIImage = self.resizeImage(image: viewSignButton.image!,newHeight: 500)!
         if let imageDataChuKy:NSData = imageSign.pngData() as NSData?{
             let srtBase64ChuKy = imageDataChuKy.base64EncodedString(options: .endLineWithLineFeed)

      
                 WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) { [self] in

                     MPOSAPIMangerV2.shared.returnDeviceReceipt(receiptId: self.receiptID,signatureBase64: srtBase64ChuKy) {[weak self] result in
                         guard let self = self else {return}
                         WaitingNetworkResponseAlert.DismissWaitingAlert {
                             switch result {
                             case .success(let data):
                                 if data.success {
                                     let alert = UIAlertController(title: "Thông báo", message: data.Message, preferredStyle: .alert)
                                     alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                         _ = self.navigationController?.popToRootViewController(animated: true)
                                         self.dismiss(animated: true, completion: nil)

                                     })
                                     self.present(alert, animated: true)
                                 }
                                 else {
                                     self.showPopUp(data.Message, "Thông báo", buttonTitle: "OK")

                                 }

                             case .failure(let error):
                                 self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")

                             }
                         }
                     }
                 }
            }
        
        if let ok = onOKAction {
            ok()
        }
        print("touch")
    }
    
    
    @objc func closeAction(){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
extension PopUPDoneReceipt:EPSignatureDelegate {
    func resizeImage(image: UIImage, newHeight: CGFloat) -> UIImage? {
        
        let scale = newHeight / image.size.height
        let newWidth = image.size.width * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    func cropImage(image:UIImage, toRect rect:CGRect) -> UIImage{
        let imageRef:CGImage = image.cgImage!.cropping(to: rect)!
        let croppedImage:UIImage = UIImage(cgImage:imageRef)
        return croppedImage
    }
    func epSignature(_: EPSignatureViewController, didCancel error : NSError) {
        
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect) {
        let width = viewSign.frame.size.width - Common.Size(s:10)
        isSign = true
        let sca:CGFloat = boundingRect.size.width / boundingRect.size.height
        let heightImage:CGFloat = width / sca
        heightForSign = Int(heightImage)
        heightViewBounds = CGFloat(heightForSign)
        viewSign.subviews.forEach { $0.removeFromSuperview() }
        viewSignButton  = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: width, height: heightImage))
        
        viewSignButton.contentMode = .scaleAspectFit
        viewSign.addSubview(viewSignButton)
        viewSignButton.image = cropImage(image: signatureImage, toRect: boundingRect)
        
        viewSign.frame.size.height = viewSignButton.frame.size.height + viewSignButton.frame.origin.y + Common.Size(s:5)
        reSignatureSignn()
        configureButtonView()
        configureBlankButton()
        scrollView.updateConstraints()
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    func configureBlankButton(){
        
        blankBt.frame = CGRect(x: 0, y: viewBounds.frame.size.height + viewBounds.frame.origin.y+10, width: widtd, height: 5)
        viewBounds.frame.size.height = viewBounds.frame.size.height + viewBounds.frame.origin.y + 140
        
        
    }
    func reSignatureSignn(){
        
        let tapShowSignature = UITapGestureRecognizer(target: self, action: #selector(tapShowSign))
        viewSignButton.isUserInteractionEnabled = true
        viewSignButton.addGestureRecognizer(tapShowSignature)
    }
}
