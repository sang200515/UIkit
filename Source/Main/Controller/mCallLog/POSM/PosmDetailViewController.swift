//
//  PosmImageViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import Toaster
class PosmDetailViewController: UIViewController,PosmImageItemCellDelegate {
  
    
    var lstPosmImage = [DetailCallLogPosm]()
    var btnBack: UIBarButtonItem!
    var posmItem:WorkPosm?
    var tableView:UITableView!
    var cellHeight: CGFloat = 0
    var posImageUpload:Int = -1
    var imagePicker = UIImagePickerController()
    var detailSelectItem:DetailCallLogPosm?
    var parameDetailImages:[ParameDetailImage] = []
    var lbTitleCallLog:UILabel!
    var line:UIView!
    var viewHeader:UIView!
    var customAlert = PosmReasonRejectDialog()
    var lblReasonRejectSum:UILabel!
    private var isPreventButtonSend = true
    override func viewDidLoad() {
        self.title = "Báo cáo hình ảnh POSM"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
        
        viewHeader = UIView(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: view.frame.size.width, height: 0))
        self.view.addSubview(viewHeader)
        
        lbTitleCallLog = UILabel(frame: CGRect(x: 0, y:0, width: viewHeader.frame.size.width/1.3, height: Common.Size(s: 20)))
    
        lbTitleCallLog.textAlignment = .left
        lbTitleCallLog.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        lbTitleCallLog.textColor = UIColor(netHex:0x00955E)
        
