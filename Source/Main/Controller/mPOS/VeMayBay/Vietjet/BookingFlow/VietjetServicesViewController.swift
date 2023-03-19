//
//  VietjetServicesViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetServicesViewController: UIViewController {

    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet weak var vInsurance: UIView!
    @IBOutlet weak var vLuggage: UIView!
    @IBOutlet weak var vSeat: UIView!
    @IBOutlet weak var btnContinue: UIButton!
    
    //MARK:- Baggage
    @IBOutlet weak var stvDeparture: UIStackView!
    @IBOutlet weak var lbDeparture: UILabel!
    @IBOutlet weak var lbDepartureBaggage: UILabel!
    @IBOutlet weak var tbvDepartureBaggage: UITableView!
    @IBOutlet weak var cstDepartureBagage: NSLayoutConstraint!
    @IBOutlet weak var stvReturn: UIStackView!
    @IBOutlet weak var lbReturn: UILabel!
    @IBOutlet weak var lbReturnBaggage: UILabel!
    @IBOutlet weak var tbvReturnBagage: UITableView!
    @IBOutlet weak var cstReturnBagage: NSLayoutConstraint!
    @IBOutlet weak var lbBagagePrice: UILabel!
    
    //MARK:- Seat
    @IBOutlet weak var lbDepartureSeat: UILabel!
    @IBOutlet weak var tbvDepartureSeat: UITableView!
    @IBOutlet weak var cstDepartureSeat: NSLayoutConstraint!
    @IBOutlet weak var lbReturnSeat: UILabel!
    @IBOutlet weak var tbvReturnSeat: UITableView!
    @IBOutlet weak var cstReturnSeat: NSLayoutConstraint!
    @IBOutlet weak var lbSeatPrice: UILabel!
    
    //MARK:- Insurance
    @IBOutlet weak var tbvInsurance: UITableView!
    @IBOutlet weak var cstInsurance: NSLayoutConstraint!
    @IBOutlet weak var lbInsurancePrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupHeaderView()
        setupServices()
    }
    
    private func setupUI() {
        title = "Dịch vụ thêm"
        addBackButton()
        
        vPrice.roundCorners(.allCorners, radius: 20)
        btnContinue.roundCorners(.allCorners, radius: 5)
    }
    
    private func setupTableView() {
        tbvDepartureBaggage.registerTableCell(VietjetServiceTableViewCell.self)
        tbvReturnBagage.registerTableCell(VietjetServiceTableViewCell.self)
        tbvDepartureSeat.registerTableCell(VietjetServiceTableViewCell.self)
        tbvReturnSeat.registerTableCell(VietjetServiceTableViewCell.self)
        tbvInsurance.registerTableCell(VietjetServiceTableViewCell.self)
    }
    
    private func setupServices() {
        // MARK:- Baggage
        if VietjetDataManager.shared.selectedDepartureBaggages.filter({ !$0.purchaseKey.isEmpty }).isEmpty {
            stvDeparture.isHidden = true
            tbvDepartureBaggage.isHidden = true
        } else {
            stvDeparture.isHidden = false
            tbvDepartureBaggage.isHidden = false
            
            lbDeparture.text = "\(VietjetDataManager.shared.selectedDepartureCity.code) - \(VietjetDataManager.shared.selectedArrivalCity.code)"
            lbDepartureBaggage.text = "| Thêm \(VietjetDataManager.shared.selectedDepartureBaggages.filter({ !$0.purchaseKey.isEmpty }).count) gói hành lý"
            
            tbvDepartureBaggage.reloadData()
            cstDepartureBagage.constant = CGFloat(20 * VietjetDataManager.shared.selectedDepartureBaggages.filter({ !$0.purchaseKey.isEmpty }).count)
        }
        
        if VietjetDataManager.shared.selectedReturnBaggages.filter({ !$0.purchaseKey.isEmpty }).isEmpty {
            stvReturn.isHidden = true
            tbvReturnBagage.isHidden = true
        } else {
            stvReturn.isHidden = false
            tbvReturnBagage.isHidden = false
            
            lbReturn.text = "\(VietjetDataManager.shared.selectedArrivalCity.code) - \(VietjetDataManager.shared.selectedDepartureCity.code)"
            lbReturnBaggage.text = "| Thêm \(VietjetDataManager.shared.selectedReturnBaggages.filter({ !$0.purchaseKey.isEmpty }).count) gói hành lý"
            
            tbvReturnBagage.reloadData()
            cstReturnBagage.constant = CGFloat(20 * VietjetDataManager.shared.selectedReturnBaggages.filter({ !$0.purchaseKey.isEmpty }).count)
        }
        
        if VietjetDataManager.shared.selectedDepartureBaggages.filter({ !$0.purchaseKey.isEmpty }).isEmpty && VietjetDataManager.shared.selectedReturnBaggages.filter({ !$0.purchaseKey.isEmpty }).isEmpty {
            lbBagagePrice.isHidden = true
        } else {
            lbBagagePrice.isHidden = false
            var price = 0
            for p in VietjetDataManager.shared.selectedDepartureBaggages {
                price += p.ancillaryCharge.totalAmountFRT
            }
            for p in VietjetDataManager.shared.selectedReturnBaggages {
                price += p.ancillaryCharge.totalAmountFRT
            }
            lbBagagePrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        }
        
        // MARK:- Seat
        if VietjetDataManager.shared.selectedDepartureSeats.filter({ !$0.selectionKey.isEmpty }).isEmpty {
            lbDepartureSeat.isHidden = true
            tbvDepartureSeat.isHidden = true
        } else {
            lbDepartureSeat.isHidden = false
            tbvDepartureSeat.isHidden = false
            
            lbDepartureSeat.text = "\(VietjetDataManager.shared.selectedDepartureCity.code) - \(VietjetDataManager.shared.selectedArrivalCity.code)"
            
            tbvDepartureSeat.reloadData()
            cstDepartureSeat.constant = CGFloat(20 * VietjetDataManager.shared.selectedDepartureSeats.filter({ !$0.selectionKey.isEmpty }).count)
        }
        
        if VietjetDataManager.shared.selectedReturnSeats.filter({ !$0.selectionKey.isEmpty }).isEmpty {
            lbReturnSeat.isHidden = true
            tbvReturnSeat.isHidden = true
        } else {
            lbReturnSeat.isHidden = false
            tbvReturnSeat.isHidden = false
            
            lbReturnSeat.text = "\(VietjetDataManager.shared.selectedArrivalCity.code) - \(VietjetDataManager.shared.selectedDepartureCity.code)"
            
            tbvReturnSeat.reloadData()
            cstReturnSeat.constant = CGFloat(20 * VietjetDataManager.shared.selectedReturnSeats.filter({ !$0.selectionKey.isEmpty }).count)
        }
        
        if VietjetDataManager.shared.selectedDepartureSeats.filter({ !$0.selectionKey.isEmpty }).isEmpty && VietjetDataManager.shared.selectedReturnSeats.filter({ !$0.selectionKey.isEmpty }).isEmpty {
            lbSeatPrice.isHidden = true
        } else {
            lbSeatPrice.isHidden = false
            var price = 0
            for p in VietjetDataManager.shared.selectedDepartureSeats {
                price += p.seatCharges.totalAmountFRT
            }
            for p in VietjetDataManager.shared.selectedReturnSeats {
                price += p.seatCharges.totalAmountFRT
            }
            lbSeatPrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        }
        
        if VietjetDataManager.shared.selectedInsurance.filter({ !$0.purchaseKey.isEmpty }).isEmpty {
            tbvInsurance.isHidden = true
            lbInsurancePrice.isHidden = true
        } else {
            tbvInsurance.isHidden = false
            lbInsurancePrice.isHidden = false
            
            var price = 0
            for p in VietjetDataManager.shared.selectedInsurance {
                price += p.totalAmountFRT
            }
            lbInsurancePrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
            tbvInsurance.reloadData()
            cstInsurance.constant = CGFloat(20 * VietjetDataManager.shared.selectedInsurance.count )
        }
        
        vLuggage.roundCorners(.allCorners, radius: 10)
        vInsurance.roundCorners(.allCorners, radius: 10)
        vSeat.roundCorners(.allCorners, radius: 10)
    }
    
    private func setupData() {
        // MARK:- Baggage
        VietjetDataManager.shared.choosenDepartureBaggages = [VietjetBaggage](repeating: VietjetBaggage(JSON: [:])!, count: VietjetDataManager.shared.passengers.count)
        VietjetDataManager.shared.choosenReturnBaggages = [VietjetBaggage](repeating: VietjetBaggage(JSON: [:])!, count: VietjetDataManager.shared.passengers.count)
        VietjetDataManager.shared.selectedDepartureBaggages = [VietjetBaggage](repeating: VietjetBaggage(JSON: [:])!, count: VietjetDataManager.shared.passengers.count)
        VietjetDataManager.shared.selectedReturnBaggages = [VietjetBaggage](repeating: VietjetBaggage(JSON: [:])!, count: VietjetDataManager.shared.passengers.count)
        VietjetDataManager.shared.departureBaggages = []
        VietjetDataManager.shared.returnBaggages = []
        
        VietjetDataManager.shared.selectedDepartureSeats = [VietjetSeatOption](repeating: VietjetSeatOption(JSON: [:])!, count: VietjetDataManager.shared.passengers.count)
        VietjetDataManager.shared.selectedReturnSeats = [VietjetSeatOption](repeating: VietjetSeatOption(JSON: [:])!, count: VietjetDataManager.shared.passengers.count)
        VietjetDataManager.shared.departureSeat = VietjetSeat(JSON: [:])!
        VietjetDataManager.shared.returnSeat = VietjetSeat(JSON: [:])!
        VietjetDataManager.shared.insurances = []
        VietjetDataManager.shared.selectedInsurance = []
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
    
    @IBAction func insuranceButtonPressed(_ sender: Any) {
        let vc = VietjetInsuranceViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func luggageButtonPressed(_ sender: Any) {
        let vc = VietjetLuggageViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func seatButtonPressed(_ sender: Any) {
        let vc = VietjetSeatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        let vc = PreviewVietjetBookingViewController()
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

extension VietjetServicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvDepartureBaggage:
            return VietjetDataManager.shared.selectedDepartureBaggages.filter({ !$0.purchaseKey.isEmpty }).count
        case tbvReturnBagage:
            return VietjetDataManager.shared.selectedReturnBaggages.filter({ !$0.purchaseKey.isEmpty }).count
        case tbvDepartureSeat:
            return VietjetDataManager.shared.selectedDepartureSeats.filter({ !$0.selectionKey.isEmpty }).count
        case tbvReturnSeat:
            return VietjetDataManager.shared.selectedReturnSeats.filter({ !$0.selectionKey.isEmpty }).count
        case tbvInsurance:
            return VietjetDataManager.shared.selectedInsurance.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetServiceTableViewCell.self)
        
        switch tableView {
        case tbvDepartureBaggage:
            let baggage = VietjetDataManager.shared.selectedDepartureBaggages.filter({ !$0.purchaseKey.isEmpty })[indexPath.row]
            
            cell.setupCell(baggage.name)
            return cell
        case tbvReturnBagage:
            let baggage = VietjetDataManager.shared.selectedReturnBaggages.filter({ !$0.purchaseKey.isEmpty })[indexPath.row]
            
            cell.setupCell(baggage.name)
            return cell
        case tbvDepartureSeat:
            let seat = VietjetDataManager.shared.selectedDepartureSeats.filter({ !$0.selectionKey.isEmpty })[indexPath.row]
            
            cell.setupCell("\(seat.seatMapCell.rowIdentifier)-\(seat.seatMapCell.seatIdentifier)")
            return cell
        case tbvReturnSeat:
            let seat = VietjetDataManager.shared.selectedReturnSeats.filter({ !$0.selectionKey.isEmpty })[indexPath.row]
            
            cell.setupCell("\(seat.seatMapCell.rowIdentifier)-\(seat.seatMapCell.seatIdentifier)")
            return cell
        case tbvInsurance:
            let insurance = VietjetDataManager.shared.selectedInsurance[indexPath.row]
            
            cell.setupCell(insurance.name)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 20
    }
}
