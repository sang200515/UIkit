//
//  LichSuGiaoDichMoMoViewController.swift
//  mPOS
//
//  Created by tan on 12/11/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
class LichSuGiaoDichMoMoViewController : UIViewController{
    
    var tableView: UITableView!
    var list = [ItemHistorySOM]()
    var lbFromDateText: UILabel!
    var lbToDateText: UILabel!
    var cateID = ""
    var cellHeight:CGFloat = 0
    
    private let calendar: AVCalendarViewController = AVCalendarViewController.calendar
    private var selectedDate: AVDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Lịch sử giao dịch"
        
        let lbFromDate = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: (self.view.frame.width - Common.Size(s: 30))/2 - Common.Size(s: 5), height: Common.Size(s: 20)))
        lbFromDate.text = "Từ ngày:"
        lbFromDate.font = UIFont.boldSystemFont(ofSize: 13)
        self.view.addSubview(lbFromDate)
        
        lbFromDateText = UILabel(frame: CGRect(x: lbFromDate.frame.origin.x, y: lbFromDate.frame.origin.y + lbFromDate.frame.height, width: lbFromDate.frame.width, height: Common.Size(s: 25)))
        lbFromDateText.text = ""
        lbFromDateText.font = UIFont.systemFont(ofSize: 13)
        lbFromDateText.layer.cornerRadius = 3
        lbFromDateText.layer.borderWidth = 1
        lbFromDateText.layer.borderColor = UIColor.lightGray.cgColor
        lbFromDateText.tag = 1
        self.view.addSubview(lbFromDateText)
        
        let tapFromDate = UITapGestureRecognizer(target: self, action: #selector(handleCalendar(sender:)))
        lbFromDateText.isUserInteractionEnabled = true
        lbFromDateText.addGestureRecognizer(tapFromDate)
        
        let lbToDate = UILabel(frame: CGRect(x: lbFromDate.frame.origin.x + lbFromDate.frame.width + Common.Size(s: 10), y: Common.Size(s: 10), width: lbFromDate.frame.origin.x + lbFromDate.frame.width + Common.Size(s: 10), height: Common.Size(s: 20)))
        lbToDate.text = "Đến ngày:"
        lbToDate.font = UIFont.boldSystemFont(ofSize: 13)
        self.view.addSubview(lbToDate)
        
        lbToDateText = UILabel(frame: CGRect(x: lbToDate.frame.origin.x, y: lbToDate.frame.origin.y + lbToDate.frame.height, width: lbToDate.frame.width, height: Common.Size(s: 25)))
        lbToDateText.text = ""
        lbToDateText.font = UIFont.systemFont(ofSize: 13)
        lbToDateText.layer.cornerRadius = 3
        lbToDateText.layer.borderWidth = 1
        lbToDateText.layer.borderColor = UIColor.lightGray.cgColor
        lbToDateText.tag = 2
        self.view.addSubview(lbToDateText)
        
        let tapToDate = UITapGestureRecognizer(target: self, action: #selector(handleCalendar(sender:)))
        lbToDateText.isUserInteractionEnabled = true
        lbToDateText.addGestureRecognizer(tapToDate)
        
        let btnCheck = UIButton(frame: CGRect(x: Common.Size(s: 15), y: lbToDateText.frame.origin.y + lbToDateText.frame.height + Common.Size(s: 10), width: self.view.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        btnCheck.setTitle("Tìm kiếm", for: .normal)
        btnCheck.setTitleColor(.white, for: .normal)
        btnCheck.backgroundColor = UIColor(netHex: 0x74ba6e)
        btnCheck.layer.cornerRadius = 8
        btnCheck.addTarget(self, action: #selector(fetchHistorySOM), for: .touchUpInside)
        self.view.addSubview(btnCheck)
        
        let tableViewHeight:CGFloat = self.view.frame.height - (self.self.navigationController?.navigationBar.frame.height ?? 0) - UIApplication.shared.statusBarFrame.height

        tableView = UITableView(frame: CGRect(x: 0, y: btnCheck.frame.origin.y + btnCheck.frame.height + Common.Size(s: 8), width: self.view.frame.width, height: tableViewHeight - btnCheck.frame.origin.y - btnCheck.frame.height - Common.Size(s: 12)))
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MomoSOMHistoryCell.self, forCellReuseIdentifier: "momoSOMHistoryCell")
        tableView.tableFooterView = UIView()
        
        let dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "dd/MM/yyyy"
        let str = dateFomatter.string(from: Date())
        self.lbFromDateText.text = " \(str)"
        self.lbToDateText.text = " \(str)"
        
        if tableView != nil {
            self.fetchHistorySOM()
        }
    }
    
    @objc func handleCalendar(sender: UIGestureRecognizer) {
        
        calendar.dateStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .white,
                                                              highlightColor: UIColor(netHex: 0x7ec0c4).withAlphaComponent(0.5))
        calendar.yearStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x594166),
                                                              textColor: .black, highlightColor: .white)
        calendar.monthStyleComponents = CalendarComponentStyle(backgroundColor: UIColor(netHex: 0x2f3c5f),
                                                               textColor: .black,
                                                               highlightColor: UIColor.white)
        calendar.subscriber = { [weak self] (date) in guard let checkedSelf = self else { return }
            if date != nil {
                checkedSelf.selectedDate = date
                let selectedDate = Date(timeIntervalSince1970: TimeInterval(date?.doubleVal ?? 0))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd/MM/yyyy"
                let str = dateFormatter.string(from: selectedDate)
                let view = sender.view ?? UIView()
                if view.tag == 1 {
                    self?.lbFromDateText.text = " \(str)"
                } else {
                    self?.lbToDateText.text = " \(str)"
                }
            }
        }
        calendar.preSelectedDate = selectedDate
        self.present(calendar, animated: false, completion: nil)
    }
    
    // MARK:- API
    @objc func fetchHistorySOM(){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            SOMAPIManager.shared.filterItemsHistorySOM(fromDate:"\((self.lbFromDateText.text ?? "").trim())",toDate: "\((self.lbToDateText.text ?? "").trim())", parentCategoryIds: "\(self.cateID)") {[weak self] result in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    switch result {
                    case .success(let items):
                        self.list = items
                        if(items.count <= 0){
                            TableViewHelper.EmptyMessage(message: "Không có vận đơn.\n:/", viewController: self.tableView)
                        }else{
                            TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                        }
                        self.tableView.reloadData()
                    case .failure(let error):
                        self.showPopUp(error.description, "Thông báo", buttonTitle: "OK")

                    }
                }
            }
        }
    }
  
}
extension LichSuGiaoDichMoMoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MomoSOMHistoryCell = tableView.dequeueReusableCell(withIdentifier: "momoSOMHistoryCell", for: indexPath) as! MomoSOMHistoryCell
        let item = list[indexPath.row]
        cell.item = item
        cell.setUpCell()
        self.cellHeight = cell.estimateHeight
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = list[indexPath.row]
        let vc = DetailLSMomoViewController()
        vc.itemDetail = item
        vc.orderID = item.orderID&
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

