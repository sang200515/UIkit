//
//  LiveCameraViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 5/14/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import PopupDialog
class LiveCameraViewController: UIViewController{
//    VLCMediaPlayerDelegate
//    var cameraDetail:CameraDetail!
//    var mediaPlayer: VLCMediaPlayer = VLCMediaPlayer()
//    var checkPlay: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavigationBar()
//        self.title = "\(cameraDetail.TenCamera)"
//        self.view.backgroundColor = .white
//
//        //---
//        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
//        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
//        let btBackIcon = UIButton.init(type: .custom)
//        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
//        btBackIcon.imageView?.contentMode = .scaleAspectFit
//        btBackIcon.addTarget(self, action: #selector(LiveCameraViewController.actionBack), for: UIControl.Event.touchUpInside)
//        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
//        viewLeftNav.addSubview(btBackIcon)
//        //---
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        checkPlay = 0
//        let url = URL(string: "\(cameraDetail.LinkCamera)")
//
//        if url == nil {
//            print("Invalid URL")
//            return
//        }
//        let media = VLCMedia(url: url!)
//        mediaPlayer.media = media
//        mediaPlayer.delegate = self
//        mediaPlayer.drawable = self.view
//        mediaPlayer.libraryInstance.debugLogging = true
//        mediaPlayer.play()
//        print("Playing")
//
//        let when = DispatchTime.now() + 10
//        DispatchQueue.main.asyncAfter(deadline: when) {
//            if(self.checkPlay < 1){
//
//
//                let popup = PopupDialog(title: "THÔNG BÁO", message: "Không thể tải dữ liệu camera. Vui lòng thử lại sau!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
//                    print("Completed")
//                }
//                let buttonOne = CancelButton(title: "OK") {
//                    self.navigationController?.popViewController(animated: true)
//                }
//                popup.addButtons([buttonOne])
//                self.present(popup, animated: true, completion: nil)
//            }
//        }
    }
    //    func mediaPlayerStateChanged(_ aNotification: Notification!) {
    //          print("mediaPlayerStateChanged")
    //        if let userInfo = aNotification.userInfo as? [String: Any] // or use if you know the type  [AnyHashable : Any]
    //        {
    //            print(userInfo)
    //
    //            if let progressValue = userInfo["progressPercentage"] as? Float {
    //                if progressValue > 0.01{
    //
    //                }
    //            }
    //        }
    //    }
    
//    func mediaPlayerStateChanged(_ aNotification: Notification!) {
//        if mediaPlayer.state == .stopped {
//            self.dismiss(animated: true, completion: nil)
//        }else if mediaPlayer.state == .buffering {
//            print("mediaPlayerStateChanged buffering")
//            if(checkPlay == 1){
//                checkPlay = 2
//                let nc = NotificationCenter.default
//                let when = DispatchTime.now() + 0.5
//                DispatchQueue.main.asyncAfter(deadline: when) {
//                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
//                }
//            }
//        }else if mediaPlayer.state == .error {
//            print("mediaPlayerStateChanged error")
//        }else if mediaPlayer.state == .opening {
//            print("mediaPlayerStateChanged opening")
//        }else if mediaPlayer.state == .playing {
//            checkPlay = 1
//            print("mediaPlayerStateChanged playing")
//            let newViewController = LoadingViewController()
//            newViewController.content = "Đang tải dữ liệu camera..."
//            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//            self.navigationController?.present(newViewController, animated: true, completion: nil)
//
//        }else if mediaPlayer.state == .ended {
//            print("mediaPlayerStateChanged ended")
//        }else if mediaPlayer.state == .esAdded {
//            print("mediaPlayerStateChanged esAdded")
//        }
//    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