        viewHeader.addSubview(lbTitleCallLog)
        
        
     
        
        let imageSend = UIImageView()
        imageSend.frame = CGRect(x:lbTitleCallLog.frame.size.width + lbTitleCallLog.frame.origin.x + Common.Size(s:10),y:0,width: Common.Size(s:30),height: Common.Size(s:20))
        imageSend.contentMode = UIView.ContentMode.scaleAspectFit
        imageSend.image = UIImage(named: "iconSendPOSM")
        let tapImageSend = UITapGestureRecognizer(target: self, action: #selector(PosmDetailViewController.actionTabSend))
        imageSend.isUserInteractionEnabled = true
        imageSend.addGestureRecognizer(tapImageSend)
        viewHeader.addSubview(imageSend)
        
        
        
        lblReasonRejectSum = UILabel(frame:CGRect(x: 0, y: lbTitleCallLog.frame.size.height + lbTitleCallLog.frame.origin.y, width: viewHeader.frame.size.width - Common.Size(s: 20), height: 0))
        viewHeader.addSubview(lblReasonRejectSum)
        
  
    
        
        viewHeader.frame.size.height = lblReasonRejectSum.frame.size.height + lblReasonRejectSum.frame.origin.y + Common.Size(s:10)
        line = UIView(frame:CGRect(x:0,y:viewHeader.frame.size.height + viewHeader.frame.origin.y,width:view.frame.size.width,height:1))
        line.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(line)
        
        tableView = UITableView(frame: CGRect(x: 0, y: line.frame.size.height + line.frame.origin.y + Common.Size(s: 5), width: self.view.frame.size.width, height: self.view.frame.size.height - viewHeader.frame.size.height -  ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height) - 1))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PosmImageItemCell.self, forCellReuseIdentifier: "PosmImageItemCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        self.actionLoadDetailImage()
        

        
    }
    func reloadUI(){
        let lbTitleCallLogHeight:CGFloat = lbTitleCallLog.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitleCallLog.optimalHeight
        lbTitleCallLog.numberOfLines = 0
        lbTitleCallLog.frame = CGRect(x: lbTitleCallLog.frame.origin.x, y: lbTitleCallLog.frame.origin.y, width: lbTitleCallLog.frame.width, height: lbTitleCallLogHeight)
        
        
        if(lblReasonRejectSum.text != ""){
            lblReasonRejectSum.frame.origin.y = lbTitleCallLog.frame.size.height + lbTitleCallLog.frame.origin.y + Common.Size(s:10)
            let lblReasonRejectSumHeight:CGFloat = lblReasonRejectSum.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblReasonRejectSum.optimalHeight
            lblReasonRejectSum.numberOfLines = 0
            lblReasonRejectSum.frame = CGRect(x: lblReasonRejectSum.frame.origin.x, y: lblReasonRejectSum.frame.origin.y, width: lblReasonRejectSum.frame.width, height: lblReasonRejectSumHeight)
            viewHeader.frame.size.height = lblReasonRejectSum.frame.size.height + lblReasonRejectSum.frame.origin.y + Common.Size(s:10)
        }else{
            lblReasonRejectSum.frame.size.height = 0
            viewHeader.frame.size.height = lbTitleCallLog.frame.size.height + lbTitleCallLog.frame.origin.y + Common.Size(s:10)
        }
        
        line.frame.origin.y = viewHeader.frame.size.height + viewHeader.frame.origin.y
        tableView.frame.origin.y = line.frame.size.height + line.frame.origin.y + Common.Size(s: 5)
        tableView.frame.size.height =  self.view.frame.size.height - viewHeader.frame.size.height -  ((self.navigationController?.navigationBar.frame.size.height)! )
        
    }
    func validate() -> Int {
        var count = 0
        for item in parameDetailImages {
            if ((item.Url == "" || item.Url == nil) && item.LyDoKhongUpHinh == "") {
                count += 1
            }
        }
        return count
    }
    @objc func actionTabSend(){
        if isPreventButtonSend {
            showPopUp("Bạn không được up hình ảnh bước này !!!", "Thông báo", buttonTitle: "OK")
            return
        }
        
        if validate() > 0 {
            let alrt = UIAlertController(title: "Thông báo", message: "Bạn còn \(validate()) hạng mục chưa up hình.Vui lòng nhập lý do khiến bạn chưa thể up hình cho hạng mục này.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Đồng ý", style: .default, handler: nil)
            alrt.addAction(action)
            self.present(alrt, animated: true, completion: nil)
            return
        }
            var lstDict:[Any] = []
            if(parameDetailImages.count > 0){
                for item in parameDetailImages{
                    let dict = self.dictionary(object: item)
                    lstDict.append(dict as Any)
                }
            }
            let newViewController = LoadingViewController()
            newViewController.content = "Đang lưu thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
            mCallLogApiManager.TypeId_229_XuLy(RequestId:"\(posmItem?.RequestId ?? "")",Details:lstDict) { [weak self](results, err) in
                guard let self = self else {return}
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results?.Result != 0){
                            let alert = UIAlertController(title: "Thông báo", message: results?.Message ?? "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                self.navigationController?.popViewController(animated: true)
                            })
                            self.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: results?.Message ?? "", preferredStyle: .alert)
                            
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

        
    }
    
    
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
 
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        sender.view?.removeFromSuperview()
    }
    @objc func actionLoadDetailImage(){
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        mCallLogApiManager.TypeId_229_GetDetail(RequestId: "\(self.posmItem?.RequestId ?? "999")") { [weak self](results,title,reason, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.lstPosmImage.removeAll()
                    self.lstPosmImage = results
                    for item in results {
                        if item.TinhTrangDuyet != "2" {
                            let newItem = ParameDetailImage(DetailId: item.RequestDetailId, Url: "", LyDoKhongUpHinh: "")
                            newItem.LyDoKhongUpHinh = item.LyDoKhongUpHinh
                            self.parameDetailImages.append(newItem)
                        }
                    }
                    self.tableView.reloadData()
                    self.lbTitleCallLog.text = title
                    if(reason != ""){
                        let attributedTitle = NSMutableAttributedString(string: "Lý do chưa up hình: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.black])
                        attributedTitle.append(NSAttributedString(string: reason, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor: UIColor.black]))
                        
                        self.lblReasonRejectSum.attributedText = attributedTitle
                    }else{
                        self.lblReasonRejectSum.text = ""
                    }
             
                    self.reloadUI()
                    
                }else{
               
                    self.showPopUp(err, "Thông báo", buttonTitle: "Đồng ý")
                }
            }
        }
    }
    @objc func tabCaptureImage(item:DetailCallLogPosm) {
        self.detailSelectItem = item
        self.posImageUpload = 1
        self.thisIsTheFunctionWeAreCalling()
        
    }
    func uploadImage(image:UIImage){
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang upload hình ảnh ..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
                let base64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
                
                
                
                mCallLogApiManager.TypeId_229_UploadImage(RequestId:"\(self.posmItem?.RequestId ?? "999")",RequestDetailId:"\(self.detailSelectItem?.RequestDetailId ?? "")",Base64: "\(base64)") {[weak self] (results, err) in
                    guard let self = self else {return}
                    let when = DispatchTime.now() + 0.5
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        nc.post(name: Notification.Name("dismissLoading"), object: nil)
                        if(err.count <= 0){
                            for (index,item) in self.parameDetailImages.enumerated() {
                                if item.DetailId == self.detailSelectItem?.RequestDetailId {
                                    self.parameDetailImages[index].Url = results?.Url
                                    self.lstPosmImage[self.detailSelectItem?.row ?? 0].imageSample = image
                                    self.lstPosmImage[self.detailSelectItem?.row ?? 0].isCapture = true
                                    self.tableView.reloadData()
                                }
                            }
                            
                            
                        }else{
                     
                            self.showPopUp(err, "Thông báo", buttonTitle: "Đồng ý")
                        }
                    }
                }
                
            }
        }
 
        
    }
    func tabViewImage(url: String) {
        let myVC = PosmImageViewController()
        myVC.url = url
        let navController = UINavigationController(rootViewController: myVC)
        self.navigationController?.present(navController, animated:false, completion: nil)
        
    }
    func dictionary(object:ParameDetailImage) -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(object),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
                return [:]
        }
        return dict
    }
    
}
    // MARK: - UITableViewDataSource

