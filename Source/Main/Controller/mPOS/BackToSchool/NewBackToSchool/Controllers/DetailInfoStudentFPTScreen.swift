//
//  DetailInfoStudentFPTScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/21/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum DetailInfoStudentList: Int, CaseCountable {
    case infoStudent
    case infoDiscount
    case shipType
    case updateImage
}

class DetailInfoStudentFPTScreen: BaseController {
    
    var infoDetailStudentFPT: StudentBTSInfo?
    private var iD_BackToSchool: Int?
    private var detailInfoStudentHistoryBySBD: DetailInfoStudentFPTItem.Data?

    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let btnPrint: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("IN", for: .normal)
        button.setTitleColor(Constants.COLORS.main_color_white, for: .normal)
        button.backgroundColor = Constants.COLORS.bold_green
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
//        self.title = "LỊCH SỬ SINH VIÊN FPT"
        self.title = "LỊCH SỬ CHƯƠNG TRÌNH DÀNH CHO HS/SV"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailInfoStudentFPTCell.self, forCellReuseIdentifier: DetailInfoStudentFPTCell.identifier)
        tableView.register(DiscountSudentFPTInfoCell.self, forCellReuseIdentifier: DiscountSudentFPTInfoCell.identifier)
        tableView.register(ListImageStudentInfoFPTCell.self, forCellReuseIdentifier: ListImageStudentInfoFPTCell.identifier)
        tableView.register(UINib(nibName: "RadioButtonBTSCell", bundle: nil), forCellReuseIdentifier: "RadioButtonBTSCell")
        tableView.tableFooterView = UIView()
        
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -16, y: -4, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        view.addSubview(tableView)
        tableView.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 8, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
//        view.addSubview(btnPrint)
//        view.bringSubviewToFront(btnPrint)
//        btnPrint.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 16, bottomConstant: 40, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
//        btnPrint.addTarget(self, action: #selector(sendCodeVoucherForCustomer(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }
    
    @objc func actionBack() {
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: HomeBackToSchoolScreen.self) {
//                _ = self.navigationController?.popToViewController(controller, animated: true)
//            }
//        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func sendCodeVoucherForCustomer(_ button: UIButton) {
        
    }
    
    func getiD_BackToSchool(_ id: Int) {
        self.iD_BackToSchool = id
    }
    
//    fileprivate func fetchData() {
//        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//            MPOSAPIManager.BackToSchool_LoadThongTinKHBySBD(SoBaoDanh: self.iD_BackToSchool ?? 0, handler: { [weak self] (success, errorMsg, result, err) in
//                guard let strongSelf = self else {return}
//                WaitingNetworkResponseAlert.DismissWaitingAlert {
//                    if success == "1" {
//                        if result != nil {
//                            if result?.Result == 1 {
//                                strongSelf.infoDetailStudentFPT = result
//                                strongSelf.tableView.reloadData()
//                            } else {
//                                strongSelf.showAlertOneButton(title: "Thông báo", with: err, titleButton: "Đồng ý")
//                            }
//
//                        } else {
//                            debugPrint("Không lấy được data")
//                        }
//                    } else {
//                        strongSelf.showAlertOneButton(title: "Thông báo", with: errorMsg, titleButton: "Đồng ý")
//                    }
//
//                }
//            })
//        }
//    }
//}
    
    fileprivate func fetchData() {
        let params: [String:Any] = [
            "Id_BackToSchool": self.iD_BackToSchool!
        ]
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.backToSchool_LoadHistoryKHBySBD(params: params) {[weak self] (success, data, errMsg) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        if let result = data {
                            strongSelf.detailInfoStudentHistoryBySBD = result
                            strongSelf.tableView.reloadData()
                        }
                    } else {
                        strongSelf.showPopUp(errMsg ?? "", "Thông báo", buttonTitle: "Đồng ý")
                    }
                }
            }
        }
    }
}

extension DetailInfoStudentFPTScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return DetailInfoStudentList.caseCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        case 1:
            return 40
        case 2:
            return 50
        case 3: return
            UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("THÔNG TIN THÍ SINH")
            return vHeader
        case 1:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("THÔNG TIN GIẢM GIÁ")
            return vHeader
        case 2:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("HÌNH THỨC GIAO HÀNG")
            return vHeader
        case 3:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("HÌNH ẢNH CẬP NHẬT")
            return vHeader
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoStudentFPTCell.identifier, for: indexPath) as! DetailInfoStudentFPTCell
            cell.selectionStyle = .none
            cell.getDataDetailInfoStudent(detailInfoStudentHistoryBySBD?.hoTen ?? "", detailInfoStudentHistoryBySBD?.cMND ?? "", detailInfoStudentHistoryBySBD?.sDT ?? "")
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DiscountSudentFPTInfoCell.identifier, for: indexPath) as! DiscountSudentFPTInfoCell
            cell.selectionStyle = .none
            cell.getValueData(detailInfoStudentHistoryBySBD?.phanTramGiamGia ?? "", valueStatus: detailInfoStudentHistoryBySBD?.tinhTrangVoucher ?? "")
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RadioButtonBTSCell", for: indexPath) as! RadioButtonBTSCell
            cell.bindShiptye(isShop: detailInfoStudentHistoryBySBD?.ShipType == 2)
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListImageStudentInfoFPTCell.identifier, for: indexPath) as! ListImageStudentInfoFPTCell
            cell.selectionStyle = .none
            cell.getImageIdentityFront(detailInfoStudentHistoryBySBD?.urlCMNDMT ?? "")
            cell.getImageIdentityBackSide(detailInfoStudentHistoryBySBD?.urlCMNDMS ?? "")
            cell.getImageEntranceExamination(detailInfoStudentHistoryBySBD?.urlGiayBaoThi ?? "")
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    
    
}

extension DetailInfoStudentFPTScreen: UITableViewDelegate {
    
}
