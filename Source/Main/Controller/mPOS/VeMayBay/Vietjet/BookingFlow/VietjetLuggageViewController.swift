//
//  VietjetLuggageViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class VietjetLuggageViewController: UIViewController {
    
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
    @IBOutlet weak var clvNormalLuggage: UICollectionView!
    @IBOutlet weak var btnContinue: UIButton!
    
    private var isDeparture: Bool = true
    private var selectedDeparturePassengerIndex: Int = 0
    private var selectedReturnPassengerIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        setupCollectionView()
        loadData()
    }
    
    private func setupUI() {
        title = "Chọn hành lý"
        addBackButton()
        
        vPrice.roundCorners(.allCorners, radius: 20)
        btnContinue.roundCorners(.allCorners, radius: 5)
        
        if VietjetDataManager.shared.isOneWay {
            stvOneWayTab.isHidden = true
        } else {
            stvOneWayTab.isHidden = false
        }
        
        setupHeaderView()
    }
    
    private func setupData() {
        VietjetDataManager.shared.choosenDepartureBaggages = VietjetDataManager.shared.selectedDepartureBaggages
        VietjetDataManager.shared.choosenReturnBaggages = VietjetDataManager.shared.selectedReturnBaggages
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
    
    private func loadData() {
        if isDeparture && VietjetDataManager.shared.departureBaggages.isEmpty {
            Provider.shared.vietjetAPIService.getAncillaryOptions(bookingKey: VietjetDataManager.shared.selectedDepartureFareOption.bookingKey, success: { [weak self] data in
                guard let self = self else { return }
                VietjetDataManager.shared.departureBaggages = data
                self.clvNormalLuggage.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        } else if !isDeparture && VietjetDataManager.shared.returnBaggages.isEmpty {
            Provider.shared.vietjetAPIService.getAncillaryOptions(bookingKey: VietjetDataManager.shared.selectedReturnFareOption.bookingKey, success: { [weak self] data in
                guard let self = self else { return }
                VietjetDataManager.shared.returnBaggages = data
                self.clvNormalLuggage.reloadData()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
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
        
        clvNormalLuggage.registerCollectionCell(VietjetLuggageCollectionViewCell.self)
        clvNormalLuggage.contentInset.bottom = 100
    }
    
    @IBAction func fromButtonPressed(_ sender: Any) {
        vFromSelected.isHidden = false
        vToSelected.isHidden = true
        
        isDeparture = true
        clvSelectedPassenger.reloadData()
        clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
            self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedDeparturePassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
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
            self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.selectedReturnPassengerIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        clvNormalLuggage.reloadData()
        loadData()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        VietjetDataManager.shared.selectedDepartureBaggages = VietjetDataManager.shared.choosenDepartureBaggages
        VietjetDataManager.shared.selectedReturnBaggages = VietjetDataManager.shared.choosenReturnBaggages
        
        navigationController?.popViewController(animated: true)
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

extension VietjetLuggageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case clvSelectedPassenger:
            return VietjetDataManager.shared.passengers.count
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
            let passenger = VietjetDataManager.shared.passengers[indexPath.row]
            let baggage = isDeparture ? VietjetDataManager.shared.choosenDepartureBaggages[indexPath.row] : VietjetDataManager.shared.choosenReturnBaggages[indexPath.row]
            
            cell.setupCell(isBaggege: true, isSelected: isSelected, passenger: passenger, baggage: baggage, isDeparture: isDeparture)
            return cell
        case clvNormalLuggage:
            let cell = collectionView.dequeueCollectionCell(VietjetLuggageCollectionViewCell.self, indexPath: indexPath)
            let baggage = isDeparture ? VietjetDataManager.shared.departureBaggages[indexPath.row] : VietjetDataManager.shared.returnBaggages[indexPath.row]
            let isSelected = isDeparture ? VietjetDataManager.shared.choosenDepartureBaggages[selectedDeparturePassengerIndex].purchaseKey == baggage.purchaseKey : VietjetDataManager.shared.choosenReturnBaggages[selectedReturnPassengerIndex].purchaseKey == baggage.purchaseKey
            
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
                self.clvSelectedPassenger.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            })
            clvNormalLuggage.reloadData()
        case clvNormalLuggage:
            if isDeparture {
                if VietjetDataManager.shared.choosenDepartureBaggages[selectedDeparturePassengerIndex].purchaseKey == VietjetDataManager.shared.departureBaggages[indexPath.row].purchaseKey {
                    VietjetDataManager.shared.choosenDepartureBaggages[selectedDeparturePassengerIndex] = VietjetBaggage(JSON: [:])!
                } else {
                    VietjetDataManager.shared.choosenDepartureBaggages[selectedDeparturePassengerIndex] = VietjetDataManager.shared.departureBaggages[indexPath.row]
                }
            } else {
                if VietjetDataManager.shared.choosenReturnBaggages[selectedReturnPassengerIndex].purchaseKey == VietjetDataManager.shared.returnBaggages[indexPath.row].purchaseKey {
                    VietjetDataManager.shared.choosenReturnBaggages[selectedReturnPassengerIndex] = VietjetBaggage(JSON: [:])!
                } else {
                    VietjetDataManager.shared.choosenReturnBaggages[selectedReturnPassengerIndex] = VietjetDataManager.shared.returnBaggages[indexPath.row]
                }
            }
            
            clvSelectedPassenger.reloadData()
            clvSelectedPassenger.performBatchUpdates(nil, completion: { result in
                self.clvSelectedPassenger.selectItem(at: IndexPath(row: self.isDeparture ? self.selectedDeparturePassengerIndex : self.selectedReturnPassengerIndex, section: 0), animated: false, scrollPosition: .centeredHorizontally)
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

class PagingCollectionViewLayout: UICollectionViewFlowLayout {
    
    var velocityThresholdPerPage: CGFloat = 2
    var numberOfItemsPerPage: CGFloat = 1
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }
        
        let pageLength: CGFloat
        let approxPage: CGFloat
        let currentPage: CGFloat
        let speed: CGFloat
        
        if scrollDirection == .horizontal {
            pageLength = (self.itemSize.width + self.minimumLineSpacing) * numberOfItemsPerPage
            approxPage = collectionView.contentOffset.x / pageLength
            speed = velocity.x
        } else {
            pageLength = (self.itemSize.height + self.minimumLineSpacing) * numberOfItemsPerPage
            approxPage = collectionView.contentOffset.y / pageLength
            speed = velocity.y
        }
        
        if speed < 0 {
            currentPage = ceil(approxPage)
        } else if speed > 0 {
            currentPage = floor(approxPage)
        } else {
            currentPage = round(approxPage)
        }
        
        guard speed != 0 else {
            if scrollDirection == .horizontal {
                return CGPoint(x: currentPage * pageLength, y: 0)
            } else {
                return CGPoint(x: 0, y: currentPage * pageLength)
            }
        }
        
        var nextPage: CGFloat = currentPage * (speed > 0 ? 1 : -1)
        
        let increment = speed / velocityThresholdPerPage
        nextPage += (speed < 0) ? ceil(increment) : floor(increment)
        
        if scrollDirection == .horizontal {
            return CGPoint(x: nextPage * pageLength, y: 0)
        } else {
            return CGPoint(x: 0, y: nextPage * pageLength)
        }
    }
}
