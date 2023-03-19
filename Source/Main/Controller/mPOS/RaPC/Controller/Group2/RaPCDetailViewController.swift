//
//  RaPCDetailViewController1.swift
//  fptshop
//
//  Created by Sang Truong on 12/3/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class RaPCDetailViewController: UIViewController {
    var isCheck = false
    var dataInsert:DataInsertPC?

    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    var scanIndex:Int = 0
    var listImei = [Imei]()

    var pcItem: DataRaPC?
    var listLinhKien1 :[LinhKienRaPCDetail] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    func bindUI(){
        self.stateLbl.textColor = pcItem?.colorStatus
        self.stateLbl.text = pcItem!.docEntry + pcItem!.statusDes
        self.timeLbl.text = pcItem?.createDate
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = "PHIẾU RÃ PC"
        tableView.register(UINib(nibName: "LinhKienRaPCCell", bundle: nil), forCellReuseIdentifier: "LinhKienRaPCCell")
        tableView.register(UINib(nibName: "LinhKienRaPCHeader", bundle: nil), forCellReuseIdentifier: "LinhKienRaPCHeader")
        setbuttonWith(status: pcItem?.status ?? "")
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
        Provider.shared.raPCAPService.getListLinhKien(item_code_pc: pcItem?.itemCode ?? "", doc_header: pcItem?.docEntry ?? "", doc_request: pcItem?.docEntry_Request ?? "", success: {[weak self] result in
            ProgressView.shared.hide()
            guard let self = self else {return}
            self.listLinhKien1 = result?.data ?? []
            self.tableView.reloadData()
            self.tableViewHeight.constant = CGFloat((self.listLinhKien1.count * 150) + 44)
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
    func loadListProductByImei() {
        
    }
    @IBAction func save() {
        
          var detail = [[String:Any]]()
          for item in listLinhKien1 {
              var itemDiction = [String: Any]()
//              if pcItem?.status == "4" {
//                  self.showPopUp("Phiếu ở trạng thái huỷ không thể lưu", "Thông báo", buttonTitle: "OK")
//              }
              itemDiction["itemCode"] = self.pcItem?.itemCode
              itemDiction["itemName"] = self.pcItem?.itemName
              itemDiction["imei"] = item.imei
              if pcItem?.status == "1" {
                  isCheck = true
              }
              if pcItem?.status == "2" {
                  if item.is_Imei == "1" && item.imei == "" {
                      isCheck = false
                      self.showPopUp("(*): Bắt buộc chọn imei!", "Thông báo", buttonTitle: "OK")
                  }else{
                      isCheck = true
                  }
              }
           
              if item.imei != "" {
               itemDiction["WhsCode"] = item.WhsCode
              }
              else {
                  itemDiction["WhsCode"] = Cache.user!.ShopCode+item.loai_Kho!
              }
              itemDiction["sL"] = item.so_Luong
              itemDiction["loai_Kho"] = item.loai_Kho

               detail.append(itemDiction)


          }
          if isCheck {
              ProgressView.shared.show()
              Provider.shared.raPCAPService.insertBuildPC(doc_request: self.pcItem?.docEntry_Request ?? "", doc_header: self.pcItem?.docEntry ?? "", update_by_code: Cache.user!.UserName, update_by_name: Cache.user!.EmployeeName, detail: detail, success:{ [weak self] result in
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
        ProgressView.shared.show()
        Provider.shared.raPCAPService.updateStatePCBuild(doc_request: dataInsert != nil ? self.dataInsert?.docEntry_Request ?? "" : self.pcItem?.docEntry_Request ?? "", doc_header: dataInsert != nil ? dataInsert?.docEntry_Header ?? "" : self.pcItem?.docEntry ?? "", status: "3", update_by_code: Cache.user!.UserName, update_by_name: Cache.user!.EmployeeName, success: { [weak self] result in
            ProgressView.shared.hide()
            guard let self = self,let response = result else {return}
            if response.message?.message_Code == 200 {
                self.showPopUp("Cập nhật thông tin thành công", "Thông báo", buttonTitle: "OK") {
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                self.showPopUp(response.message?.message_Desc ?? "", "Thông báo", buttonTitle: "OK", handleOk: nil)
            }
        }, failure: { [weak self] error in
            self?.showPopUp(error.localizedDescription, "Thông báo", buttonTitle: "OK")
        })
    }
    
    func setbuttonWith(status: String) {
        if status == "3" || status == "4" {
            saveButton.isHidden = true
            confirmButton.isHidden = true
        } else if status == "1" {
            saveButton.isHidden = false
            if isCheck {
                confirmButton.isHidden = true
 }
        } else if status == "2" {
            saveButton.isHidden = true
            confirmButton.isHidden = false
        }
    }
    
}
extension RaPCDetailViewController:UITableViewDataSource,UITableViewDelegate {
    
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
        }else  {
            return listLinhKien1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinhKienRaPCHeader", for: indexPath) as! LinhKienRaPCHeader
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LinhKienRaPCCell", for: indexPath) as! LinhKienRaPCCell
            cell.bindCell(item: listLinhKien1[indexPath.row], canUpdateImei: pcItem?.status == "1" || pcItem?.status == "2")
           
            cell.onScan = {
                self.scanIndex = indexPath.row
                let viewController = ScanCodeViewController()
                viewController.scanSuccess = { text in
                    self.listLinhKien1[self.scanIndex].imei = text
                    self.tableView.reloadData()
                    self.saveButton.isHidden = false
                    self.confirmButton.isHidden = true
                }
                self.present(viewController, animated: false, completion: nil)
            }
            cell.onSelectImei = {
                print(self.pcItem!.itemCode);
                print(self.pcItem!.shopCode)
                let item = self.listLinhKien1[indexPath.row].itemCode_PC
                
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
                            self.listLinhKien1[indexPath.row].imei = imei.DistNumber
                            self.listLinhKien1[indexPath.row].WhsCode = imei.WhsCode
                            self.saveButton.isHidden = false
                            self.confirmButton.isHidden = true
                            self.tableView.reloadRows(at: [indexPath], with: .none)
                        }
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            }
            cell.onSelectDetails = {
                let vc =  DetailsLinhKienRaPC()
                vc.imei = self.listLinhKien1[indexPath.row].imei!
                vc.itemCode = self.listLinhKien1[indexPath.row].itemCode_PC!
               
                self.navigationController?.pushViewController(vc, animated: true)
            
            }
            return cell
        }
    
    }
}
