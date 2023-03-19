//
//  AddMoreServicesViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class AddMoreServicesViewController: UIViewController {
    
    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var vLuggage: UIView!
    @IBOutlet weak var vSeat: UIView!
    
    @IBOutlet weak var tbvFlight: UITableView!
    @IBOutlet weak var cstFlight: NSLayoutConstraint!
    @IBOutlet weak var tbvPassenger: UITableView!
    @IBOutlet weak var cstPassenger: NSLayoutConstraint!
    
    //MARK:- SERVICES DETAIL
    @IBOutlet weak var vServiceDetail: UIView!
    @IBOutlet weak var vServiceDetailPopup: UIView!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var vBaggages: UIStackView!
    @IBOutlet weak var vDepartureBaggages: UIStackView!
    @IBOutlet weak var vReturnBaggages: UIStackView!
    @IBOutlet var lbDepartureBaggages: [UILabel]!
    @IBOutlet var lbReturnBaggages: [UILabel]!
    @IBOutlet weak var stvSeat: UIStackView!
    @IBOutlet weak var vDepartureSeat: UIStackView!
    @IBOutlet weak var vReturnSeat: UIStackView!
    @IBOutlet weak var lbDepartureSeat: UILabel!
    @IBOutlet weak var lbReturnSeat: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    
    private var adult: [VietjetHistoryPassenger] = []
    private var child: [VietjetHistoryPassenger] = []
    private var infant: [VietjetHistoryPassenger] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.cstPassenger.constant = self.tbvPassenger.contentSize.height
        }
    }
    
    private func setupUI() {
        title = "Dịch vụ"
        addBackButton()
        
        vLuggage.roundCorners(.allCorners, radius: 10)
        vSeat.roundCorners(.allCorners, radius: 10)
        vServiceDetailPopup.roundCorners(.allCorners, radius: 6)
        btnOK.roundCorners(.allCorners, radius: 15)
        
        setupHeaderView()
    }
    
    private func setupTableView() {
        tbvFlight.registerTableCell(VietjetFlightInfoTableViewCell.self)
        tbvFlight.rowHeight = 235
        
        tbvPassenger.registerTableCell(VietjetPassengerInfoTableViewCell.self)
        tbvPassenger.estimatedRowHeight = 100
        tbvPassenger.rowHeight = UITableView.automaticDimension
        
        DispatchQueue.main.async {
            self.cstFlight.constant = CGFloat((VietjetDataManager.shared.historyBooking.arrival == nil ? 1 : 2) * 235)
            
            self.tbvPassenger.performBatchUpdates(nil, completion: { result in
                self.cstPassenger.constant = self.tbvPassenger.contentSize.height
            })
        }
    }
    
    private func setupHeaderView() {
        adult = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability == "adult" }
        child = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability == "child" }
        infant = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability == "infant" }
        
        var passenger = ""
        if adult.count > 0 { passenger += "\(adult.count) Người lớn, " }
        if child.count > 0 { passenger += "\(child.count) Trẻ em, " }
        if infant.count > 0 { passenger += "\(infant.count) Em bé, " }
        
        if passenger.last == " " {
            passenger.removeLast()
            passenger.removeLast()
        }
        
        lbFlightInfo.text = "\(VietjetDataManager.shared.historyBooking.arrival == nil ? "Một chiều" : "Hai chiều"): \(passenger)"
        lbFrom.text = "\(VietjetDataManager.shared.historyBooking.departure.cityPair.departure.name) (\(VietjetDataManager.shared.historyBooking.departure.cityPair.departure.code))"
        lbTo.text = "\(VietjetDataManager.shared.historyBooking.departure.cityPair.arrival.name) (\(VietjetDataManager.shared.historyBooking.departure.cityPair.arrival.code))"
    }
    
    private func setupData() {
        VietjetDataManager.shared.departureBaggages = []
        VietjetDataManager.shared.returnBaggages = []
        VietjetDataManager.shared.departureSeat = VietjetSeat(JSON: [:])!
        VietjetDataManager.shared.returnSeat = VietjetSeat(JSON: [:])!
    }
    
    @IBAction func luggageButtonPressed(_ sender: Any) {
        let passengers = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability != "infant" }
 
        let departureBaggages = passengers.filter { $0.departure.ancillaryPurchases == nil }
        var needAddMoreBaggage = departureBaggages.count
        if VietjetDataManager.shared.historyBooking.arrival != nil {
            let returnBaggages = passengers.filter { $0.arrival.ancillaryPurchases == nil }
            needAddMoreBaggage += returnBaggages.count
        }
        
        if needAddMoreBaggage > 0 {
            let vc = AddMoreLuggageViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlertOneButton(title: "Thông báo", with: "Tất cả các hành khách đã được mua hành lý", titleButton: "OK")
        }
    }
    
    @IBAction func seatButtonPressed(_ sender: Any) {
        let vc = AddMoreSeatViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func dismissPopupButtonPressed(_ sender: Any) {
        vServiceDetail.isHidden = true
    }
}

