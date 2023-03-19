//
//  PriceDetailPopupViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 10/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PriceDetailPopupViewController: UIViewController {

    @IBOutlet weak var vReturn: UIView!
    @IBOutlet weak var vInsurance: UIView!
    @IBOutlet weak var vDepartureDetail: UIView!
    @IBOutlet weak var vReturnDetail: UIView!
    @IBOutlet weak var vInsuranceDetail: UIView!
    @IBOutlet weak var vDepartureServices: UIView!
    @IBOutlet weak var vReturnServices: UIView!
    
    @IBOutlet weak var lbFromDepartmentCode: UILabel!
    @IBOutlet weak var lbFromDepartmentCity: UILabel!
    @IBOutlet weak var lbFromDepartmentTime: UILabel!
    @IBOutlet weak var lbFromTime: UILabel!
    @IBOutlet weak var lbFromReturnCode: UILabel!
    @IBOutlet weak var lbFromReturnCity: UILabel!
    @IBOutlet weak var lbFromReturnTime: UILabel!
    @IBOutlet weak var tbvFromDetail: UITableView!
    @IBOutlet weak var cstFromDetail: NSLayoutConstraint!
    @IBOutlet weak var lbFromBaggages: UILabel!
    @IBOutlet weak var lbFromSeats: UILabel!
    @IBOutlet weak var lbFromPrice: UILabel!
    
    @IBOutlet weak var lbToDepartmentCode: UILabel!
    @IBOutlet weak var lbToDepartmentCity: UILabel!
    @IBOutlet weak var lbToDepartmentTime: UILabel!
    @IBOutlet weak var lbToTime: UILabel!
    @IBOutlet weak var lbToReturnCode: UILabel!
    @IBOutlet weak var lbToReturnCity: UILabel!
    @IBOutlet weak var lbToReturnTime: UILabel!
    @IBOutlet weak var tbvToDetail: UITableView!
    @IBOutlet weak var cstToDetail: NSLayoutConstraint!
    @IBOutlet weak var lbToBaggages: UILabel!
    @IBOutlet weak var lbToSeats: UILabel!
    @IBOutlet weak var lbToPrice: UILabel!
    
    @IBOutlet weak var tbvInsurance: UITableView!
    @IBOutlet weak var cstInsurance: NSLayoutConstraint!
    @IBOutlet weak var lbInsurancePrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDepartureUI()
        setupReturnUI()
        setupInsuranceUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vDepartureDetail.roundCorners(.allCorners, radius: 6)
        vReturnDetail.roundCorners(.allCorners, radius: 6)
        vInsuranceDetail.roundCorners(.allCorners, radius: 6)
    }
    
    private func setupTableView() {
        tbvFromDetail.registerTableCell(FareDetailTableViewCell.self)
        tbvToDetail.registerTableCell(FareDetailTableViewCell.self)
        tbvInsurance.registerTableCell(FareDetailTableViewCell.self)
        
        tbvFromDetail.rowHeight = 66
        tbvToDetail.rowHeight = 66
        tbvInsurance.rowHeight = 65
        
        cstFromDetail.constant = CGFloat((VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeFareOption.fareChargeDetails.count : VietjetDataManager.shared.selectedDepartureFareOption.fareChargeDetails.count) * 66)
        cstToDetail.constant = CGFloat(VietjetDataManager.shared.selectedReturnFareOption.fareChargeDetails.count * 66)
        cstInsurance.constant = CGFloat(VietjetDataManager.shared.selectedInsurance.count * 65)
    }
    
    private func setupDepartureUI() {
        lbFromDepartmentCode.text = VietjetDataManager.shared.selectedDepartureCity.code
        lbFromDepartmentCity.text = VietjetDataManager.shared.selectedDepartureCity.name
        lbFromDepartmentTime.text = VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeTravel.departureTime : VietjetDataManager.shared.selectedDepartureTravel.departureTime
        lbFromTime.text = VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeTravel.totalTime : VietjetDataManager.shared.selectedDepartureTravel.totalTime
        lbFromReturnCode.text = VietjetDataManager.shared.selectedArrivalCity.code
        lbFromReturnCity.text = VietjetDataManager.shared.selectedArrivalCity.name
        lbFromReturnTime.text = VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeTravel.cityPair.arrival.hours : VietjetDataManager.shared.selectedDepartureTravel.cityPair.arrival.hours
        
        let ticketPrice = VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeFareOption.totalAmountFRT : VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT
        var baggagePrice = 0
        for p in VietjetDataManager.shared.selectedDepartureBaggages {
            baggagePrice += p.ancillaryCharge.totalAmountFRT
        }
        var seatPrice = 0
        for p in VietjetDataManager.shared.selectedDepartureSeats {
            seatPrice += p.seatCharges.totalAmountFRT
        }
        
        if VietjetDataManager.shared.selectedDepartureBaggages.isEmpty && VietjetDataManager.shared.selectedDepartureSeats.isEmpty {
            vDepartureServices.isHidden = true
        } else {
            vDepartureServices.isHidden = false
        }
        
        lbFromBaggages.text = "\(Common.convertCurrencyV2(value: baggagePrice)) VNĐ"
        lbFromSeats.text = "\(Common.convertCurrencyV2(value: seatPrice)) VNĐ"
        lbFromPrice.text = "\(Common.convertCurrencyV2(value: ticketPrice + baggagePrice + seatPrice)) VNĐ"
    }
    
    private func setupReturnUI() {
        vReturn.isHidden = VietjetDataManager.shared.selectedReturnFareOption.bookingKey.isEmpty
        
        lbToDepartmentCode.text = VietjetDataManager.shared.selectedArrivalCity.code
        lbToDepartmentCity.text = VietjetDataManager.shared.selectedArrivalCity.name
        lbToDepartmentTime.text = VietjetDataManager.shared.selectedReturnTravel.departureTime
        lbToTime.text = VietjetDataManager.shared.selectedReturnTravel.totalTime
        lbToReturnCode.text = VietjetDataManager.shared.selectedDepartureCity.code
        lbToReturnCity.text = VietjetDataManager.shared.selectedDepartureCity.name
        lbToReturnTime.text = VietjetDataManager.shared.selectedReturnTravel.cityPair.arrival.hours
        
        let ticketPrice = VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
        var baggagePrice = 0
        for p in VietjetDataManager.shared.selectedReturnBaggages {
            baggagePrice += p.ancillaryCharge.totalAmountFRT
        }
        var seatPrice = 0
        for p in VietjetDataManager.shared.selectedReturnSeats {
            seatPrice += p.seatCharges.totalAmountFRT
        }
        
        if VietjetDataManager.shared.selectedReturnBaggages.isEmpty && VietjetDataManager.shared.selectedReturnSeats.isEmpty {
            vReturnServices.isHidden = true
        } else {
            vReturnServices.isHidden = false
        }
        
        lbToBaggages.text = "\(Common.convertCurrencyV2(value: baggagePrice)) VNĐ"
        lbToSeats.text = "\(Common.convertCurrencyV2(value: seatPrice)) VNĐ"
        lbToPrice.text = "\(Common.convertCurrencyV2(value: ticketPrice + baggagePrice + seatPrice)) VNĐ"
    }
    
    private func setupInsuranceUI() {
        vInsurance.isHidden = VietjetDataManager.shared.selectedInsurance.count == 0
        
        var insurancePrice = 0
        for p in VietjetDataManager.shared.selectedInsurance {
            insurancePrice += p.totalAmountFRT
        }
        
        lbInsurancePrice.text = "\(Common.convertCurrencyV2(value: insurancePrice)) VNĐ"
    }
    
    @IBAction func collapseButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PriceDetailPopupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvFromDetail:
            return VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeFareOption.fareChargeDetails.count : VietjetDataManager.shared.selectedDepartureFareOption.fareChargeDetails.count
        case tbvToDetail:
            return VietjetDataManager.shared.selectedReturnFareOption.fareChargeDetails.count
        case tbvInsurance:
            return VietjetDataManager.shared.selectedInsurance.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(FareDetailTableViewCell.self)
        
        switch tableView {
        case tbvFromDetail:
            cell.setupCell(VietjetDataManager.shared.isChangeFlight ? VietjetDataManager.shared.selectedChangeFareOption.fareChargeDetails[indexPath.row] : VietjetDataManager.shared.selectedDepartureFareOption.fareChargeDetails[indexPath.row])
            return cell
        case tbvToDetail:
            cell.setupCell(VietjetDataManager.shared.selectedReturnFareOption.fareChargeDetails[indexPath.row])
            return cell
        case tbvInsurance:
            cell.lbName.text = VietjetDataManager.shared.selectedInsurance[indexPath.row].name
            cell.lbPrice.text = "\(Common.convertCurrencyV2(value: VietjetDataManager.shared.selectedInsurance[indexPath.row].totalAmountFRT)) VNĐ"
            cell.lbCount.text = "x1"
            return cell
        default:
            return UITableViewCell()
        }
    }
}
