//
//  TestListDetailViolationScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/31/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

enum ListDetailViolation: Int, CaseCountable {
    case infoCell
    case contentTest
    case contentViolation
    case response
}
class TestListDetailViolationScreen: BaseController {
    
    private var numberViolation: Int?
    private var listConversation = [Conversations]()
    private var infoDetailViolation: InfoViolationItem?
    private var isExpandHeaderContentTestViolation: Bool = false
    private var isExpandHeaderContentViolation: Bool = false
    private var isExpandHeaderContentResponseViolation: Bool = false
    private var valuesRating: [Int] = [1, 2]
    private var isSelected: Bool = false
    private var selectedIndex: Int = 0
    private var cellHeightHeaderContentTestViolation: CGFloat = 0.0
    private var type: Int?
    private var content: String?
    private var employCode: String?
    
    let tableView: SelfSizedTableView = {
        let tableView = SelfSizedTableView()
        return tableView
    }()
    
    let vContainerSendContent: ContainerContentSendView = {
        let view = ContainerContentSendView()
        view.backgroundColor = .white
        return view
    }()
    
    let vInputTextViewResponseAgreeNill: InputTextViewResponseAgreeNill = {
        let view = InputTextViewResponseAgreeNill()
        view.backgroundColor = .white
        return view
    }()
    
    let vMainContainerSendContent: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var listDetailViolation = ListDetailViolation(rawValue: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ListConversationCell.self, forCellReuseIdentifier: ListConversationCell.identifier)
        tableView.register(InfoDetailViolationCell.self, forCellReuseIdentifier: InfoDetailViolationCell.identifier)
        tableView.register(TestContentViolationCell.self, forCellReuseIdentifier: TestContentViolationCell.identifier)
        tableView.register(ContentViolationCell.self, forCellReuseIdentifier: ContentViolationCell.identifier)
    }
    
    override func setupViews() {
        super.setupViews()
        employCode = UserDefaults.standard.getUsernameEmployee()
        vInputTextViewResponseAgreeNill.delegate = self
        vContainerSendContent.delegate = self
        self.view.addSubview(vMainContainerSendContent)
        self.view.bringSubviewToFront(vMainContainerSendContent)
        vMainContainerSendContent.myCustomAnchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 100)
        
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.myCustomAnchor(top: self.view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: vMainContainerSendContent.topAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 2, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func getData() {
        super.getData()
        getDataViolationDetail()
    }
    
    func getNumberViolation(_ number: Int?) {
        self.title = "Phiếu phạt: \(number ?? 0)"
        self.numberViolation = number
    }
    
    fileprivate func getDataViolationDetail() {
        if let userInside = UserDefaults.standard.getUsernameEmployee(), let number = numberViolation {
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                MyInfoAPIManager.shared.getDetailViolationItem(userInside, requestId: number) {[weak self] (result, err) in
                    guard let strongSelf = self else {return}
                    if let itemInfoViolation = result?.info, let conversations = result?.conversations {
                        strongSelf.listConversation = conversations
                        strongSelf.infoDetailViolation = itemInfoViolation
                        strongSelf.tableView.reloadData()
                        if itemInfoViolation.phanHoiDongY == 0 && itemInfoViolation.phanHoiTuChoi == "0" {
                            strongSelf.addInputTextView(false)
                        } else if itemInfoViolation.phanHoiDongY == 1 && itemInfoViolation.phanHoiTuChoi == "0" {
                            strongSelf.addInputTextView(true)
                        } else if itemInfoViolation.phanHoiDongY == 0 && itemInfoViolation.phanHoiTuChoi == "1" {
                            strongSelf.addInputTextView(true)
                        }
                        strongSelf.stopLoading()
                    } else {
                        strongSelf.showPopUp(err ?? "", "Thông báo chi tiết phiếu phạt", buttonTitle: "Ok") {
                            strongSelf.navigationController?.popViewController(animated: true)
                        }
                        strongSelf.stopLoading()
                    }
                }
            }
        }
    }
    
    func addInputTextView(_ bool: Bool) {
        if !bool {
            vMainContainerSendContent.addSubview(vContainerSendContent)
            vInputTextViewResponseAgreeNill.isHidden = true
            vContainerSendContent.isHidden = false
            vContainerSendContent.fill()
        } else {
            vMainContainerSendContent.addSubview(vInputTextViewResponseAgreeNill)
            vInputTextViewResponseAgreeNill.isHidden = false
            vContainerSendContent.isHidden = true
            vInputTextViewResponseAgreeNill.fill(left: 10, top: 8, right: -10, bottom: -10)
            
        }
    }
    
}

