//
//  SelectImeiPopup.swift
//  fptshop
//
//  Created by Ngo Bao Ngoc on 01/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectImeiPopup: BaseController {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imeiLabel: UILabel!
    @IBOutlet weak var imeiView: UIView!
    @IBOutlet weak var contentVew: UIView!
    
    var onUpdate: ((String) -> Void)?
    var onClose: (() -> Void)?
    var productCode = ""
    
    var listImei = [Imei]()
    var detailOrder: InstallmentOrderData?
    var selectedImei: Imei?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blurView.alpha = 0.5
        imeiView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onViewAction))
        imeiView.addGestureRecognizer(gesture)
        self.nameLabel.text = detailOrder?.product.name
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getImei()
    }
    
    func getImei() {
        showLoading()
        MPOSAPIManager.getImeiFF(productCode: self.productCode, shopCode: Cache.user!.ShopCode) { [weak self] (result, err) in
            self?.stopLoading()
            if err != "" {
                self?.showPopup(with: err, completion: nil)
            } else {
                self?.listImei = result
                for (index,item) in result.enumerated() {
                    if let theDate = Date(jsonDate: "\(item.CreateDate)") {
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "dd/MM/yyyy"
                        let dateString = dayTimePeriodFormatter.string(from: theDate)
                        self?.listImei[index].CreateDate = dateString
                    }
                }
                
            }
        }
    }
    
    
    
    @objc func onViewAction() {
        let subSubView = ImeiListView()
        subSubView.listImei = listImei.map({"\($0.DistNumber) - \($0.CreateDate)"})
        subSubView.frame.origin = self.view.frame.origin
        subSubView.backgroundColor = .white
        
        subSubView.frame.size = CGSize(width: self.view.bounds.width - 32, height: 250)
        subSubView.makeCorner(corner: 10)
        subSubView.center = self.view.convert(self.view.center, to: subSubView)
        subSubView.onSelectImei = { [weak self] (imeiStr, index) in
            self?.imeiLabel.text = imeiStr
            self?.selectedImei = self?.listImei[index]
        }
        self.view.addSubview(subSubView)
    }
    
    
    @IBAction func onUpdateAction() {
        if imeiLabel.text?.trim().isEmpty ?? false {
            showPopup(with: "Imei trống, vui lòng chọn imei trước khi xác nhận", completion: nil)
            return
        }
        if let update = onUpdate {
            let imei = self.imeiLabel.text?.components(separatedBy: "-").first ?? ""
            update(imei.trim())
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCloseAction() {
        self.dismiss(animated: true, completion: nil)
        if let close = onClose {
            close()
        }
    }
    
}
