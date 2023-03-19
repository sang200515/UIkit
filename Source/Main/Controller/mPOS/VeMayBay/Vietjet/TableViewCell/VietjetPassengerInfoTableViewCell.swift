//
//  VietjetPassengerInfoTableViewCell.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetPassengerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbDOB: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbCMND: UILabel!
    @IBOutlet weak var vCMND: UIStackView!
    @IBOutlet weak var vServices: UIStackView!
    
    var didPressShowServiceDetail: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(type: VietjetPassengerType, index: Int = 0) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        switch type {
        case .adult:
            lbTitle.text = "Người lớn \(index)"
            let passenger = VietjetDataManager.shared.passengers[index - 1]
            lbName.text = passenger.reservationProfile.lastName + " " + VietjetDataManager.shared.passengers[index - 1].reservationProfile.firstName
            
            let dob = dateFormatter.date(from: passenger.reservationProfile.birthDate)
            lbDOB.text = dob == nil ? passenger.reservationProfile.birthDate : dob!.stringWith(format: "dd/MM/yyyy")
            lbGender.text = passenger.reservationProfile.gender == "Male" ? "Nam" : "Nữ"
            
            lbCMND.text = passenger.reservationProfile.idcard
            vCMND.isHidden = passenger.reservationProfile.idcard.isEmpty
        case .child:
            vCMND.isHidden = true
            
            lbTitle.text = "Trẻ em \(index)"
            let passenger = VietjetDataManager.shared.passengers[VietjetDataManager.shared.adultCount + index - 1]
            lbName.text = passenger.reservationProfile.lastName + " " + passenger.reservationProfile.firstName
            
            let dob = dateFormatter.date(from: passenger.reservationProfile.birthDate)
            lbDOB.text = dob == nil ? passenger.reservationProfile.birthDate : dob!.stringWith(format: "dd/MM/yyyy")
            lbGender.text = passenger.reservationProfile.gender == "Male" ? "Nam" : "Nữ"
        case .infant:
            vCMND.isHidden = true
            vServices.isHidden = true
            
            lbTitle.text = "Em bé \(index)"
            lbName.text = VietjetDataManager.shared.passengers[index - 1].infantProfile!.lastName + " " + VietjetDataManager.shared.passengers[index - 1].infantProfile!.firstName
            
            let dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[index - 1].infantProfile!.birthDate)
            lbDOB.text = dob == nil ? VietjetDataManager.shared.passengers[index - 1].infantProfile!.birthDate : dob!.stringWith(format: "dd/MM/yyyy")
            lbGender.text = VietjetDataManager.shared.passengers[index - 1].infantProfile!.gender == "Male" ? "Nam" : "Nữ"
        default:
            break
        }
    }
    
    @IBAction func serviceButtonPressed(_ sender: Any) {
        didPressShowServiceDetail?()
    }
}
