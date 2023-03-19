//
//  CheckListViewController.swift
//  mSM
//
//  Created by Apple on 4/23/19.
//  Copyright © 2019 fptshop.com.vn. All rights reserved.
//

protocol CheckListViewControllerDelegate: AnyObject{
    func getReportTypeString(valueString: String)
}

import UIKit

class CheckListViewController: UIViewController {
    
    var btnContinue: UIButton!
    weak var delegate:CheckListViewControllerDelegate?
    var lockOrient = "portrait"
    var isCellCheck = false
    var listDSMayType: [DSMayType] = []
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var arrImgCheckView = [UIImageView]()
    
    @objc func canRotate() -> Void{}

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUpView()
        
        if self.lockOrient == "portrait" {
            AppUtility.lockOrientation(.portrait)
        } else if self.lockOrient == "landscape"{
            AppUtility.lockOrientation(.landscape)
        }
    }
    
    func setUpView(){
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width - Common.Size(s: 50), height: UIScreen.main.bounds.height * 0.7)
        self.view.layer.cornerRadius = 8
        self.view.backgroundColor = UIColor.white
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 60))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let viewDetail = UIView(frame: CGRect(x: 0, y: Common.Size(s: 10), width: scrollView.frame.width, height: 40))
        scrollView.addSubview(viewDetail)
        
        for i in 0...self.listDSMayType.count - 1 {
            let item = self.listDSMayType[i]
            
            let lbText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: CGFloat(i) * 30, width: (viewDetail.frame.width - Common.Size(s:60)), height: 30))
            lbText.text = "\(item.textValue ?? "")"
            lbText.font = UIFont.systemFont(ofSize: 14)
            viewDetail.addSubview(lbText)
            
            let imgCheck = UIImageView(frame: CGRect(x: lbText.frame.origin.x + lbText.frame.width + Common.Size(s: 10), y: lbText.frame.origin.y + Common.Size(s: 5), width: 20, height: 20))
            viewDetail.addSubview(imgCheck)
            
            if item.isCheck == true {
                imgCheck.image = #imageLiteral(resourceName: "check-1-1")
            } else {
                imgCheck.image = #imageLiteral(resourceName: "check-2-1")
            }
            self.arrImgCheckView.append(imgCheck)
            imgCheck.tag = i + 1
            let tapCheckError = UITapGestureRecognizer(target: self, action: #selector(chooseDSMayType(sender:)))
            imgCheck.isUserInteractionEnabled = true
            imgCheck.addGestureRecognizer(tapCheckError)
        }
        let viewDetailHeight:CGFloat = ((CGFloat(listDSMayType.count) + 1) * 30) + 10

        viewDetail.frame = CGRect(x: viewDetail.frame.origin.x, y: viewDetail.frame.origin.y, width: viewDetail.frame.width, height: viewDetailHeight)
        
        scrollViewHeight = viewDetail.frame.origin.y + viewDetail.frame.height + 5
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        
        btnContinue = UIButton(frame: CGRect(x: 20, y: scrollView.frame.origin.y + scrollView.frame.height + 5, width: scrollView.frame.width - 40, height: 35))
        btnContinue.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        btnContinue.setTitle("TIẾP TỤC", for: .normal)
        btnContinue.layer.cornerRadius = 5
        self.view.addSubview(btnContinue)
        btnContinue.addTarget(self, action: #selector(getValuesChecked), for: .touchUpInside)
    }
    
    @objc func getValuesChecked() {
        var strChosen = [String]()
        for i in self.listDSMayType {
            if i.isCheck {
                strChosen.append(i.textValue ?? "")
            }
        }
        if strChosen.count > 0 {
            var str = ""
            if strChosen.contains("ALL"){
                str = "ALL"
            } else {
                str = strChosen.joined(separator: ",")
            }
            debugPrint("loai: \(str)")
            
            delegate?.getReportTypeString(valueString: str)
            self.dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn loại cho báo cáo!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func chooseDSMayType(sender: UIGestureRecognizer) {
        let view = sender.view ?? UIView()
        debugPrint("tagimg: \(view.tag)")
        
        let item = self.listDSMayType[view.tag - 1]
        item.isCheck = !item.isCheck
        
        if (item.textValue == "ALL") {
            if item.isCheck {
                self.listDSMayType.forEach({$0.isCheck = true})
                self.arrImgCheckView.forEach({$0.image = #imageLiteral(resourceName: "check-1-1")})
            } else {
                self.listDSMayType.forEach({$0.isCheck = false})
                self.arrImgCheckView.forEach({$0.image = #imageLiteral(resourceName: "check-2-1")})
            }
        } else {
            if item.isCheck {
                self.arrImgCheckView[view.tag - 1].image = #imageLiteral(resourceName: "check-1-1")
            } else {
                self.arrImgCheckView[view.tag - 1].image = #imageLiteral(resourceName: "check-2-1")
            }
        }
    }
}
struct AppUtility {
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
    
}



class DSMayType {
    var textValue: String?
    var isCheck: Bool = false

    init(textValue: String, isCheck: Bool) {
        self.textValue = textValue
        self.isCheck = isCheck
    }
}




