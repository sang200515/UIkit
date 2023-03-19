//
//  BookingVietjetFlightViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 15/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class BookingVietjetFlightViewController: UIViewController {

    @IBOutlet weak var vSearch: UIView!
    @IBOutlet weak var imgOneWay: UIImageView!
    @IBOutlet weak var imgReturn: UIImageView!
    @IBOutlet weak var vFrom: UIView!
    @IBOutlet weak var lbFromDate: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var vTo: UIView!
    @IBOutlet weak var vToDate: UIView!
    @IBOutlet weak var lbToDate: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPassenger: UIView!
    @IBOutlet weak var lbPassenger: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var vBackground: UIView!
    
    @IBOutlet weak var vSelectPassenger: UIView!
    @IBOutlet weak var lbAdult: UILabel!
    @IBOutlet weak var lbChild: UILabel!
    @IBOutlet weak var lbInfant: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnHistory: UIButton!
    
    private let selectedImage = UIImage(named: "selected_radio_ic")!
    private let unselectedImage = UIImage(named: "unselected_radio_ic")!
    private var editingAdultCount: Int = 1
    private var editingChildCount: Int = 0
    private var editingInfantCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VietjetDataManager.shared.isAddon = false
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDateLabel()
        setAirportLabel()
        setPassengerLabel()
        setRadioButton()
    }
    
    private func setupUI() {
        title = "Tìm chuyến bay"
        addBackButton()
        
        vSearch.roundCorners(.allCorners, radius: 10)
        vFrom.roundCorners(.allCorners, radius: 20)
        vTo.roundCorners(.allCorners, radius: 20)
        vPassenger.roundCorners(.allCorners, radius: 20)
        btnSearch.roundCorners(.allCorners, radius: 20)
        vPassenger.roundCorners(.allCorners, radius: 20)
        vSelectPassenger.roundCorners([.topLeft, .topRight], radius: 15)
        btnAccept.roundCorners(.allCorners, radius: 5)
        btnCancel.roundCorners(.allCorners, radius: 5)
        btnHistory.roundCorners(.allCorners, radius: 5)
    }
    
    private func setDateLabel() {
        let dayOfWeek = VietjetDataManager.shared.selectedFirstDate.getDayOfWeek()
        lbFromDate.text = "\(dayOfWeek == 1 ? "CN" : "T\(dayOfWeek)"), \(VietjetDataManager.shared.selectedFirstDate.stringWith(format: "dd/MM"))"
        
        if VietjetDataManager.shared.isOneWay {
            vToDate.isHidden = true
        } else {
            vToDate.isHidden = false
            
            if let lastDate = VietjetDataManager.shared.selectedLastDate {
                lbToDate.text = "\(lastDate.getDayOfWeek() == 1 ? "CN" : "T\(lastDate.getDayOfWeek())"), \(lastDate.stringWith(format: "dd/MM"))"
            } else {
                lbToDate.text = ""
            }
        }
    }
    
    private func setAirportLabel() {
        if !VietjetDataManager.shared.selectedDepartureCity.name.isEmpty {
            lbFrom.text = "\(VietjetDataManager.shared.selectedDepartureCity.name) - \(VietjetDataManager.shared.selectedDepartureCity.code)"
        } else {
            lbFrom.text = "Điểm khởi hành"
        }
        
        if !VietjetDataManager.shared.selectedArrivalCity.name.isEmpty {
            lbTo.text = "\(VietjetDataManager.shared.selectedArrivalCity.name) - \(VietjetDataManager.shared.selectedArrivalCity.code)"
        } else {
            lbTo.text = "Điểm đến"
        }
    }
    
    private func setPassengerLabel() {
        var text = ""
        if VietjetDataManager.shared.adultCount > 0 { text += "\(VietjetDataManager.shared.adultCount) Người lớn, " }
        if VietjetDataManager.shared.childCount > 0 { text += "\(VietjetDataManager.shared.childCount) Trẻ em, " }
        if VietjetDataManager.shared.infantCount > 0 { text += "\(VietjetDataManager.shared.infantCount) Em bé, " }
        
        if text.last == " " {
            text.removeLast()
            text.removeLast()
        }
        
        lbPassenger.text = text
    }
    
    private func setRadioButton() {
        if VietjetDataManager.shared.isOneWay {
            imgOneWay.image = selectedImage
            imgReturn.image = unselectedImage
        } else {
            imgOneWay.image = unselectedImage
            imgReturn.image = selectedImage
        }
    }
    
    @IBAction func oneWayButtonPressed(_ sender: Any) {
        VietjetDataManager.shared.isOneWay = true
        vToDate.isHidden = true
        setRadioButton()
        setDateLabel()
    }
    
    @IBAction func returnButtonPressed(_ sender: Any) {
        VietjetDataManager.shared.isOneWay = false
        VietjetDataManager.shared.selectedLastDate = nil
        vToDate.isHidden = false
        setRadioButton()
        setDateLabel()
    }
    
    @IBAction func fromButtonPressed(_ sender: Any) {
        let vc = SearchVietjetFlightViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func fromDateButtonPressed(_ sender: Any) {
        let vc = SelectVietjetFlightDateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toButtonPressed(_ sender: Any) {
        let vc = SearchVietjetFlightViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toDateButtonPressed(_ sender: Any) {
        let vc = SelectVietjetFlightDateViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func passengerButtonPressed(_ sender: Any) {
        lbAdult.text = "\(editingAdultCount)"
        lbChild.text = "\(editingChildCount)"
        lbInfant.text = "\(editingInfantCount)"
        
        vBackground.isHidden = false
        vSelectPassenger.isHidden = false
    }
    
    @IBAction func addAdultButtonPressed(_ sender: Any) {
        let total = editingAdultCount + editingChildCount + editingInfantCount
        if total < 9 { editingAdultCount += 1 }
        lbAdult.text = "\(editingAdultCount)"
    }
    
    @IBAction func minusAdultButtonPressed(_ sender: Any) {
        var total = editingAdultCount + editingChildCount + editingInfantCount
        total -= 1
        if total != 0 && editingAdultCount - 1 >= 1 { editingAdultCount -= 1 }
        lbAdult.text = "\(editingAdultCount)"
    }
    
    @IBAction func addChildButtonPressed(_ sender: Any) {
        let total = editingAdultCount + editingChildCount + editingInfantCount
        if total < 9 { editingChildCount += 1 }
        lbChild.text = "\(editingChildCount)"
    }
    
    @IBAction func minusChildButtonPressed(_ sender: Any) {
        var total = editingAdultCount + editingChildCount + editingInfantCount
        total -= 1
        if total != 0 && editingChildCount - 1 >= 0 { editingChildCount -= 1 }
        lbChild.text = "\(editingChildCount)"
    }
    
    @IBAction func addInfantButtonPressed(_ sender: Any) {
        let total = editingAdultCount + editingChildCount + editingInfantCount
        if editingAdultCount > editingInfantCount && total < 9 { editingInfantCount += 1 }
        lbInfant.text = "\(editingInfantCount)"
    }
    
    @IBAction func minusInfantButtonPressed(_ sender: Any) {
        var total = editingAdultCount + editingChildCount + editingInfantCount
        total -= 1
        if total != 0 && editingInfantCount - 1 >= 0 { editingInfantCount -= 1 }
        lbInfant.text = "\(editingInfantCount)"
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        VietjetDataManager.shared.adultCount = editingAdultCount
        VietjetDataManager.shared.childCount = editingChildCount
        VietjetDataManager.shared.infantCount = editingInfantCount
        
        vBackground.isHidden = true
        vSelectPassenger.isHidden = true
        
        setPassengerLabel()
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        editingAdultCount = VietjetDataManager.shared.adultCount
        editingChildCount = VietjetDataManager.shared.childCount
        editingInfantCount = VietjetDataManager.shared.infantCount
        
        vBackground.isHidden = true
        vSelectPassenger.isHidden = true
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if VietjetDataManager.shared.selectedDepartureCity.name.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn điểm khởi hành", titleButton: "OK")
            return
        }
        
        if VietjetDataManager.shared.selectedLastDate == nil && !VietjetDataManager.shared.isOneWay {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn ngày về", titleButton: "OK")
            return
        }
        
        let vc = SelectVietjetFlightViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        let vc = VietjetPaymentHistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
