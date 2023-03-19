//
//  SelectBookingChangeViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 11/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectBookingChangeViewController: UIViewController {
    
    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet var vCircles: [UIView]!
    
    //MARK:- CURRENT FLIGHT INFO
    @IBOutlet weak var vBackground: UIView!
    @IBOutlet weak var lbFlightNo: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbFromCode: UILabel!
    @IBOutlet weak var lbFromCity: UILabel!
    @IBOutlet weak var lbFromTime: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var lbToCode: UILabel!
    @IBOutlet weak var lbToCity: UILabel!
    @IBOutlet weak var lbToTime: UILabel!
    @IBOutlet weak var lbPassenger: UILabel!
    
    //MARK:- CHANGE FLIGHT INFO
    @IBOutlet weak var vChangeInfo: UIView!
    @IBOutlet weak var vChangeEdit: UIView!
    @IBOutlet weak var vChangeDate: UIView!
    @IBOutlet weak var btnChangePreviousDate: UIButton!
    @IBOutlet weak var btnChangeNextDate: UIButton!
    @IBOutlet weak var clvChangeDate: UICollectionView!
    @IBOutlet weak var vChangeTime: UIView!
    @IBOutlet weak var clvChangeTime: UICollectionView!
    @IBOutlet weak var cstChangeTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var vChangePreview: UIView!
    @IBOutlet var lbChangeFlightNo: [UILabel]!
    @IBOutlet var lbChangeFlightDate: [UILabel]!
    @IBOutlet var lbChangeDepartureCode: [UILabel]!
    @IBOutlet var lbChangeDepartureCity: [UILabel]!
    @IBOutlet var lbChangeDepartureTime: [UILabel]!
    @IBOutlet var lbChangeDuration: [UILabel]!
    @IBOutlet var lbChangeReturnCode: [UILabel]!
    @IBOutlet var lbChangeReturnCity: [UILabel]!
    @IBOutlet var lbChangeReturnTime: [UILabel]!
    @IBOutlet weak var vChangeSummary: UIView!
    @IBOutlet weak var lbChangePrice: UILabel!
    @IBOutlet weak var lbChangePassenger: UILabel!
    @IBOutlet weak var vChangeTicket: UIView!
    @IBOutlet weak var tbvChangeTicket: UITableView!
    @IBOutlet weak var cstChangeTicketHeight: NSLayoutConstraint!
    
    //MARK:- CONTINUE BUTTON
    @IBOutlet weak var vContinue: UIView!
    @IBOutlet weak var tbnContinue: UIButton!
    
    private var currentStep: Int = 0
    private var dates: [Date] = []
    private var selectedIndex: Int = 0
    private var totalPrice: Int = 0
    private var totalPriceFRT: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        setupUI()
        setupCurrentFlightUI()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            for circle in self.vCircles {
                circle.roundCorners(.allCorners, radius: 16)
            }
            self.vPrice.roundCorners(.allCorners, radius: 20)
            self.vChangeDate.roundCorners(.allCorners, radius: 10)
            self.vChangePreview.roundCorners(.allCorners, radius: 10)
            self.vChangeSummary.roundCorners(.allCorners, radius: 10)
            self.vChangeTicket.roundCorners(.allCorners, radius: 20)
            self.tbnContinue.roundCorners(.allCorners, radius: 5)
        }
    }
    
    private func setupStep() {
        DispatchQueue.main.async {
            switch self.currentStep {
            case 1:
                self.vChangeInfo.isHidden = false
                self.vChangeEdit.isHidden = true
                self.vChangeDate.isHidden = false
                self.vChangeTime.isHidden = false
                self.vChangePreview.isHidden = true
                self.vChangeSummary.isHidden = true
                self.vChangeTicket.isHidden = true
                self.vContinue.isHidden = true
                
                self.clvChangeTime.reloadData()
                self.clvChangeTime.performBatchUpdates(nil, completion: { result in
                    self.cstChangeTimeHeight.constant = self.clvChangeTime.contentSize.height
                    self.vChangeTime.layoutIfNeeded()
                    self.vChangeTime.roundCorners(.allCorners, radius: 20)
                })
            case 2:
                self.vChangeDate.isHidden = true
                self.vChangeTime.isHidden = true
                self.vChangePreview.isHidden = false
                self.vChangeTicket.isHidden = false
                self.vContinue.isHidden = false
                self.vChangeSummary.isHidden = true
                
                for label in self.lbChangeFlightNo {
                    label.text = VietjetDataManager.shared.selectedChangeTravel.airlineNumber
                }
                for label in self.lbChangeFlightDate {
                    label.text = VietjetDataManager.shared.selectedFirstDate.stringWith(format: "dd/MM/yyyy")
                }
                for label in self.lbChangeDepartureCode {
                    label.text = VietjetDataManager.shared.selectedDepartureCity.code
                }
                for label in self.lbChangeDepartureCity {
                    label.text = VietjetDataManager.shared.selectedDepartureCity.name
                }
                for label in self.lbChangeReturnCode {
                    label.text = VietjetDataManager.shared.selectedArrivalCity.code
                }
                for label in self.lbChangeReturnCity {
                    label.text = VietjetDataManager.shared.selectedArrivalCity.name
                }
                for label in self.lbChangeDepartureTime {
                    label.text = VietjetDataManager.shared.selectedChangeTravel.departureTime
                }
                for label in self.lbChangeReturnTime {
                    label.text = VietjetDataManager.shared.selectedChangeTravel.cityPair.arrival.hours
                }
                for label in self.lbChangeDuration {
                    label.text = VietjetDataManager.shared.selectedChangeTravel.totalTime
                }
                
                self.setupPrice()
                
                self.tbvChangeTicket.reloadData()
                self.tbvChangeTicket.performBatchUpdates(nil, completion: { result in
                    self.cstChangeTicketHeight.constant = self.tbvChangeTicket.contentSize.height
                    self.vChangeTicket.layoutIfNeeded()
                    self.vChangeTicket.roundCorners(.allCorners, radius: 20)
                })
            case 3:
                self.vChangePreview.isHidden = true
                self.vChangeTicket.isHidden = true
                self.vContinue.isHidden = false
                self.vChangeSummary.isHidden = false
                self.vChangeEdit.isHidden = false
                
                self.lbChangeFlightNo.last!.text = VietjetDataManager.shared.selectedChangeTravel.airlineNumber + " - " + VietjetDataManager.shared.selectedChangeFareOption.fareClass
                let fromPrice = VietjetDataManager.shared.selectedChangeFareOption.totalAmountFRT
                self.lbChangePrice.text = "\(Common.convertCurrencyV2(value: fromPrice)) VNĐ"
                self.lbChangePassenger.text = "\(VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount) Hành khách"
                
                self.setupPrice()
            default:
                self.vChangeInfo.isHidden = true
                self.vContinue.isHidden = true
            }
        }
    }
    
    private func setupUI() {
        title = "Thông tin chuyến bay"
        addBackButton(#selector(handleBackButton))
        
        vBackground.roundCorners(.allCorners, radius: 10)
        
        makeDateList()
        setupHeaderView()
        setupStep()
    }
    
    @objc func handleBackButton() {
        if currentStep > 1 {
            currentStep -= 1
            setupStep()
        } else {
            VietjetDataManager.shared.travelOptions = VietjetTravelOption(JSON: [:])!
            VietjetDataManager.shared.selectedChangeTravel = VietjetTravel(JSON: [:])!
            VietjetDataManager.shared.selectedChangeFareOption = FareOption(JSON: [:])!
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupPrice() {
        totalPrice = VietjetDataManager.shared.selectedChangeFareOption.totalAmount
        totalPriceFRT = VietjetDataManager.shared.selectedChangeFareOption.totalAmountFRT
        self.lbPrice.text = "\(Common.convertCurrencyV2(value: totalPriceFRT)) VNĐ"
        
        imgDown.isHidden = totalPriceFRT == 0
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
        
        lbFlightInfo.text = "Một chiều: \(passenger)"
        lbFrom.text = "\(VietjetDataManager.shared.selectedDepartureCity.name) (\(VietjetDataManager.shared.selectedDepartureCity.code))"
        lbTo.text = "\(VietjetDataManager.shared.selectedArrivalCity.name) (\(VietjetDataManager.shared.selectedArrivalCity.code))"
    }
    
    private func setupCurrentFlightUI() {
        let flight = VietjetDataManager.shared.isDeparture ? VietjetDataManager.shared.historyBooking.departure : VietjetDataManager.shared.historyBooking.arrival!
        
        lbFlightNo.text = "\(flight.airlineNumber) - \(flight.fareClass)"
        lbDate.text = flight.departureDate
        lbFromCode.text = flight.cityPair.departure.code
        lbFromCity.text = flight.cityPair.departure.name
        lbFromTime.text = flight.cityPair.departure.hours
        lbTotalTime.text = flight.totalTime
        lbToCode.text = flight.cityPair.arrival.code
        lbToCity.text = flight.cityPair.arrival.name
        lbToTime.text = flight.cityPair.arrival.hours
        lbPassenger.text = "\(VietjetDataManager.shared.historyBooking.passengers.count) Hành khách"
    }
    
    private func setupCollectionView() {
        clvChangeDate.registerCollectionCell(VietjetDateCollectionViewCell.self)
        clvChangeTime.registerCollectionCell(VietjetTimeCollectionViewCell.self)
    }
    
    private func setupTableView() {
        tbvChangeTicket.registerTableCell(VietjetTicketClassTableViewCell.self)
        tbvChangeTicket.estimatedRowHeight = 100
        tbvChangeTicket.rowHeight = UITableView.automaticDimension
    }
    
    private func makeDateList() {
        let firstDate = VietjetDataManager.shared.selectedFirstDate
        
        let firstCal = Calendar.current
        let beforeCal = Calendar.current
        let afterCal = Calendar.current
        let calToday = Calendar.current
        
        let currentFirstDate = firstCal.startOfDay(for: firstDate)
        var beforeFirstDate = beforeCal.startOfDay(for: firstDate)
        var afterFirstDate = afterCal.startOfDay(for: firstDate)
        let today = calToday.startOfDay(for: Date())
        
        var days: [Date] = []
        
        for _ in 1...7 {
            beforeFirstDate = beforeCal.date(byAdding: .day, value: -1, to: beforeFirstDate)!
            if beforeFirstDate < today {
                break
            }
            
            days.append(beforeFirstDate)
        }
        
        days.reverse()
        days.append(currentFirstDate)
        selectedIndex = days.count - 1
        
        for _ in 1...7 {
            afterFirstDate = afterCal.date(byAdding: .day, value: 1, to: afterFirstDate)!
            days.append(afterFirstDate)
        }
        
        dates = days
        clvChangeDate.reloadData()
        clvChangeDate.performBatchUpdates(nil, completion: { result in
            self.clvChangeDate.selectItem(at: IndexPath(row: self.selectedIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        setupDateButton()
    }
    
    private func loadData() {
        let from = VietjetDataManager.shared.selectedDepartureCity.code
        let to = VietjetDataManager.shared.selectedArrivalCity.code
        let fromTime = VietjetDataManager.shared.selectedFirstDate.stringWith(format: "yyyy-MM-dd")
        let toTime = VietjetDataManager.shared.isOneWay ? "" : VietjetDataManager.shared.selectedLastDate!.stringWith(format: "yyyy-MM-dd")
        let adult = VietjetDataManager.shared.adultCount
        let child = VietjetDataManager.shared.childCount
        let infant = VietjetDataManager.shared.infantCount
        let reservationKey = VietjetDataManager.shared.historyBooking.key
        let journeyKey = VietjetDataManager.shared.isDeparture ? VietjetDataManager.shared.historyBooking.departure.key : VietjetDataManager.shared.historyBooking.arrival!.key
        
        Provider.shared.vietjetAPIService.getTravelOptions(from: from, to: to, fromTime: fromTime, adult: adult, child: child, infant: infant, toTime: toTime, reservationKey: reservationKey, journeyKey: journeyKey, success:  { [weak self] data in
            guard let self = self, let result = data else { return }
            if result.departureOption.travels.isEmpty {
                self.showAlertOneButton(title: "Thông báo", with: "Không tìm thấy chuyến bay phù hợp, bạn vui lòng điều chỉnh lại thông tin ngày bay hoặc điểm đi/đến", titleButton: "OK")
                VietjetDataManager.shared.travelOptions = VietjetTravelOption(JSON: [:])!
            } else {
                VietjetDataManager.shared.travelOptions = result
                self.currentStep = 1
            }
            
            self.setupStep()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            VietjetDataManager.shared.travelOptions = VietjetTravelOption(JSON: [:])!
            self.setupStep()
        })
    }
    
    private func setupDateButton() {
        if selectedIndex == 0 {
            btnChangePreviousDate.isHidden = true
        } else {
            btnChangePreviousDate.isHidden = false
        }
        
        if selectedIndex == dates.count - 1 {
            btnChangeNextDate.isHidden = true
        } else {
            btnChangeNextDate.isHidden = false
        }
    }
    
    private func prepareParam() {
        VietjetDataManager.shared.changeFlightParam.order.shopcode = Cache.user!.ShopCode
        VietjetDataManager.shared.changeFlightParam.order.usercode = Cache.user!.UserName
        VietjetDataManager.shared.changeFlightParam.order.deviceID = 2
        VietjetDataManager.shared.changeFlightParam.order.totalAmount = totalPrice
        VietjetDataManager.shared.changeFlightParam.order.totalAmountFRT = totalPriceFRT
        VietjetDataManager.shared.changeFlightParam.order.xmlPayments = ""
        VietjetDataManager.shared.changeFlightParam.order.xmlPromotions = ""
        VietjetDataManager.shared.changeFlightParam.order.xmlItemProducts = ""
        
        VietjetDataManager.shared.changeFlightParam.contact.fullName = VietjetDataManager.shared.historyBooking.contactInformation.name
        VietjetDataManager.shared.changeFlightParam.contact.phoneNumber = VietjetDataManager.shared.historyBooking.contactInformation.phoneNumber
        VietjetDataManager.shared.changeFlightParam.contact.email = VietjetDataManager.shared.historyBooking.contactInformation.email
        VietjetDataManager.shared.changeFlightParam.contact.address = VietjetDataManager.shared.historyBooking.contactInformation.address
        
        VietjetDataManager.shared.changeFlightParam.booking.locator = VietjetDataManager.shared.historyBooking.locator
        VietjetDataManager.shared.changeFlightParam.booking.number = VietjetDataManager.shared.historyBooking.number
        VietjetDataManager.shared.changeFlightParam.booking.resKey = VietjetDataManager.shared.historyBooking.key
        
        let journeyKey = VietjetDataManager.shared.isDeparture ? VietjetDataManager.shared.historyBooking.departure.key : VietjetDataManager.shared.historyBooking.arrival!.key
        VietjetDataManager.shared.changeFlightParam.booking.reservationJourney.journeyKey = journeyKey
        VietjetDataManager.shared.changeFlightParam.booking.reservationJourney.bookingKey = VietjetDataManager.shared.selectedChangeFareOption.bookingKey
        VietjetDataManager.shared.changeFlightParam.booking.reservationJourney.airlineNumber =
            VietjetDataManager.shared.selectedChangeTravel.airlineNumber
        VietjetDataManager.shared.changeFlightParam.booking.reservationJourney.aircraftModel = VietjetDataManager.shared.selectedChangeTravel.aircraftModel
        VietjetDataManager.shared.changeFlightParam.booking.reservationJourney.cityPair = VietjetDataManager.shared.selectedChangeTravel.cityPair
        VietjetDataManager.shared.changeFlightParam.booking.reservationJourney.journeyDetails = VietjetDataManager.shared.isDeparture ? VietjetDataManager.shared.historyBooking.departure.journeyDetail : VietjetDataManager.shared.historyBooking.arrival!.journeyDetail
    }
    
    private func calculatePrice() {
        prepareParam()
        Provider.shared.vietjetAPIService.calculateVietjetUpdateFlightPrice(param: VietjetDataManager.shared.changeFlightParam, success: { [weak self] data in
            guard let self = self, let result = data else { return }
            let vc = VietjetPaymentViewController()
            vc.bill = result
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func editChangeButtonPressed(_ sender: Any) {
        currentStep = 1
        setupStep()
    }
    
    @IBAction func changePreviousButtonPressed(_ sender: Any) {
        if selectedIndex - 1 >= 0 {
            selectedIndex -= 1
        }
        
        clvChangeDate.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        loadData()
        setupDateButton()
    }
    
    @IBAction func changeNextButtonPressed(_ sender: Any) {
        if selectedIndex + 1 < dates.count {
            selectedIndex += 1
        }
        
        clvChangeDate.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        loadData()
        setupDateButton()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if currentStep == 2 {
            currentStep = 3
            setupStep()
        } else if currentStep == 3 {
            calculatePrice()
        }
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

extension SelectBookingChangeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case clvChangeDate:
            return dates.count
        case clvChangeTime:
            return VietjetDataManager.shared.travelOptions.departureOption.travels.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case clvChangeDate:
            let cell = collectionView.dequeueCollectionCell(VietjetDateCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(dates[indexPath.row])
            return cell
        case clvChangeTime:
            let cell = collectionView.dequeueCollectionCell(VietjetTimeCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(VietjetDataManager.shared.travelOptions.departureOption.travels[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case clvChangeDate:
            selectedIndex = indexPath.row
            VietjetDataManager.shared.selectedFirstDate = dates[indexPath.row]
            clvChangeDate.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            loadData()
            setupDateButton()
        case clvChangeTime:
            VietjetDataManager.shared.selectedChangeTravel = VietjetDataManager.shared.travelOptions.departureOption.travels[indexPath.row]
            VietjetDataManager.shared.selectedChangeFareOption = VietjetDataManager.shared.selectedChangeTravel.fareOptions.first ?? FareOption(JSON: [:])!
            currentStep = 2
            setupStep()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case clvChangeDate:
            let width = (UIScreen.main.bounds.width - 100) / 3
            return CGSize(width: width, height: 70)
        case clvChangeTime:
            let width = (self.clvChangeTime.frame.size.width - 20) / 3
            let height = width * 131 / 107
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case clvChangeDate:
            return 0
        case clvChangeTime:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case clvChangeDate:
            return 0
        case clvChangeTime:
            return 0
        default:
            return 0
        }
    }
}

extension SelectBookingChangeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return VietjetDataManager.shared.selectedChangeTravel.fareOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetTicketClassTableViewCell.self)
        cell.selectionStyle = .none
        
        let isSelected = VietjetDataManager.shared.selectedChangeFareOption.bookingKey == VietjetDataManager.shared.selectedChangeTravel.fareOptions[indexPath.row].bookingKey
        cell.setupCell(VietjetDataManager.shared.selectedChangeTravel.fareOptions[indexPath.row], isSelected: isSelected)
        cell.didExpand = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tbvChangeTicket.reloadData()
                self.tbvChangeTicket.performBatchUpdates(nil, completion: { result in
                    self.cstChangeTicketHeight.constant = self.tbvChangeTicket.contentSize.height
                    self.vChangeTicket.layoutIfNeeded()
                    self.vChangeTicket.roundCorners(.allCorners, radius: 20)
                })
            }
        }
        cell.didPressHyperlink = { [weak self] in
            guard let self = self else { return }
            let vc = TicketDetailPopupViewController()
            vc.ticketDetail = VietjetDataManager.shared.travelOptions.htmlTAC
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: true, completion: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        VietjetDataManager.shared.selectedChangeFareOption = VietjetDataManager.shared.selectedChangeTravel.fareOptions[indexPath.row]
        setupPrice()
        tbvChangeTicket.reloadData()
    }
}
