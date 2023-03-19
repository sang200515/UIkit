//
//  VietjetSelectPromotionTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetSelectPromotionTableViewCell: UITableViewCell {

    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var lbGroup: UILabel!
    @IBOutlet weak var tbvPromotion: UITableView!
    @IBOutlet weak var cstPromotion: NSLayoutConstraint!
    
    private var promotions: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tbvPromotion.delegate = self
        tbvPromotion.dataSource = self
        tbvPromotion.registerTableCell(VietjetPromotionRowTableViewCell.self)
        tbvPromotion.estimatedRowHeight = 20
        tbvPromotion.rowHeight = UITableView.automaticDimension
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setupData(_ promotions: [VietjetPromotion]) {
        self.promotions = []
        for promotion in promotions {
            if promotion.tienGiam > 0 {
                self.promotions.append("Giảm giá: \(Common.convertCurrencyV2(value: promotion.tienGiam)) VNĐ")
            }
            
            if !promotion.tenSANPhamTang.isEmpty {
                self.promotions.append(promotion.tenSANPhamTang)
            }
        }
        
        tbvPromotion.reloadData()
        cstPromotion.constant = CGFloat(self.promotions.count * 40)
    }
    
    private func setupData(_ promotions: [ProductPromotions]) {
        self.promotions = []
        for promotion in promotions {
            if promotion.TienGiam > 0 {
                self.promotions.append("Giảm giá: \(Common.convertCurrencyFloatV2(value: promotion.TienGiam)) VNĐ")
            }
            
            if !promotion.TenSanPham_Tang.isEmpty {
                self.promotions.append(promotion.TenSanPham_Tang)
            }
        }
        
        tbvPromotion.reloadData()
        cstPromotion.constant = CGFloat(self.promotions.count * 40)
    }
    
    func setupCell(_ group: String, promotions: [VietjetPromotion], isSelected: Bool) {
        let selected = UIImage(named: "selected_radio_ic")!
        let unselected = UIImage(named: "unselected_radio_ic")!
        
        imgSelected.image = isSelected ? selected : unselected
        lbGroup.text = "Nhóm \(group)"
        setupData(promotions)
    }
    
    func setupCell(_ group: String, promotions: [ProductPromotions], isSelected: Bool) {
        let selected = UIImage(named: "selected_radio_ic")!
        let unselected = UIImage(named: "unselected_radio_ic")!
        
        imgSelected.image = isSelected ? selected : unselected
        lbGroup.text = "Nhóm \(group)"
        setupData(promotions)
    }
}

extension VietjetSelectPromotionTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return promotions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetPromotionRowTableViewCell.self)
        cell.setupCell(promotions[indexPath.row])
        return cell
    }
}
