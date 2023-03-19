//
//  VietjetFlightInfoViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 28/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetFlightInfoViewController: UIViewController {

    @IBOutlet weak var vOrderInfo: UIView!
    @IBOutlet weak var svFlightInfo: UIScrollView!
    @IBOutlet weak var tbvFlight: UITableView!
    @IBOutlet weak var cstFlight: NSLayoutConstraint!
    @IBOutlet weak var tbvPassenger: UITableView!
    @IBOutlet weak var cstPassenger: NSLayoutConstraint!
    @IBOutlet weak var vOrder: UIView!
    @IBOutlet weak var vFlight: UIView!
    @IBOutlet weak var tbvInsurance: UITableView!
    @IBOutlet weak var cstInsurance: NSLayoutConstraint!
    
    //MARK:- SERVICES DETAIL
    @IBOutlet weak var vServiceDetail: UIView!
    @IBOutlet weak var vServiceDetailPopup: UIView!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var vBaggages: UIStackView!
    @IBOutlet weak var vDepartureBaggages: UIStackView!
    @IBOutlet weak var vReturnBaggages: UIStackView!
    @IBOutlet var lbDepartureBaggages: [UILabel]!
    @IBOutlet var lbReturnBaggages: [UILabel]!
    @IBOutlet weak var vSeat: UIStackView!
    @IBOutlet weak var vDepartureSeat: UIStackView!
    @IBOutlet weak var vReturnSeat: UIStackView!
    @IBOutlet weak var lbDepartureSeat: UILabel!
    @IBOutlet weak var lbReturnSeat: UILabel!
    @IBOutlet weak var btnOK: UIButton!
    
    var history: VietjetPaymentHistory = VietjetPaymentHistory(JSON: [:])!
    private var orderDetail: VietjetHistoryOrder = VietjetHistoryOrder(JSON: [:])!
    private var adult: [VietjetHistoryPassenger] = []
    private var child: [VietjetHistoryPassenger] = []
    private var infant: [VietjetHistoryPassenger] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.cstPassenger.constant = self.tbvPassenger.contentSize.height
        }
    }
    
    private func setupUI() {
        title = "SO \(history.sompos)"
        addBackButton()
        
        vServiceDetailPopup.roundCorners(.allCorners, radius: 6)
        btnOK.roundCorners(.allCorners, radius: 15)
    }
    
    private func setupTableView() {
        tbvFlight.registerTableCell(VietjetFlightInfoTableViewCell.self)
        tbvFlight.rowHeight = 235
        
        tbvPassenger.registerTableCell(VietjetPassengerInfoTableViewCell.self)
        tbvPassenger.estimatedRowHeight = 100
        tbvPassenger.rowHeight = UITableView.automaticDimension
        
        tbvInsurance.registerTableCell(VietjetServiceTableViewCell.self)
        tbvInsurance.rowHeight = 20
    }
    
    private func loadData() {
        Provider.shared.vietjetAPIService.getOrderDetail(id: history.id, mpos: history.sompos, locator: history.locator, success: { [weak self] data in
            guard let self = self, let result = data else { return }
            self.orderDetail = result
            self.loadUI()
            self.setupTableViewHeight()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func loadUI() {
        let orderVC = VietjetPaymentViewController()
        orderVC.isHistory = true
        orderVC.order = orderDetail
        addChild(orderVC)
        vOrderInfo.addSubview(orderVC.view)
        
        orderVC.view.frame = vOrderInfo.bounds
        orderVC.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        orderVC.didMove(toParent: self)
    }
    
    private func setupTableViewHeight() {
        adult = orderDetail.booking.passengers.filter { $0.fareApplicability == "adult" }
        child = orderDetail.booking.passengers.filter { $0.fareApplicability == "child" }
        infant = orderDetail.booking.passengers.filter { $0.fareApplicability == "infant" }
        
        DispatchQueue.main.async {
            self.cstFlight.constant = CGFloat((self.orderDetail.booking.arrival == nil ? 1 : 2) * 235)
            self.tbvFlight.reloadData()
            
            self.tbvPassenger.reloadData()
            self.tbvPassenger.performBatchUpdates(nil, completion: { result in
                self.cstPassenger.constant = self.tbvPassenger.contentSize.height
            })
            
            self.tbvInsurance.reloadData()
            self.tbvInsurance.performBatchUpdates(nil, completion: { result in
                self.cstInsurance.constant = CGFloat(self.orderDetail.booking.insurances.count * 20)
            })
        }
    }
    
    @IBAction func orderButtonPressed(_ sender: Any) {
        vOrder.isHidden = false
        vFlight.isHidden = true
        
        vOrderInfo.isHidden = false
        svFlightInfo.isHidden = true
    }
    
    @IBAction func flightButtonPressed(_ sender: Any) {
        vOrder.isHidden = true
        vFlight.isHidden = false
        
        vOrderInfo.isHidden = true
        svFlightInfo.isHidden = false
    }
    
    @IBAction func dismissPopupButtonPressed(_ sender: Any) {
        vServiceDetail.isHidden = true
    }
}

extension VietjetFlightInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvFlight:
            return orderDetail.booking.arrival == nil ? 1 : 2
        case tbvInsurance:
            return orderDetail.booking.insurances.count
        default:
            return orderDetail.booking.passengers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvFlight:
            let cell = tableView.dequeueTableCell(VietjetFlightInfoTableViewCell.self)
            cell.setupCell(indexPath.row == 0 ? orderDetail.booking.departure : orderDetail.booking.arrival!, isDeparture: indexPath.row == 0, code: orderDetail.booking.locator)
            return cell
        case tbvInsurance:
            let cell = tableView.dequeueTableCell(VietjetServiceTableViewCell.self)
            let insurance = orderDetail.booking.insurances[indexPath.row]
            
            cell.setupCell(insurance.name)
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
