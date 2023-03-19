//
//  VietjetSeatViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 20/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetSeatViewController: UIViewController {

    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    @IBOutlet weak var stvOneWayTab: UIStackView!
    @IBOutlet weak var vFromSelected: UIView!
    @IBOutlet weak var vToSelected: UIView!
    @IBOutlet weak var clvSelectedPassenger: UICollectionView!
    @IBOutlet var circleViews: [UIView]!
    @IBOutlet weak var tbvSeat: UITableView!
    @IBOutlet weak var vConfirm: UIView!
    @IBOutlet weak var lbSeatPrice: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    
    private var isDeparture: Bool = true
    private var selectedDeparturePassengerIndex: Int = 0
    private var selectedReturnPassengerIndex: Int = 0
    private var selectingSeat: VietjetSeatOption = VietjetSeatOption(JSON: [:])!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
        setupTableView()
        loadData()
    }

    private func setupUI() {
        title = "Chọn chỗ ngồi"
        addBackButton()
        
        for circle in circleViews {
            circle.makeCircle()
        }
        vPrice.roundCorners(.allCorners, radius: 20)
        vConfirm.roundCorners(.allCorners, radius: 10)
        btnConfirm.roundCorners(.allCorners, radius: 25/2)
        vConfirm.isHidden = true
        
        if VietjetDataManager.shared.isOneWay {
            stvOneWayTab.isHidden = true
        } else {
            stvOneWayTab.isHidden = false
        }
        
        setupHeaderView()
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
        if isDeparture && VietjetDataManager.shared.departureSeat.seatOptions.isEmpty {
            Provider.shared.vietjetAPIService.getSeatOptions(bookingKey: VietjetDataManager.shared.selectedDepartureFareOption.bookingKey, success: { [weak self] data in
                guard let self = self, let result = data else { return }
                VietjetDataManager.shared.departureSeat = result
                self.tbvSeat.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else if !isDeparture && VietjetDataManager.shared.returnSeat.seatOptions.isEmpty {
            Provider.shared.vietjetAPIService.getSeatOptions(bookingKey: VietjetDataManager.shared.selectedReturnFareOption.bookingKey, success: { [weak self] data in
                guard let self = self, let result = data else { return }
                VietjetDataManager.shared.returnSeat = result
                self.tbvSeat.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
    }
    
    private func selectSeat(seat: VietjetSeatOption) {
        vConfirm.isHidden = false
        if isDeparture {
            if VietjetDataManager.shared.selectedDepartureSeats.contains(where: { $0.selectionKey == seat.selectionKey }) {
                btnConfirm.setTitle("Bỏ qua", for: .normal)
            } else {
                btnConfirm.setTitle("Xác nhận", for: .normal)
//                if let _ = VietjetDataManager.shared.passengers[selectedDeparturePassengerIndex].infantProfile {
//                    if !seat.infant {
//                        showAlertOneButton(title: "Thông báo", with: "Ghế đang chọn không phù hợp khi đi kèm với em bé.\nVui lòng chọn ghế khác", titleButton: "OK")
//                        return
//                    }
//                }
            }
        } else {
            if VietjetDataManager.shared.selectedReturnSeats.contains(where: { $0.selectionKey == seat.selectionKey }) {
                btnConfirm.setTitle("Bỏ qua", for: .normal)
            } else {
                btnConfirm.setTitle("Xác nhận", for: .normal)
//                if let _ = VietjetDataManager.shared.passengers[selectedReturnPassengerIndex].infantProfile {
//                    if !seat.infant {
//                        showAlertOneButton(title: "Thông báo", with: "Ghế đang chọn không phù hợp khi đi kèm với em bé.\nVui lòng chọn ghế khác", titleButton: "OK")
//                        return
//                    }
//                }
            }
        }
        
        lbSeatPrice.text = "\(Common.convertCurrencyV2(value: seat.seatCharges.totalAmountFRT)) VNĐ"
        selectingSeat = seat
        tbvSeat.reloadData()
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
        if btnConfirm.title(for: .normal) == "Xác nhận" {
            if isDeparture {
                VietjetDataManager.shared.selectedDepartureSeats[selectedDeparturePassengerIndex] = selectingSeat
            } else {
                VietjetDataManager.shared.selectedReturnSeats[selectedReturnPassengerIndex] = selectingSeat
            }
        } else {
            if isDeparture {
                VietjetDataManager.shared.selectedDepartureSeats[selectedDeparturePassengerIndex] = VietjetSeatOption(JSON: [:])!
            } else {
                VietjetDataManager.shared.selectedReturnSeats[selectedReturnPassengerIndex] = VietjetSeatOption(JSON: [:])!
            }
        }
        
        selectingSeat = VietjetSeatOption(JSON: [:])!
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.isDeparture ? self.selectedDeparturePassengerIndex : self.selectedReturnPassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        
        tbvSeat.reloadData()
        vConfirm.isHidden = true
        setupHeaderView()
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

extension VietjetSeatViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return VietjetDataManager.shared.passengers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(VietjetSelectingCollectionViewCell.self, indexPath: indexPath)
        let isSelected = isDeparture ? indexPath.row == selectedDeparturePassengerIndex : indexPath.row == selectedReturnPassengerIndex
        let passenger = VietjetDataManager.shared.passengers[indexPath.row]
        let seat = isDeparture ? VietjetDataManager.shared.selectedDepartureSeats[indexPath.row] : VietjetDataManager.shared.selectedReturnSeats[indexPath.row]
        
        cell.setupCell(isBaggege: false, isSelected: isSelected, passenger: passenger, seat: seat, isDeparture: isDeparture)
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

extension VietjetSeatViewController: UITableViewDelegate, UITableViewDataSource {
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
        for (index, seat) in seats.enumerated() {
            if isDeparture {
                if VietjetDataManager.shared.selectedDepartureSeats.contains(where: { $0.selectionKey == seat.selectionKey }) {
                    selectedIndexes.append(seats.count < 6 ? index + 1 : index)
                }
            } else {
                if VietjetDataManager.shared.selectedReturnSeats.contains(where: { $0.selectionKey == seat.selectionKey }) {
                    selectedIndexes.append(seats.count < 6 ? index + 1 : index)
                }
            }
            
            if selectingSeat.selectionKey == seat.selectionKey && !selectedIndexes.contains(seats.count < 6 ? index + 1 : index) {
                selectedIndexes.append(seats.count < 6 ? index + 1 : index)
            }
        }
        
        cell.setupCell(seats: seats, index: indexPath.row + 1, selectedIndexes: selectedIndexes)
        cell.didSelectSeat = { seat in
            self.selectSeat(seat: seat)
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
