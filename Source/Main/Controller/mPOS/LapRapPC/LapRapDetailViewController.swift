//
//  LapRapDetailViewController.swift
//  fptshop
//
//  Created by Sang Truong on 10/7/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

final class LapRapDetailViewController: BaseController {
    //MARK: - Properties
    private var isCheckCanInsert = false
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var productCodeTxt: UITextField!
    @IBOutlet weak var productNameTxt: UILabel!
    @IBOutlet weak var counttxt: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var pcImage: ImageFrameCustom!
    @IBOutlet weak var serialPCImage: ImageFrameCustom!
    var pcItem: DataPC?
    private var scanIndex:Int = 0
    private var listLinhKien:[LinhKienDetail] = []
    private var dataInsert:DataInsertPC?
    private var listImei = [Imei]()
    private var urlIamgePC:String = ""
    private var urlImageSerial:String = ""
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1, execute: {
            self.bindUI()
        })
        pcImage.controller = self
        pcImage.delegate = self
        pcImage.hiddenRight = true
        serialPCImage.controller = self
        serialPCImage.hiddenRight = true
        serialPCImage.delegate = self
        
        if pcItem?.status == "2" {
            pcImage.isHidden = false
            serialPCImage.isHidden = false
        }else {
            pcImage.isHidden = true
            serialPCImage.isHidden = true
        }
    }
    
    
    // MARK: - Helpers
    
    private func validate() -> Bool{
        guard let _ = pcImage.resultLeftImg.image else {
            self.showAlert("Bạn vui lòng chụp đủ ảnh của PC và serial của PC!")
            return false
        }
        
        guard let _ = serialPCImage.resultLeftImg.image else {
            self.showAlert("Bạn vui lòng chụp đủ ảnh của PC và serial của PC!")
            return false
        }
        return true
    }
    private func setbuttonWith(status: String) {
        if status == "3" || status == "4" {
            saveButton.isHidden = true
            confirmButton.isHidden = true
            pcImage.isHidden = true
            serialPCImage.isHidden = true
        } else if status == "1" {
            saveButton.isHidden = false
            if isCheckCanInsert {
                confirmButton.isHidden = true
                pcImage.isHidden = true
                serialPCImage.isHidden = true
            }
        } else if status == "2" {
            saveButton.isHidden = true
            confirmButton.isHidden = false
            pcImage.isHidden = false
            serialPCImage.isHidden = false
            
        }
    }
    
    
    private func bindUI() {
        self.stateLbl.textColor = pcItem?.colorStatus
        self.stateLbl.text = pcItem!.docEntry + pcItem!.statusDes
        self.timeLbl.text = pcItem?.createDate
        self.productCodeTxt.text = pcItem?.itemCode
        self.productNameTxt.text = pcItem?.itemName
        self.counttxt.text = pcItem?.quantity
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "LinhKienPCCell", bundle: nil), forCellReuseIdentifier: "LinhKienPCCell")
        tableView.register(UINib(nibName: "LinhKienPCHeader", bundle: nil), forCellReuseIdentifier: "LinhKienPCHeader")
        setbuttonWith(status: pcItem?.status ?? "")
        ProgressView.shared.show()
        Provider.shared.laprapPCAPService.getListLinhKien(item_code_pc: pcItem?.itemCode ?? "", doc_header: pcItem?.docEntry ?? "", doc_request: pcItem?.docEntry_Request ?? "", success: {[weak self] result in
            ProgressView.shared.hide()
            guard let self = self else {return}
            self.listLinhKien = result?.data ?? []
            self.tableView.reloadData()
            self.tableViewHeight.constant = CGFloat((self.listLinhKien.count * 150) + 44)
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                var height: CGFloat = 0
                for cell in self.tableView.cells {
                    height += cell.frame.size.height
                }
                self.tableViewHeight.constant = height
            })
            print("reloading")
            CATransaction.commit()
        }, failure: { [weak self] error in
            self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK", handleOk: nil)
        })
    }
    
    private func updateImagePC(base64:String,fileName:String){
        self.showLoading()
        Provider.shared.laprapPCAPService.uploadImagePC(base64: base64, folder: "LapRapPC", filename: "\(self.pcItem?.docEntry ?? "")_\(fileName).jpg", success: { [weak self] result in
            guard let self = self,let response = result else {return}
            self.stopLoading()
            if response.success{
                self.showPopUp("Cập nhật ảnh thành công", "Thông báo", buttonTitle: "OK") { [self] in
                    switch fileName{
                    case "PC":
                        self.urlIamgePC = response.url
                    case "Serial":
                        self.urlImageSerial = response.url
                    default:
                        return
                    }
                }
            }
            else {
                self.showPopUp(response.message , "Thông báo", buttonTitle: "OK", handleOk: nil)
            }
            
        }, failure: { [weak self] error in
            self?.stopLoading()
            self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
        })
        
    }
    private func saveImagePC(){
        ProgressView.shared.show()
    }
    
    // MARK: - Selectors
    @IBAction func save() {
        var detail = [[String:Any]]()
        for item in listLinhKien {
            var itemDiction = [String: Any]()
            itemDiction["itemCode"] = self.pcItem?.itemCode
            itemDiction["itemName"] = self.pcItem?.itemName
            itemDiction["itemCode_LK"] = item.itemCode_LK
            itemDiction["itemName_LK"] = item.itemName_LK
            itemDiction["imei"] = item.imei
            if pcItem?.status == "1" {
                isCheckCanInsert = true
            }
            if pcItem?.status == "2" {
                if item.is_Imei == "1" && item.imei == "" {
                    isCheckCanInsert = false
                    self.showPopUp("(*): Bắt buộc chọn imei!", "Thông báo", buttonTitle: "OK")
                }else{
                    isCheckCanInsert = true
                }
            }
            
            if item.imei != "" {
                let whsCode = Cache.user!.ShopCode+item.loai_Kho!
                itemDiction["WhsCode"] = item.WhsCode ?? whsCode
            }
            else {
                itemDiction["WhsCode"] = Cache.user!.ShopCode+item.loai_Kho!
            }
            itemDiction["sL"] = item.so_Luong
            itemDiction["is_Imei"] = item.is_Imei
            
            detail.append(itemDiction)
            
            
        }
        if isCheckCanInsert {
            ProgressView.shared.show()
            Provider.shared.laprapPCAPService.insertBuildPC(doc_request: self.pcItem?.docEntry_Request ?? "", doc_header: self.pcItem?.docEntry ?? "", update_by_code: Cache.user!.UserName, update_by_name: Cache.user!.EmployeeName, detail: detail, success:{ [weak self] result in
                ProgressView.shared.hide()
                guard let self = self else {return}
                if result?.message?.message_Code == 200 {
                    self.showPopUp(result?.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK")
                    self.setbuttonWith(status: result?.data?.status ?? "")
                    self.dataInsert = result?.data
                    self.pcItem?.status = result?.data?.status ?? ""
                    self.stateLbl.textColor = self.pcItem?.colorStatus
                    self.stateLbl.text = self.pcItem!.docEntry + self.pcItem!.statusDes
                    self.confirmButton.isHidden = false
                    //                self.stateLbl.text = pcItem!.docEntry + pcItem!.statusDes
                    
                } else {
                    self.showPopUp(result?.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK")
                }
            } , failure: {
                [weak self] error in
                self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
            })
            
        }
    }
    
    
    @IBAction func confirm() {

        let dispatchGroup = DispatchGroup()

        if validate() {
            dispatchGroup.enter()
            ProgressView.shared.show()
            let fileName = urlIamgePC + "," + urlImageSerial
            Provider.shared.laprapPCAPService.uploadFilePC(userCode: Cache.user!.UserName, shopCode: Cache.user!.ShopCode, docEntry: pcItem?.docEntry ?? "", fileName: fileName, success: { [weak self] result in
                guard let self = self,let response = result else {return}
                if response.success{
                    dispatchGroup.leave()
                }
                else {
                    self.showPopUp(response.message , "Thông báo", buttonTitle: "OK", handleOk: nil)
                    dispatchGroup.leave()

                }
            }, failure: { [weak self] error in
                self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
                dispatchGroup.leave()

            })
            dispatchGroup.enter()
            Provider.shared.laprapPCAPService.updateStatePCBuild(doc_request: dataInsert != nil ? self.dataInsert?.docEntry_Request ?? "" : self.pcItem?.docEntry_Request ?? "", doc_header: dataInsert != nil ? dataInsert?.docEntry_Header ?? "" : self.pcItem?.docEntry ?? "", status: "3", update_by_code: Cache.user!.UserName, update_by_name: Cache.user!.EmployeeName, success: { [weak self] result in
                ProgressView.shared.hide()
                guard let self = self,let response = result else {return}
                if response.message?.message_Code == 200 {
                    ProgressView.shared.hide()
                    self.showPopUp("Cập nhật thông tin thành công", "Thông báo", buttonTitle: "OK") {
                        self.navigationController?.popViewController(animated: true)
                        dispatchGroup.leave()
                    }
                } else {
                    self.showPopUp(response.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK", handleOk: nil)
                    dispatchGroup.leave()
                }
            }, failure: { [weak self] error in
                self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
                dispatchGroup.leave()
            })
            dispatchGroup.notify(queue: .main) {
                ProgressView.shared.hide()
            }
        }
    }
    
}
// MARK: - UITableViewDataSource


extension LapRapDetailViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 44
        } else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return listLinhKien.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinhKienPCHeader", for: indexPath) as! LinhKienPCHeader
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinhKienPCCell", for: indexPath) as! LinhKienPCCell
            cell.bindCell(item: listLinhKien[indexPath.row], canUpdateImei: pcItem?.status == "1" || pcItem?.status == "2")
            cell.onScan = {
                self.scanIndex = indexPath.row
                let viewController = ScanCodeViewController()
                viewController.scanSuccess = { text in
                    self.listLinhKien[self.scanIndex].imei = text
                    self.tableView.reloadData()
                    self.saveButton.isHidden = false
                    self.confirmButton.isHidden = true
                }
                self.present(viewController, animated: false, completion: nil)
            }
            
            cell.onSelectImei = {
                print(self.pcItem!.itemCode);
                print(self.pcItem!.shopCode)
                let item = self.listLinhKien[indexPath.row].itemCode_LK
                
                ProgressView.shared.show()
                MPOSAPIManager.getImeiFF(productCode: item ?? "", shopCode: self.pcItem?.shopCode ?? "") { [weak self] (result, err) in
                    ProgressView.shared.hide()
                    guard let self = self else { return }
                    self.listImei = result
                    
                    for (index,item) in result.enumerated() {
                        if let theDate = Date(jsonDate: "\(item.CreateDate)") {
                            let dateString = theDate.stringWith(format: "dd/MM/yyyy")
                            self.listImei[index].CreateDate = dateString
                        }
                    }
                    
                    if err != "" {
                        self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                    } else {
                        let vc = SelectImeiPCPopup()
                        vc.modalPresentationStyle = .overCurrentContext
                        vc.modalTransitionStyle = .crossDissolve
                        vc.listImei = result
                        vc.onSelectImei = { imei in
                            self.listLinhKien[indexPath.row].imei = imei.DistNumber
                            self.listLinhKien[indexPath.row].WhsCode = imei.WhsCode
                            self.saveButton.isHidden = false
                            self.confirmButton.isHidden = true
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
            return cell
        }
    }
}

extension UITableView {
    /**
     * Returns all cells in a table
     * ## Examples:
     * tableView.cells // array of cells in a tableview
     */
    public var cells: [UITableViewCell] {
        (0..<self.numberOfSections).indices.map { (sectionIndex: Int) -> [UITableViewCell] in
            (0..<self.numberOfRows(inSection: sectionIndex)).indices.compactMap { (rowIndex: Int) -> UITableViewCell? in
                self.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex))
            }
        }.flatMap { $0 }
    }
}
extension LapRapDetailViewController: ImageFrameCustomDelegate {
    func didPickImage(_ view: ImageFrameCustom, image: UIImage, isLeft: Bool) {
        if view == pcImage {
            if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
                let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
                self.updateImagePC(base64: base64Str, fileName: "PC")
            }
        } else {
            if let imageData:NSData = image.jpegData(compressionQuality: Common.resizeImageScanCMND) as NSData?{
                let base64Str = imageData.base64EncodedString(options: .endLineWithLineFeed)
                self.updateImagePC(base64: base64Str, fileName: "Serial")
            }
        }
    }
    
}
