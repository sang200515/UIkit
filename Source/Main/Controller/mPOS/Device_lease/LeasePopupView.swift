//
//  LeasePopupView.swift
//  fptshop
//
//  Created by Ngoc Bao on 19/07/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit

class LeasePopupView: UIView {

    @IBOutlet weak var grayView: UIView!
    var onAction: ((Int)->Void)?
    
    func loadNib() -> LeasePopupView {
        Bundle.main.loadNibNamed("LeasePopupView", owner: self, options: nil)?.first as! LeasePopupView
    }
    
    @IBAction func onCLose() {
        self.removeFromSuperview()
    }
    
    @IBAction func onMiraAction() {
        self.removeFromSuperview()
        if let mirae = self.onAction {
            mirae(0)
        }
    }
    
    @IBAction func onCAVAction() {
        self.removeFromSuperview()
        if let cav = self.onAction {
            cav(1)
        }
    }

}
