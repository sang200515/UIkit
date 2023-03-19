//
//  CMSNHistoryDetailViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 08/03/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CMSNHistoryDetailViewController: UIViewController {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbDOB: UILabel!
    @IBOutlet weak var lbCMND: UILabel!
    @IBOutlet weak var lbUser: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var imgCMND: UIImageView!
    
    var detail: CMSNHistoryData = CMSNHistoryData(JSON: [:])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Chi tiết lịch sử"
        addBackButton()
        
        lbName.text = detail.fullname
        lbPhone.text = detail.phoneNumber
        lbDOB.text = detail.birthday
        lbCMND.text = detail.idCard
        lbUser.text = detail.updatedBy
        lbDate.text = detail.updatedDate
        lbStatus.text = detail.status
        lbStatus.textColor = UIColor.init(hexString: detail.statusColor)
        
        Common.encodeURLImg(urlString: detail.sftpFileURL, imgView: imgCMND)
    }
}