extension PosmDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lstPosmImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PosmImageItemCell = tableView.dequeueReusableCell(withIdentifier: "PosmImageItemCell", for: indexPath) as! PosmImageItemCell
        //let cell: PosmImageItemCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "PosmImageItemCell") as! PosmImageItemCell
        let item = lstPosmImage[indexPath.row]
        item.row = indexPath.row
        cell.setUpCell(item: item)
        cell.selectionStyle = .none
        cell.delegate = self
        self.cellHeight = cell.estimateCellHeight
        if item.ChoPhepUpHinh == true {
            self.isPreventButtonSend = false
        }
        cell.onTxtChange = { [weak self] text in
            self?.lstPosmImage[indexPath.row].LyDoKhongUpHinh = text
            self?.parameDetailImages[indexPath.row].LyDoKhongUpHinh = text
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
 

 
    
}
protocol PosmImageItemCellDelegate:AnyObject {
    
    func tabCaptureImage(item:DetailCallLogPosm)
    func tabViewImage(url:String)
}
class PosmImageItemCell: UITableViewCell , UITextViewDelegate{
    
    var lbTitle:UILabel!
    var lbStatus:UILabel!
    var imageCheck:UIImageView!
    var imagePOSM:UIImageView!
    var btViewImage:UIButton!
    var btCaptureImage:UIButton!
    var reasonLbl:UILabel!
    var reasonTxt:UITextView!
    var estimateCellHeight: CGFloat = 0
    weak var delegate: PosmImageItemCellDelegate?
    var itemDetail:DetailCallLogPosm?
    var reasonReject:UILabel!
    var onTxtChange:((String)-> Void)?

