//
//  BookingTribiFlightViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 12/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import TripiFlightKit
import PopupDialog
import Toaster
class BookingTribiFlightViewController: UIViewController,UITextFieldDelegate {
    
    var scrollView:UIScrollView!
    var btConnection:UIButton!
    private static var _manager = Config.manager
    override func viewWillAppear(_ animated: Bool) {
        
        self.initNavigationBar()
        navigationController?.navigationBar.isTranslucent = false
    }
    
    
    override func viewDidLoad() {
        self.title = "Đặt vé máy bay"
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated:true)
        navigationController?.navigationBar.isTranslucent = false
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(BookingTribiFlightViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        

        
        btConnection = UIButton()
        btConnection.frame = CGRect(x: Common.Size(s: 10), y:  Common.Size(s:20), width:  self.view.frame.size.width - Common.Size(s:30),height: Common.Size(s: 40))
        btConnection.backgroundColor = UIColor(netHex:0x00955E)
        btConnection.setTitle("Mua vé máy bay", for: .normal)
        btConnection.addTarget(self, action: #selector(registerTribiFlightSDK), for: .touchUpInside)
        btConnection.layer.borderWidth = 0.5
        btConnection.layer.borderColor = UIColor.white.cgColor
        btConnection.layer.cornerRadius = 3
        self.view.addSubview(btConnection)
        btConnection.clipsToBounds = true
        
        let lbInfoCustomerMore = UILabel(frame: CGRect(x: btConnection.frame.origin.x , y: btConnection.frame.size.height + btConnection.frame.origin.y + Common.Size(s: 10), width:btConnection.frame.size.width, height: Common.Size(s: 14)))
        lbInfoCustomerMore.textAlignment = .right
        lbInfoCustomerMore.textColor = UIColor(netHex:0x04AB6E)
        lbInfoCustomerMore.font = UIFont.italicSystemFont(ofSize: Common.Size(s:13))
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Xem lịch sử vé máy bay", attributes: underlineAttribute)
        lbInfoCustomerMore.attributedText = underlineAttributedString
         self.view.addSubview(lbInfoCustomerMore)
        let tapShowDetailCustomer = UITapGestureRecognizer(target: self, action: #selector(BookingTribiFlightViewController.actionHistory))
        lbInfoCustomerMore.isUserInteractionEnabled = true
        lbInfoCustomerMore.addGestureRecognizer(tapShowDetailCustomer)
              
        if(Config.manager.version! != "Production"){
            btConnection.isUserInteractionEnabled = false
        }
        
        //self.registerTribiFlightSDK()
        
    }
    @objc func actionHistory(){
        let newViewController = HistoryTribiFlightViewController()
        self.navigationController?.push(viewController: newViewController)
    }
    
    @objc func registerTribiFlightSDK(){
        

       let toast = Toast.init(text: "Đang kết nối đến đối tác vui lòng chờ .... !")
        toast.show()
        guard let navi = self.navigationController else { return }
        
        TripiFlightKit.shared.callFlightSDK(
            from: navi,
            delegate: self,
            shopId: "\(Cache.user!.ShopCode)",
            saleId: "\(Cache.user!.UserName)",
            appToken: "\(Config.manager.KEY_TRIPI!)",
            language: "vi") { (isSuccess) in
                toast.cancel()
                if isSuccess {
                      
                    print("Xác thực thành công")
                } else {
                    print("Xác thực thất bại")
                  
                    self.showDialog(message: "Xác thực thất bại")
                }
                
        }
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
       
        
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
    
    
    
}
extension BookingTribiFlightViewController: TripiFlightKitDelegate {
    func didBookOrderWith(jsonData: Data?) {
        let jsonString = String.init(data: jsonData!, encoding: .utf8)
        //self.tv.text = jsonString
        print(jsonString!)
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra giao dịch..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default


        MPOSAPIManager.mpos_FRT_Flight_Tripi_InsertBooking(Json: jsonString!) { (result, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(result!.Result == 1){
                        let alert = UIAlertController(title: "Thông báo", message: result!.Message, preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                       
                            //
                            let newViewController2 = LoadingViewController()
                            newViewController2.content = "Đang load thông tin..."
                            newViewController2.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                            newViewController2.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            self.navigationController?.present(newViewController2, animated: true, completion: nil)
                            let nc = NotificationCenter.default


                            MPOSAPIManager.mpos_FRT_Flight_Tripi_GetDetailInfor(docentry:"\(result!.DocEntry)") { (result, err) in
                                let when = DispatchTime.now() + 0.5
                                DispatchQueue.main.asyncAfter(deadline: when) {
                                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                                    if(err.count <= 0){
                                        self.initNavigationBar()
                                        let newViewController = ResultTribiFlightViewController()
                                        newViewController.detailTribi = result[0]
                                        self.navigationController?.pushViewController(newViewController, animated: true)
                                        
                                    }else{
                              
                                        self.showDialog(message: err)
                                    }
                                }
                            }
                            //
                        })
                        self.present(alert, animated: true)
               

                    }else{
                     
                        self.showDialog(message: result!.Message)
                    }
                }else{
         
                    self.showDialog(message: err)
                }
            }
        }

    }
    
}

