//
//  CreateStudentFPTInfoScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/20/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ListInfoCreateStudentFPT: Int, CaseCountable {
    case studentInfo
}

class CreateSudentFPTInfoScreen: BaseController {
    
    private var firstAndLastName: String?
    private var identity: String?
    private var phoneNumber: String?
    private var selectedType: Int?
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    let btnUpload: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(Constants.COLORS.main_color_white, for: .normal)
        button.backgroundColor = Constants.COLORS.bold_green
        button.layer.cornerRadius = 8.0
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        //        self.title = "SINH VIÊN FPT"
        self.title = "CHƯƠNG TRÌNH DÀNH CHO HS/SV"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CreateStudentInfoFPTCell.self, forCellReuseIdentifier: CreateStudentInfoFPTCell.identifier)
        tableView.register(DiscountSudentFPTInfoCell.self, forCellReuseIdentifier: DiscountSudentFPTInfoCell.identifier)
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
        tableView.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        
        view.addSubview(btnUpload)
        view.bringSubviewToFront(btnUpload)
        btnUpload.myCustomAnchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 16, trailingConstant: 16, bottomConstant: 40, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 50)
        btnUpload.addTarget(self, action: #selector(uploadAction(_:)), for: .touchUpInside)
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func uploadAction(_ button: UIButton) {
        let vc = UploadImageStudenFPTInfoPreventive()
        
        guard let user = UserDefaults.standard.getUsernameEmployee() else {return}
        //        if selectedType == 1 || selectedType == 2 {
        //
        //        } else {
        //            self.showPopUp("Vui lòng chọn sinh viên FPT hoặc sinh viên xét tuyển", "Thông báo", buttonTitle: "Đồng ý")
        //        }
        selectedType = 2
        MPOSAPIManager.backToSchool_InsertDataStudentFPT(name: self.firstAndLastName ?? "", identity: self.identity ?? "", phoneNumber: self.phoneNumber ?? "", user: user, type:  selectedType ?? 0) {[weak self] (success, mErr, result, err) in
            guard let strongSelf = self else {return}
            if let success = success {
                if success == true {
                    if let data = result {
                        if data.result == 1 {
                            vc.getIdBackToSchool(result?.idBackToSchool ?? 0)
                            vc.getNumberIdentity(strongSelf.identity ?? "")
                            strongSelf.navigationController?.pushViewController(vc, animated: true)
                        } else {
                            strongSelf.showAlertOneButton(title: "Thông báo", with: data.msg ?? "", titleButton: "Đồng ý") {
                            }
                        }
                    }
                    
                } else {
                    strongSelf.showAlertOneButton(title: "Thông báo", with: mErr ?? "", titleButton: "Đồng ý") {
                    }
                }
            }
        }
        
    }
}

extension CreateSudentFPTInfoScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListInfoCreateStudentFPT.caseCount
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let vHeader = HeaderSectionStudentFPTView()
            vHeader.setupTitleView("THÔNG TIN THÍ SINH")
            return vHeader
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CreateStudentInfoFPTCell.identifier, for: indexPath) as! CreateStudentInfoFPTCell
            cell.selectionStyle = .none
            cell.createStudentInfoFPTCellDelegate = self
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension CreateSudentFPTInfoScreen: UITableViewDelegate {
    
}

extension CreateSudentFPTInfoScreen: CreateStudentInfoFPTCellDelegate {
    func getTypeStudent(_ type: Int) {
        self.selectedType = type
    }
    
    func getFirstAndLastname(_ name: String) {
        firstAndLastName = name
    }
    
    func getIdentity(_ identity: String) {
        self.identity = identity
        
    }
    
    func getPhoneNumber(_ phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}
