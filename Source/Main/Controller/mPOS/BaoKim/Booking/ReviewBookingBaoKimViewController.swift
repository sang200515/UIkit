//
//  ReviewBookingBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 23/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ReviewBookingBaoKimViewController: UIViewController {

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
    @IBOutlet weak var lbSeats: UILabel!
    
    //MARK:- CUSTOMER
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerPhone: UILabel!
    @IBOutlet weak var lbCustomerEmail: UILabel!
    
    //MARK:- POINT
    @IBOutlet weak var lbPickupTime: UILabel!
    @IBOutlet weak var lbPickupName: UILabel!
    @IBOutlet weak var lbPickupAddress: UILabel!
    @IBOutlet weak var lbDropoffTime: UILabel!
    @IBOutlet weak var lbDropoffName: UILabel!
    @IBOutlet weak var lbDropoffAddress: UILabel!
    
    //MARK:- BOOKING
    @IBOutlet weak var vEdit: UIView!
    @IBOutlet weak var vVoucher: UIView!
    @IBOutlet weak var vDiscount: UIStackView!
    @IBOutlet weak var vPrice: UIStackView!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var tfVoucher: CommonTextField!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    private var transactionId: String = ""
    private var didBooking: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    private func setupUI() {
        title = "Thông tin chuyến xe"
        addBackButton(#selector(actionBack))
        
        let trip = BaoKimDataManager.shared.selectedTrip
        lbFromTime.text = trip.route.schedules.first?.pickupDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mmZ", newFormat: "HH:mm")
        lbFrom.text = trip.route.from.name
        lbToTime.text = trip.route.schedules.last?.arrivalTime.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mmZ", newFormat: "HH:mm")
        lbTotalDistance.text = "\(trip.route.distance) km"
        lbTo.text = trip.route.to.name
        lbTotalTime.text = "\(trip.route.duration / 60) giờ \(trip.route.duration % 60) phút"
        lbName.text = trip.company.name
        lbRate.text = "\(trip.company.ratings.overall)"
        lbDetail.text = trip.route.schedules.first?.vehicleType
        lbDate.text = trip.route.departureDate.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ", newFormat: "dd/MM/yyyy")
        var seatString = "Mã ghế: "
        for seat in BaoKimDataManager.shared.selectedSeats {
            seatString += seat.seatCode + ", "
        }
        seatString = seatString.dropLast
        seatString = seatString.dropLast
        lbSeats.text = seatString
        
        var urlString = trip.company.images.first?.files.the1000X600 ?? ""
        while urlString.first == "/" {
            urlString = String(urlString.dropFirst())
        }
        urlString = "https://" + urlString
        Common.encodeURLImg(urlString: urlString, imgView: imgLogo)
        
        lbCustomerName.text = BaoKimDataManager.shared.name
        lbCustomerPhone.text = BaoKimDataManager.shared.phone
        lbCustomerEmail.text = BaoKimDataManager.shared.email
        
        lbPickupTime.text = String(BaoKimDataManager.shared.selectedPickup.realTime.prefix(5))
        lbPickupName.text = BaoKimDataManager.shared.selectedPickup.name
        lbPickupAddress.text = BaoKimDataManager.shared.selectedPickup.address
        lbDropoffTime.text = String(BaoKimDataManager.shared.selectedDropoff.realTime.prefix(5))
        lbDropoffName.text = BaoKimDataManager.shared.selectedDropoff.name
        lbDropoffAddress.text = BaoKimDataManager.shared.selectedDropoff.address
        
        tfVoucher.delegateTextfield = self
        tfVoucher.rightAction = true
    }
    
    @objc private func actionBack() {
        if didBooking {
            showAlertTwoButton(title: "Thông báo", with: "Bạn chưa hoàn tất thanh toán cho mã đặt vé này. Bạn có chắc muốn thoát?", titleButtonOne: "OK", titleButtonTwo: "Cancel", handleButtonOne: {
                self.navigationController?.popToRootViewController(animated: true)
            }, handleButtonTwo: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func prepareParam(seats: String) {
        let param: BaoKimBookingParam = BaoKimBookingParam(JSON: [:])!
        param.transactionId = transactionId
        param.tripCode = BaoKimDataManager.shared.selectedTrip.route.schedules.first!.tripCode&
        param.seats = seats
        param.customerPhone = BaoKimDataManager.shared.phone
        param.customerName = BaoKimDataManager.shared.name
        param.customerEmail = BaoKimDataManager.shared.email
        param.pickup = BaoKimDataManager.shared.selectedPickup.name
        param.pickupId = BaoKimDataManager.shared.selectedPickup.id
        param.transfer = ""
        param.transferId = 0
        param.dropOffInfo = BaoKimDataManager.shared.selectedDropoff.name
        param.dropOffPointId = BaoKimDataManager.shared.selectedDropoff.id
        param.dropOffTransferInfo = ""
        param.arriveTransferId = 0
        param.haveEating = 0
        param.userAgent = ""
        param.note = ""
        param.busId = BaoKimDataManager.shared.selectedTrip.company.id
        param.customerIdCard = 0
        
        BaoKimDataManager.shared.bookTripParam = param
    }
    
    private func getBookingInfo() {
        Provider.shared.baokimAPIService.getBookingInfo(bookingCode: BaoKimDataManager.shared.bookingCode.bookingCode, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            BaoKimDataManager.shared.bookingInfo = data
            self.view.endEditing(true)
            self.lbPrice.text = "\(Common.convertCurrencyV2(value: data.data.first?.amountBooking ?? 0)) VNĐ"
            self.updateBooking()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func updateBooking() {
        if let data = try? JSONSerialization.data(withJSONObject: BaoKimDataManager.shared.bookingInfo.toJSON(), options: []) {
            if let jsonData = String(data: data, encoding: .utf8) {
                Provider.shared.baokimAPIService.updateMPOSBooking(transactionCode: transactionId, bookingCode: BaoKimDataManager.shared.bookingCode.bookingCode, bookingInfo: jsonData, price: BaoKimDataManager.shared.bookingInfo.data.first?.amountBooking ?? 0, success: { result in }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
            }
        }
    }
    
    private func updateVoucher() {
        if let data = try? JSONSerialization.data(withJSONObject: BaoKimDataManager.shared.voucherInfo.toJSON(), options: []) {
            if let jsonData = String(data: data, encoding: .utf8) {
                Provider.shared.baokimAPIService.updateMPOSVoucher(transactionCode: transactionId, bookingCode: BaoKimDataManager.shared.bookingCode.bookingCode, voucherInfo: jsonData, price: BaoKimDataManager.shared.voucherInfo.data.info.fareInfo.couponValue, success: { result in }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
            }
        }
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        guard let voucher = tfVoucher.text, !voucher.isEmpty else { return }
        
        Provider.shared.baokimAPIService.getVoucherInfo(voucher: voucher, tripCode: BaoKimDataManager.shared.bookTripParam.tripCode, bookingCode: BaoKimDataManager.shared.bookingCode.bookingCode, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            BaoKimDataManager.shared.voucherInfo = data
            self.vDiscount.isHidden = false
            self.lbDiscount.text = "\(Common.convertCurrencyV2(value: data.data.info.fareInfo.couponValue)) VNĐ"
            self.lbPrice.text = "\(Common.convertCurrencyV2(value: data.data.info.fareInfo.finalFare)) VNĐ"
            self.updateVoucher()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        let vc = EditInfoBaoKimViewController()
        vc.didChangeCustomerInfo = {
            let vc = SearchCustomerBaoKimViewController()
            vc.isEdit = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func confirmButtonPressed(_ sender: Any) {
        if btnConfirm.title(for: .normal) == "Xác Nhận" {
            let vc = PaymentBaoKimViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let attribute = [NSAttributedString.Key.foregroundColor: UIColor.red]
            let alertString = NSAttributedString(string: "Mọi thay đổi thông tin sẽ bị tính phí.", attributes: attribute)
            let messageString = NSMutableAttributedString(string: "Bạn vui lòng kiểm tra lại thông tin trước khi xác nhận. Thông tin vé và hành khách sẽ không thể thay đổi sau khi xác nhận.\n")
            messageString.append(alertString)
            
            let alert = UIAlertController(title: "Thông báo", message: nil, preferredStyle: .alert)
            alert.setValue(messageString, forKey: "attributedMessage")
            alert.addAction(UIAlertAction(title: "Tiếp tục", style: .default, handler: { (_) in
                var seats: String = ""
                var quantity: Int = 0
                for seat in BaoKimDataManager.shared.selectedSeats {
                    seats += seat.seatCode + "|" + "\(seat.coachNum)" + "|" + "\(seat.rowNum)" + "|" + "\(seat.colNum)"
                    seats += ","
                    quantity += 1
                }
                seats = seats.dropLast
                Provider.shared.baokimAPIService.getTransactionId(seats: seats, quantity: quantity, success: { [weak self] result in
                    guard let self = self, let data = result else { return }
                    if data.transactionCode.isEmpty {
                        self.showAlertOneButton(title: "Thông báo", with: data.message, titleButton: "OK")
                    } else {
                        self.transactionId = data.transactionCode
                        self.prepareParam(seats: seats)
                        
                        Provider.shared.baokimAPIService.bookTrip(param: BaoKimDataManager.shared.bookTripParam, success: { [weak self] result in
                            guard let self = self, let data = result else { return }
                            BaoKimDataManager.shared.bookingCode = data
                            self.showAlertOneButton(title: "Thông báo", with: "Booking thành công. Mã đặt vé của bạn là \(data.bookingCode)", titleButton: "OK")
                            self.didBooking = true
                            self.vEdit.isHidden = true
                            self.vVoucher.isHidden = false
                            self.vPrice.isHidden = false
                            self.btnConfirm.setTitle("Xác Nhận", for: .normal)
                            self.getBookingInfo()
                        }, failure: { [weak self] error in
                            guard let self = self else { return }
                            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                        })
                    }
                }, failure: { [weak self] error in
                    guard let self = self else { return }
                    self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension ReviewBookingBaoKimViewController: CommonTextFieldDelegate {
    func onRightTxt(tag: Int) {
        let vc = ScanCodeViewController()
        vc.scanSuccess = { text in
            self.tfVoucher.text = text
        }
        self.present(vc, animated: false, completion: nil)
    }
}