class MomoSOMHistoryCell: UITableViewCell {
    var item: ItemHistorySOM?
    var estimateHeight:CGFloat = 0
    
    func setUpCell() {
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = UIColor.white
        
        let viewContent = UIView(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 5), width: self.frame.width - Common.Size(s: 16), height: self.frame.height))
        viewContent.backgroundColor = UIColor(netHex:0xF8F4F5)
        viewContent.layer.cornerRadius = 5
        self.addSubview(viewContent)
        
        let lbSoPhieu = UILabel(frame: CGRect(x: Common.Size(s: 8), y: Common.Size(s: 5), width: (viewContent.frame.width - Common.Size(s: 16))/3, height: Common.Size(s: 20)))
        lbSoPhieu.text = "Số phiếu"
        lbSoPhieu.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbSoPhieu)

        let lbSoPhieuText = UILabel(frame: CGRect(x: lbSoPhieu.frame.origin.x + lbSoPhieu.frame.width + Common.Size(s: 3), y: lbSoPhieu.frame.origin.y, width: ((viewContent.frame.width - Common.Size(s: 16)) * 2/3) - Common.Size(s: 3), height: Common.Size(s: 20)))
        lbSoPhieuText.text = "\(item?.billNo ?? "")"
        lbSoPhieuText.font = UIFont.boldSystemFont(ofSize: 13)
        lbSoPhieuText.textAlignment = .right
        viewContent.addSubview(lbSoPhieuText)
        
        let lbSdtKH = UILabel(frame: CGRect(x: Common.Size(s: 8), y: lbSoPhieuText.frame.origin.y + lbSoPhieuText.frame.height, width: lbSoPhieu.frame.width, height: Common.Size(s: 20)))
        lbSdtKH.text = "SĐT khách hàng"
        lbSdtKH.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbSdtKH)

        let lbSdtKHText = UILabel(frame: CGRect(x: lbSdtKH.frame.origin.x + lbSdtKH.frame.width + Common.Size(s: 3), y: lbSdtKH.frame.origin.y, width: lbSoPhieuText.frame.width, height: Common.Size(s: 20)))
        lbSdtKHText.text = "\(item?.customerPhoneNumber ?? "")"
        lbSdtKHText.font = UIFont.boldSystemFont(ofSize: 13)
        lbSdtKHText.textAlignment = .right
        lbSdtKHText.textColor = UIColor(netHex: 0x73b36d)
        viewContent.addSubview(lbSdtKHText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 8), y: lbSdtKHText.frame.origin.y + lbSdtKHText.frame.height, width: lbSoPhieu.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái"
        lbTrangThai.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbTrangThai)

        let lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width + Common.Size(s: 3), y: lbTrangThai.frame.origin.y, width: lbSoPhieuText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.font = UIFont.systemFont(ofSize: 13)
        lbTrangThaiText.textAlignment = .right
        viewContent.addSubview(lbTrangThaiText)
        
        let status = CreateOrderResultViettelPay_SOM(rawValue: item?.orderStatus ?? 3)
        lbTrangThaiText.text = "\(status?.message ?? "")"
        
        let lbTrangThaiTextHeight:CGFloat = lbTrangThaiText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTrangThaiText.optimalHeight + Common.Size(s: 5))
        lbTrangThaiText.numberOfLines = 0
        lbTrangThaiText.frame = CGRect(x: lbTrangThaiText.frame.origin.x, y: lbTrangThaiText.frame.origin.y, width: lbTrangThaiText.frame.width, height: lbTrangThaiTextHeight)
        
        if item?.orderStatus == 2 {
            lbTrangThaiText.textColor = UIColor(netHex: 0x73b36d)
        } else  if item?.orderStatus == 3 {
            lbTrangThaiText.textColor = .red
        } else {
            lbTrangThaiText.textColor = .blue
        }
        
        let lbLoaiDV = UILabel(frame: CGRect(x: Common.Size(s: 8), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height, width: lbSoPhieu.frame.width, height: Common.Size(s: 20)))
        lbLoaiDV.text = "Loại dịch vụ"
        lbLoaiDV.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbLoaiDV)
        
        let lbLoaiDVText = UILabel(frame: CGRect(x: lbLoaiDV.frame.origin.x + lbLoaiDV.frame.width + Common.Size(s: 3), y: lbLoaiDV.frame.origin.y, width: lbSoPhieuText.frame.width, height: Common.Size(s: 20)))
        lbLoaiDVText.font = UIFont.systemFont(ofSize: 13)
        lbLoaiDVText.text = "\(item?.categoryName ?? "")"
        lbLoaiDVText.textAlignment = .right
        lbLoaiDVText.textColor = .lightGray
        viewContent.addSubview(lbLoaiDVText)
        
        let lbTenNV = UILabel(frame: CGRect(x: Common.Size(s: 8), y: lbLoaiDVText.frame.origin.y + lbLoaiDVText.frame.height, width: lbSoPhieu.frame.width, height: Common.Size(s: 20)))
        lbTenNV.text = "Tên nhân viên"
        lbTenNV.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbTenNV)
        
        let lbTenNVText = UILabel(frame: CGRect(x: lbTenNV.frame.origin.x + lbTenNV.frame.width + Common.Size(s: 3), y: lbTenNV.frame.origin.y, width: lbSoPhieuText.frame.width, height: Common.Size(s: 20)))
        lbTenNVText.font = UIFont.systemFont(ofSize: 13)
        lbTenNVText.text = "\(item?.employeeName ?? "")"
        lbTenNVText.textAlignment = .right
        lbTenNVText.textColor = .lightGray
        viewContent.addSubview(lbTenNVText)
        
        let lbTenNVTextHeight:CGFloat = lbTenNVText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : (lbTenNVText.optimalHeight + Common.Size(s: 5))
        lbTenNVText.numberOfLines = 0
        lbTenNVText.frame = CGRect(x: lbTenNVText.frame.origin.x, y: lbTenNVText.frame.origin.y, width: lbTenNVText.frame.width, height: lbTenNVTextHeight)
        
        let lbThoiGian = UILabel(frame: CGRect(x: Common.Size(s: 8), y: lbTenNVText.frame.origin.y + lbTenNVText.frame.height, width: lbSoPhieu.frame.width, height: Common.Size(s: 20)))
        lbThoiGian.text = "Thời gian"
        lbThoiGian.font = UIFont.systemFont(ofSize: 13)
        viewContent.addSubview(lbThoiGian)
        
        let lbThoiGianText = UILabel(frame: CGRect(x: lbThoiGian.frame.origin.x + lbThoiGian.frame.width + Common.Size(s: 3), y: lbThoiGian.frame.origin.y, width: lbSoPhieuText.frame.width, height: Common.Size(s: 20)))
        lbThoiGianText.font = UIFont.systemFont(ofSize: 13)
        lbThoiGianText.text = "\(Common.convertDateISO8601(dateString: item?.creationTime ?? ""))"
        lbThoiGianText.textAlignment = .right
        lbThoiGianText.textColor = .lightGray
        viewContent.addSubview(lbThoiGianText)
        
        viewContent.frame = CGRect(x: viewContent.frame.origin.x, y: viewContent.frame.origin.y, width: viewContent.frame.width, height: lbThoiGianText.frame.origin.y + lbThoiGianText.frame.height + Common.Size(s: 5))
        estimateHeight = viewContent.frame.origin.y + viewContent.frame.height + Common.Size(s: 5)
    }
}

