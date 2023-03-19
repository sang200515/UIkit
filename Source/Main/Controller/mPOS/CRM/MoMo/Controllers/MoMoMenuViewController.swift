//
//  MoMoMenuViewController.swift
//  mPOS
//
//  Created by tan on 12/7/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import WebKit
class MoMoMenuViewController: UIViewController {
    
    // MARK: - Properties
    
 
    private var webView:WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), configuration: Common.configurationWKWebView())
        webView.backgroundColor = .white
        return webView
    }()
    
    private var iconTypeMoMoNapTien: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "RutTienMoMo")
        image.contentMode = .scaleAspectFit

        return image
    }()
    
    private var iconTypeMoMoLichSu: UIImageView = {
       let image = UIImageView()
        image.image = #imageLiteral(resourceName: "LichSuMoMo")
        image.contentMode = .scaleAspectFit
    
        return image
    }()
    private var infoPOSM:InfoSOM?
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {

        configureNavigationItem()
        configureUI()
      
        fetchNoteAPI()
        fetchInfoProviderPOSM()
    }
    
    
    // MARK: - API
    func fetchNoteAPI(){
        
        MPOSAPIManager.mpos_FRT_SP_Mirae_noteforsale(type:"4") {[weak self] (result, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
   
                if(result.count > 0){
  
                    self.webView.loadHTMLString(result, baseURL: nil)
             
                }
                
            }
            
        }
    }
    

    func fetchCheckPemissionMoMoAPI(){

        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
          
            SOMAPIManager.shared.checkPemissionMoMoAPI {[weak self] result in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                    case .success(let permissionMoMo):
                        guard let infoPOSM = self.infoPOSM else {return}
                        let newViewController = NapTienMoMoViewController(configInput: permissionMoMo.code != "001" ? .scan(permissionMoMo.detail ?? "") : .all,infoProviderPOSM: infoPOSM)
                        self.navigationController?.pushViewController(newViewController, animated: true)
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                        
                    }
                }
            }
        }
        
    }
    

    func fetchInfoProviderPOSM(){
        

    
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.fetchInfoSOM(includeDetails: "true") { [weak self]result in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                         case .success(let infoSOMResponse):

                            self.infoPOSM = infoSOMResponse
                      
                         case .failure(let error):
                     
                            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")
                         }
                    
                }
            }
        }
        
    }
    
    // MARK: - Selectors
    @objc func handleNapTien(){
        fetchCheckPemissionMoMoAPI()
    }
    
    
    @objc func handleHistory(){
        let newViewController = LichSuGiaoDichMoMoViewController()
        let cate = self.infoPOSM?.categoryIDS ?? []
        if cate.count > 0 {
            newViewController.cateID = cate[0]
        }
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    @objc func handleBack(){

        self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - Helpers
    func configureNavigationItem(){
        //left menu icon
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.title = "Nạp tiền MoMo"
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    
    
    func configureUI(){
        self.view.backgroundColor = .white
        view.addSubview(webView)
        view.addSubview(iconTypeMoMoNapTien)
        view.addSubview(iconTypeMoMoLichSu)
        
        
        webView.frame = CGRect(x: 0 , y: Common.Size(s: 5) , width: view.frame.size.width , height: Common.Size(s: 140) )
        
        iconTypeMoMoNapTien.frame = CGRect(x: Common.Size(s: 110), y: webView.frame.size.height + webView.frame.origin.y + Common.Size(s: 20), width: Common.Size(s: 100) , height: Common.Size(s: 100))
        let gestureNapTienMoMo = UITapGestureRecognizer(target: self, action:  #selector (handleNapTien))
        iconTypeMoMoNapTien.isUserInteractionEnabled = true
        iconTypeMoMoNapTien.addGestureRecognizer(gestureNapTienMoMo)
       
        
        iconTypeMoMoLichSu.frame = CGRect(x: Common.Size(s: 110)   , y: iconTypeMoMoNapTien.frame.origin.y + iconTypeMoMoNapTien.frame.size.height + Common.Size(s: 30), width: Common.Size(s: 100) , height: Common.Size(s: 100))
        let gestureLichSuMoMo = UITapGestureRecognizer(target: self, action:  #selector (handleHistory))
        iconTypeMoMoLichSu.isUserInteractionEnabled = true
        iconTypeMoMoLichSu.addGestureRecognizer(gestureLichSuMoMo)
        
        
 
    }

    
}
