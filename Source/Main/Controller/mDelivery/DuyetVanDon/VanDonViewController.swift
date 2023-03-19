//
//  VanDonViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 30/06/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
class VanDonViewController: UIViewController {
    
    var safeArea: UILayoutGuide!
    var icFilter: UIBarButtonItem!
    var tableView: UITableView!
    var valueToDate: String = ""
    var valueFromDate: String = ""
    var list: [VanDon] = []
    var filteredVanDon: [VanDon] = []
    var keySearch:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.title = "Duyệt Vận đơn điện tử"
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(self.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let viewFilter = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        let btFilterIcon = UIButton.init(type: .custom)
        btFilterIcon.setImage(#imageLiteral(resourceName: "Filter"), for: UIControl.State.normal)
        btFilterIcon.imageView?.contentMode = .scaleAspectFit
        btFilterIcon.addTarget(self, action: #selector(self.actionFilter), for: UIControl.Event.touchUpInside)
        btFilterIcon.frame = CGRect(x: 5, y: 0, width: 30, height: 50)
        viewFilter.addSubview(btFilterIcon)
        
        icFilter = UIBarButtonItem(customView: btFilterIcon)
        self.navigationItem.rightBarButtonItem = icFilter
        
        safeArea = view.layoutMarginsGuide
        
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.clipsToBounds = true
        self.view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        let searchField = UITextField()
        searchField.placeholder = "Bạn cần tìm?"
        searchField.backgroundColor = .white
        searchField.layer.cornerRadius = 5
        searchField.layer.borderWidth = 0.5
        searchField.layer.borderColor = UIColor.lightGray.cgColor

        searchField.leftViewMode = .always
        let searchImageViewWrapper = UIView(frame: CGRect(x: 0, y: 0, width: 35, height: 15))
        let searchImageView = UIImageView(frame: CGRect(x: 10, y: 0, width: 15, height: 15))
        let search = UIImage(named: "search", in: Bundle(for: YNSearch.self), compatibleWith: nil)
        searchImageView.image = search
        searchImageViewWrapper.addSubview(searchImageView)
        searchField.leftView = searchImageViewWrapper
        searchField.addTarget(self, action: #selector(search(textField:)), for: .editingChanged)
        
        headerView.addSubview(searchField)
        searchField.translatesAutoresizingMaskIntoConstraints = false
        
        searchField.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: Common.Size(s: 10)).isActive = true
        searchField.topAnchor.constraint(equalTo: headerView.topAnchor,constant: Common.Size(s: 10)).isActive = true
        searchField.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        searchField.rightAnchor.constraint(equalTo: headerView.rightAnchor, constant: Common.Size(s: -10)).isActive = true
        searchField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Common.Size(s: -10)).isActive = true
        
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.register(VanDonCell.self, forCellReuseIdentifier: "VanDonCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = UIColor(netHex: 0xEEEEEE)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = Common.Size(s: 235)
        tableView.rowHeight = UITableView.automaticDimension
        
       
        loadData()
    }
    func loadData(){
        var dayComponent    = DateComponents()
        dayComponent.day    = -7
        let theCalendar     = Calendar.current
        let nextDate        = theCalendar.date(byAdding: dayComponent, to: Date())
        
        valueToDate = formatDate2(date: Date())
        valueFromDate = formatDate2(date: nextDate!)
        APIManager.searchVanDon(fromDate: valueToDate, toDate: valueToDate, shopCodeEx: "", shopCodeRec: "", statusCode: "", transporter: "", soBillFRT: "") { (results) in
            self.list = results.sorted(by: { a, b in
                a.trangThaiDuyet > b.trangThaiDuyet
            })
            self.tableView.reloadData()
        }
    }
    
    
    @objc private func search(textField: UITextField) {
        if let key = textField.text {
            self.keySearch = key
            filteredVanDon = list.filter { (ycdc: VanDon) -> Bool in
                return ycdc.soBillFRT.lowercased().contains(self.keySearch.lowercased())
            }
            tableView.reloadData()
        }
    }
    @objc func actionFilter() {
        let vc = FilterPopupViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.heightNavigation = ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
        vc.filter = { [weak self] (valueFromDate,valueToDate,nvc,selectStatus,shopRe,shopEx) in
            
            APIManager.searchVanDon(fromDate: valueFromDate, toDate: valueToDate, shopCodeEx: shopEx, shopCodeRec: shopRe, statusCode: selectStatus, transporter: nvc, soBillFRT: "") { (results) in
                self?.list = results.sorted(by: { a, b in
                    a.trangThaiDuyet > b.trangThaiDuyet
                })
                self?.tableView.reloadData()
            }
        }
        present(vc, animated: true)
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension VanDonViewController: UITableViewDelegate, UITableViewDataSource,VanDonCellDelegate {
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.keySearch != "" {
            return filteredVanDon.count
        }
        return list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = VanDonCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "VanDonCell")
        cell.delegate = self
        let item: VanDon
        if self.keySearch != "" {
            item = filteredVanDon[indexPath.row]
        } else {
            item = list[indexPath.row]
        }
        cell.setUpCell(item: item, indx: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    func didAction(index: Int, isApproved: Bool) {
        
        let refreshAlert = UIAlertController(title: "Chú ý", message: "Bạn muốn \(isApproved ? "duyệt" : "từ chối") vận đơn này?", preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { (action: UIAlertAction!) in
            print("index \(index) isApproved \(isApproved)")
            let item: VanDon
            if self.keySearch != "" {
                item = self.filteredVanDon[index]
            } else {
                item = self.list[index]
            }
            var arr: [BodyRequestApproveVanDon] = []
            let it = BodyRequestApproveVanDon(duyet: isApproved, soBillFRT: item.soBillFRT, ghiChu: "")
            arr.append(it)
            
            let request = RequestApproveVanDon(userCode: "\(Cache.user!.UserName)", userName: "\(Cache.user!.EmployeeName)", os: "2", listBill: arr)
            let newViewController = LoadingViewController();
            newViewController.content = "Đang duyệt Vận đơn..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
            let nc = NotificationCenter.default
            
            APIManager.approveVanDon(param: request) { result, message, erro in
                let when = DispatchTime.now() + 0.5
                DispatchQueue.main.asyncAfter(deadline: when) {
                    nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    if(result == "1"){
                        self.showAlertOneButton(title: "Thông báo", with: "\(message!)", titleButton: "OK") {
                            self.loadData()
                        }
                    }else{
                        self.showAlertOneButton(title: "Thông báo", with: "\(message!)", titleButton: "OK")
                    }
                }
            }
        }))

        refreshAlert.addAction(UIAlertAction(title: "Hủy", style: .cancel, handler: { (action: UIAlertAction!) in
              print("Handle Cancel Logic here")
        }))

        self.present(refreshAlert, animated: true, completion: nil)
    }

    func formatDate2(date:Date) -> String{
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "yyyy-MM-dd"
        return deFormatter.string(from: date)
    }
    func formatDate3(date:Date) -> String{
        let deFormatter = DateFormatter()
        deFormatter.dateFormat = "dd/MM/yyyy"
        return deFormatter.string(from: date)
    }

}
protocol VanDonCellDelegate: AnyObject {
    func didAction(index:Int, isApproved: Bool)
}
class VanDonCell: UITableViewCell {
    weak var delegate: VanDonCellDelegate?
    var lblSOYCDC = UILabel()
    var lblDate = UILabel()
    var viewCell = UIView()
    var line = UIView()
    var lbCost = UILabel()
    var lbCostOffer = UILabel()
    var lbTextCost = UILabel()
    var lbServiceOffer = UILabel()
    
    var lbTextNote = UILabel()
    var lbNote = UILabel()
    var lbTextService = UILabel()
    var lbService = UILabel()
    var lbTextApprovedBy = UILabel()
    var lbApprovedBy = UILabel()
    var lbTextStatus = UILabel()
    var lbStatus = UILabel()
    var line1 = UIView()
    var line2 = UIView()
    var lbTransportersOffer = UILabel()
    
    var lbTransporters = UILabel()
    var lbTextTransporters = UILabel()
    var viewLineSpace = UIView()
    var lbTextReality = UILabel()
    var lbTextSpace = UILabel()
    var lbTextOffer = UILabel()
    
    var btnApprove = UIButton()
    var btnReject = UIButton()
    func setUpCell(item: VanDon, indx: Int){
        self.subviews.forEach({$0.removeFromSuperview()})
        self.backgroundColor = .clear
        self.contentView.addSubview(viewCell)
        viewCell.translatesAutoresizingMaskIntoConstraints = false
        
        viewCell.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: Common.Size(s: 5)).isActive = true
        viewCell.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        viewCell.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: Common.Size(s: -5)).isActive = true
        viewCell.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: Common.Size(s: -5)).isActive = true
//        viewCell.heightAnchor.constraint(equalToConstant: Common.Size(s: 230)).isActive = true
        viewCell.backgroundColor = .white
        viewCell.layer.cornerRadius = 5

        lblSOYCDC.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lblSOYCDC)

