//
//  VietjetInsuranceViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 04/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetInsuranceViewController: UIViewController {
    
    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet weak var tbvInsurance: UITableView!
    @IBOutlet weak var vConfirm: UIView!
    @IBOutlet weak var lbInsurancePrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!

    private var selectedIndexes: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VietjetDataManager.shared.prepareParam()
        setupUI()
        setupTableView()
        loadData()
        setupData()
    }
    
    private func setupUI() {
        title = "Chọn gói bảo hiểm"
        addBackButton()
        
        vPrice.roundCorners(.allCorners, radius: 20)
        vConfirm.roundCorners(.allCorners, radius: 10)
        btnConfirm.roundCorners(.allCorners, radius: 25/2)
        vConfirm.isHidden = true
        
        setupHeaderView()
    }
    
    private func setupTableView() {
        tbvInsurance.registerTableCell(VietjetInsuranceTableViewCell.self)
        tbvInsurance.estimatedRowHeight = 100
        tbvInsurance.rowHeight = UITableView.automaticDimension
        tbvInsurance.contentInset.bottom = 100
    }
    
    private func loadData() {
        guard VietjetDataManager.shared.insurances.isEmpty else { return }
        Provider.shared.vietjetAPIService.getInsuranceOptions(param: VietjetDataManager.shared.orderParam, success: { [weak self] data in
            guard let self = self else { return }
            VietjetDataManager.shared.insurances = data
            self.setupData()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func setupData() {
        for (index, insurance) in VietjetDataManager.shared.insurances.enumerated() {
            if VietjetDataManager.shared.selectedInsurance.contains(where: { $0.purchaseKey == insurance.purchaseKey }) {
                selectedIndexes.append(index)
            }
        }
        
        tbvInsurance.reloadData()
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
        
        var price = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT + VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
        for p in VietjetDataManager.shared.selectedDepartureBaggages {
            price += p.ancillaryCharge.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedReturnBaggages {
            price += p.ancillaryCharge.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedDepartureSeats {
            price += p.seatCharges.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedReturnSeats {
            price += p.seatCharges.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedInsurance {
            price += p.totalAmountFRT
        }
        lbPrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        
        imgDown.isHidden = price == 0
    }
    
    private func setupConfirmView() {
        var price = 0
        for i in selectedIndexes {
            price += VietjetDataManager.shared.insurances[i].totalAmountFRT
        }
        
        lbInsurancePrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        vConfirm.isHidden = false
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        var insurances: [VietjetInsurance] = []
        for i in selectedIndexes {
            insurances.append(VietjetDataManager.shared.insurances[i])
        }
        
        VietjetDataManager.shared.selectedInsurance = insurances
        setupHeaderView()
        vConfirm.isHidden = true
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

extension VietjetInsuranceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VietjetDataManager.shared.insurances.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetInsuranceTableViewCell.self)
        cell.setupCell(VietjetDataManager.shared.insurances[indexPath.row], isSelected: selectedIndexes.contains(indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndexes.contains(indexPath.row) {
            selectedIndexes.removeAll(where: { $0 == indexPath.row })
        } else {
            selectedIndexes.append(indexPath.row)
        }
        
        setupConfirmView()
        tbvInsurance.reloadData()
    }
}
