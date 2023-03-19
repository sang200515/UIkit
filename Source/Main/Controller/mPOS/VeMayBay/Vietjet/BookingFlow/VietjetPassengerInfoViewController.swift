//
//  VietjetPassengerInfoViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetPassengerInfoViewController: UIViewController {
    
    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet weak var tbvPassenger: UITableView!
    @IBOutlet weak var cstPassengerHeight: NSLayoutConstraint!
    @IBOutlet weak var tbvContact: UITableView!
    @IBOutlet weak var cstContactHeight: NSLayoutConstraint!
    @IBOutlet weak var btnContinue: UIButton!
    
    private var isExpand: [Bool] = []
    private var totalPassenger: Int = 0
    private var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupTableView()
    }
    
    private func setupUI() {
        title = "Thông tin khách hàng"
        addBackButton()
        
        vPrice.roundCorners(.allCorners, radius: 20)
        btnContinue.roundCorners(.allCorners, radius: 5)
        
        setupHeaderView()
    }
    
    private func setupData() {
        dateFormatter.dateFormat = "dd-MM-yyyy"
        totalPassenger = VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount
        isExpand = [Bool](repeating: true, count: totalPassenger + 1)
        VietjetDataManager.shared.passengers = []
        
        for _ in 0..<VietjetDataManager.shared.adultCount {
            let passenger = VietjetPassenger(JSON: [:])!
            passenger.fareApplicability.adult = true
            passenger.fareApplicability.child = false
            VietjetDataManager.shared.passengers.append(passenger)
        }
        for _ in VietjetDataManager.shared.adultCount..<(VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount) {
            let passenger = VietjetPassenger(JSON: [:])!
            passenger.fareApplicability.adult = false
            passenger.fareApplicability.child = true
            VietjetDataManager.shared.passengers.append(passenger)
        }
        for i in 0..<VietjetDataManager.shared.infantCount {
            let passenger = VietjetDataManager.shared.passengers[i]
            let infant = VietjetInfantProfile(JSON: [:])!
            passenger.infantProfile = infant
            VietjetDataManager.shared.passengers[i] = passenger
        }
        
        VietjetDataManager.shared.contact = VietjetContact(JSON: [:])!
    }
    
    private func setupTableView() {
        tbvPassenger.registerTableCell(VietjetPassengerTableViewCell.self)
        tbvContact.registerTableCell(VietjetPassengerTableViewCell.self)
        
        tbvContact.performBatchUpdates(nil, completion: { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.cstContactHeight.constant = self.tbvContact.contentSize.height
            })
        })
        
        tbvPassenger.performBatchUpdates(nil, completion: { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self.cstPassengerHeight.constant = self.tbvPassenger.contentSize.height
            })
        })
    }
    
    private func setupHeaderView() {
        var passenger = ""
        if VietjetDataManager.shared.adultCount > 0 { passenger += "\(VietjetDataManager.shared.adultCount) Người lớn, " }
        if VietjetDataManager.shared.childCount > 0 { passenger += "\(VietjetDataManager.shared.childCount) Trẻ em, " }
        if VietjetDataManager.shared.infantCount > 0 { passenger += "\(VietjetDataManager.shared.infantCount) Em bé, " }
        
        if passenger.last == " " {
            passenger.removeLast()
            passenger.removeLast()
        }
        
        lbFlightInfo.text = "\(VietjetDataManager.shared.isOneWay ? "Một chiều" : "Hai chiều"): \(passenger)"
        lbFrom.text = "\(VietjetDataManager.shared.selectedDepartureCity.name) (\(VietjetDataManager.shared.selectedDepartureCity.code))"
        lbTo.text = "\(VietjetDataManager.shared.selectedArrivalCity.name) (\(VietjetDataManager.shared.selectedArrivalCity.code))"
        
        let price = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT + VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
        lbPrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        
        imgDown.isHidden = price == 0
    }
    
    private func checkAdult(_ index: Int) -> Bool {
        if VietjetDataManager.shared.passengers[index - 1].reservationProfile.firstName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Tên đệm và tên của Người lớn \(index)", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.passengers[index - 1].reservationProfile.lastName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Họ của Người lớn \(index)", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.passengers[index - 1].reservationProfile.birthDate.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Ngày sinh của Người lớn \(index)", titleButton: "OK")
            return false
        }
        
        if VietjetDataManager.shared.passengers[index - 1].reservationProfile.birthDate.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Ngày sinh của Người lớn \(index)", titleButton: "OK")
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[index - 1].reservationProfile.birthDate)
        let maxYear = Calendar.current.date(byAdding: .year, value: -267, to: Date()) ?? Date()
        let minYear = Calendar.current.date(byAdding: .year, value: -12, to: Date()) ?? Date()
        if dob == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[index - 1].reservationProfile.birthDate)
            if dob == nil {
                showAlertOneButton(title: "Thông báo", with: "Bạn đã nhập thông tin Ngày sinh của Người lớn \(index) không chính xác. Vui lòng kiểm tra lại", titleButton: "OK")
                return false
            }
        }
        
        if dob! > minYear {
            showAlertOneButton(title: "Thông báo", with: "Ngày sinh của Người lớn \(index) phải lớn hơn hoặc bằng 12 tuổi", titleButton: "OK")
            return false
        }
        
        if dob! <= maxYear {
            showAlertOneButton(title: "Thông báo", with: "Ngày sinh của Người lớn \(index) quá lớn. Vui lòng kiểm tra lại", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func checkChild(_ index: Int) -> Bool {
        let childIndex = VietjetDataManager.shared.adultCount + index - 1
        if VietjetDataManager.shared.passengers[childIndex].reservationProfile.firstName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Tên đệm và tên của Trẻ em \(index)", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.passengers[childIndex].reservationProfile.lastName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Họ của Trẻ em \(index)", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.passengers[childIndex].reservationProfile.birthDate.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Ngày sinh của Trẻ em \(index)", titleButton: "OK")
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[childIndex].reservationProfile.birthDate)
        let maxYear = Calendar.current.date(byAdding: .year, value: -12, to: Date()) ?? Date()
        let minYear = Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date()
        if dob == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[childIndex].reservationProfile.birthDate)
            if dob == nil {
                showAlertOneButton(title: "Thông báo", with: "Bạn đã nhập thông tin Ngày sinh của Trẻ em \(index) không chính xác. Vui lòng kiểm tra lại", titleButton: "OK")
                return false
            }
        }
        
        if dob! > minYear || dob! <= maxYear {
            showAlertOneButton(title: "Thông báo", with: "Ngày sinh của Trẻ em \(index) phải lớn hơn hoặc bằng 2 tuổi và nhỏ hơn 11 tuổi", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func checkInfant(_ index: Int) -> Bool {
        if VietjetDataManager.shared.passengers[index - 1].infantProfile!.firstName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Tên đệm và tên của Em bé \(index)", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.passengers[index - 1].infantProfile!.lastName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Họ của Em bé \(index)", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.passengers[index - 1].infantProfile!.birthDate.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Ngày sinh của Em bé \(index)", titleButton: "OK")
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[index - 1].infantProfile!.birthDate)
        let maxYear = Calendar.current.date(byAdding: .year, value: -2, to: Date()) ?? Date()
        let minYear = Date()
        if dob == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            dob = dateFormatter.date(from: VietjetDataManager.shared.passengers[index - 1].infantProfile!.birthDate)
            if dob == nil {
                showAlertOneButton(title: "Thông báo", with: "Bạn đã nhập thông tin Ngày sinh của Em bé \(index) không chính xác. Vui lòng kiểm tra lại", titleButton: "OK")
                return false
            }
        }
        
        if dob! > minYear || dob! <= maxYear {
            showAlertOneButton(title: "Thông báo", with: "Ngày sinh của Em bé \(index) phải nhỏ hơn 24 tháng tuổi", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func checkContact() -> Bool {
        if VietjetDataManager.shared.contact.fullName.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Họ và tên của người liên hệ", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.contact.phoneNumber.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT của người liên hệ", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.contact.phoneNumber.count != 10 && VietjetDataManager.shared.contact.phoneNumber.count != 11 {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin SĐT 10 hoặc 11 chữ số", titleButton: "OK")
            return false
        }
        if VietjetDataManager.shared.contact.email.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Email của người liên hệ", titleButton: "OK")
            return false
        }
        if !VietjetDataManager.shared.contact.email.isValidEmail() {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng nhập thông tin Email hợp lệ", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        for i in 0..<VietjetDataManager.shared.adultCount {
            guard checkAdult(i + 1) else { return }
        }
        for i in 0..<VietjetDataManager.shared.childCount {
            guard checkChild(i + 1) else { return }
        }
        for i in 0..<VietjetDataManager.shared.infantCount {
            guard checkInfant(i + 1) else { return }
        }
        guard checkContact() else { return }
        
        let vc = VietjetServicesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func showPriceDetailButtonPressed(_ sender: Any) {
        if !imgDown.isHidden {
            let vc = PriceDetailPopupViewController()
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        }
    }
}

extension VietjetPassengerInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvPassenger:
            return VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvPassenger:
            let cell = tableView.dequeueTableCell(VietjetPassengerTableViewCell.self)
            cell.selectionStyle = .none
            cell.tag = indexPath.row
            var index: Int = 0
            
            if indexPath.row < VietjetDataManager.shared.adultCount {
                index = indexPath.row + 1
                cell.setupCell(type: .adult, isExpand: isExpand[indexPath.row], index: index)
            } else if indexPath.row < VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount {
                index = indexPath.row - VietjetDataManager.shared.adultCount + 1
                cell.setupCell(type: .child, isExpand: isExpand[indexPath.row], index: index)
            } else {
                index = indexPath.row - (VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount) + 1
                cell.setupCell(type: .infant, isExpand: isExpand[indexPath.row], index: index)
            }
            
            cell.didExpand = {
                if !self.isExpand[indexPath.row] {
                    self.isExpand[indexPath.row] = !self.isExpand[indexPath.row]
                } else {
                    return
                    //                    if indexPath.row < VietjetDataManager.shared.adultCount {
                    //                        if self.checkAdult(index) {
                    //                            self.isExpand[indexPath.row] = !self.isExpand[indexPath.row]
                    //                        }
                    //                    } else if indexPath.row < VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount {
                    //                        if self.checkChild(index) {
                    //                            self.isExpand[indexPath.row] = !self.isExpand[indexPath.row]
                    //                        }
                    //                    } else {
                    //                        if self.checkInfant(index) {
                    //                            self.isExpand[indexPath.row] = !self.isExpand[indexPath.row]
                    //                        }
                    //                    }
                }
                
                self.tbvPassenger.reloadData()
                self.tbvPassenger.performBatchUpdates(nil, completion: { result in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        self.cstPassengerHeight.constant = self.tbvPassenger.contentSize.height
                    })
                })
            }
            return cell
        default:
            let cell = tableView.dequeueTableCell(VietjetPassengerTableViewCell.self)
            cell.selectionStyle = .none
            cell.setupCell(type: .contact, isExpand: isExpand.last!)
            cell.didExpand = {
                if !self.isExpand[self.isExpand.count - 1] {
                    self.isExpand[self.isExpand.count - 1] = !self.isExpand[self.isExpand.count - 1]
                } else {
                    if self.checkContact() {
                        self.isExpand[self.isExpand.count - 1] = !self.isExpand[self.isExpand.count - 1]
                    } else {
                        return
                    }
                }
                
                self.tbvContact.reloadData()
                self.tbvContact.performBatchUpdates(nil, completion: { result in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                        self.cstContactHeight.constant = self.tbvContact.contentSize.height
                    })
                })
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case tbvPassenger:
            if indexPath.row < VietjetDataManager.shared.adultCount {
                if isExpand[indexPath.row] {
                    return 84 + (65 * 5) + (15 * 5)
                } else {
                    return 84
                }
            } else {
                if isExpand[indexPath.row] {
                    return 84 + (65 * 4) + (15 * 4)
                } else {
                    return 84
                }
            }
        default:
            if isExpand.last! {
                return 84 + (65 * 5) + (15 * 5)
            } else {
                return 84
            }
        }
    }
}
