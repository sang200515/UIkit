//
//  DetailStudentInfoCreateScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ListDetailStudentInfoCreate: Int, CaseCountable {
    case infoStudent
    case infoDiscount
    case infoExamPoint
}


class DetailStudentInfoCreateScreen: BaseController {
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var cellHeightPointExam: CGFloat = 0
    
    private var infoDetailStudentFPT: StudentBTSInfo?
    private var iD_BackToSchool: Int?
    
    let btnUpload: UIButton = {
        let button = UIButton()
        button.setTitle("UPLOAD HÌNH ẢNH", for: .normal)
        button.setTitleColor(Constants.COLORS.main_color_white, for: .normal)
        button.backgroundColor = Constants.COLORS.bold_green
        button.makeCorner(corner: 8)
        return button
    }()
    
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
        
        self.view.addSubview(btnUpload)
        btnUpload.myCustomAnchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 16, bottomConstant: 30, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
        
        btnUpload.addTarget(self, action: #selector(gotoUploadImageScreen(_:)), for: .touchUpInside)
        
        tableView.register(DiscountSudentFPTInfoCell.self, forCellReuseIdentifier: DiscountSudentFPTInfoCell.identifier)
        tableView.register(DetailInfoStudentCell.self, forCellReuseIdentifier: DetailInfoStudentCell.identifier)
        tableView.register(DetailInfoPointForCreateStudentCell.self, forCellReuseIdentifier: DetailInfoPointForCreateStudentCell.identifier)
        self.view.addSubview(tableView)
        tableView.myCustomAnchor(top: self.view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: btnUpload.topAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 4, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadDataStudent()
    }
    
    @objc private func gotoUploadImageScreen(_ sender: UIButton) {
        let uploadImageScreen = UploadStudentImageViewController()
        uploadImageScreen.studentInfoItem = infoDetailStudentFPT
        self.navigationController?.pushViewController(uploadImageScreen, animated: true)
    }
    
    private func reloadDataStudent() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.BackToSchool_LoadThongTinKHBySBD(SoBaoDanh: self.iD_BackToSchool ?? 0 , handler: {[weak self] (success, errorMsg, result, err) in
                guard let strongSelf = self else {return}
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if success == "1" {
                        if result != nil {
                            if result?.Result == 1 {
                                strongSelf.infoDetailStudentFPT = result
                                strongSelf.tableView.reloadData()
                            } else {
                                strongSelf.showPopUp(errorMsg, "Thông báo", buttonTitle: "Đồng ý")
                            }
                            
                        } else {
                            debugPrint("Không lấy được data")
                        }
                    } else {
                        strongSelf.showPopUp(errorMsg, "Thông báo", buttonTitle: "Đồng ý")
                    }
                }
            })
        }
    }
    
    func getIdBackToSchool(_ id: Int) {
        self.iD_BackToSchool = id
    }
    
    @objc func actionBack() {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeBackToSchoolScreen.self) {
                _ = self.navigationController?.popToViewController(controller, animated: true)
            }
        }
    }

}

extension DetailStudentInfoCreateScreen: UITableViewDataSource {
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
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return cellHeightPointExam
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
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoStudentCell.identifier, for: indexPath) as? DetailInfoStudentCell else {return UITableViewCell()}
            cell.getDataInfoStudent(infoDetailStudentFPT?.HoTen ?? "", identity: infoDetailStudentFPT?.CMND ?? "", phoneNumber: infoDetailStudentFPT?.SDT ?? "", birthDay: infoDetailStudentFPT?.NgaySinh ?? "")
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscountSudentFPTInfoCell.identifier, for: indexPath) as? DiscountSudentFPTInfoCell else {return UITableViewCell()}
            cell.getValueData(infoDetailStudentFPT?.PhanTramGiamGia ?? "", valueStatus: infoDetailStudentFPT?.TinhTrangVoucher ?? "")
            cell.selectionStyle = .none
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailInfoPointForCreateStudentCell.identifier, for: indexPath) as? DetailInfoPointForCreateStudentCell else {return UITableViewCell()}
            if let item = infoDetailStudentFPT {
                cell.setupViews(item)
            }
            cellHeightPointExam = cell.cellHeight
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
extension DetailStudentInfoCreateScreen: UITableViewDelegate {
    
}
