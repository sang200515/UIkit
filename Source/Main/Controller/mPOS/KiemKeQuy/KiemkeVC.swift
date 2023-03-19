//
//  KiemkeVC.swift
//  fptshop
//
//  Created by Ngoc Bao on 07/09/2021.
//  Copyright © 2021 Duong Hoang Minh. All rights reserved.
//

import UIKit
import DropDown
import Toaster
import CoreMedia

enum KiemKeState {
    case kiemkecuoingay
    case kiemkethuong
    case giaitrinh
    case review
    case none
}

class KiemkeVC: BaseController {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDate2: UILabel!
    @IBOutlet weak var lblShop: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var stateStack: UIStackView!
    @IBOutlet weak var shopStack: UIStackView!
    @IBOutlet weak var hearderKkView: UIView!
    @IBOutlet weak var hearderExView: UIView!
    @IBOutlet weak var lblKk: UILabel!
    @IBOutlet weak var lblEx: UILabel!
    @IBOutlet weak var kkContentView: UIView!
    @IBOutlet weak var exContentView: UIView!
    
    // outlet Kiem ke
    @IBOutlet weak var moneytxtl500: UITextField!
    @IBOutlet weak var moneytxt200: UITextField!
    @IBOutlet weak var moneytxt100: UITextField!
    @IBOutlet weak var moneytxt50: UITextField!
    @IBOutlet weak var moneytxt20: UITextField!
    @IBOutlet weak var moneytxt10: UITextField!
    @IBOutlet weak var moneytxt5: UITextField!
    @IBOutlet weak var moneytxt2: UITextField!
    @IBOutlet weak var moneytxt1: UITextField!
    @IBOutlet weak var moneytxt005: UITextField!
    @IBOutlet weak var moneyLbl500: UILabel!
    @IBOutlet weak var moneyLbl200: UILabel!
    @IBOutlet weak var moneyLbl100: UILabel!
    @IBOutlet weak var moneyLbl50: UILabel!
    @IBOutlet weak var moneyLbl20: UILabel!
    @IBOutlet weak var moneyLbl10: UILabel!
    @IBOutlet weak var moneyLbl5: UILabel!
    @IBOutlet weak var moneyLbl2: UILabel!
    @IBOutlet weak var moneyLbl1: UILabel!
    @IBOutlet weak var moneyLbl005: UILabel!
    @IBOutlet weak var moneyLblTotal: UILabel!
    @IBOutlet weak var lblTotalSystem: UILabel!
    @IBOutlet weak var lblDifference: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var confirmKKButton: UIButton!
    
    //outlet giaitrinh
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var totalExplainMoney: UILabel!
    @IBOutlet weak var differenceLbl: UILabel!
    
