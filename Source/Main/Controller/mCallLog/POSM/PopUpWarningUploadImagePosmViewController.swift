//
//  PopUpWarningUploadImagePosmViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/27/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit

class PopUpWarningUploadImagePosmViewController: UIViewController {
    var taskNotes:UITextView!
    var parameDetailImages:[ParameDetailImage]?
    var lstPosmImage:[DetailCallLogPosm]?
    var number:Int = 0
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white
        
        if(lstPosmImage!.count > 0){
            number = lstPosmImage!.count - parameDetailImages!.count
        }
        
        let lblTitle = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s: 10), width: view.frame.size.width - Common.Size(s:30), height: Common.Size(s:14)))
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        lblTitle.text = "Bạn còn \(number) hạng mục chưa up hình. Vui lòng nhập lý do khiến bạn chưa thể up hình cho hạng mục này"
        view.addSubview(lblTitle)
        
        let lblTitleHeight:CGFloat = lblTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblTitle.optimalHeight
        lblTitle.numberOfLines = 0
        lblTitle.frame = CGRect(x: lblTitle.frame.origin.x, y: lblTitle.frame.origin.y, width: lblTitle.frame.width, height: lblTitleHeight)
        
        taskNotes = UITextView(frame: CGRect(x: lblTitle.frame.origin.x , y: lblTitle.frame.origin.y  + lblTitle.frame.size.height + Common.Size(s:10), width: lblTitle.frame.size.width, height: Common.Size(s:40) * 2 ))
        
        let borderColor : UIColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0)
        taskNotes.layer.borderWidth = 0.5
        taskNotes.layer.borderColor = borderColor.cgColor
        taskNotes.layer.cornerRadius = 5.0
        
        taskNotes.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        view.addSubview(taskNotes)
        
        
        let btClose = UIButton()
        btClose.frame = CGRect(x:  Common.Size(s:30), y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:30) , width: Common.Size(s:120), height: Common.Size(s:40) )
        btClose.backgroundColor = UIColor(netHex:0x00955E)
        btClose.setTitle("Đóng", for: .normal)
        btClose.addTarget(self, action: #selector(actionClose), for: .touchUpInside)
        btClose.layer.borderWidth = 0.5
        btClose.layer.borderColor = UIColor.white.cgColor
        btClose.layer.cornerRadius = 5.0
        view.addSubview(btClose)
        
        let btComplete = UIButton()
        btComplete.frame = CGRect(x: btClose.frame.size.width + btClose.frame.origin.x + Common.Size(s:10), y: taskNotes.frame.origin.y + taskNotes.frame.size.height + Common.Size(s:30) , width: Common.Size(s:120), height: Common.Size(s:40) )
        btComplete.backgroundColor = UIColor(netHex:0x00955E)
        btComplete.setTitle("Hoàn tất", for: .normal)
        btComplete.addTarget(self, action: #selector(actionComplete), for: .touchUpInside)
        btComplete.layer.borderWidth = 0.5
        btComplete.layer.borderColor = UIColor.white.cgColor
        btComplete.layer.cornerRadius = 5.0
        view.addSubview(btComplete)
        
        
    }
    @objc func actionClose(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @objc func actionComplete(){
        if(self.taskNotes.text == ""){
    
            self.showPopUp("Vui lòng nhập lý do !!!", "Thông báo", buttonTitle: "Đồng ý")
            return
        }
        //        let jsonEncoder = JSONEncoder()
        //        let jsonData = try jsonEncoder.encode(parameDetailImages)
//        let json = String(data: jsonData, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
//        print(json as Any)
        var lstDict:[Any] = []
        if(parameDetailImages!.count > 0){
            for item in parameDetailImages!{
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
        
        
        mCallLogApiManager.TypeId_229_XuLy(RequestId:"\(lstPosmImage![0].RequestId)",Details:lstDict) {[weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(results?.Result != 0){
                        let alert = UIAlertController(title: "Thông báo", message: results?.Message ?? "", preferredStyle: .alert)
                        
                        alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in
                            _ = self.navigationController?.popToRootViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        })
                        self.present(alert, animated: true)
                    }else{
            
                        self.showPopUp(results?.Message ?? "", "Thông báo", buttonTitle: "OK")
                    }
                    
                    
                }else{
             
                    self.showPopUp(err, "Thông báo", buttonTitle: "Đồng ý")
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

