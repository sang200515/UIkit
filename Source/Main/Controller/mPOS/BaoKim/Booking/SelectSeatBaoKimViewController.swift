//
//  SelectSeatBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SelectSeatBaoKimViewController: UIViewController {

    //MARK:- HEADER
    @IBOutlet weak var lbFromTime: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbToTime: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var lbTotalDistance: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbRate: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    
    //MARK:- SEAT
    @IBOutlet weak var svCoach: UIStackView!
    @IBOutlet weak var btnFirstCoach: UIButton!
    @IBOutlet weak var btnSecondCoach: UIButton!
    @IBOutlet weak var clvSeat: UICollectionView!
    @IBOutlet weak var vPrice: UIView!
    @IBOutlet weak var lbSeatTitle: UILabel!
    @IBOutlet weak var lbSelectionSeat: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    var seat: BaoKimSeat = BaoKimSeat(JSON: [:])!
    private var selectedColor: String = "42935D"
    private var isFirstCoach: Bool = true
    private var numberOfColumns: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        title = "Thông tin chuyến xe"
        addBackButton()
        
        let trip = BaoKimDataManager.shared.selectedTrip
        lbFromTime.text = trip.route.schedules.first?.pickupDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mmZ", newFormat: "HH:mm")
        lbFrom.text = trip.route.from.name
        lbToTime.text = trip.route.schedules.last?.arrivalTime.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mmZ", newFormat: "HH:mm")
        lbTo.text = trip.route.to.name
        lbTotalTime.text = "\(trip.route.duration / 60) giờ \(trip.route.duration % 60) phút"
        lbTotalDistance.text = "\(trip.route.distance) km"
        lbName.text = trip.company.name
        lbRate.text = "\(trip.company.ratings.overall)"
        lbDetail.text = trip.route.schedules.first?.vehicleType
        lbDate.text = trip.route.departureDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ", newFormat: "dd/MM/yyyy")
        
        var urlString = trip.company.images.first?.files.the1000X600 ?? ""
        while urlString.first == "/" {
            urlString = String(urlString.dropFirst())
        }
        urlString = "https://" + urlString
        Common.encodeURLImg(urlString: urlString, imgView: imgLogo)
        
        if seat.data.numCoaches < 2 {
            svCoach.isHidden = true
        } else {
            svCoach.isHidden = false
            setupCoachButton()
        }
        numberOfColumns = seat.data.coachSeatTemplate.first?.numCols ?? 0
    }
    
    private func setupCollectionView() {
        clvSeat.registerCollectionCell(BaoKimSeatCell.self)
    }
    
    private func setupCoachButton() {
        if isFirstCoach {
            btnFirstCoach.setTitle(seat.data.coachSeatTemplate.first?.coachName, for: .normal)
            btnFirstCoach.backgroundColor = UIColor(hexString: selectedColor)
            btnFirstCoach.setTitleColor(.white, for: .normal)
            btnSecondCoach.setTitle(seat.data.coachSeatTemplate.last?.coachName, for: .normal)
            btnSecondCoach.backgroundColor = .white
            btnSecondCoach.setTitleColor(.black, for: .normal)
        } else {
            btnSecondCoach.setTitle(seat.data.coachSeatTemplate.last?.coachName, for: .normal)
            btnSecondCoach.backgroundColor = UIColor(hexString: selectedColor)
            btnSecondCoach.setTitleColor(.white, for: .normal)
            btnFirstCoach.setTitle(seat.data.coachSeatTemplate.first?.coachName, for: .normal)
            btnFirstCoach.backgroundColor = .white
            btnFirstCoach.setTitleColor(.black, for: .normal)
        }
        
        clvSeat.reloadData()
    }
    
    private func setupPrice() {
        if BaoKimDataManager.shared.selectedSeats.count > 0 {
            lbSelectionSeat.isHidden = false
            lbSeatTitle.text = "Đặt chỗ:"
            
            var price = 0
            var seatString = ""
            for seat in BaoKimDataManager.shared.selectedSeats {
                price += seat.fare
                seatString += seat.seatCode + ", "
            }
            seatString = seatString.dropLast
            seatString = seatString.dropLast
            lbSelectionSeat.text = seatString
            lbPrice.text = "\(Common.convertCurrencyV2(value: price)) đ"
        } else {
            lbSelectionSeat.isHidden = true
            lbSeatTitle.text = "Chưa đặt chỗ"
            lbPrice.text = "0 đ"
        }
    }
    
    @IBAction func firstCoachButtonPressed(_ sender: Any) {
        isFirstCoach = true
        numberOfColumns = seat.data.coachSeatTemplate.first?.numCols ?? 0
        setupCoachButton()
    }
    
    @IBAction func secondCoachButtonPressed(_ sender: Any) {
        isFirstCoach = false
        numberOfColumns = seat.data.coachSeatTemplate.last?.numCols ?? 0
        setupCoachButton()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if BaoKimDataManager.shared.selectedSeats.count == 0 {
            self.showAlertOneButton(title: "Thông báo", with: "Bạn chưa chọn ghế", titleButton: "OK")
        } else {
//            ProgressView.shared.show()
            let vc = SelectPointBaoKimViewController()
            vc.pickupPoints = seat.data.pickupPoints
            vc.dropoffPoints = seat.data.dropOffPointsatArrive
            self.navigationController?.pushViewController(vc, animated: true)
//            let dispatchGroup = DispatchGroup()
            
//            dispatchGroup.enter()
//            Provider.shared.baokimAPIService.getPoints(pointId: seat.data.pickupPoints.first?.pointId ?? 0, success: { result in
//                guard let data = result else { return }
//                vc.pickupPoints = data.data
//                dispatchGroup.leave()
//            }, failure: { [weak self] error in
//                guard let self = self else { return }
//                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
//                dispatchGroup.leave()
//            })
//
//            dispatchGroup.enter()
//            Provider.shared.baokimAPIService.getPoints(pointId: seat.data.dropOffPointsatArrive.first?.pointId ?? 0, success: { result in
//                guard let data = result else { return }
//                vc.dropoffPoints = data.data
//                dispatchGroup.leave()
//            }, failure: { [weak self] error in
//                guard let self = self else { return }
//                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
//                dispatchGroup.leave()
//            })
            
//            dispatchGroup.notify(queue: .main) {
//                ProgressView.shared.hide()
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
    }
}

