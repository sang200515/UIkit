//
//  AddMoreSeatViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 06/05/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class AddMoreSeatViewController: UIViewController {
    
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
    @IBOutlet var circleViews: [UIView]!
    @IBOutlet weak var tbvSeat: UITableView!
    @IBOutlet weak var vConfirm: UIView!
    @IBOutlet weak var lbSeatPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private var passengers: [VietjetHistoryPassenger] = []
    private var isDeparture: Bool = true
    private var selectedDeparturePassengerIndex: Int = 0
    private var selectedReturnPassengerIndex: Int = 0
    private var selectedSeat: (isDeparture: Bool, passengerIndex: Int, seat: VietjetSeatOption) = (isDeparture: true, passengerIndex: -1, seat: VietjetSeatOption(JSON: [:])!)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        setupCollectionView()
        setupTableView()
        loadData()
    }

    private func setupData() {
        passengers = VietjetDataManager.shared.historyBooking.passengers.filter { $0.fareApplicability != "infant" }
    }
    
    private func setupUI() {
        title = "Chọn chỗ ngồi"
        addBackButton()
        
        vConfirm.roundCorners(.allCorners, radius: 10)
        btnConfirm.roundCorners(.allCorners, radius: 25/2)
        vConfirm.isHidden = true
        
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
            self.clvSelectedPassenger.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
    }
    
    private func setupTableView() {
        tbvSeat.registerTableCell(VietjetSeatHeaderTableViewCell.self)
        tbvSeat.registerTableCell(VietjetSeatTableViewCell.self)
        tbvSeat.contentInset.bottom = 100
    }
    
    private func loadData() {
        let bookingKey = isDeparture ? VietjetDataManager.shared.historyBooking.departure.bookingKey : VietjetDataManager.shared.historyBooking.arrival!.bookingKey
        
        if isDeparture && VietjetDataManager.shared.departureSeat.seatOptions.isEmpty {
            Provider.shared.vietjetAPIService.getSeatOptions(bookingKey: bookingKey, success: { [weak self] data in
                guard let self = self, let result = data else { return }
                VietjetDataManager.shared.departureSeat = result
                self.tbvSeat.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else if !isDeparture && VietjetDataManager.shared.returnSeat.seatOptions.isEmpty {
            Provider.shared.vietjetAPIService.getSeatOptions(bookingKey: bookingKey, success: { [weak self] data in
                guard let self = self, let result = data else { return }
                VietjetDataManager.shared.returnSeat = result
                self.tbvSeat.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
    
    private func prepareParam() {
        VietjetDataManager.shared.seatOrderParam.order.shopcode = Cache.user!.ShopCode
        VietjetDataManager.shared.seatOrderParam.order.usercode = Cache.user!.UserName
        VietjetDataManager.shared.seatOrderParam.order.deviceID = 2
        VietjetDataManager.shared.seatOrderParam.order.totalAmount = selectedSeat.seat.seatCharges.totalAmount
        VietjetDataManager.shared.seatOrderParam.order.totalAmountFRT = selectedSeat.seat.seatCharges.totalAmountFRT
        VietjetDataManager.shared.seatOrderParam.order.xmlPayments = ""
        VietjetDataManager.shared.seatOrderParam.order.xmlPromotions = ""
        VietjetDataManager.shared.seatOrderParam.order.xmlItemProducts = ""
        
        VietjetDataManager.shared.seatOrderParam.contact.fullName = VietjetDataManager.shared.historyBooking.contactInformation.name
        VietjetDataManager.shared.seatOrderParam.contact.phoneNumber = VietjetDataManager.shared.historyBooking.contactInformation.phoneNumber
        VietjetDataManager.shared.seatOrderParam.contact.email = VietjetDataManager.shared.historyBooking.contactInformation.email
        VietjetDataManager.shared.seatOrderParam.contact.address = VietjetDataManager.shared.historyBooking.contactInformation.address
        
        VietjetDataManager.shared.seatOrderParam.booking.locator = VietjetDataManager.shared.historyBooking.locator
        VietjetDataManager.shared.seatOrderParam.booking.number = VietjetDataManager.shared.historyBooking.number
        VietjetDataManager.shared.seatOrderParam.booking.resKey = VietjetDataManager.shared.historyBooking.key
        VietjetDataManager.shared.seatOrderParam.booking.ancillaryPurchases = nil
        
        let seatPurchases = VietjetSeatPurchases(JSON: [:])!
        let passenger = selectedSeat.isDeparture ? passengers[selectedSeat.passengerIndex] : passengers[selectedSeat.passengerIndex]
        if selectedSeat.isDeparture {
            if let departureSeat = passenger.departure.seatSelection, !departureSeat.key.isEmpty {
                VietjetDataManager.shared.isUpdateSeat = true
            } else {
                VietjetDataManager.shared.isUpdateSeat = false
            }
        } else {
            if let arrivalSeat = passenger.arrival.seatSelection, !arrivalSeat.key.isEmpty {
                VietjetDataManager.shared.isUpdateSeat = true
            } else {
                VietjetDataManager.shared.isUpdateSeat = false
            }
        }
        
        seatPurchases.seatPurchasesDescription = VietjetDataManager.shared.isUpdateSeat ? "Update seat \(selectedSeat.seat.seatMapCell.rowIdentifier)-\(selectedSeat.seat.seatMapCell.seatIdentifier)" : "Add seat \(selectedSeat.seat.seatMapCell.rowIdentifier)-\(selectedSeat.seat.seatMapCell.seatIdentifier)"
        seatPurchases.selectionKey = selectedSeat.seat.selectionKey
        seatPurchases.passenger.key = passenger.key
        seatPurchases.passenger.href = passenger.href
        seatPurchases.journey.key = selectedSeat.isDeparture ? VietjetDataManager.shared.historyBooking.departure.key : VietjetDataManager.shared.historyBooking.arrival!.key
        seatPurchases.journey.href = selectedSeat.isDeparture ? VietjetDataManager.shared.historyBooking.departure.href : VietjetDataManager.shared.historyBooking.arrival!.href
        seatPurchases.segment.key = selectedSeat.isDeparture ? VietjetDataManager.shared.historyBooking.departure.segment.key : VietjetDataManager.shared.historyBooking.arrival!.segment.key
        
        if VietjetDataManager.shared.isUpdateSeat {
            seatPurchases.seatSelectionKey = selectedSeat.isDeparture ? passenger.departure.seatSelection!.key : passenger.arrival.seatSelection!.key
            seatPurchases.timestamp = selectedSeat.isDeparture ? passenger.departure.seatSelection!.timestamp : passenger.arrival.seatSelection!.timestamp
        }
        
        VietjetDataManager.shared.seatOrderParam.booking.seatPurchases = seatPurchases
        VietjetDataManager.shared.isAddonBaggage = false
    }
    
    private func calculatePrice() {
        prepareParam()
        if VietjetDataManager.shared.isUpdateSeat {
            Provider.shared.vietjetAPIService.calculateVietjetUpdateSeatPrice(param: VietjetDataManager.shared.seatOrderParam, success: { [weak self] data in
                guard let self = self, let result = data else { return }
                let vc = VietjetPaymentViewController()
                vc.bill = result
                self.navigationController?.pushViewController(vc, animated: true)
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else {
            Provider.shared.vietjetAPIService.calculateVietjetSeatPrice(param: VietjetDataManager.shared.seatOrderParam, success: { [weak self] data in
                guard let self = self, let result = data else { return }
                let vc = VietjetPaymentViewController()
                vc.bill = result
                self.navigationController?.pushViewController(vc, animated: true)
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
    
    @IBAction func fromButtonPressed(_ sender: Any) {
        vFromSelected.isHidden = false
        vToSelected.isHidden = true
        
        isDeparture = true
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedDeparturePassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        tbvSeat.reloadData()
        loadData()
    }
    
    @IBAction func toButtonPressed(_ sender: Any) {
        vFromSelected.isHidden = true
        vToSelected.isHidden = false
        
        isDeparture = false
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedReturnPassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        tbvSeat.reloadData()
        loadData()
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if selectedSeat.seat.selectionKey.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn chỗ ngồi muốn mua thêm/thay đổi", titleButton: "OK")
        } else {
            calculatePrice()
        }
    }
}

extension AddMoreSeatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return passengers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(VietjetSelectingCollectionViewCell.self, indexPath: indexPath)
        let isSelected = isDeparture ? indexPath.row == selectedDeparturePassengerIndex : indexPath.row == selectedReturnPassengerIndex
        let passenger = passengers[indexPath.row]
        var seat = VietjetSeatOption(JSON: [:])!
        if isDeparture && selectedSeat.isDeparture && selectedSeat.passengerIndex == indexPath.row {
            seat = selectedSeat.seat
        } else if !isDeparture && !selectedSeat.isDeparture && selectedSeat.passengerIndex == indexPath.row {
            seat = selectedSeat.seat
        }
        
        cell.setupAddMoreCell(isBaggege: false, isSelected: isSelected, passenger: passenger, seat: seat, isDeparture: isDeparture)
        if seat.selectionKey.isEmpty {
            if let preSelectedSeat = isDeparture ? passenger.departure.seatSelection : passenger.arrival.seatSelection {
                cell.lbSeat.text = "\(preSelectedSeat.rowIdentifier)-\(preSelectedSeat.seatIdentifier)"
                cell.lbSelection.text = !preSelectedSeat.key.isEmpty ? "Đã chọn" : "Chưa chọn"
                cell.lbSelection.textColor = !preSelectedSeat.key.isEmpty ? UIColor(hexString: "10AF71") : UIColor(hexString: "6C6B6B")
                cell.lbPrice.isHidden = preSelectedSeat.key.isEmpty
                cell.lbSeat.isHidden = preSelectedSeat.key.isEmpty
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isDeparture {
            selectedDeparturePassengerIndex = indexPath.row
        } else {
            selectedReturnPassengerIndex = indexPath.row
        }
        
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            self.clvSelectedPassenger.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        })
        tbvSeat.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 54
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension AddMoreSeatViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDeparture {
            return Int(VietjetDataManager.shared.departureSeat.row) ?? 0
        } else {
            return Int(VietjetDataManager.shared.returnSeat.row) ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueTableCell(VietjetSeatHeaderTableViewCell.self)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetSeatTableViewCell.self)
        let seats = isDeparture ? VietjetDataManager.shared.departureSeat.seatOptions.filter { $0.seatMapCell.rowIdentifier == "\(indexPath.row + 1)" } : VietjetDataManager.shared.returnSeat.seatOptions.filter { $0.seatMapCell.rowIdentifier == "\(indexPath.row + 1)" }
        var selectedIndexes: [Int] = []
        let seatIndexDict = ["A": 0, "B": 1, "C": 2, "D": 3, "E": 4, "F": 5]
        if isDeparture {
            if let seat = passengers[selectedDeparturePassengerIndex].departure.seatSelection, Int(seat.rowIdentifier) == indexPath.row + 1 {
                if let index = seatIndexDict[seat.seatIdentifier] {
                    selectedIndexes.append(index)
                }
            }
        } else {
            if let seat = passengers[selectedReturnPassengerIndex].arrival.seatSelection, Int(seat.rowIdentifier) == indexPath.row + 1 {
                if let index = seatIndexDict[seat.seatIdentifier] {
                    selectedIndexes.append(index)
                }
            }
        }
        
        for (index, seat) in seats.enumerated() {
            if selectedSeat.seat.selectionKey == seat.selectionKey && !selectedIndexes.contains(index) {
                selectedIndexes.append(seats.count < 6 ? index + 1 : index)
            }
        }
        
        cell.setupCell(seats: seats, index: indexPath.row + 1, selectedIndexes: selectedIndexes)
        cell.didSelectSeat = { seat in
            self.selectedSeat.isDeparture = self.isDeparture
            self.selectedSeat.passengerIndex = self.isDeparture ? self.selectedDeparturePassengerIndex : self.selectedReturnPassengerIndex
            self.selectedSeat.seat = seat
            
            self.vConfirm.isHidden = false
            self.lbSeatPrice.text = "\(Common.convertCurrencyV2(value: seat.seatCharges.totalAmountFRT)) VNĐ"
            
            self.clvSelectedPassenger.reloadData()
            self.clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
                self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.isDeparture ? self.selectedDeparturePassengerIndex : self.selectedReturnPassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
            })
            self.tbvSeat.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
