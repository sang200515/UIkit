//
//  HistoryDetailBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 29/12/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HistoryDetailBaoKimViewController: UIViewController {
    
    @IBOutlet weak var vOrder: UIView!
    @IBOutlet weak var vTrip: UIView!
    @IBOutlet weak var vOrderInfo: UIView!
    @IBOutlet weak var vTripInfo: UIView!
    
    @IBOutlet weak var lbBooking: UILabel!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var tbvProduct: UITableView!
    @IBOutlet weak var cstProduct: NSLayoutConstraint!
    @IBOutlet weak var tbvVoucher: UITableView!
    @IBOutlet weak var cstVoucher: NSLayoutConstraint!
    @IBOutlet weak var tbvPromotion: UITableView!
    @IBOutlet weak var cstPromotion: NSLayoutConstraint!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbDiscount: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    //MARK:- HEADER
    @IBOutlet weak var lbFromTime: UILabel!
    @IBOutlet weak var lbFrom: UILabel!
    @IBOutlet weak var lbToTime: UILabel!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var lbTotalTime: UILabel!
    @IBOutlet weak var lbTotalDistance: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lbVerhicleName: UILabel!
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
    
    var bookingCode: String = ""
    var mposCode: String = ""
    private var orderDetail: BaoKimHistoryDetail = BaoKimHistoryDetail(JSON: [:])!
    private var tripDetail: BaoKimBooking = BaoKimBooking(JSON: [:])!
    private var companyDetail: BaoKimCompanyDetail = BaoKimCompanyDetail(JSON: [:])!
    private var selectedPromotionGroup: [(sl: String, name: String)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
    }
    
    private func setupUI() {
        title = "Chi tiết lịch sử"
        addBackButton()
    }
    
    private func setupTableView() {
        tbvProduct.registerTableCell(VietjetProductTableViewCell.self)
        tbvProduct.estimatedRowHeight = 100
        tbvProduct.rowHeight = UITableView.automaticDimension
        
        tbvPromotion.registerTableCell(VietjetPromotionTableViewCell.self)
        tbvPromotion.estimatedRowHeight = 100
        tbvPromotion.rowHeight = UITableView.automaticDimension
        
        tbvVoucher.registerTableCell(VietjetPromotionTableViewCell.self)
        tbvVoucher.estimatedRowHeight = 100
        tbvVoucher.rowHeight = UITableView.automaticDimension
    }
    
    private func loadData() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Provider.shared.baokimAPIService.getBookingInfo(bookingCode: bookingCode, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.tripDetail = data
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Provider.shared.baokimAPIService.getHistoryDetail(bookingCode: bookingCode, mposCode: mposCode, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            self.orderDetail = data
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            self.loadCompanyDetail()
        }
    }
    
    private func loadCompanyDetail() {
        if let trip = tripDetail.data.first {
            Provider.shared.baokimAPIService.getCompanyDetail(companyId: trip.companyID, success: { [weak self] result in
                guard let self = self, let data = result else { return }
                self.companyDetail = data
                self.loadUI()
            }, failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
        }
        
    }
    
    private func loadUI() {
        lbBooking.text = orderDetail.bookingID
        lbName.text = orderDetail.cardName
        lbPhone.text = orderDetail.licTradNum
        lbEmail.text = orderDetail.customerEmail
        lbTotal.text = "\(Common.convertCurrencyV2(value: orderDetail.preDoctal)) VNĐ"
        lbDiscount.text = "\(Common.convertCurrencyV2(value: orderDetail.discount)) VNĐ"
        lbPrice.text = "\(Common.convertCurrencyV2(value: orderDetail.doctal)) VNĐ"
        
        tbvProduct.reloadData()
        setupPromotionData()
        
        if let trip = tripDetail.data.first {
            lbFromTime.text = String(trip.pickupDate.prefix(5))
            lbFrom.text = trip.pickupInfo
            lbToTime.text = String(trip.arrivalDate.prefix(5))
            lbTotalDistance.isHidden = true
            lbTo.text = trip.dropOffInfo
            lbTotalTime.isHidden = true
            lbVerhicleName.text = trip.company
            lbRate.isHidden = true
            lbDetail.isHidden = true
            lbDate.text = String(trip.tripDate.suffix(10))
            var seatString = "Mã ghế: "
            for seat in trip.seatCodes {
                seatString += seat + ", "
            }
            seatString = seatString.dropLast
            seatString = seatString.dropLast
            lbSeats.text = seatString
            
            
//            var urlString = trip.company.images.first?.files.the1000X600 ?? ""
//            while urlString.first == "/" {
//                urlString = String(urlString.dropFirst())
//            }
//            urlString = "https://" + urlString
//            Common.encodeURLImg(urlString: urlString, imgView: imgLogo)
            imgLogo.isHidden = true
            
            lbCustomerName.text = trip.customer.name
            lbCustomerPhone.text = trip.customer.phone
            lbCustomerEmail.text = trip.customer.email
            
            lbPickupTime.text = String(trip.pickupDate.prefix(5))
            lbPickupName.text = trip.from
            lbPickupAddress.text = trip.pickupInfo
            lbDropoffTime.text = String(trip.arrivalDate.prefix(5))
            lbDropoffName.text = trip.to
            lbDropoffAddress.text = trip.dropOffInfo
        }
    }
    
    private func setupPromotionData() {
        for promotion in orderDetail.frTORDRPROMOS {
            if promotion.tienGiam > 0 {
                let tuple = (sl: "1", name: "Giảm giá: \(Common.convertCurrencyV2(value: promotion.tienGiam)) VNĐ")
                selectedPromotionGroup.append(tuple)
            }
            
            if !promotion.tenSANPhamTang.isEmpty {
                let tuple = (sl: "\(promotion.sLTang)", name: promotion.tenSANPhamTang)
                selectedPromotionGroup.append(tuple)
            }
        }
        
        tbvPromotion.reloadData()
        cstPromotion.constant = CGFloat(selectedPromotionGroup.count * 60)
    }

    @IBAction func orderButtonPressed(_ sender: Any) {
        vOrder.isHidden = false
        vTrip.isHidden = true
        
        vOrderInfo.isHidden = false
        vTripInfo.isHidden = true
    }
    
    @IBAction func tripButtonPressed(_ sender: Any) {
        vOrder.isHidden = true
        vTrip.isHidden = false
        
        vOrderInfo.isHidden = true
        vTripInfo.isHidden = false
    }
}

extension HistoryDetailBaoKimViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case tbvProduct:
            return orderDetail.frTRDR1S.count
        case tbvVoucher:
            return 0//vouchers.count
        default:
            return selectedPromotionGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case tbvProduct:
            let cell = tableView.dequeueTableCell(VietjetProductTableViewCell.self)
            
            if let bookingInfo = orderDetail.frTRDR1S.first {
                cell.lbName.text = "\(bookingInfo.itemCode) - \(bookingInfo.description)"
                cell.lbQuantiy.text = "SL: \(bookingInfo.quantity)"
                cell.lbPrice.text = "Giá: \(Common.convertCurrencyV2(value: bookingInfo.priceFisrt)) VNĐ"
            }
            
            return cell
        case tbvVoucher:
            let cell = tableView.dequeueTableCell(VietjetPromotionTableViewCell.self)
            
//            cell.lbIndex.text = "\(indexPath.row + 1)"
//            cell.lbName.text = vouchers[indexPath.row].VC_Code
//            cell.lbQuantity.text = "SL: 1"
            
            return cell
        default:
            let cell = tableView.dequeueTableCell(VietjetPromotionTableViewCell.self)
            
            cell.lbIndex.text = "\(indexPath.row + 1)"
            cell.lbName.text = selectedPromotionGroup[indexPath.row].name
            cell.lbQuantity.text = "SL: \(selectedPromotionGroup[indexPath.row].sl)"
            
            return cell
        }
    }
}
