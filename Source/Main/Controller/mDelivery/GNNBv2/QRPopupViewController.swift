//
//  QRPopupViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 26/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class QRPopupViewController: UIViewController {

    @IBOutlet weak var vBackgrounnd: UIView!
    var genQRDidPressed: (() -> Void)?
    var scanQRDidPressed: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vBackgrounnd.roundCorners(.allCorners, radius: 10)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func genQRButtonPressed(_ sender: Any) {
        genQRDidPressed?()
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func scanQRButtonPressed(_ sender: Any) {
        scanQRDidPressed?()
        dismiss(animated: false, completion: nil)
    }
}
