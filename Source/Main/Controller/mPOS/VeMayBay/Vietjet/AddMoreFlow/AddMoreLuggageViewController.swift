//
//  AddMoreLuggageViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class AddMoreLuggageViewController: UIViewController {

    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    
    @IBOutlet weak var stvOneWayTab: UIStackView!
    @IBOutlet weak var vFromSelected: UIView!
    @IBOutlet weak var vToSelected: UIView!
    @IBOutlet weak var clvSelectedPassenger: UICollectionView!
    @IBOutlet weak var clvNormalLuggage: UICollectionView!
    @IBOutlet weak var btnContinue: UIButton!
    
    private var passengers: [VietjetHistoryPassenger] = []
    private var departureBaggages: [VietjetHistoryPassenger] = []
    private var isDeparture: Bool = true
    private var returnBaggages: [VietjetHistoryPassenger] = []
    private var selectedDeparturePassengerIndex: Int = 0
    private var selectedReturnPassengerIndex: Int = 0
    private var selectedBaggage: (isDeparture: Bool, index: Int, passengerIndex: Int, baggage: VietjetBaggage) = (isDeparture: true, index: -1, passengerIndex: -1, baggage: VietjetBaggage(JSON: [:])!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        setupCollectionView()
        loadData()
    }
    
    private func setupData() {
        passengers = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability != "infant" }
        departureBaggages = passengers.filter { $0.departure.ancillaryPurchases == nil }
        returnBaggages = passengers.filter { $0.arrival.ancillaryPurchases == nil }
    }
    
    private func setupUI() {
        title = "Chọn hành lý"
        addBackButton()
        
        btnContinue.roundCorners(.allCorners, radius: 5)
        
        if VietjetDataManager.shared.historyBooking.arrival == nil {
            stvOneWayTab.isHidden = true
        } else {
            stvOneWayTab.isHidden = false
        }
        
        setupHeaderView()
    }
    
    private func setupHeaderView() {
        let adult = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability == "adult" }
        let child = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability == "child" }
        let infant = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability == "infant" }
        
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
    
    private func setupCollectionView() {
        clvSelectedPassenger.registerCollectionCell(VietjetSelectingCollectionViewCell.self)
        
        let layout = PagingCollectionViewLayout()
        let spacing: CGFloat = UIScreen.main.bounds.width - 200 / 2
        layout.sectionInset = .init(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.scrollDirection = .horizontal
        
        clvSelectedPassenger.collectionViewLayout = layout
        clvSelectedPassenger.translatesAutoresizingMaskIntoConstraints = false
        clvSelectedPassenger.showsHorizontalScrollIndicator = false
        clvSelectedPassenger.decelerationRate = .fast
        
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            if self.departureBaggages.count > 0 {
                self.clvSelectedPassenger.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        })
        
        clvNormalLuggage.registerCollectionCell(VietjetLuggageCollectionViewCell.self)
        clvNormalLuggage.contentInset.bottom = 100
    }
    
    private func loadData() {
        let bookingKey = isDeparture ? VietjetDataManager.shared.historyBooking.departure.bookingKey : VietjetDataManager.shared.historyBooking.arrival!.bookingKey
        
        if isDeparture && VietjetDataManager.shared.departureBaggages.isEmpty && departureBaggages.count > 0 {
            Provider.shared.vietjetAPIService.getAncillaryOptions(bookingKey: bookingKey, success: { [weak self] data in
                guard let self = self else { return }
                VietjetDataManager.shared.departureBaggages = data
                self.clvNormalLuggage.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else if !isDeparture && VietjetDataManager.shared.returnBaggages.isEmpty && returnBaggages.count > 0 {
            Provider.shared.vietjetAPIService.getAncillaryOptions(bookingKey: bookingKey, success: { [weak self] data in
                guard let self = self else { return }
                VietjetDataManager.shared.returnBaggages = data
                self.clvNormalLuggage.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
    
    private func prepareParam() {
        VietjetDataManager.shared.ancillaryOrderParam.order.shopcode = Cache.user!.ShopCode
        VietjetDataManager.shared.ancillaryOrderParam.order.usercode = Cache.user!.UserName
        VietjetDataManager.shared.ancillaryOrderParam.order.deviceID = 2
        VietjetDataManager.shared.ancillaryOrderParam.order.totalAmount = selectedBaggage.baggage.ancillaryCharge.totalAmount
        VietjetDataManager.shared.ancillaryOrderParam.order.totalAmountFRT = selectedBaggage.baggage.ancillaryCharge.totalAmountFRT
        VietjetDataManager.shared.ancillaryOrderParam.order.xmlPayments = ""
        VietjetDataManager.shared.ancillaryOrderParam.order.xmlPromotions = ""
        VietjetDataManager.shared.ancillaryOrderParam.order.xmlItemProducts = ""
        
        VietjetDataManager.shared.ancillaryOrderParam.contact.fullName = VietjetDataManager.shared.historyBooking.contactInformation.name
        VietjetDataManager.shared.ancillaryOrderParam.contact.phoneNumber = VietjetDataManager.shared.historyBooking.contactInformation.phoneNumber
        VietjetDataManager.shared.ancillaryOrderParam.contact.email = VietjetDataManager.shared.historyBooking.contactInformation.email
        VietjetDataManager.shared.ancillaryOrderParam.contact.address = VietjetDataManager.shared.historyBooking.contactInformation.address
        
        VietjetDataManager.shared.ancillaryOrderParam.booking.locator = VietjetDataManager.shared.historyBooking.locator
        VietjetDataManager.shared.ancillaryOrderParam.booking.number = VietjetDataManager.shared.historyBooking.number
        VietjetDataManager.shared.ancillaryOrderParam.booking.resKey = VietjetDataManager.shared.historyBooking.key
        VietjetDataManager.shared.ancillaryOrderParam.booking.seatPurchases = nil
        
        let ancillaryPurchases = VietjetAncillaryPurchases(JSON: [:])!
        ancillaryPurchases.ancillaryPurchasesDescription = selectedBaggage.baggage.description
        ancillaryPurchases.purchaseKey = selectedBaggage.baggage.purchaseKey
        ancillaryPurchases.passenger.key = selectedBaggage.isDeparture ? departureBaggages[selectedBaggage.passengerIndex].key : returnBaggages[selectedBaggage.passengerIndex].key
        ancillaryPurchases.passenger.href = selectedBaggage.isDeparture ? departureBaggages[selectedBaggage.passengerIndex].href : returnBaggages[selectedBaggage.passengerIndex].href
        ancillaryPurchases.journey.key = selectedBaggage.isDeparture ? VietjetDataManager.shared.historyBooking.departure.key : VietjetDataManager.shared.historyBooking.arrival!.key
        ancillaryPurchases.journey.href = selectedBaggage.isDeparture ? VietjetDataManager.shared.historyBooking.departure.href : VietjetDataManager.shared.historyBooking.arrival!.href
        
        VietjetDataManager.shared.ancillaryOrderParam.booking.ancillaryPurchases = ancillaryPurchases
        VietjetDataManager.shared.isAddonBaggage = true
    }
    
    private func calculatePrice() {
        prepareParam()
        Provider.shared.vietjetAPIService.calculateVietjetAncillaryPrice(param: VietjetDataManager.shared.ancillaryOrderParam, success: { [weak self] data in
            guard let self = self, let result = data else { return }
            let vc = VietjetPaymentViewController()
            vc.bill = result
            self.navigationController?.pushViewController(vc, animated: true)
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func fromButtonPressed(_ sender: Any) {
        vFromSelected.isHidden = false
        vToSelected.isHidden = true
        
        isDeparture = true
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            if self.departureBaggages.count > 0 {
                self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedDeparturePassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            }
        })
        clvNormalLuggage.reloadData()
        loadData()
    }
    
    @IBAction func toButtonPressed(_ sender: Any) {
        vFromSelected.isHidden = true
        vToSelected.isHidden = false
        
        isDeparture = false
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            if self.returnBaggages.count > 0 {
                self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedReturnPassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)

            }
        })
        clvNormalLuggage.reloadData()
        loadData()
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if selectedBaggage.baggage.purchaseKey.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn hành lý muốn mua thêm", titleButton: "OK")
        } else {
            calculatePrice()
        }
    }
}

extension AddMoreLuggageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case clvSelectedPassenger:
            return isDeparture ? departureBaggages.count : returnBaggages.count
        case clvNormalLuggage:
            return isDeparture ? VietjetDataManager.shared.departureBaggages.count : VietjetDataManager.shared.returnBaggages.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case clvSelectedPassenger:
            let cell = collectionView.dequeueCollectionCell(VietjetSelectingCollectionViewCell.self, indexPath: indexPath)
            let isSelected = isDeparture ? indexPath.row == selectedDeparturePassengerIndex : indexPath.row == selectedReturnPassengerIndex
            let passenger = isDeparture ? departureBaggages[indexPath.row] : returnBaggages[indexPath.row]
            var baggage = VietjetBaggage(JSON: [:])!
            if isDeparture && selectedBaggage.isDeparture && selectedBaggage.passengerIndex == indexPath.row {
                baggage = selectedBaggage.baggage
            } else if !isDeparture && !selectedBaggage.isDeparture && selectedBaggage.passengerIndex == indexPath.row {
                baggage = selectedBaggage.baggage
            }
            
            cell.setupAddMoreCell(isBaggege: true, isSelected: isSelected, passenger: passenger, baggage: baggage, isDeparture: isDeparture)
            return cell
        case clvNormalLuggage:
            let cell = collectionView.dequeueCollectionCell(VietjetLuggageCollectionViewCell.self, indexPath: indexPath)
            let baggage = isDeparture ? VietjetDataManager.shared.departureBaggages[indexPath.row] : VietjetDataManager.shared.returnBaggages[indexPath.row]
            let isSelected = isDeparture ? selectedBaggage.isDeparture && indexPath.row == selectedBaggage.index : !selectedBaggage.isDeparture && indexPath.row == selectedBaggage.index
            
            cell.setupCell(baggage: baggage, isSelected: isSelected)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case clvSelectedPassenger:
            if isDeparture {
                selectedDeparturePassengerIndex = indexPath.row
            } else {
                selectedReturnPassengerIndex = indexPath.row
            }
            
            clvSelectedPassenger.reloadData()
            clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
                if self.isDeparture && self.departureBaggages.count > 0 {
                    self.clvSelectedPassenger.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                } else if !self.isDeparture && self.returnBaggages.count > 0 {
                    self.clvSelectedPassenger.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                }
            })
            clvNormalLuggage.reloadData()
        case clvNormalLuggage:
            selectedBaggage.isDeparture = isDeparture
            selectedBaggage.index = indexPath.row
            selectedBaggage.passengerIndex = isDeparture ? selectedDeparturePassengerIndex : selectedReturnPassengerIndex
            selectedBaggage.baggage = isDeparture ? VietjetDataManager.shared.departureBaggages[indexPath.row] : VietjetDataManager.shared.returnBaggages[indexPath.row]
            
            clvSelectedPassenger.reloadData()
            clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
                if self.isDeparture && self.departureBaggages.count > 0 {
                    self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedDeparturePassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                } else if !self.isDeparture && self.returnBaggages.count > 0 {
                    self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedReturnPassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
                }
            })
            clvNormalLuggage.reloadData()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case clvSelectedPassenger:
            return CGSize(width: 200, height: 125)
        case clvNormalLuggage:
            let width = (self.clvNormalLuggage.frame.size.width - 35) / 3
            let height = width * 104 / 100
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case clvSelectedPassenger:
            return 54
        case clvNormalLuggage:
            return 35
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        default:
            return 0
        }
    }
}
