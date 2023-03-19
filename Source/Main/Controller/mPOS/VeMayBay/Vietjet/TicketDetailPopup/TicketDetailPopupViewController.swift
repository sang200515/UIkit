//
//  TicketDetailPopupViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 13/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import WebKit

class TicketDetailPopupViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var wvWeb: WKWebView!
    
    var ticketDetail: String = ""
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = url {
            lbTitle.text = "Điều kiện giá vé, Điều lệ vận chuyển"
            let request = URLRequest(url: url)
            wvWeb.load(request)
        } else {
            lbTitle.text = "Điều kiện vé - Vietjet Air"
            wvWeb.loadHTMLString(ticketDetail, baseURL: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vBackground.roundCorners([.topLeft, .topRight], radius: 10)
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