extension SelectSeatBaoKimViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFirstCoach {
            return (seat.data.coachSeatTemplate.first?.numCols ?? 0) * (seat.data.coachSeatTemplate.first?.numRows ?? 0)
        } else {
            return (seat.data.coachSeatTemplate.last?.numCols ?? 0) * (seat.data.coachSeatTemplate.last?.numRows ?? 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCollectionCell(BaoKimSeatCell.self, indexPath: indexPath)
        let seatTemplate = (isFirstCoach ? seat.data.coachSeatTemplate.first : seat.data.coachSeatTemplate.last) ?? BaoKimCoachSeatTemplate(JSON: [:])!
        let row = (indexPath.row / numberOfColumns) + 1
        let col = (indexPath.row % numberOfColumns) + 1
        if let seat = seatTemplate.seats.first(where: { $0.rowNum == row && $0.colNum == col }) {
            cell.setupCell(seat: seat, isSelected: BaoKimDataManager.shared.selectedSeats.contains(where: { $0.seatCode == seat.seatCode && $0.rowNum == row && $0.colNum == col }))
            cell.didSelectSeat = { seat in
                if BaoKimDataManager.shared.selectedSeats.contains(where: { $0.seatCode == seat.seatCode && $0.rowNum == row && $0.colNum == col }) {
                    BaoKimDataManager.shared.selectedSeats.removeAll(where: { $0.seatCode == seat.seatCode && $0.rowNum == row && $0.colNum == col })
                } else {
                    if BaoKimDataManager.shared.selectedSeats.count == 6 {
                        self.showAlertOneButton(title: "Thông báo", with: "Bạn chỉ được phép chọn tối đa 6 ghế cho 1 lần tạo", titleButton: "OK")
                    } else {
                        seat.coachNum = self.isFirstCoach ? 1 : 2
                        BaoKimDataManager.shared.selectedSeats.append(seat)
                    }
                }
                self.clvSeat.reloadItems(at: [indexPath])
                self.setupPrice()
            }
        } else {
            cell.btnSeat.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let space: CGFloat = (UIScreen.main.bounds.width - 60 - CGFloat(70 * numberOfColumns)) / CGFloat(numberOfColumns + 1)
        return space
    }
}