extension TestListDetailViolationScreen: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ListDetailViolation.caseCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        if section == 1 {
            return 1
        }
        if section == 2 {
            return 1
        }
        if section == 3 {
            return listConversation.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemInfoViolation = infoDetailViolation
        switch section {
        case 0:
            return UIView()
        case 1:
            let vHeader = HeaderContentTestViolationView()
            vHeader.customInit(title: "Nội dung kiểm tra: ", section: 1, delegate: self)
            vHeader.isRotate = isExpandHeaderContentTestViolation
            vHeader.rotateImage()
            return vHeader
        case 2:
            let vHeader = ContentViolationHeader()
            vHeader.customInit(title: "Nội dung vi phạm: ", section: 2, delegate: self)
            vHeader.isRotate = isExpandHeaderContentViolation
            vHeader.rotateImage()
            if let contentTutorial = infoDetailViolation?.huongDan {
                if contentTutorial == "" {
                    vHeader.enableShowTutorial(false)
                } else {
                    vHeader.enableShowTutorial(true)
                }
            }
            return vHeader
        case 3:
            let vHeader = ContentHeaderResponseViolation()
            vHeader.customInit(title: "PHẢN HỒI", section: 3, delegate: self)
            vHeader.isRotate = isExpandHeaderContentResponseViolation
            vHeader.rotateImage()
            if itemInfoViolation?.phanHoiDongY == 0, itemInfoViolation?.phanHoiTuChoi == "0" {
                vHeader.showHideChooseStatus(false)
                vHeader.showHideViewContaintStatusAfterChosen(true)
            } else if itemInfoViolation?.phanHoiDongY == 1, itemInfoViolation?.phanHoiTuChoi == "0" {
                vHeader.showHideChooseStatus(true)
                vHeader.showHideViewContaintStatusAfterChosen(false)
                vHeader.setupStatusAfterChosen(true)
            } else if itemInfoViolation?.phanHoiDongY == 0, itemInfoViolation?.phanHoiTuChoi == "1" {
                vHeader.showHideChooseStatus(true)
                vHeader.showHideViewContaintStatusAfterChosen(false)
                vHeader.setupStatusAfterChosen(false)
            }
            return vHeader
        default:
            return UIView()
        }        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            if isExpandHeaderContentTestViolation {
                return 50
            } else {
                return 0
            }
        case 2:
            if isExpandHeaderContentViolation {
                return 50
            } else {
                return 0.00001
            }
        case 3:
            if isExpandHeaderContentResponseViolation {
                return UITableView.automaticDimension
                
            } else {
                return 0.000001
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InfoDetailViolationCell.identifier, for: indexPath) as! InfoDetailViolationCell
            if let item = infoDetailViolation {
                cell.getDataViolationDetail(item)
                cell.selectionStyle = .none
                
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TestContentViolationCell.identifier, for: indexPath) as! TestContentViolationCell
            if let content = infoDetailViolation?.noiDungKiemTra {
                cell.getDataContentTest(content)
                cell.selectionStyle = .none                
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: ContentViolationCell.identifier, for: indexPath) as! ContentViolationCell
            if let content = infoDetailViolation?.noiDungViPham {
                cell.getDataContentViolation(content)
                cell.selectionStyle = .none
                
            }
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: ListConversationCell.identifier, for: indexPath) as! ListConversationCell
            let itemConversation = listConversation[indexPath.row]
            cell.getDataConversation(itemConversation)
            cell.selectionStyle = .none
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
}

extension TestListDetailViolationScreen: UITableViewDelegate {
    
}

extension TestListDetailViolationScreen: HeaderContentTestViolationViewDelegate {
    func toggleSection(header: HeaderContentTestViolationView, section: Int) {
        let expanded = isExpandHeaderContentTestViolation
        isExpandHeaderContentTestViolation = !expanded
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
        tableView.endUpdates()
    }
}

extension TestListDetailViolationScreen: ContentViolationHeaderDelegate {
    func toggleShowTutorial() {
        if let tutorialContent = infoDetailViolation?.huongDan {
            self.showAlertOneButton(title: "Hướng dẫn thực hiện đúng", with: tutorialContent, titleButton: "Đóng")
        }
    }
    
    func toggleSection(header: ContentViolationHeader, section: Int) {
        let expanded = isExpandHeaderContentViolation
        isExpandHeaderContentViolation = !expanded
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
        tableView.endUpdates()
    }
}

extension TestListDetailViolationScreen: ContentHeaderResponseViolationDelegate {
    func selectedType(_ type: Int) {
        self.type = type
    }
    
    func toggleSection(header: ContentHeaderResponseViolation, section: Int) {
        let expanded = isExpandHeaderContentResponseViolation
        isExpandHeaderContentResponseViolation = !expanded
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
        tableView.endUpdates()
    }
}

extension TestListDetailViolationScreen: InputTextViewResponseAgreeNillDelegate {
    func sendToggleAction() {
        var params: [String : Any] = [:]
        params["requestID"] = numberViolation
        params["type"] = type
        params["message"] = content
        params["employcode"] = employCode
        
        self.showLoading()
        MyInfoAPIManager.shared.postResponseViolationSubmit(employCode ?? "", params) {[weak self] (response, err) in
            guard let strongSelf = self else {return}
            if let itemResponse = response {
                strongSelf.stopLoading()
                strongSelf.showPopUp(itemResponse.msg, "Thông báo", buttonTitle: "Đồng ý") {
                    strongSelf.getDataViolationDetail()
                }
            } else {
                strongSelf.showPopUp(err ?? "", "Thông báo", buttonTitle: "Đồng ý") {
                    
                }
                strongSelf.stopLoading()
            }
        }
    }
    
    func outputContent(_ content: String) {
        self.content = content
    }
    
}

extension TestListDetailViolationScreen: ContainerContentSendViewDelegate {
    func sendAction() {
        var params: [String : Any] = [:]
        params["requestID"] = numberViolation
        params["type"] = type
        params["message"] = content
        params["employcode"] = employCode
        
        self.showLoading()
        MyInfoAPIManager.shared.postResponseViolationSubmit(employCode ?? "", params) {[weak self] (response, err) in
            guard let strongSelf = self else {return}
            if let itemResponse = response {
                strongSelf.stopLoading()
                strongSelf.showPopUp(itemResponse.msg, "Thông báo", buttonTitle: "Đồng ý") {
                    strongSelf.getDataViolationDetail()
                }
            } else {
                strongSelf.showPopUp(err ?? "", "Thông báo", buttonTitle: "Đồng ý") {
                    
                }
                strongSelf.stopLoading()
            }
        }
    }
    
    func outputContentResponse(_ content: String) {
        self.content = content
    }
}
