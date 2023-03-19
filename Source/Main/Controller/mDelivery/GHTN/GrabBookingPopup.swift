//
//  GrabBookingPopup.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/08/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class GrabBookingPopup: UIViewController {

    @IBOutlet weak var shopAddress: UILabel!
    @IBOutlet weak var cusAddress: UILabel!
    @IBOutlet weak var vehicleType: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var estimateTimeLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var frtButton: UIButton!
    @IBOutlet weak var bookingButton: UIButton!
    
    var planningItem: GrabPlainingItem?
    var orderItem: GetSOByUserResult?
    var titleButton:String = ""
    var onBook: (()->Void)?
    var onCancel: (()->Void)?
    var onFrtDelivery: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moneyLabel.text = "\(Common.convertCurrencyInteger(value: planningItem?.amount ?? 0))đ"
        shopAddress.text = planningItem?.diaChiShop
        cusAddress.text = planningItem?.diaChiKhachHang
        vehicleType.text = planningItem?.tenDichVu
        distanceLabel.text = "Khoảng cách: \(planningItem?.khoangCach ?? "")"
        estimateTimeLabel.text = "Dự kiến: \(planningItem?.duKien ?? "")"
        frtButton.isHidden = orderItem?.btn_FRTGiao != "" ? false : true
        frtButton.setTitle(orderItem?.btn_FRTGiao, for: .normal)
        
        self.bookingButton.setTitle(self.titleButton, for: .normal)
    }
    
    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
        if let cancel = onCancel {
            cancel()
        }
    }
    
    @IBAction func frtDelivery() {
        self.dismiss(animated: true, completion: nil)
        if let frt = onFrtDelivery {
            frt()
        }
    }
    
    @IBAction func booking() {
        self.dismiss(animated: true, completion: nil)
        if let book = onBook {
            book()
        }
    }

}