extension AddMoreServicesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvFlight:
            return VietjetDataManager.shared.historyBooking.arrival == nil ? 1 : 2
        default:
            return VietjetDataManager.shared.historyBooking.passengers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvFlight:
            let cell = tableView.dequeueTableCell(VietjetFlightInfoTableViewCell.self)
            cell.setupCell(indexPath.row == 0 ? VietjetDataManager.shared.historyBooking.departure : VietjetDataManager.shared.historyBooking.arrival!, isDeparture: indexPath.row == 0, code: VietjetDataManager.shared.historyBooking.locator)
            return cell
        default:
            let cell = tableView.dequeueTableCell(VietjetPassengerInfoTableViewCell.self)
            cell.vCMND.isHidden = true
            var index: Int = 0

            if indexPath.row < adult.count {
                index = indexPath.row + 1
                cell.lbTitle.text = "Người lớn \(index)"
                cell.lbName.text = adult[index - 1].lastName + " " + adult[index - 1].firstName
                cell.lbDOB.text = adult[index - 1].birthDate
                cell.lbGender.text = adult[index - 1].gender == "Male" ? "Nam" : "Nữ"
            } else if indexPath.row < adult.count + child.count {
                index = indexPath.row - (adult.count - 1)
                cell.lbTitle.text = "Trẻ em \(index)"
                cell.lbName.text = child[index - 1].lastName + " " + child[index - 1].firstName
                cell.lbDOB.text = child[index - 1].birthDate
                cell.lbGender.text = child[index - 1].gender == "Male" ? "Nam" : "Nữ"
            } else {
                index = indexPath.row - (adult.count + child.count - 1)
                cell.lbTitle.text = "Em bé \(index)"
                cell.lbName.text = infant[index - 1].lastName + " " + infant[index - 1].firstName
                cell.lbDOB.text = infant[index - 1].birthDate
                cell.lbGender.text = infant[index - 1].gender == "Male" ? "Nam" : "Nữ"
                cell.vServices.isHidden = true
            }
            
            cell.didPressShowServiceDetail = {
                if indexPath.row < self.adult.count {
                    self.lbCustomerName.text = self.adult[index - 1].lastName + " " + self.adult[index - 1].firstName
                    
                    if let ancillary = self.adult[index - 1].departure.ancillaryPurchases, let baggage = ancillary.first, !baggage.purchaseKey.isEmpty {
                        self.vDepartureBaggages.isHidden = false
                        self.lbDepartureBaggages[0].text = baggage.name
                    } else {
                        self.vDepartureBaggages.isHidden = true
                    }
                    
                    if let ancillary = self.adult[index - 1].arrival.ancillaryPurchases, let baggage = ancillary.first, !baggage.purchaseKey.isEmpty {
                        self.vReturnBaggages.isHidden = false
                        self.lbReturnBaggages[0].text = baggage.name
                    } else {
                        self.vReturnBaggages.isHidden = true
                    }
                    
                    if let seat = self.adult[index - 1].departure.seatSelection, !seat.key.isEmpty {
                        self.vDepartureSeat.isHidden = false
                        self.lbDepartureSeat.text = "\(seat.rowIdentifier) - \(seat.seatIdentifier)"
                    } else {
                        self.vDepartureSeat.isHidden = true
                    }
                    
                    if let seat = self.adult[index - 1].arrival.seatSelection, !seat.key.isEmpty {
                        self.vReturnSeat.isHidden = false
                        self.lbReturnSeat.text = "\(seat.rowIdentifier) - \(seat.seatIdentifier)"
                    } else {
                        self.vReturnSeat.isHidden = true
                    }
                } else if indexPath.row < self.adult.count + self.child.count {
                    self.lbCustomerName.text = self.child[index - 1].lastName + " " + self.child[index - 1].firstName
                    
                    if let ancillary = self.child[index - 1].departure.ancillaryPurchases, let baggage = ancillary.first, !baggage.purchaseKey.isEmpty {
                        self.vDepartureBaggages.isHidden = false
                        self.lbDepartureBaggages[0].text = baggage.name
                    } else {
                        self.vDepartureBaggages.isHidden = true
                    }
                    
                    if let ancillary = self.child[index - 1].arrival.ancillaryPurchases, let baggage = ancillary.first, !baggage.purchaseKey.isEmpty {
                        self.vReturnBaggages.isHidden = false
                        self.lbReturnBaggages[0].text = baggage.name
                    } else {
                        self.vReturnBaggages.isHidden = true
                    }
                    
                    if let seat = self.child[index - 1].departure.seatSelection, !seat.key.isEmpty {
                        self.vDepartureSeat.isHidden = false
                        self.lbDepartureSeat.text = "\(seat.rowIdentifier) - \(seat.seatIdentifier)"
                    } else {
                        self.vDepartureSeat.isHidden = true
                    }
                    
                    if let seat = self.child[index - 1].arrival.seatSelection, !seat.key.isEmpty {
                        self.vReturnSeat.isHidden = false
                        self.lbReturnSeat.text = "\(seat.rowIdentifier) - \(seat.seatIdentifier)"
                    } else {
                        self.vReturnSeat.isHidden = true
                    }
                }
                
                self.vServiceDetail.isHidden = false
            }
            
            return cell
        }
    }
}