        lblSOYCDC.leftAnchor.constraint(equalTo: self.viewCell.leftAnchor, constant: Common.Size(s: 5)).isActive = true
        lblSOYCDC.topAnchor.constraint(equalTo: self.viewCell.topAnchor, constant: Common.Size(s: 5)).isActive = true
        lblSOYCDC.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/2).isActive = true
        lblSOYCDC.heightAnchor.constraint(equalToConstant: Common.Size(s: 20)).isActive = true
        lblSOYCDC.text = "  Vận đơn: \(item.soBillFRT)"
        lblSOYCDC.textColor = UIColor.white
        lblSOYCDC.font = UIFont.boldSystemFont(ofSize: 15)
        lblSOYCDC.backgroundColor = UIColor(netHex:0x00955E)
        lblSOYCDC.numberOfLines = 1

        lblDate.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lblDate)
        lblDate.leftAnchor.constraint(equalTo: lblSOYCDC.rightAnchor, constant: Common.Size(s: 5)).isActive = true
        lblDate.topAnchor.constraint(equalTo: lblSOYCDC.topAnchor).isActive = true
        lblDate.rightAnchor.constraint(equalTo: self.viewCell.rightAnchor, constant: Common.Size(s: -5)).isActive = true
        lblDate.heightAnchor.constraint(equalTo: lblSOYCDC.heightAnchor).isActive = true
        lblDate.text = "\(item.thoiGianDuyet)"
        lblDate.textColor = UIColor.black
        lblDate.textAlignment = .right
        lblDate.font = UIFont.systemFont(ofSize: 13)

        line.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(line)
        line.leftAnchor.constraint(equalTo: lblSOYCDC.leftAnchor).isActive = true
        line.topAnchor.constraint(equalTo: lblSOYCDC.bottomAnchor).isActive = true
        line.rightAnchor.constraint(equalTo: lblDate.rightAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1).isActive = true
        line.backgroundColor = UIColor(netHex:0x00955E)
        
        lbTextApprovedBy.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextApprovedBy)
        lbTextApprovedBy.leftAnchor.constraint(equalTo: lblSOYCDC.leftAnchor).isActive = true
        lbTextApprovedBy.topAnchor.constraint(equalTo: line.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        lbTextApprovedBy.widthAnchor.constraint(equalTo: viewCell.widthAnchor, multiplier: 1/4).isActive = true

        lbTextApprovedBy.textAlignment = .left
        lbTextApprovedBy.textColor = UIColor.black
        lbTextApprovedBy.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextApprovedBy.text = "Người duyệt:"

        lbApprovedBy.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbApprovedBy)
        lbApprovedBy.leftAnchor.constraint(equalTo: lbTextApprovedBy.rightAnchor).isActive = true
        lbApprovedBy.topAnchor.constraint(equalTo: lbTextApprovedBy.topAnchor).isActive = true
        lbApprovedBy.rightAnchor.constraint(equalTo: line.rightAnchor).isActive = true
        lbApprovedBy.textAlignment = .left
        lbApprovedBy.textColor = UIColor.black
        lbApprovedBy.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbApprovedBy.text = "\(item.nguoiDuocDuyet) - \(item.tenNguoiDuyet)"

        lbTextNote.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextNote)
        lbTextNote.textAlignment = .left
        lbTextNote.textColor = UIColor.black
        lbTextNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextNote.text = "Nội dung:"
        lbTextNote.leftAnchor.constraint(equalTo: lbTextApprovedBy.leftAnchor).isActive = true
        lbTextNote.topAnchor.constraint(equalTo: lbTextApprovedBy.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        lbTextNote.rightAnchor.constraint(equalTo: lbTextApprovedBy.rightAnchor).isActive = true

        lbNote.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbNote)
        lbNote.leftAnchor.constraint(equalTo: lbTextNote.rightAnchor).isActive = true
        lbNote.topAnchor.constraint(equalTo: lbTextNote.topAnchor).isActive = true
        lbNote.rightAnchor.constraint(equalTo: line.rightAnchor).isActive = true
        lbNote.heightAnchor.constraint(greaterThanOrEqualTo: lbTextNote.heightAnchor).isActive = true
        lbNote.numberOfLines = 3
        lbNote.textAlignment = .left
        lbNote.textColor = UIColor.black
        lbNote.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbNote.text = "\(item.ghiChu)"
        
        lbTextStatus.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextStatus)
        lbTextStatus.textAlignment = .left
        lbTextStatus.textColor = UIColor.black
        lbTextStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextStatus.text = "Trạng thái:"
        lbTextStatus.leftAnchor.constraint(equalTo: lbTextApprovedBy.leftAnchor).isActive = true
        lbTextStatus.topAnchor.constraint (equalTo: lbNote.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        lbTextStatus.rightAnchor.constraint(equalTo: lbTextApprovedBy.rightAnchor).isActive = true
        
        viewCell.addSubview(lbStatus)
        lbStatus.translatesAutoresizingMaskIntoConstraints = false
        lbStatus.textAlignment = .left
        lbStatus.textColor = UIColor.black
        lbStatus.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbStatus.text = "\(item.tenTrangThai)"
        lbStatus.leftAnchor.constraint(equalTo: lbTextStatus.rightAnchor).isActive = true
        lbStatus.topAnchor.constraint(equalTo: lbTextStatus.topAnchor).isActive = true
        lbStatus.rightAnchor.constraint(equalTo: line.rightAnchor).isActive = true
        if(item.trangThaiDuyet == "C"){
            lbStatus.textColor = UIColor.blue
        }else if(item.trangThaiDuyet == "K"){
            lbStatus.textColor = UIColor.red
        }else if(item.trangThaiDuyet == "N"){
            lbStatus.textColor = UIColor.green
        }
               
      
        viewLineSpace.translatesAutoresizingMaskIntoConstraints = false
        viewLineSpace.backgroundColor = UIColor(netHex: 0xEEEEEE)
        viewCell.addSubview(viewLineSpace)
        viewLineSpace.leftAnchor.constraint(equalTo: line.leftAnchor).isActive = true
        viewLineSpace.topAnchor.constraint (equalTo: lbTextStatus.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        viewLineSpace.rightAnchor.constraint(equalTo: line.rightAnchor).isActive = true
        viewLineSpace.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        
        lbTextSpace.translatesAutoresizingMaskIntoConstraints = false
        viewLineSpace.addSubview(lbTextSpace)
        lbTextSpace.leftAnchor.constraint(equalTo: viewLineSpace.leftAnchor).isActive = true
        lbTextSpace.topAnchor.constraint (equalTo: viewLineSpace.topAnchor).isActive = true
        lbTextSpace.heightAnchor.constraint(equalTo:viewLineSpace.heightAnchor).isActive = true
        lbTextSpace.widthAnchor.constraint(equalTo: viewLineSpace.widthAnchor, multiplier: 1/4).isActive = true
        
        lbTextReality.translatesAutoresizingMaskIntoConstraints = false
        viewLineSpace.addSubview(lbTextReality)
        lbTextReality.leftAnchor.constraint(equalTo: lbTextSpace.rightAnchor).isActive = true
        lbTextReality.topAnchor.constraint (equalTo: viewLineSpace.topAnchor).isActive = true
        lbTextReality.heightAnchor.constraint(equalTo:viewLineSpace.heightAnchor).isActive = true
        lbTextReality.widthAnchor.constraint(equalTo: viewLineSpace.widthAnchor, multiplier: 3/8).isActive = true
        lbTextReality.textAlignment = .left
        lbTextReality.textColor = UIColor.black
        lbTextReality.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTextReality.text = "Thực tế"
        
        lbTextOffer.translatesAutoresizingMaskIntoConstraints = false
        viewLineSpace.addSubview(lbTextOffer)
        lbTextOffer.leftAnchor.constraint(equalTo: lbTextReality.rightAnchor).isActive = true
        lbTextOffer.topAnchor.constraint (equalTo: viewLineSpace.topAnchor).isActive = true
        lbTextOffer.heightAnchor.constraint(equalTo:viewLineSpace.heightAnchor).isActive = true
        lbTextOffer.widthAnchor.constraint(equalTo: viewLineSpace.widthAnchor, multiplier: 3/8).isActive = true
        lbTextOffer.textAlignment = .left
        lbTextOffer.textColor = UIColor.black
        lbTextOffer.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTextOffer.text = "Đề xuất"
        
        
        lbTextTransporters.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextTransporters)
        lbTextTransporters.textAlignment = .left
        lbTextTransporters.textColor = UIColor.black
        lbTextTransporters.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextTransporters.text = "Nhà VC:"
        lbTextTransporters.leftAnchor.constraint(equalTo: lbTextApprovedBy.leftAnchor).isActive = true
        lbTextTransporters.topAnchor.constraint (equalTo: viewLineSpace.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        lbTextTransporters.rightAnchor.constraint(equalTo: lbTextApprovedBy.rightAnchor).isActive = true
        
        lbTransporters.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTransporters)
        lbTransporters.leftAnchor.constraint(equalTo: lbTextTransporters.rightAnchor).isActive = true
        lbTransporters.topAnchor.constraint (equalTo: lbTextTransporters.topAnchor).isActive = true
        lbTransporters.widthAnchor.constraint(equalTo: viewLineSpace.widthAnchor, multiplier: 3/8).isActive = true
        lbTransporters.textAlignment = .left
        lbTransporters.textColor = UIColor.black
        lbTransporters.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTransporters.text = "\(item.tenNhaVanChuyen)"
        
        lbTransportersOffer.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTransportersOffer)
        lbTransportersOffer.leftAnchor.constraint(equalTo: lbTransporters.rightAnchor).isActive = true
        lbTransportersOffer.topAnchor.constraint (equalTo: lbTransporters.topAnchor).isActive = true
        lbTransportersOffer.widthAnchor.constraint(equalTo: viewLineSpace.widthAnchor, multiplier: 3/8).isActive = true
        lbTransportersOffer.textAlignment = .left
        lbTransportersOffer.textColor = UIColor.black
        lbTransportersOffer.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbTransportersOffer.text = "\(item.tenNhaVanChuyenDeXuat)"
        
        line1.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(line1)
        line1.leftAnchor.constraint(equalTo: line.leftAnchor).isActive = true
        line1.topAnchor.constraint(equalTo: lbTextTransporters.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        line1.rightAnchor.constraint(equalTo: line.rightAnchor).isActive = true
        line1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line1.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        lbTextService.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextService)
        lbTextService.textAlignment = .left
        lbTextService.textColor = UIColor.black
        lbTextService.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextService.text = "Dịch vụ:"
        lbTextService.leftAnchor.constraint(equalTo: lbTextApprovedBy.leftAnchor).isActive = true
        lbTextService.topAnchor.constraint (equalTo: line1.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        lbTextService.rightAnchor.constraint(equalTo: lbTextApprovedBy.rightAnchor).isActive = true
        
        lbService.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbService)
        lbService.leftAnchor.constraint(equalTo: lbTransporters.leftAnchor).isActive = true
        lbService.topAnchor.constraint (equalTo: lbTextService.topAnchor).isActive = true
        lbService.widthAnchor.constraint(equalTo: lbTransporters.widthAnchor).isActive = true
        lbService.textAlignment = .left
        lbService.textColor = UIColor.black
        lbService.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbService.text = "\(item.tenDichVu)"
        
        lbServiceOffer.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbServiceOffer)
        lbServiceOffer.leftAnchor.constraint(equalTo: lbTransportersOffer.leftAnchor).isActive = true
        lbServiceOffer.topAnchor.constraint (equalTo: lbTextService.topAnchor).isActive = true
        lbServiceOffer.widthAnchor.constraint(equalTo: lbTransportersOffer.widthAnchor).isActive = true
        lbServiceOffer.textAlignment = .left
        lbServiceOffer.textColor = UIColor.black
        lbServiceOffer.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbServiceOffer.text = "\(item.tenDichVuDeXuat)"
        
        line2.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(line2)
        line2.leftAnchor.constraint(equalTo: line.leftAnchor).isActive = true
        line2.topAnchor.constraint(equalTo: lbTextService.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        line2.rightAnchor.constraint(equalTo: line.rightAnchor).isActive = true
        line2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        line2.backgroundColor = UIColor(netHex: 0xEEEEEE)
        
        lbTextCost.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbTextCost)
        lbTextCost.textAlignment = .left
        lbTextCost.textColor = UIColor.black
        lbTextCost.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lbTextCost.text = "Chi phí:"
        lbTextCost.leftAnchor.constraint(equalTo: lbTextApprovedBy.leftAnchor).isActive = true
        lbTextCost.topAnchor.constraint (equalTo: line2.bottomAnchor, constant: Common.Size(s: 5)).isActive = true
        lbTextCost.rightAnchor.constraint(equalTo: lbTextApprovedBy.rightAnchor).isActive = true
        
        lbCost.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbCost)
        lbCost.leftAnchor.constraint(equalTo: lbTransporters.leftAnchor).isActive = true
        lbCost.topAnchor.constraint (equalTo: lbTextCost.topAnchor).isActive = true
        lbCost.widthAnchor.constraint(equalTo: lbTransporters.widthAnchor).isActive = true
        lbCost.textAlignment = .left
        lbCost.textColor = UIColor(netHex:0x00955E)
        lbCost.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbCost.text = "\(Common.convertCurrencyDoubleV2(value: Double(item.chiPhi) ?? 0) )"
        
        lbCostOffer.translatesAutoresizingMaskIntoConstraints = false
        viewCell.addSubview(lbCostOffer)
        lbCostOffer.leftAnchor.constraint(equalTo: lbTransportersOffer.leftAnchor).isActive = true
        lbCostOffer.topAnchor.constraint (equalTo: lbTextCost.topAnchor).isActive = true
        lbCostOffer.widthAnchor.constraint(equalTo: lbTransportersOffer.widthAnchor).isActive = true
        lbCostOffer.textAlignment = .left
        lbCostOffer.textColor = UIColor(netHex:0x00955E)
        lbCostOffer.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        lbCostOffer.text = "\(Common.convertCurrencyDoubleV2(value: Double(item.chiPhiDeXuat) ?? 0))"
        

        
        
        let leftView = UIView()
        leftView.translatesAutoresizingMaskIntoConstraints = false

        btnApprove.translatesAutoresizingMaskIntoConstraints = false
        leftView.addSubview(btnApprove)
        btnApprove.setTitle("Duyệt", for: .normal)
        btnApprove.backgroundColor = UIColor(netHex:0x00955E)
        btnApprove.setTitleColor(.white, for: .normal)
        btnApprove.layer.cornerRadius = 10

        btnApprove.widthAnchor.constraint(equalTo: leftView.widthAnchor,multiplier: 1/2).isActive = true
        btnApprove.heightAnchor.constraint(equalTo: leftView.heightAnchor).isActive = true
        btnApprove.centerXAnchor.constraint(equalTo: leftView.centerXAnchor).isActive = true
        btnApprove.centerYAnchor.constraint(equalTo: leftView.centerYAnchor).isActive = true
        btnApprove.tag = indx
        btnApprove.addTarget(self, action: #selector(approveAction), for: .touchUpInside)


        let rightView = UIView()
        rightView.translatesAutoresizingMaskIntoConstraints = false

        btnReject.translatesAutoresizingMaskIntoConstraints = false
        rightView.addSubview(btnReject)
        btnReject.setTitle("Từ chối", for: .normal)
        btnReject.backgroundColor = UIColor.red
        btnReject.setTitleColor(.white, for: .normal)
        btnReject.layer.cornerRadius = 10
        btnReject.widthAnchor.constraint(equalTo: rightView.widthAnchor,multiplier: 1/2).isActive = true
        btnReject.heightAnchor.constraint(equalTo: rightView.heightAnchor).isActive = true
        btnReject.centerXAnchor.constraint(equalTo: rightView.centerXAnchor).isActive = true
        btnReject.centerYAnchor.constraint(equalTo: rightView.centerYAnchor).isActive = true
        btnReject.tag = indx
        btnReject.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)

        
        
        let stackView = UIStackView(arrangedSubviews: [leftView,rightView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        viewCell.addSubview(stackView)
        
        

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: viewCell.leftAnchor).isActive = true
        stackView.topAnchor.constraint (equalTo: lbTextCost.bottomAnchor,constant: Common.Size(s: 10)).isActive = true
        stackView.rightAnchor.constraint(equalTo: viewCell.rightAnchor).isActive = true
        if(item.trangThaiDuyet != "N"){
            stackView.heightAnchor.constraint(equalToConstant:0).isActive = true
        }else{
            stackView.heightAnchor.constraint(equalToConstant: Common.Size(s: 25)).isActive = true
        }
        stackView.bottomAnchor.constraint(equalTo: viewCell.bottomAnchor, constant:Common.Size(s: -10)).isActive = true
        
     
        
        
    }
    
    @objc func rejectAction(sender: UIButton!) {
        let indx = sender.tag
        delegate?.didAction(index: indx, isApproved: false)
     }
    @objc func approveAction(sender: UIButton!) {
        let indx = sender.tag
        delegate?.didAction(index: indx, isApproved: true)
     }
}
