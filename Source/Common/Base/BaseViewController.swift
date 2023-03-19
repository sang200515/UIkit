//
//  BaseViewController.swift
//  BaseViewController
//
//  Created by Trần Văn Dũng on 09/07/2021.
//
import RxSwift
import RxCocoa
import UIKit
import Kingfisher
import NVActivityIndicatorView
import DropDown

class BaseViewController: UIViewController, NVActivityIndicatorViewable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
    }
    
    func showPopup(vc:UIViewController,selfVC:UIViewController){
        let vc = vc
        selfVC.addChild(vc)
        vc.view.frame = selfVC.view.frame
        selfVC.view.addSubview(vc.view)
        vc.didMove(toParent: selfVC)
    }
    
    func startLoading(message:String){
        DispatchQueue.main.async {
            self.startAnimating(
                CGSize(width:30,height:30),
                message: message == "" ? "Đang tải tài nguyên" : message,
                messageFont: UIFont.boldSystemFont(ofSize: 16),
                type: .ballSpinFadeLoader,
                color: .darkGray,
                padding: 0,
                displayTimeThreshold: 0,
                minimumDisplayTime: 1,
                backgroundColor: UIColor.init(white: 0.9, alpha: 0.5),
                textColor: .darkGray)
        }
    }
    
    func stopLoading(){
        self.stopAnimating()
    }
    
    func configureNavigationBackItem(title:String){
        self.title = title
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}




