//
//  SingleFlutterViewController.swift
//  fptshop
//
//  Created by Sang Truong on 1/4/22.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//
import Flutter
import FlutterPluginRegistrant
import UIKit
import Foundation
class SingleFlutterViewController: FlutterViewController {

    var info = [String:String]()
    private var channel: FlutterMethodChannel?
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    init(withEntrypoint entryPoint: String?) {
        let newEngine = appDelegate.flutterEngine.makeEngine(withEntrypoint: entryPoint, libraryURI: nil)
        GeneratedPluginRegistrant.register(with: newEngine)
            if #available(iOS 13.0, *) {
                appDelegate.window?.overrideUserInterfaceStyle = .dark
            } else {
                // Fallback on earlier versions
            }
        super.init(engine: newEngine, nibName: nil, bundle: nil)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func onCountUpdate(newCount: Int64) {
        if let channel = channel {
            channel.invokeMethod("setUser", arguments: newCount)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        if (navigationController?.topViewController != self) {
            navigationController?.navigationBar.isHidden = false
        }
        super.viewWillDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("******************************DATA SEND TO FLUTTER******************************\n \(info)\n******************************SEND DATA SUCCESS******************************\n")
        channel = FlutterMethodChannel(
            name: "vn.com.fptshop/FPTShop", binaryMessenger: self.engine!.binaryMessenger)
        channel!.invokeMethod("setUser", arguments: info)
        channel!.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "getUser" {
                result(self.info)
            }
            if call.method == "back" {
                if #available(iOS 13.0, *) {
                    self.appDelegate.window?.overrideUserInterfaceStyle = .light
                } else {
                    // Fallback on earlier versions
                }
                self.navigationController?.popViewController(animated: true)
                result(nil)
            }
        }
    }

}