    let dropDownMenu = DropDown()
    var listEx: [ExplainItem] = [
        ExplainItem(explain: "", money: "", url: "")
    ]
    var detail: KiemKeItem?
    var saveKiemke = true
    var saveDone = false
    var listMoney:[[String:Any]] = [["value":0.0,"count":0.0,"menh_Gia":500000],["value":0.0,"count":0.0,"menh_Gia":200000],["value":0.0,"count":0.0,"menh_Gia":100000],["value":0.0,"count":0.0,"menh_Gia":50000],["value":0.0,"count":0.0,"menh_Gia":20000],["value":0.0,"count":0.0,"menh_Gia":10000],["value":0.0,"count":0.0,"menh_Gia":5000],["value":0.0,"count":0.0,"menh_Gia":2000],["value":0.0,"count":0.0,"menh_Gia":1000],["value":0.0,"count":0.0,"menh_Gia":500]]
    var currentState: KiemKeState = .none
    var docStatus = "O"
    var docEntry = ""
    var totalMoney: Double = 0
    var totalExMoney: Double = 0
    var totalDifference: Double = 0
    var needExplain = false
    var reviewItem: SearchKiemKeDetail?
    var uploadAtIndex = -1
    var shopItem: ItemShop?
    var onreload:(()->Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    func initView() {
        if currentState == .kiemkecuoingay || currentState == .kiemkethuong {
            self.title = "KIỂM KÊ \(currentState == .kiemkethuong ? "THƯỜNG" : "CUỐI NGÀY")"
        }
        moneytxtl500.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt200.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt100.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt50.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt20.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt10.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt5.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt2.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt1.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        moneytxt005.addTarget(self, action: #selector(onChange(txt:)), for: .editingChanged)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ExplainCellTableViewCell", bundle: nil), forCellReuseIdentifier: "ExplainCellTableViewCell")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onclickKK))
        hearderKkView.addGestureRecognizer(gesture)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(onclickEx))
        hearderExView.addGestureRecognizer(gesture2)
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        if currentState == .kiemkethuong || currentState == .kiemkecuoingay {
            saveButton.isHidden = false
            stateStack.isHidden = true
            selectTab(index: 0)
            lblShop.text = "\(shopItem?.needFullName ?? false ? shopItem?.fullName ?? "" : shopItem?.name ?? "")"
            lblName.text = "\(Cache.user!.UserName)-\(Cache.user!.EmployeeName)"
            lblDate.text = Common.gettimeWith(format: "dd/MM/yyyy")
            lblDate2.text = Common.gettimeWith(format: "dd/MM/yyyy")
        } else if currentState == .review {
            self.saveKiemke = false
            self.kkContentView.isUserInteractionEnabled = false
            self.docEntry = self.reviewItem?.docentry ?? ""
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                KiemkequyApiManager.shared.getDetailKiemKe(docentry: Int(self.reviewItem?.docentry ?? "0") ?? 0) {[weak self] result, errMsg in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert { [self] in
                        if errMsg != "" {
                            self.showPopUp(errMsg, "Thông báo", buttonTitle: "OK") {
                                self.navigationController?.popViewController(animated: true)
                            }
                        } else {
                            self.detail = result
                           //binData here.
                            if self.reviewItem?.doc_Status?.lowercased() == "w" && self.detail?.data?.is_Giai_Trinh.lowercased() == "true" {
                                self.title = "GIẢI TRÌNH"
                                self.selectTab(index: 1)
                            } else {
                                self.title = "CHI TIẾT KIỂM KÊ"
                                self.selectTab(index: 0)
                            }
                            
                            self.lblDate.text = self.reviewItem?.create_Date
                            self.lblDate2.isHidden = false
                            self.lblDate2.text = self.reviewItem?.create_Date
                            self.lblShop.text = self.reviewItem?.shop_Name
                            self.lblTitle.text = "\(self.reviewItem?.docentry ?? "")-\(self.reviewItem?.statusName ?? "")"
                            self.lblTitle.textColor = self.reviewItem?.statusColor
                            self.lblName.text = "\(Cache.user!.UserName)-\(Cache.user!.EmployeeName)"
                            self.totalMoney = result?.data?.header.so_Tien_Kiem_Quy ?? 0
                            self.totalDifference = result?.data?.header.so_Tien_Lech ?? 0
                            self.calculateDifference(item: result?.data?.header.so_Tien_He_Thong ?? 0)
                            for item in result?.data?.chi_Tiet ?? [] {
                                switch item.menh_Gia {
                                case 500000:
                                    self.calculateMoney(lbl: self.moneyLbl500, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxtl500.text = "\(item.so_To)"
                                case 200000:
                                    self.calculateMoney(lbl: self.moneyLbl200, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt200.text = "\(item.so_To)"
                                case 100000:
                                    self.calculateMoney(lbl: self.moneyLbl100, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt100.text = "\(item.so_To)"
                                case 50000:
                                    self.calculateMoney(lbl: self.moneyLbl50, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt50.text = "\(item.so_To)"
                                case 20000:
                                    self.calculateMoney(lbl: self.moneyLbl20, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt20.text = "\(item.so_To)"
                                case 10000:
                                    self.calculateMoney(lbl: self.moneyLbl10, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt10.text = "\(item.so_To)"
                                case 5000:
                                    self.calculateMoney(lbl: self.moneyLbl5, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt5.text = "\(item.so_To)"
                                case 2000:
                                    self.calculateMoney(lbl: self.moneyLbl2, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt2.text = "\(item.so_To)"
                                case 1000:
                                    self.calculateMoney(lbl: self.moneyLbl1, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt1.text = "\(item.so_To)"
                                case 500:
                                    self.calculateMoney(lbl: self.moneyLbl005, count: Double(item.so_To), money: item.menh_Gia)
                                    self.moneytxt005.text = "\(item.so_To)"
                                default:
                                    break
                                }
                            }
                            
                            if (result?.data?.giai_Trinh.count ?? 0) > 0 {
                                self.listEx = []
                                for item in result?.data?.giai_Trinh ?? [] {
                                    self.listEx.append(ExplainItem(reasonCode: item.reason_Code ?? "0", explain: item.reason_Content ?? "", money: Double(item.total ?? "0")?.removeZerosFromEnd() ?? "0", url: item.url_Image ?? ""))
                                }
                            } else {
                                if self.reviewItem?.doc_Status?.lowercased() != "w" {
                                    self.listEx = []
                                } else {
                                    if fabs(self.totalDifference) <= 10000 {
                                        self.listEx = []
                                    }
                                }
                            }
                            self.reloadMoney()
                            self.reloadTable()
                        }
                    }
                }
            }
        }
    }
    @objc func onclickKK() {selectTab(index: 0)}
    @objc func onclickEx() {selectTab(index: 1)}
    @objc func onChange(txt: UITextField) {
        let count = Double(txt.text ?? "0") ?? 0
        switch txt.tag {
        case 0:
            calculateMoney(lbl: moneyLbl500, count: count , money: 500000)
            listMoney[0]["value"] = count * 500000
            listMoney[0]["count"] = count
        case 1:
            calculateMoney(lbl: moneyLbl200, count: count , money: 200000)
            listMoney[1]["value"] = count * 200000
            listMoney[1]["count"] = count
        case 2:
            calculateMoney(lbl: moneyLbl100, count: count , money: 100000)
            listMoney[2]["value"] = count * 100000
            listMoney[2]["count"] = count
        case 3:
            calculateMoney(lbl: moneyLbl50, count: count , money: 50000)
            listMoney[3]["value"] = count * 50000
            listMoney[3]["count"] = count
        case 4:
            calculateMoney(lbl: moneyLbl20, count: count , money: 20000)
            listMoney[4]["value"] = count * 20000
            listMoney[4]["count"] = count
        case 5:
            calculateMoney(lbl: moneyLbl10, count: count , money: 10000)
            listMoney[5]["value"] = count * 10000
            listMoney[5]["count"] = count
        case 6:
            calculateMoney(lbl: moneyLbl5, count: count , money: 5000)
            listMoney[6]["value"] = count * 5000
            listMoney[6]["count"] = count
        case 7:
            calculateMoney(lbl: moneyLbl2, count: count , money: 2000)
            listMoney[7]["value"] = count * 2000
            listMoney[7]["count"] = count
        case 8:
            calculateMoney(lbl: moneyLbl1, count: count , money: 1000)
            listMoney[8]["value"] = count * 1000
            listMoney[8]["count"] = count
        case 9:
            calculateMoney(lbl: moneyLbl005, count: count , money: 500)
            listMoney[9]["value"] = count * 500
            listMoney[9]["count"] = count
        default:
            break
        }
    }
    
    func calculateTotal() {
        let money = Double(moneyLbl500.text?.trimMoney() ?? "0")! + Double(moneyLbl200.text?.trimMoney() ?? "0")! + Double(moneyLbl100.text?.trimMoney() ?? "0")! + Double(moneyLbl50.text?.trimMoney() ?? "0")!
        let anotherMoney = Double(moneyLbl20.text?.trimMoney() ?? "0")! + Double(moneyLbl10.text?.trimMoney() ?? "0")! + Double(moneyLbl5.text?.trimMoney() ?? "0")! + Double(moneyLbl2.text?.trimMoney() ?? "0")! + Double(moneyLbl1.text?.trimMoney() ?? "0")! + Double(moneyLbl005.text?.trimMoney() ?? "0")!
        totalMoney = money + anotherMoney
        moneyLblTotal.text = Common.convertCurrencyDouble(value: money + anotherMoney)
    }
    
    func calculateMoney(lbl: UILabel,count: Double, money: Double) {
        let money = count * money
        lbl.text = Common.convertCurrencyDouble(value: money)
        calculateTotal()
    }
    
    func reloadTable() {
        tableViewHeight.constant = CGFloat(listEx.count * 50)
        tableView.reloadData()
    }
    
    func reloadMoney() {
        var money:Double = 0
        listEx.forEach { item in
            money += Double(item.money) ?? 0
        }
        self.totalExMoney = money
        totalExplainMoney.text = Common.convertCurrencyDouble(value: money)
    }
    
    func selectTab(index: Int) {
        kkContentView.isHidden = index != 0
        exContentView.isHidden = index != 1
        hearderKkView.backgroundColor = index == 0 ? Constants.COLORS.bold_green : .white
        lblKk.textColor = index == 0 ? .white : .black
        hearderExView.backgroundColor = index == 1 ? Constants.COLORS.bold_green : .white
        lblEx.textColor = index == 1 ? .white : .black
        if index == 0 {
            confirmKKButton.isHidden = true
            if detail?.data?.is_Huy_Kiem_Ke.lowercased() == "true" { // confirm button
                cancelButton.isHidden = false
            } else {
                if saveKiemke {
                    if saveDone {
                        cancelButton.isHidden = false
                    } else {
                        cancelButton.isHidden = true
                    }
                } else {
                    cancelButton.isHidden = true
                }
            }
            
            if detail?.data?.is_Kiem_Ke.lowercased() == "true" { // confirm button
                confirmButton.isHidden = false
                saveButton.isHidden = true
            } else {
                if saveKiemke {
                    if saveDone {
                        confirmButton.isHidden = false
                    } else {
                        confirmButton.isHidden = true
                        saveButton.isHidden = false
                    }
                } else {
                    confirmButton.isHidden = true
                    saveButton.isHidden = true
                }
            }
        } else {
            cancelButton.isHidden = true
            confirmButton.isHidden = true
            saveButton.isHidden = true
            if detail?.data?.is_Giai_Trinh.lowercased() == "true" {
                confirmKKButton.isHidden = false
            } else {
                confirmKKButton.isHidden = true
            }
        }
    }
    func getDetailMoney() -> [[String:Any]] {
        var detail = [[String: Any]]()
        for item in listMoney {
            var newItem = [String: Any]()
            if (item["count"] as! Double) == 0 {
                continue
            }
            newItem["so_To"] = item["count"] as! Double
            newItem["menh_Gia"] = item["menh_Gia"] as! Int
            newItem["thanh_Tien"] = item["value"] as! Double
            detail.append(newItem)
        }
        return detail
    }
    func getDetailGiaiTrinh() -> [[String:Any]] {
        var detail = [[String: Any]]()
        for item in listEx {
            var newItem = [String: Any]()
            newItem["reason_Code"] = item.reasonCode
            newItem["reason_Content"] = item.explain
            newItem["total"] = item.money
            newItem["url_Image"] = item.url
            detail.append(newItem)
        }
        return detail
    }
    func calculateDifference(item: Double) {
        let sysMoney = item
        needExplain = (totalMoney - sysMoney != 0)
        lblTotalSystem.text = Common.convertCurrencyDouble(value: sysMoney)
        lblDifference.text = Common.convertCurrencyDouble(value: self.totalDifference)
        differenceLbl.text = "Tổng tiền chênh lệch: \(Common.convertCurrencyDouble(value: self.totalDifference))"
    }
    
    func validate() -> Bool {
        return self.listEx.filter({$0.isNull}).count > 0
    }
    
    func kiemKe() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            KiemkequyApiManager.shared.saveGiaiTrinh(docentry: Int(self.docEntry) ?? 0, detail: self.getDetailGiaiTrinh()) { result, errMsg in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if errMsg != "" {
                        self.showPopUp(errMsg, "Thông báo", buttonTitle: "OK", handleOk: nil)
                    } else {
                        self
                            .showPopUp(result?.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK") {
                                self.navigationController?.popViewController(animated: true)
                                if let reload = self.onreload {
                                    reload()
                                }
                            }
                    }
                }
            }
        }
    }
    
    @IBAction func addNewreason() {
        if reviewItem?.doc_Status?.lowercased() == "f" {
            return
        }
        listEx.append(ExplainItem())
        reloadTable()
    }
    
    @IBAction func onSave() {
        if currentState == .kiemkethuong || currentState == .kiemkecuoingay {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                KiemkequyApiManager.shared.saveCheckFund(shopItem: self.shopItem ?? ItemShop(code: "", name: ""),isNormal: self.currentState == .kiemkethuong, doc_Status: self.docStatus, totalFund: self.totalMoney, detail: self.getDetailMoney()) { [weak self] (result, errMsg) in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if errMsg != "" {
                            self.showPopUp(errMsg, "Thông báo", buttonTitle: "OK", handleOk: nil)
                        } else {
                            self.saveDone = true
                            self.saveButton.isHidden = true
                            self.confirmButton.isHidden = false
                            self.cancelButton.isHidden = false
                            self.stateStack.isHidden = false
                            self.kkContentView.isUserInteractionEnabled = false
                            self.lblTitle.text = "\(result?.data?.docentry ?? "0") - Mở"
                            self.docEntry = result?.data?.docentry ?? "0"
                            let sysMoney =  Double(result?.data?.so_Tien_He_Thong ?? "0") ?? 0
                            self.totalDifference = self.totalMoney - sysMoney
                            self.calculateDifference(item: sysMoney)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onConfirmKK() {
        if fabs(self.totalDifference) > 10000 {
            if listEx.count == 0 {
                showPopup(with: "Cần có lí do giải trình", completion: nil)
            } else if validate() {
                showPopup(with: "Bạn chưa chọn lý do hoặc nhập số tiền", completion: nil)
            } else {
                kiemKe()
            }
        } else {
            if validate() {
                showPopup(with: "Bạn chưa chọn lý do hoặc nhập số tiền", completion: nil)
            } else {
                kiemKe()
            }
        }
    }
    
    @IBAction func onConfirm() {
        docStatus = needExplain ? "W" : "F"
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            KiemkequyApiManager.shared.updateHeaderState(docentry: Int(self.docEntry) ?? 0, status: self.docStatus) {[weak self] result, errMsg in
                guard let self = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if errMsg != "" {
                        self.showPopUp(errMsg, "Thông báo", buttonTitle: "OK", handleOk: nil)
                    } else {
                        self.showPopUp(result?.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK") {
                            for vc in self.navigationController?.viewControllers ?? [] {
                                if vc is KiemkequyMenuVC {
                                    self.navigationController?.popToViewController(vc, animated: true)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func onCancel() {
        docStatus = "C"
        showPopUpCustom(title: "Thông báo", titleButtonOk: "Đồng ý", titleButtonCancel: "Huỷ", message: "Bạn có muốn hủy phiếu kiểm kê không?", actionButtonOk: {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                KiemkequyApiManager.shared.updateHeaderState(docentry: Int(self.docEntry) ?? 0, status: self.docStatus) {[weak self] result, errMsg in
                    guard let self = self else {return}
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if errMsg != "" {
                            self.showPopUp(errMsg, "Thông báo", buttonTitle: "OK", handleOk: nil)
                        } else {
                            self.showPopUp(result?.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK") {
                                self.navigationController?.popViewController(animated: true)
                                if let reload = self.onreload {
                                    reload()
                                }
                            }
                        }
                    }
                }
            }
        }, actionButtonCancel: nil, isHideButtonOk: false, isHideButtonCancel: false)
    }
}

extension KiemkeVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listEx.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExplainCellTableViewCell", for: indexPath) as! ExplainCellTableViewCell
        cell.bindCell(item: listEx[indexPath.row],isViewOnly: reviewItem?.doc_Status?.lowercased() == "f")
        cell.onImage = {
            if self.reviewItem?.doc_Status?.lowercased() == "f" && self.listEx[indexPath.row].url == "" {
                self.showPopup(with: "Không có ảnh!", completion: nil)
            } else {
                self.uploadAtIndex = indexPath.row
                let camera = DSCameraHandler(delegate_: self)
                let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                optionMenu.popoverPresentationController?.sourceView = self.view
                
                let takePhoto = UIAlertAction(title: "Chụp ảnh", style: .default) { (alert : UIAlertAction!) in
                    camera.getCameraOn(self, canEdit: false)
                }
                let sharePhoto = UIAlertAction(title: "Xem ảnh", style: .default) { (alert : UIAlertAction!) in
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL(string: self.listEx[indexPath.row].url)!, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.canOpenURL(URL(string: self.listEx[indexPath.row].url)!)
                    }
                }
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert : UIAlertAction!) in}
                if self.reviewItem?.doc_Status?.lowercased() != "f" {
                    optionMenu.addAction(takePhoto)
                }
                if self.listEx[indexPath.row].url != "" {
                    optionMenu.addAction(sharePhoto)
                }
                optionMenu.addAction(cancelAction)
                self.present(optionMenu, animated: true, completion: nil)
            }
        }
        cell.onReason = { [weak self] index in
            self?.listEx[indexPath.row].reasonCode = index
            self?.reloadTable()
        }
        cell.onTxtChnage = { [weak self] (isMoney,value) in
            if isMoney {
                self?.listEx[indexPath.row].money = value == "" ? "0" : value.trimMoney()
            } else {
                self?.listEx[indexPath.row].explain = value
            }
            self?.reloadMoney()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return reviewItem?.doc_Status?.lowercased() == "w"
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            listEx.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            reloadTable()
            reloadMoney()
        }
    }
}

extension KiemkeVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        let imageData:NSData = image.jpegData(compressionQuality: 0.7)! as NSData
        let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
        self.showLoading()
        CRMAPIManager.uploadImageUrl(strBase64: strBase64,folder: "KIEM_KE_QUY", filename: "\(Date().timeIntervalSince1970.description.trimAllSpace()).jpg") { (url, msg, err) in
            self.stopLoading()
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if err.count <= 0 {
                    if !(url.isEmpty) {
                        self.showPopup(with: msg ?? "", completion: nil)
                        self.listEx[self.uploadAtIndex].url = url
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(msg ?? "upload image thất bại!")", preferredStyle: UIAlertController.Style.alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: UIAlertController.Style.alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension String {
    func trimMoney() -> String {
        return self.replace(",", withString: "").replace(".", withString: "").trim()
    }
}
