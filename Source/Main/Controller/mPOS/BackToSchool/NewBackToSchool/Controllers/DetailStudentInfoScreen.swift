//
//  DetailStudentInfoScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ListDetailStudentInfo: Int, CaseCountable {
    case infoStudent
    case infoDiscount
    case infoExamPoint
    case shipType
    case imageUpdate
}

class DetailStudentInfoScreen: BaseController {
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var cellHeightPointExam: CGFloat = 0
    
    private var infoDetailStudentFPT: StudentBTSInfo?
    private var detailInfoStudentHistoryBySBD: DetailInfoStudentFPTItem.Data?
    private var iD_BackToSchool: Int?
    
    override func setupViews() {
        super.setupViews()
        self.title = "CHI TIẾT SINH VIÊN"
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
        tableView.register(DiscountSudentFPTInfoCell.self, forCellReuseIdentifier: DiscountSudentFPTInfoCell.identifier)
        tableView.register(ListImageStudentInfoFPTCell.self, forCellReuseIdentifier: ListImageStudentInfoFPTCell.identifier)
        tableView.register(DetailInfoStudentCell.self, forCellReuseIdentifier: DetailInfoStudentCell.identifier)
        tableView.register(DetailInfoPointEachSubjectCell.self, forCellReuseIdentifier: DetailInfoPointEachSubjectCell.identifier)
        tableView.register(UINib(nibName: "RadioButtonBTSCell", bundle: nil), forCellReuseIdentifier: "RadioButtonBTSCell")
        self.view.addSubview(tableView)
        tableView.fill()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataStudent()
    }
    
//    private func reloadDataStudent() {
//        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
//            MPOSAPIManager.BackToSchool_LoadThongTinKHBySBD(SoBaoDanh: self.iD_BackToSchool ?? 0 , handler: {[weak self] (success, errorMsg, result, err) in
//                guard let strongSelf = self else {return}
//                WaitingNetworkResponseAlert.DismissWaitingAlert {
//                    if success == "1" {
//                        if result != nil {
//                            if result?.Result == 1 {
//                                strongSelf.infoDetailStudentFPT = result
//                                strongSelf.tableView.reloadData()
//                            } else {
//                                strongSelf.showPopUp(errorMsg, "Thông báo", buttonTitle: "Đồng ý")
//                            }
//
//                        } else {
//                            debugPrint("Không lấy được data")
//                        }
//                    } else {
//                        strongSelf.showPopUp(errorMsg, "Thông báo", buttonTitle: "Đồng ý")
//                    }
//                }
//            })
//        }
//    }
    
    private func reloadDataStudent() {
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
    
    func getIdBackToSchool(_ id: Int) {
        self.iD_BackToSchool = id
    }
    
    @objc func actionBack() {
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: HomeBackToSchoolScreen.self) {
//                _ = self.navigationController?.popToViewController(controller, animated: true)
//            }
//        }
        self.navigationController?.popViewController(animated: true)
    }

}

extension DetailStudentInfoScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListDetailStudentInfo.caseCount
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
        case 4:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return cellHeightPointExam
        case 3:
            return 50
        default:
            return UITableView.automaticDimension
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
            vHeader.setupTitleView("THÔNG TIN ĐIỂM THI")
            return vHeader
        case 3:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("HÌNH THỨC GIAO HÀNG")
            return vHeader
        case 4:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("THÔNG TIN HÌNH ẢNH")
            return vHeader
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoStudentCell.identifier, for: indexPath) as? DetailInfoStudentCell else {return UITableViewCell()}
            cell.getDataInfoStudent(detailInfoStudentHistoryBySBD?.hoTen ?? "", identity: detailInfoStudentHistoryBySBD?.cMND ?? "", phoneNumber: detailInfoStudentHistoryBySBD?.sDT ?? "", birthDay: detailInfoStudentHistoryBySBD?.ngaySinh ?? "")
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscountSudentFPTInfoCell.identifier, for: indexPath) as? DiscountSudentFPTInfoCell else {return UITableViewCell()}
            cell.getValueData(detailInfoStudentHistoryBySBD?.phanTramGiamGia ?? "", valueStatus: detailInfoStudentHistoryBySBD?.tinhTrangVoucher ?? "")
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoPointEachSubjectCell.identifier, for: indexPath) as? DetailInfoPointEachSubjectCell else {return UITableViewCell()}
            if let item = detailInfoStudentHistoryBySBD {
                cell.setupViews(item)
            }
            cellHeightPointExam = cell.cellHeight
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "RadioButtonBTSCell", for: indexPath) as! RadioButtonBTSCell
            cell.bindShiptye(isShop: detailInfoStudentHistoryBySBD?.ShipType == 2)
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListImageStudentInfoFPTCell.identifier, for: indexPath) as? ListImageStudentInfoFPTCell else {return UITableViewCell()}
            cell.getImageIdentityFront(detailInfoStudentHistoryBySBD?.urlCMNDMT ?? "")
            cell.getImageIdentityBackSide(detailInfoStudentHistoryBySBD?.urlCMNDMS ?? "")
            cell.getImageEntranceExamination(detailInfoStudentHistoryBySBD?.urlGiayBaoThi ?? "")
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
extension DetailStudentInfoScreen: UITableViewDelegate {
    
}