    func setUpCell(item: DetailCallLogPosm) {
        itemDetail = item
        self.subviews.forEach({$0.removeFromSuperview()})
        
        imageCheck = UIImageView()
        imageCheck.frame = CGRect(x:Common.Size(s:8),y:Common.Size(s:10),width: Common.Size(s:30),height: Common.Size(s:20))
        imageCheck.contentMode = UIView.ContentMode.scaleAspectFit
        imageCheck.image = UIImage(named: "Check")
        
        self.addSubview(imageCheck)
        
        lbTitle = UILabel(frame: CGRect(x:imageCheck.frame.size.width + imageCheck.frame.origin.x + Common.Size(s:10), y: Common.Size(s:10), width: self.frame.width/1.8, height: Common.Size(s: 20)))
        lbTitle.text = "\(item.TenCongViecChiTiet)"
        lbTitle.textAlignment = .left
        lbTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbTitle.textColor = .black
        self.addSubview(lbTitle)
        
        let lbTitleHeight:CGFloat = lbTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        
        lbStatus = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: self.frame.width - Common.Size(s:20), height: Common.Size(s: 20)))
        //lbStatus.text = "\(item.TinhTrangDuyet_Text)"
        lbStatus.attributedText = "\(item.TinhTrangDuyet_Text)".convertHtmlToNSAttributedString
        lbStatus.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        //lbStatus.textColor = .gray
        lbStatus.textAlignment = .right
        self.addSubview(lbStatus)
        if(item.TinhTrangDuyet == "2"){
            imageCheck.image = UIImage(named: "check-booksim")
            //lbStatus.textColor = UIColor(netHex:0x00955E)
        }
    
        imagePOSM = UIImageView(frame: CGRect(x:Common.Size(s:10),y:lbTitle.frame.size.height + lbTitle.frame.origin.y + Common.Size(s:10) ,width: 160,height: 160))
        reasonReject = UILabel(frame: CGRect(x: Common.Size(s:10), y: imagePOSM.frame.size.height + imagePOSM.frame.origin.y + Common.Size(s:10), width: self.frame.width - Common.Size(s:15), height: 0))
 
        reasonReject.textAlignment = .left
        reasonReject.font = UIFont.systemFont(ofSize: Common.Size(s: 14))
        reasonReject.textColor = .gray
        reasonReject.text = "mot hai ba nam sau bay tam chin muoi"
        self.addSubview(reasonReject)
        if(item.TinhTrangDuyet == "3"){
            //lbStatus.textColor = .red
            imageCheck.image = UIImage(named: "pdFFriendDelete")
            
            if(item.LyDoKhongDuyet != ""){
                
                let attributedTitle = NSMutableAttributedString(string: "Lý do: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: UIColor.black])
                attributedTitle.append(NSAttributedString(string: item.LyDoKhongDuyet, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),NSAttributedString.Key.foregroundColor: UIColor.black]))
                
                self.reasonReject.attributedText = attributedTitle
                
                let reasonRejectHeight:CGFloat = reasonReject.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : reasonReject.optimalHeight
                reasonReject.numberOfLines = 0
                reasonReject.frame = CGRect(x: reasonReject.frame.origin.x, y: reasonReject.frame.origin.y, width: reasonReject.frame.width, height: reasonRejectHeight)
            }
        }
        reasonLbl = UILabel(frame: CGRect(x: Common.Size(s:10), y: reasonReject.frame.size.height + reasonReject.frame.origin.y + Common.Size(s:10), width: UIScreen.main.bounds.width - 30, height: 20))
        reasonLbl.font = UIFont.systemFont(ofSize: 14)
        reasonLbl.textAlignment = .left
        reasonLbl.text = "Lý do không up ảnh:"
        self.addSubview(reasonLbl)
        reasonTxt = UITextView(frame: CGRect(x: Common.Size(s:10), y: reasonLbl.frame.size.height + reasonLbl.frame.origin.y + Common.Size(s:10), width: UIScreen.main.bounds.width - 30, height: 40))
        reasonTxt.delegate = self
        reasonTxt.cornerRadius = 10
        reasonTxt.borderWidth = 1
        reasonTxt.borderColor = .gray
        reasonTxt.text = "Nhập lý do không up ảnh"
        reasonTxt.textColor = .lightGray
        var reasonHeight: CGFloat = 70
        if item.LyDoKhongUpHinh != ""{
            reasonTxt.isUserInteractionEnabled = item.TinhTrangDuyet == "3" ? true : false
            reasonTxt.text = "\(item.LyDoKhongUpHinh)"
            reasonTxt.textColor = .black
            if reasonTxt.contentSize.height > 70 {            
                reasonHeight = reasonTxt.contentSize.height + 30
            }
        }
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if(item.isCapture == false){
            if(item.ChoPhepUpHinh  == false){
                if(item.LinkHinhShopUp != ""){
                    if let escapedString = "\(item.LinkHinhShopUp)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                        if escapedString != "" {
                            print(escapedString)
                            let url = URL(string: "\(escapedString)")!
                            imagePOSM.kf.setImage(with: url,
                                                  placeholder: nil,
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: nil)
                        }
                  
                    }
                }
            }else{
                if(item.LinkHinhMau != ""){
                    if let escapedString = "\(item.LinkHinhMau)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
                        print(escapedString)
                        if escapedString != "" {
                            let url = URL(string: "\(escapedString)")!
                            imagePOSM.kf.setImage(with: url,
                                                  placeholder: nil,
                                                  options: [.transition(.fade(1))],
                                                  progressBlock: nil,
                                                  completionHandler: nil)
                        }
                  
                    }
                }
            }
           
        }else{
            imagePOSM.image = item.imageSample
        }
   
        imagePOSM.contentMode = UIView.ContentMode.scaleAspectFit
        imagePOSM.layer.borderWidth = 0.5
        imagePOSM.layer.borderColor = UIColor.white.cgColor
        imagePOSM.layer.cornerRadius = 5.0
        imagePOSM.clipsToBounds = true
        imagePOSM.layer.borderWidth = 1
        imagePOSM.layer.borderColor = UIColor.black.cgColor
        self.addSubview(imagePOSM)
        self.addSubview(reasonTxt)
        
        btViewImage = UIButton()
        btViewImage.frame = CGRect(x: imagePOSM.frame.size.width + imagePOSM.frame.origin.x + Common.Size(s:18), y: imagePOSM.frame.origin.y + Common.Size(s:30) , width: Common.Size(s:140), height: Common.Size(s:30) )
        btViewImage.backgroundColor = UIColor(netHex:0x00955E)
        btViewImage.setTitle("Xem ảnh mẫu", for: .normal)
        btViewImage.addTarget(self, action: #selector(actionViewImage), for: .touchUpInside)
        btViewImage.layer.borderWidth = 0.5
        btViewImage.layer.borderColor = UIColor.white.cgColor
        btViewImage.layer.cornerRadius = 5.0
        self.addSubview(btViewImage)
        
        btCaptureImage = UIButton()
        btCaptureImage.frame = CGRect(x: imagePOSM.frame.size.width + imagePOSM.frame.origin.x + Common.Size(s:18), y: btViewImage.frame.size.height + btViewImage.frame.origin.y + Common.Size(s:10), width: Common.Size(s:140), height: Common.Size(s:30) )
        btCaptureImage.backgroundColor = UIColor(netHex:0x00955E)
        btCaptureImage.setTitle("Chụp ảnh", for: .normal)
        btCaptureImage.addTarget(self, action: #selector(actionCaptureImage), for: .touchUpInside)
        btCaptureImage.layer.borderWidth = 0.5
        btCaptureImage.layer.borderColor = UIColor.white.cgColor
        btCaptureImage.layer.cornerRadius = 5.0
        self.addSubview(btCaptureImage)
        if(item.ChoPhepUpHinh == false){
            btCaptureImage.isHidden = true
            btCaptureImage.isEnabled = false
            if item.LyDoKhongUpHinh == "" {
                reasonTxt.isHidden = true
                reasonLbl.isHidden = true
                reasonHeight = 0
            }
        }
        
   
        
        estimateCellHeight = reasonReject.frame.origin.y + reasonReject.frame.height + Common.Size(s: 5) + reasonHeight
        
        
        
        
    }
    @objc func actionViewImage(){
        
        delegate?.tabViewImage(url: itemDetail?.LinkHinhMau ?? "")
    }
    @objc func actionCaptureImage(){
        if let detail = itemDetail {
            delegate?.tabCaptureImage(item:detail)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Nhập lý do không up ảnh"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if let change = onTxtChange {
            change(textView.text ?? "")
        }
    }
    
}
extension PosmDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        //self.openCamera()
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        if (self.posImageUpload == 1){
            
            self.uploadImage(image: image)
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
class PosmReasonRejectDialog {
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    private var myTargetView:UIView?
    private var taskNotes:UITextView!
    private var myViewController:UIViewController?
    private var parameDetailImages:[ParameDetailImage] = []
    private var lstPosmImage:[DetailCallLogPosm] = []
    func showAlert(with title:String, messsage:String , on viewController: UIViewController,parameDetailImagesView:[ParameDetailImage],lstPosmImageView:[DetailCallLogPosm]){
        guard let targetView = viewController.view else{
            return
        }
        backgroundView.frame = targetView.bounds
        myTargetView = targetView
        myViewController = viewController
        parameDetailImages = parameDetailImagesView
        lstPosmImage = lstPosmImageView
        targetView.addSubview(backgroundView)
              targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 250)
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 0, width: alertView.frame.size.width - 10, height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        alertView.addSubview(titleLabel)
        
        
        
        taskNotes = UITextView(frame: CGRect(x:10 , y: 80, width: alertView.frame.size.width - 16, height: Common.Size(s:40) * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        alertView.addSubview(taskNotes)
        
        
        let button = UIButton(frame: CGRect(x: 12, y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:18), width: 120, height: 50))
        alertView.addSubview(button)
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Đóng", for: .normal)
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        
        let btComplete = UIButton()
        btComplete.frame = CGRect(x: button.frame.size.width + button.frame.origin.x + 10, y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:20) , width: 120, height: 40 )
        btComplete.backgroundColor = UIColor(netHex:0x00955E)
        btComplete.setTitle("Hoàn tất", for: .normal)
        btComplete.addTarget(self, action: #selector(actionComplete), for: .touchUpInside)
        btComplete.layer.borderWidth = 0.5
        btComplete.layer.borderColor = UIColor.white.cgColor
        btComplete.layer.cornerRadius = 5.0
        alertView.addSubview(btComplete)
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        },completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    //self.alertView.center = targetView.center
                    self.alertView.frame.origin.y = targetView.frame.size.width/1.8
                })
            }
        })
        
        
    }
    @objc func dismissAlert(){
        guard let targetView = myTargetView else{return}
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 300)
        },completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                },completion: {done in
                    if done{
                        self.lstPosmImage = []
                        self.parameDetailImages = []
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                    
                } )
            }
        })
    }
    @objc func actionComplete(){
        guard let reason = taskNotes.text else {return}
        if(reason == ""){
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa nhập lý do từ chối !!! ", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                
            })
            self.myViewController?.present(alert, animated: true)
            return
        }
        var lstDict:[Any] = []
        
            if(parameDetailImages.count > 0){
                for item in parameDetailImages{
                    let dict = self.dictionary(object: item)
                    lstDict.append(dict as Any)
                }
            }

            let newViewController = LoadingViewController()
            newViewController.content = "Đang lưu thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.myViewController?.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            
        mCallLogApiManager.TypeId_229_XuLy(RequestId:"\(lstPosmImage.first?.RequestId ?? "9999")",Details:lstDict) { (results, err) in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(err.count <= 0){
                        if(results?.Result != 0){
                            let alert = UIAlertController(title: "Thông báo", message: results?.Message ?? "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                _ = self.myViewController?.navigationController?.popToRootViewController(animated: true)
                                self.myViewController?.dismiss(animated: true, completion: nil)
                            })
                            self.myViewController?.present(alert, animated: true)
                        }else{
                            let alert = UIAlertController(title: "Thông báo", message: results?.Message ?? "", preferredStyle: .alert)
                            
                            alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                                
                            })
                            self.myViewController?.present(alert, animated: true)
                        }
                        
                        
                    }else{
                        let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            
                        })
                        self.myViewController?.present(alert, animated: true)
                        
                    }
                }
            }
    }
    func dictionary(object:ParameDetailImage) -> [String: Any] {
         let encoder = JSONEncoder()
         encoder.dateEncodingStrategy = .millisecondsSince1970
         guard let json = try? encoder.encode(object),
             let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
                 return [:]
         }
         return dict
     }
}
