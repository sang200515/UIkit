//
//  PreviewVietjetBookingViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 27/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class PreviewVietjetBookingViewController: UIViewController {

    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet weak var vFlightSelected: UIView!
    @IBOutlet weak var vCustomerSelected: UIView!
    @IBOutlet weak var btnConfirm: UIButton!
    
    //MARK:- FLIGHT INFO
    @IBOutlet var vCircles: [UIView]!
    @IBOutlet weak var vFromFlight: UIView!
    @IBOutlet weak var lbFromFlight: UILabel!
    @IBOutlet weak var lbFromDate: UILabel!
    @IBOutlet weak var lbFromStartCode: UILabel!
    @IBOutlet weak var lbFromStartCity: UILabel!
    @IBOutlet weak var lbFromStartTime: UILabel!
    @IBOutlet weak var lbFromEndCode: UILabel!
    @IBOutlet weak var lbFromEndCity: UILabel!
    @IBOutlet weak var lbFromEndTime: UILabel!
    @IBOutlet weak var lbFromDuration: UILabel!
    @IBOutlet weak var lbFromPrice: UILabel!
    @IBOutlet weak var lbFromPassenger: UILabel!
    @IBOutlet weak var vToFlight: UIView!
    @IBOutlet weak var lbToFlight: UILabel!
    @IBOutlet weak var lbToDate: UILabel!
    @IBOutlet weak var lbToStartCode: UILabel!
    @IBOutlet weak var lbToStartCity: UILabel!
    @IBOutlet weak var lbToStartTime: UILabel!
    @IBOutlet weak var lbToEndCode: UILabel!
    @IBOutlet weak var lbToEndCity: UILabel!
    @IBOutlet weak var lbToEndTime: UILabel!
    @IBOutlet weak var lbToDuration: UILabel!
    @IBOutlet weak var lbToPrice: UILabel!
    @IBOutlet weak var lbToPassenger: UILabel!
    @IBOutlet weak var vFrom: UIView!
    @IBOutlet weak var vFromSummary: UIView!
    @IBOutlet weak var vTo: UIView!
    @IBOutlet weak var vToSummary: UIView!
    
    //MARK:- CUSTOMER INFO
    @IBOutlet weak var vCustomerInfo: UIView!
    @IBOutlet weak var tbvPassenger: UITableView!
    @IBOutlet weak var cstPassenger: NSLayoutConstraint!
    @IBOutlet weak var tbvInsurance: UITableView!
    @IBOutlet weak var cstInsurance: NSLayoutConstraint!
    @IBOutlet weak var lbContactName: UILabel!
    @IBOutlet weak var lbContactPhone: UILabel!
    @IBOutlet weak var lbContactEmail: UILabel!
    @IBOutlet weak var vContactAddress: UIStackView!
    @IBOutlet weak var lbContactAddress: UILabel!
    
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
    
    private var totalPrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VietjetDataManager.shared.prepareParam()
        setupUI()
        setupHeaderView()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            self.cstPassenger.constant = self.tbvPassenger.contentSize.height
        }
    }
    
    private func setupUI() {
        title = "Thông tin chuyến bay"
        addBackButton()
        
        for circle in self.vCircles {
            circle.roundCorners(.allCorners, radius: 16)
        }
        vFromSummary.roundCorners(.allCorners, radius: 10)
        vToSummary.roundCorners(.allCorners, radius: 10)
        vPrice.roundCorners(.allCorners, radius: 20)
        btnConfirm.roundCorners(.allCorners, radius: 5)
        vServiceDetailPopup.roundCorners(.allCorners, radius: 6)
        btnOK.roundCorners(.allCorners, radius: 15)
        
        lbFromFlight.text = VietjetDataManager.shared.selectedDepartureTravel.airlineNumber + " - " + VietjetDataManager.shared.selectedDepartureFareOption.fareClass
        let fromPrice = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT
        lbFromPrice.text = "\(Common.convertCurrencyV2(value: fromPrice)) VNĐ"
        lbFromPassenger.text = "\(VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount) Hành khách"
        lbFromDate.text = VietjetDataManager.shared.selectedFirstDate.stringWith(format: "dd/MM/yyyy")
        lbFromStartCode.text = VietjetDataManager.shared.selectedDepartureCity.code
        lbFromStartCity.text = VietjetDataManager.shared.selectedDepartureCity.name
        lbFromStartTime.text = VietjetDataManager.shared.selectedDepartureTravel.cityPair.departure.hours
        lbFromEndCode.text = VietjetDataManager.shared.selectedArrivalCity.code
        lbFromEndCity.text = VietjetDataManager.shared.selectedArrivalCity.name
        lbFromEndTime.text = VietjetDataManager.shared.selectedDepartureTravel.cityPair.arrival.hours
        lbFromDuration.text = VietjetDataManager.shared.selectedDepartureTravel.totalTime
        
        if !VietjetDataManager.shared.isOneWay {
            vToFlight.isHidden = false
            
            lbToFlight.text = VietjetDataManager.shared.selectedReturnTravel.airlineNumber + " - " + VietjetDataManager.shared.selectedReturnFareOption.fareClass
            let toPrice = VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
            lbToPrice.text = "\(Common.convertCurrencyV2(value: toPrice)) VNĐ"
            lbToPassenger.text = "\(VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount) Hành khách"
            lbToDate.text = VietjetDataManager.shared.selectedLastDate!.stringWith(format: "dd/MM/yyyy")
            lbToStartCode.text = VietjetDataManager.shared.selectedArrivalCity.code
            lbToStartCity.text = VietjetDataManager.shared.selectedArrivalCity.name
            lbToStartTime.text = VietjetDataManager.shared.selectedReturnTravel.cityPair.departure.hours
            lbToEndCode.text = VietjetDataManager.shared.selectedDepartureCity.code
            lbToEndCity.text = VietjetDataManager.shared.selectedDepartureCity.name
            lbToEndTime.text = VietjetDataManager.shared.selectedReturnTravel.cityPair.arrival.hours
            lbToDuration.text = VietjetDataManager.shared.selectedReturnTravel.totalTime
        } else {
            vToFlight.isHidden = true
        }
        
        lbContactName.text = VietjetDataManager.shared.contact.fullName
        lbContactPhone.text = VietjetDataManager.shared.contact.phoneNumber
        lbContactEmail.text = VietjetDataManager.shared.contact.email
        lbContactAddress.text = VietjetDataManager.shared.contact.address
        vContactAddress.isHidden = VietjetDataManager.shared.contact.address.isEmpty
        
        if VietjetDataManager.shared.selectedInsurance.filter({ !$0.purchaseKey.isEmpty }).isEmpty {
            tbvInsurance.isHidden = true
            cstInsurance.constant = 0
        } else {
            tbvInsurance.isHidden = false
            cstInsurance.constant = CGFloat(20 * VietjetDataManager.shared.selectedInsurance.count )
        }
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
        
        totalPrice = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT + VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
        for p in VietjetDataManager.shared.selectedDepartureBaggages {
            totalPrice += p.ancillaryCharge.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedReturnBaggages {
            totalPrice += p.ancillaryCharge.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedDepartureSeats {
            totalPrice += p.seatCharges.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedReturnSeats {
            totalPrice += p.seatCharges.totalAmountFRT
        }
        for p in VietjetDataManager.shared.selectedInsurance {
            totalPrice += p.totalAmountFRT
        }
        lbPrice.text = "\(Common.convertCurrencyV2(value: totalPrice)) VNĐ"
        
        imgDown.isHidden = totalPrice == 0
    }
    
    private func setupTableView() {
        tbvPassenger.registerTableCell(VietjetPassengerInfoTableViewCell.self)
        tbvPassenger.estimatedRowHeight = 100
        tbvPassenger.rowHeight = UITableView.automaticDimension
        
        tbvInsurance.registerTableCell(VietjetServiceTableViewCell.self)
        tbvInsurance.rowHeight = 20
    }
    
    private func calculateVietjetPrice() {
        Provider.shared.vietjetAPIService.calculateVietjetPrice(param: VietjetDataManager.shared.orderParam, success: { [weak self] data in
            guard let self = self, let result = data else { return }
            let vc = VietjetPaymentViewController()
            vc.bill = result
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func flightButtonPressed(_ sender: Any) {
        vFlightSelected.isHidden = false
        vCustomerSelected.isHidden = true
        
        vFrom.isHidden = false
        if !VietjetDataManager.shared.isOneWay {
            vTo.isHidden = false
        }
        vCustomerInfo.isHidden = true
    }
    
    @IBAction func customerButtonPressed(_ sender: Any) {
        vFlightSelected.isHidden = true
        vCustomerSelected.isHidden = false
        
        vFrom.isHidden = true
        vTo.isHidden = true
        vCustomerInfo.isHidden = false
    }
    
    @IBAction func dismissPopupButtonPressed(_ sender: Any) {
        vServiceDetail.isHidden = true
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        let attribute = [NSAttributedString.Key.foregroundColor: UIColor.red]
        let alertString = NSAttributedString(string: "Mọi thay đổi thông tin sẽ bị tính phí.", attributes: attribute)
        let messageString = NSMutableAttributedString(string: "Bạn vui lòng kiểm tra lại thông tin trước khi xác nhận. Thông tin vé và hành khách sẽ không thể thay đổi sau khi xác nhận.\n")
        messageString.append(alertString)
        
        let alert = UIAlertController(title: "Thông báo", message: nil, preferredStyle: .alert)
        alert.setValue(messageString, forKey: "attributedMessage")
        alert.addAction(UIAlertAction(title: "Tiếp tục", style: .default, handler: { (_) in
            self.calculateVietjetPrice()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

extension PreviewVietjetBookingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvPassenger:
            return VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount
        case tbvInsurance:
            return VietjetDataManager.shared.selectedInsurance.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvPassenger:
            let cell = tableView.dequeueTableCell(VietjetPassengerInfoTableViewCell.self)
            var index: Int = 0

            if indexPath.row < VietjetDataManager.shared.adultCount {
                index = indexPath.row + 1
                cell.setupCell(type: .adult, index: index)
            } else if indexPath.row < VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount {
                index = indexPath.row - (VietjetDataManager.shared.adultCount - 1)
                cell.setupCell(type: .child, index: index)
            } else {
                index = indexPath.row - (VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount - 1)
                cell.setupCell(type: .infant, index: index)
            }
            
            cell.didPressShowServiceDetail = {
                if indexPath.row < VietjetDataManager.shared.adultCount {
                    let passenger = VietjetDataManager.shared.passengers[index - 1]
                    self.lbCustomerName.text = passenger.reservationProfile.lastName + " " + VietjetDataManager.shared.passengers[index - 1].reservationProfile.firstName
                } else if indexPath.row < VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount {
                    let passenger = VietjetDataManager.shared.passengers[VietjetDataManager.shared.adultCount + index - 1]
                    self.lbCustomerName.text = passenger.reservationProfile.lastName + " " + passenger.reservationProfile.firstName
                } else {
                    let passenger = VietjetDataManager.shared.passengers[index - 1]
                    self.lbCustomerName.text = passenger.infantProfile!.lastName + " " + passenger.infantProfile!.firstName
                }
                
                if indexPath.row < VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount {
                    if !VietjetDataManager.shared.selectedDepartureBaggages[indexPath.row].purchaseKey.isEmpty {
                        self.vDepartureBaggages.isHidden = false
                        self.lbDepartureBaggages[0].text = VietjetDataManager.shared.selectedDepartureBaggages[indexPath.row].name
                    } else {
                        self.vDepartureBaggages.isHidden = true
                    }
                    
                    if !VietjetDataManager.shared.selectedReturnBaggages[indexPath.row].purchaseKey.isEmpty {
                        self.vReturnBaggages.isHidden = false
                        self.lbReturnBaggages[0].text = VietjetDataManager.shared.selectedReturnBaggages[indexPath.row].name
                    } else {
                        self.vReturnBaggages.isHidden = true
                    }
                    
                    if !VietjetDataManager.shared.selectedDepartureSeats[indexPath.row].selectionKey.isEmpty {
                        self.vDepartureSeat.isHidden = false
                        self.lbDepartureSeat.text = "\(VietjetDataManager.shared.selectedDepartureSeats[indexPath.row].seatMapCell.rowIdentifier) - \(VietjetDataManager.shared.selectedDepartureSeats[indexPath.row].seatMapCell.seatIdentifier)"
                    } else {
                        self.vDepartureSeat.isHidden = true
                    }
                    
                    if !VietjetDataManager.shared.selectedReturnSeats[indexPath.row].selectionKey.isEmpty {
                        self.vReturnSeat.isHidden = false
                        self.lbReturnSeat.text = "\(VietjetDataManager.shared.selectedReturnSeats[indexPath.row].seatMapCell.rowIdentifier) - \(VietjetDataManager.shared.selectedReturnSeats[indexPath.row].seatMapCell.seatIdentifier)"
                    } else {
                        self.vReturnSeat.isHidden = true
                    }
                }
                
                self.vServiceDetail.isHidden = false
            }
            
            return cell
        case tbvInsurance:
            let cell = tableView.dequeueTableCell(VietjetServiceTableViewCell.self)
            let insurance = VietjetDataManager.shared.selectedInsurance[indexPath.row]
            
            cell.setupCell(insurance.name)
            return cell
        default:
            return UITableViewCell()
        }
    }
}
