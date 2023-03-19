//
//  SelectVietjetFlightViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 16/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class
SelectVietjetFlightViewController: UIViewController {

    //MARK:- HEADER
    @IBOutlet weak var lbFlightInfo: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var imgDown: UIImageView!
    
    //MARK:- FROM INFO
    @IBOutlet weak var vFromInfo: UIView!
    @IBOutlet weak var vEditFrom: UIView!
    @IBOutlet weak var vFromDate: UIView!
    @IBOutlet weak var btnPreviousFromDate: UIButton!
    @IBOutlet weak var btnNextFromDate: UIButton!
    @IBOutlet weak var clvFromDate: UICollectionView!
    @IBOutlet weak var vFromTime: UIView!
    @IBOutlet weak var clvFromTime: UICollectionView!
    @IBOutlet weak var cstFromTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var vFromPreview: UIView!
    @IBOutlet var lbFromFlightNo: [UILabel]!
    @IBOutlet var lbFromFlightDate: [UILabel]!
    @IBOutlet var lbFromStartCode: [UILabel]!
    @IBOutlet var lbFromStartCity: [UILabel]!
    @IBOutlet var lbFromStartTime: [UILabel]!
    @IBOutlet var lbFromDuration: [UILabel]!
    @IBOutlet var lbFromEndCode: [UILabel]!
    @IBOutlet var lbFromEndCity: [UILabel]!
    @IBOutlet var lbFromEndTime: [UILabel]!
    @IBOutlet weak var vFromSummary: UIView!
    @IBOutlet weak var lbFromPrice: UILabel!
    @IBOutlet weak var lbFromPassenger: UILabel!
    @IBOutlet weak var vFromTicket: UIView!
    @IBOutlet weak var tbvFromTicket: UITableView!
    @IBOutlet weak var cstFromTicketHeight: NSLayoutConstraint!
    
    //MARK:- TO INFO
    @IBOutlet weak var vToInfo: UIView!
    @IBOutlet weak var vEditTo: UIView!
    @IBOutlet weak var vToDate: UIView!
    @IBOutlet weak var clvToDate: UICollectionView!
    @IBOutlet weak var btnPreviousToDate: UIButton!
    @IBOutlet weak var btnNextToDate: UIButton!
    @IBOutlet weak var vToTime: UIView!
    @IBOutlet weak var clvToTime: UICollectionView!
    @IBOutlet weak var cstToTimeHeight: NSLayoutConstraint!
    @IBOutlet weak var vToPreview: UIView!
    @IBOutlet var lbToFlightNo: [UILabel]!
    @IBOutlet var lbToFlightDate: [UILabel]!
    @IBOutlet var lbToStartCode: [UILabel]!
    @IBOutlet var lbToStartCity: [UILabel]!
    @IBOutlet var lbToStartTime: [UILabel]!
    @IBOutlet var lbToDuration: [UILabel]!
    @IBOutlet var lbToEndCode: [UILabel]!
    @IBOutlet var lbToEndCity: [UILabel]!
    @IBOutlet var lbToEndTime: [UILabel]!
    @IBOutlet weak var vToSummary: UIView!
    @IBOutlet weak var lbToPrice: UILabel!
    @IBOutlet weak var lbToPassenger: UILabel!
    @IBOutlet weak var vToTicket: UIView!
    @IBOutlet weak var tbvToTicket: UITableView!
    @IBOutlet weak var cstToTicketHeight: NSLayoutConstraint!
    
    //MARK:- CONTINUE BUTTON
    @IBOutlet weak var vContinue: UIView!
    @IBOutlet weak var tbnContinue: UIButton!
    
    //MARK:- CIRCLE
    @IBOutlet var vCircles: [UIView]!
    
    private var currentStep: Int = 0
    private var departureDates: [Date] = []
    private var returnDates: [Date] = []
    private var selectedDepartureIndex: Int = 0
    private var selectedReturnIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTableView()
        setupUI()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        DispatchQueue.main.async {
            for circle in self.vCircles {
                circle.roundCorners(.allCorners, radius: 16)
            }
            self.vPrice.roundCorners(.allCorners, radius: 20)
            self.vFromDate.roundCorners(.allCorners, radius: 10)
            self.vFromPreview.roundCorners(.allCorners, radius: 10)
            self.vFromSummary.roundCorners(.allCorners, radius: 10)
            self.vToDate.roundCorners(.allCorners, radius: 10)
            self.vToPreview.roundCorners(.allCorners, radius: 10)
            self.vToSummary.roundCorners(.allCorners, radius: 10)
            self.vToTicket.roundCorners(.allCorners, radius: 20)
            self.tbnContinue.roundCorners(.allCorners, radius: 5)
        }
    }

    private func setupUI() {
        title = "Thông tin chuyến bay"
        addBackButton(#selector(handleBackButton))
        
        makeDepartureDateList()
        makeReturnDateList()
        setupHeaderView()
        setupStep()
    }
    
    @objc func handleBackButton() {
        if currentStep > 1 {
            currentStep -= 1
            setupStep()
        } else {
            VietjetDataManager.shared.travelOptions = VietjetTravelOption(JSON: [:])!
            VietjetDataManager.shared.selectedDepartureTravel = VietjetTravel(JSON: [:])!
            VietjetDataManager.shared.selectedReturnTravel = VietjetTravel(JSON: [:])!
            VietjetDataManager.shared.selectedDepartureFareOption = FareOption(JSON: [:])!
            VietjetDataManager.shared.selectedReturnFareOption = FareOption(JSON: [:])!
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setupStep() {
        DispatchQueue.main.async {
            switch self.currentStep {
            case 1:
                if !self.vToInfo.isHidden && self.vToSummary.isHidden {
                    self.vToInfo.isHidden = true
                }
                self.vFromInfo.isHidden = false
                self.vEditFrom.isHidden = true
                self.vFromDate.isHidden = false
                self.vFromTime.isHidden = false
                self.vFromPreview.isHidden = true
                self.vFromSummary.isHidden = true
                self.vFromTicket.isHidden = true
                self.vContinue.isHidden = true
                
                self.clvFromTime.reloadData()
                self.clvFromTime.performBatchUpdates(nil, completion: { result in
                    self.cstFromTimeHeight.constant = self.clvFromTime.contentSize.height
                    self.vFromTime.layoutIfNeeded()
                    self.vFromTime.roundCorners(.allCorners, radius: 20)
                })
            case 2:
                self.vFromDate.isHidden = true
                self.vFromTime.isHidden = true
                self.vFromPreview.isHidden = false
                self.vFromTicket.isHidden = false
                self.vContinue.isHidden = false
                
                if !self.vToInfo.isHidden && !self.vToSummary.isHidden {
//                    self.vContinue.isHidden = false
                } else {
                    self.vFromSummary.isHidden = true
                    self.vToInfo.isHidden = true
                }
                
                for label in self.lbFromFlightNo {
                    label.text = VietjetDataManager.shared.selectedDepartureTravel.airlineNumber
                }
                for label in self.lbFromFlightDate {
                    label.text = VietjetDataManager.shared.selectedFirstDate.stringWith(format: "dd/MM/yyyy")
                }
                for label in self.lbFromStartCode {
                    label.text = VietjetDataManager.shared.selectedDepartureCity.code
                }
                for label in self.lbFromStartCity {
                    label.text = VietjetDataManager.shared.selectedDepartureCity.name
                }
                for label in self.lbFromStartTime {
                    label.text = VietjetDataManager.shared.selectedDepartureTravel.departureTime
                }
                for label in self.lbFromEndCode {
                    label.text = VietjetDataManager.shared.selectedArrivalCity.code
                }
                for label in self.lbFromEndCity {
                    label.text = VietjetDataManager.shared.selectedArrivalCity.name
                }
                for label in self.lbFromEndTime {
                    label.text = VietjetDataManager.shared.selectedDepartureTravel.cityPair.arrival.hours
                }
                for label in self.lbFromDuration {
                    label.text = VietjetDataManager.shared.selectedDepartureTravel.totalTime
                }
                
                self.setupPrice()
                
                self.tbvFromTicket.reloadData()
                self.tbvFromTicket.performBatchUpdates(nil, completion: { result in
                    self.cstFromTicketHeight.constant = self.tbvFromTicket.contentSize.height
                    self.vFromTicket.layoutIfNeeded()
                    self.vFromTicket.roundCorners(.allCorners, radius: 20)
                })
            case 3:
                self.vFromPreview.isHidden = true
                self.vFromTicket.isHidden = true
                self.vContinue.isHidden = true
                self.vFromSummary.isHidden = false
                self.vEditFrom.isHidden = false
                
                if !self.vToInfo.isHidden && !self.vToSummary.isHidden {
                    self.currentStep = 5
                    self.vContinue.isHidden = false
                } else {
                    self.vToInfo.isHidden = false
                    self.vEditTo.isHidden = true
                    self.vToDate.isHidden = false
                    self.vToTime.isHidden = false
                    self.vToPreview.isHidden = true
                    self.vToSummary.isHidden = true
                    self.vToTicket.isHidden = true
                }
                
                self.clvToTime.reloadData()
                self.clvToTime.performBatchUpdates(nil, completion: { result in
                    self.cstToTimeHeight.constant = self.clvToTime.contentSize.height
                    self.vToTime.layoutIfNeeded()
                    self.vToTime.roundCorners(.allCorners, radius: 20)
                })
                
                self.lbFromFlightNo.last!.text = VietjetDataManager.shared.selectedDepartureTravel.airlineNumber + " - " + VietjetDataManager.shared.selectedDepartureFareOption.fareClass
                let fromPrice = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT
                self.lbFromPrice.text = "\(Common.convertCurrencyV2(value: fromPrice)) VNĐ"
                self.lbFromPassenger.text = "\(VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount) Hành khách"
                
                self.setupPrice()
                
                if VietjetDataManager.shared.isOneWay {
                    self.vContinue.isHidden = false
                    self.vToInfo.isHidden = true
                }
            case 4:
                self.vToDate.isHidden = true
                self.vToTime.isHidden = true
                self.vToPreview.isHidden = false
                self.vToTicket.isHidden = false
                self.vContinue.isHidden = false
                self.vToSummary.isHidden = true
                
                for label in self.lbToFlightNo {
                    label.text = VietjetDataManager.shared.selectedReturnTravel.airlineNumber
                }
                for label in self.lbToFlightDate {
                    label.text = VietjetDataManager.shared.selectedLastDate!.stringWith(format: "dd/MM/yyyy")
                }
                for label in self.lbToStartCode {
                    label.text = VietjetDataManager.shared.selectedArrivalCity.code
                }
                for label in self.lbToStartCity {
                    label.text = VietjetDataManager.shared.selectedArrivalCity.name
                }
                for label in self.lbToStartTime {
                    label.text = VietjetDataManager.shared.selectedReturnTravel.departureTime
                }
                for label in self.lbToEndCode {
                    label.text = VietjetDataManager.shared.selectedDepartureCity.code
                }
                for label in self.lbToEndCity {
                    label.text = VietjetDataManager.shared.selectedDepartureCity.name
                }
                for label in self.lbToEndTime {
                    label.text = VietjetDataManager.shared.selectedReturnTravel.cityPair.arrival.hours
                }
                for label in self.lbToDuration {
                    label.text = VietjetDataManager.shared.selectedReturnTravel.totalTime
                }
                
                self.setupPrice()
                
                self.tbvToTicket.reloadData()
                self.tbvToTicket.performBatchUpdates(nil, completion: { result in
                    self.cstToTicketHeight.constant = self.tbvToTicket.contentSize.height
                    self.vToTicket.layoutIfNeeded()
                    self.vToTicket.roundCorners(.allCorners, radius: 20)
                })
            case 5:
                self.vToPreview.isHidden = true
                self.vToTicket.isHidden = true
                self.vContinue.isHidden = false
                self.vToSummary.isHidden = false
                self.vEditTo.isHidden = false
                
                self.lbToFlightNo.last!.text = VietjetDataManager.shared.selectedReturnTravel.airlineNumber + " - " + VietjetDataManager.shared.selectedReturnFareOption.fareClass
                let toPrice = VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
                self.lbToPrice.text = "\(Common.convertCurrencyV2(value: toPrice)) VNĐ"
                self.lbToPassenger.text = "\(VietjetDataManager.shared.adultCount + VietjetDataManager.shared.childCount + VietjetDataManager.shared.infantCount) Hành khách"
                
                self.setupPrice()
            default:
                self.vFromInfo.isHidden = true
                self.vToInfo.isHidden = true
                self.vContinue.isHidden = true
            }
        }
    }
    
    private func setupPrice() {
        let price = VietjetDataManager.shared.selectedDepartureFareOption.totalAmountFRT + VietjetDataManager.shared.selectedReturnFareOption.totalAmountFRT
        self.lbPrice.text = "\(Common.convertCurrencyV2(value: price)) VNĐ"
        
        imgDown.isHidden = price == 0
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
    }
    
    private func setupCollectionView() {
        clvFromDate.registerCollectionCell(VietjetDateCollectionViewCell.self)
        clvToDate.registerCollectionCell(VietjetDateCollectionViewCell.self)
        
        clvFromTime.registerCollectionCell(VietjetTimeCollectionViewCell.self)
        clvToTime.registerCollectionCell(VietjetTimeCollectionViewCell.self)
    }
    
    private func setupTableView() {
        tbvFromTicket.registerTableCell(VietjetTicketClassTableViewCell.self)
        tbvToTicket.registerTableCell(VietjetTicketClassTableViewCell.self)
        
        tbvFromTicket.estimatedRowHeight = 100
        tbvToTicket.estimatedRowHeight = 100
        
        tbvFromTicket.rowHeight = UITableView.automaticDimension
        tbvToTicket.rowHeight = UITableView.automaticDimension
    }
    
    private func makeDepartureDateList() {
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
        selectedDepartureIndex = days.count - 1
        
        for _ in 1...7 {
            afterFirstDate = afterCal.date(byAdding: .day, value: 1, to: afterFirstDate)!
            if !VietjetDataManager.shared.isOneWay {
                let lastDate = VietjetDataManager.shared.selectedLastDate!
                let lastCal = Calendar.current
                let currentLastDate = lastCal.startOfDay(for: lastDate)
                
                if afterFirstDate > currentLastDate {
                    break
                }
            }
            
            days.append(afterFirstDate)
        }
        
        departureDates = days
        clvFromDate.reloadData()
        clvFromDate.performBatchUpdates(nil, completion: { result in
            self.clvFromDate.selectItem(at: IndexPath(row: self.selectedDepartureIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        setupFromDateButton()
    }
    
    private func makeReturnDateList() {
        guard !VietjetDataManager.shared.isOneWay else { return }
        
        let lastDate = VietjetDataManager.shared.selectedLastDate!
        let firstDate = VietjetDataManager.shared.selectedFirstDate
        
        let lastCal = Calendar.current
        let beforeCal = Calendar.current
        let afterCal = Calendar.current
        let firstCal = Calendar.current

        let currentLastDate = lastCal.startOfDay(for: lastDate)
        var beforeLastDate = beforeCal.startOfDay(for: lastDate)
        var afterLastDate = afterCal.startOfDay(for: lastDate)
        let currentFirstDate = firstCal.startOfDay(for: firstDate)
        
        var days: [Date] = []
        
        for _ in 1...7 {
            beforeLastDate = beforeCal.date(byAdding: .day, value: -1, to: beforeLastDate)!
            if beforeLastDate < currentFirstDate {
                break
            }
            
            days.append(beforeLastDate)
        }
        
        days.reverse()
        days.append(currentLastDate)
        selectedReturnIndex = days.count - 1
        
        for _ in 1...7 {
            afterLastDate = afterCal.date(byAdding: .day, value: 1, to: afterLastDate)!
            days.append(afterLastDate)
        }
        
        returnDates = days
        clvToDate.reloadData()
        clvToDate.performBatchUpdates(nil, completion: { result in
            self.clvToDate.selectItem(at: IndexPath(row: self.selectedReturnIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        })
        setupToDateButton()
    }
    
    private func loadData() {
        let from = VietjetDataManager.shared.selectedDepartureCity.code
        let to = VietjetDataManager.shared.selectedArrivalCity.code
        let fromTime = VietjetDataManager.shared.selectedFirstDate.stringWith(format: "yyyy-MM-dd")
        let toTime = VietjetDataManager.shared.isOneWay ? "" : VietjetDataManager.shared.selectedLastDate!.stringWith(format: "yyyy-MM-dd")
        let adult = VietjetDataManager.shared.adultCount
        let child = VietjetDataManager.shared.childCount
        let infant = VietjetDataManager.shared.infantCount
            
        Provider.shared.vietjetAPIService.getTravelOptions(from: from, to: to, fromTime: fromTime, adult: adult, child: child, infant: infant, toTime: toTime, reservationKey: "", journeyKey: "", success:  { [weak self] data in
            guard let self = self, let result = data else { return }
            if result.departureOption.travels.isEmpty {
                self.showAlertOneButton(title: "Thông báo", with: "Không tìm thấy chuyến bay phù hợp, bạn vui lòng điều chỉnh lại thông tin ngày bay hoặc điểm đi/đến", titleButton: "OK")
                VietjetDataManager.shared.travelOptions = VietjetTravelOption(JSON: [:])!
            } else {
                VietjetDataManager.shared.travelOptions = result
                if self.currentStep == 0 || self.currentStep == 1 {
                    self.currentStep = 1
                } else {
                    self.currentStep = 3
                }
            }
            
            self.setupStep()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            VietjetDataManager.shared.travelOptions = VietjetTravelOption(JSON: [:])!
            self.setupStep()
        })
    }
    
    private func setupFromDateButton() {
        if selectedDepartureIndex == 0 {
            btnPreviousFromDate.isHidden = true
        } else {
            btnPreviousFromDate.isHidden = false
        }
        
        if selectedDepartureIndex == departureDates.count - 1 {
            btnNextFromDate.isHidden = true
        } else {
            btnNextFromDate.isHidden = false
        }
    }
    
    private func setupToDateButton() {
        if selectedReturnIndex == 0 {
            btnPreviousToDate.isHidden = true
        } else {
            btnPreviousToDate.isHidden = false
        }
        
        if selectedReturnIndex == returnDates.count - 1 {
            btnNextToDate.isHidden = true
        } else {
            btnNextToDate.isHidden = false
        }
    }
    
    @IBAction func editFromButtonPressed(_ sender: Any) {
        currentStep = 1
        setupStep()
    }
    
    @IBAction func previousFromButtonPressed(_ sender: Any) {
        if selectedDepartureIndex - 1 >= 0 {
            selectedDepartureIndex -= 1
        }
        
        clvFromDate.selectItem(at: IndexPath(row: selectedDepartureIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        makeReturnDateList()
        loadData()
        setupFromDateButton()
    }
    
    @IBAction func nextFromButtonPressed(_ sender: Any) {
        if selectedDepartureIndex + 1 < departureDates.count {
            selectedDepartureIndex += 1
        }
        
        clvFromDate.selectItem(at: IndexPath(row: selectedDepartureIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        makeReturnDateList()
        loadData()
        setupFromDateButton()
    }
    
    @IBAction func editToButtonPressed(_ sender: Any) {
        currentStep = 3
        vToSummary.isHidden = true
        setupStep()
    }
    
    @IBAction func previousToButtonPressed(_ sender: Any) {
        if selectedReturnIndex - 1 >= 0 {
            selectedReturnIndex -= 1
        }
        
        clvToDate.selectItem(at: IndexPath(row: selectedReturnIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        loadData()
        setupToDateButton()
    }
    
    @IBAction func nextToButtonPressed(_ sender: Any) {
        if selectedReturnIndex + 1 < returnDates.count {
            selectedReturnIndex += 1
        }
        
        clvToDate.selectItem(at: IndexPath(row: selectedReturnIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
        loadData()
        setupToDateButton()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if currentStep == 2 {
            currentStep = 3
            setupStep()
        } else if currentStep == 3 || currentStep == 5 {
            let vc = VietjetPassengerInfoViewController()
            navigationController?.pushViewController(vc, animated: true)
        } else if currentStep == 4 {
            currentStep = 5
            setupStep()
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

extension SelectVietjetFlightViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case clvFromDate:
            return departureDates.count
        case clvToDate:
            return returnDates.count
        case clvFromTime:
            return VietjetDataManager.shared.travelOptions.departureOption.travels.count
        case clvToTime:
            return VietjetDataManager.shared.travelOptions.returnOption.travels.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case clvFromDate:
            let cell = collectionView.dequeueCollectionCell(VietjetDateCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(departureDates[indexPath.row])
            return cell
        case clvToDate:
            let cell = collectionView.dequeueCollectionCell(VietjetDateCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(returnDates[indexPath.row])
            return cell
        case clvFromTime:
            let cell = collectionView.dequeueCollectionCell(VietjetTimeCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(VietjetDataManager.shared.travelOptions.departureOption.travels[indexPath.row])
            return cell
        case clvToTime:
            let cell = collectionView.dequeueCollectionCell(VietjetTimeCollectionViewCell.self, indexPath: indexPath)
            cell.setupCell(VietjetDataManager.shared.travelOptions.returnOption.travels[indexPath.row])
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case clvFromDate:
            selectedDepartureIndex = indexPath.row
            VietjetDataManager.shared.selectedFirstDate = departureDates[indexPath.row]
            clvFromDate.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            makeReturnDateList()
            loadData()
            setupFromDateButton()
        case clvToDate:
            selectedReturnIndex = indexPath.row
            VietjetDataManager.shared.selectedLastDate = returnDates[indexPath.row]
            clvToDate.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            loadData()
            setupToDateButton()
        case clvFromTime:
            VietjetDataManager.shared.selectedDepartureTravel = VietjetDataManager.shared.travelOptions.departureOption.travels[indexPath.row]
            VietjetDataManager.shared.selectedDepartureFareOption = VietjetDataManager.shared.selectedDepartureTravel.fareOptions.first ?? FareOption(JSON: [:])!
            currentStep = 2
            setupStep()
        case clvToTime:
            VietjetDataManager.shared.selectedReturnTravel = VietjetDataManager.shared.travelOptions.returnOption.travels[indexPath.row]
            VietjetDataManager.shared.selectedReturnFareOption = VietjetDataManager.shared.selectedReturnTravel.fareOptions.first ?? FareOption(JSON: [:])!
            currentStep = 4
            setupStep()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case clvFromDate, clvToDate:
            let width = (UIScreen.main.bounds.width - 100) / 3
            return CGSize(width: width, height: 70)
        case clvFromTime:
            let width = (self.clvFromTime.frame.size.width - 20) / 3
            let height = width * 131 / 107
            return CGSize(width: width, height: height)
        case clvToTime:
            let width = (self.clvToTime.frame.size.width - 20) / 3
            let height = width * 131 / 107
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case clvFromDate, clvToDate:
            return 0
        case clvFromTime, clvToTime:
            return 10
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case clvFromDate, clvToDate:
            return 0
        case clvFromTime, clvToTime:
            return 0
        default:
            return 0
        }
    }
}

extension SelectVietjetFlightViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvFromTicket:
            return VietjetDataManager.shared.selectedDepartureTravel.fareOptions.count
        case tbvToTicket:
            return VietjetDataManager.shared.selectedReturnTravel.fareOptions.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetTicketClassTableViewCell.self)
        cell.selectionStyle = .none
        
        switch tableView {
        case tbvFromTicket:
            let isSelected = VietjetDataManager.shared.selectedDepartureFareOption.bookingKey == VietjetDataManager.shared.selectedDepartureTravel.fareOptions[indexPath.row].bookingKey
            cell.setupCell(VietjetDataManager.shared.selectedDepartureTravel.fareOptions[indexPath.row], isSelected: isSelected)
            cell.didExpand = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.tbvFromTicket.reloadData()
                    self.tbvFromTicket.performBatchUpdates(nil, completion: { result in
                        self.cstFromTicketHeight.constant = self.tbvFromTicket.contentSize.height
                        self.vFromTicket.layoutIfNeeded()
                        self.vFromTicket.roundCorners(.allCorners, radius: 20)
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
        case tbvToTicket:
            let isSelected = VietjetDataManager.shared.selectedReturnFareOption.bookingKey == VietjetDataManager.shared.selectedReturnTravel.fareOptions[indexPath.row].bookingKey
            cell.setupCell(VietjetDataManager.shared.selectedReturnTravel.fareOptions[indexPath.row], isSelected: isSelected)
            cell.didExpand = { [weak self] in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.tbvToTicket.reloadData()
                    self.tbvToTicket.performBatchUpdates(nil, completion: { result in
                        self.cstToTicketHeight.constant = self.tbvToTicket.contentSize.height
                        self.vToTicket.layoutIfNeeded()
                        self.vToTicket.roundCorners(.allCorners, radius: 20)
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
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case tbvFromTicket:
            VietjetDataManager.shared.selectedDepartureFareOption = VietjetDataManager.shared.selectedDepartureTravel.fareOptions[indexPath.row]
            setupPrice()
            tbvFromTicket.reloadData()
        case tbvToTicket:
            VietjetDataManager.shared.selectedReturnFareOption = VietjetDataManager.shared.selectedReturnTravel.fareOptions[indexPath.row]
            setupPrice()
            tbvToTicket.reloadData()
        default:
            break
        }
    }
}
