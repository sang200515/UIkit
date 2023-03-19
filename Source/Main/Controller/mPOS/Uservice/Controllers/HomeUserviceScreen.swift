//
//  HomeUserviceScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 9/12/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class HomeUserviceScreen: BaseController {
    
    private var arrSection = [Section]()
    private var iTItems = [ItemApp]()
    private var switchBoardItems = [ItemApp]()
    let searchViolation = UISearchBar()
    private var isSearched: Bool = false
    private var itemAfterSearched = [Section]()
    private var searchText: String = ""
    let contentITService = "DỊCH VỤ IT"
    let contentSupport = "TỔNG ĐÀI HỖ TRỢ 87333"
    
    let minimumLineSpacing: CGFloat = 0
    let minimumInternSpacing: CGFloat = 0
    let heightItem: CGFloat = 100
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func setupViews() {
        super.setupViews()
        initSectionUservice()
        
        self.title = "USERVICE"
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        self.view.addSubview(collectionView)
        collectionView.myCustomAnchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UserviceCollectionViewCell.self, forCellWithReuseIdentifier: UserviceCollectionViewCell.identifier)
        collectionView.register(HeaderSectionUserviceView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderSectionUserviceView.identifier)
        
        setupRightBarButton()
        
    }
    
    private func initSectionUservice() {
        // IT Section
        let iTItem = ItemApp(id: "156", name: "Add IP 3G", type: "73", icon: UIImage.init(named: "ic_add_ip_3g")!)
        let errorNetwork = ItemApp(id: "158", name: "Xử lý sự cố mạng", type: "80", icon: UIImage.init(named: "ic_error_network")!)
        iTItems.append(iTItem)
        iTItems.append(errorNetwork)
        let iTSection = Section(name: "DỊCH VỤ IT", arrayItems: iTItems)
        self.arrSection.append(iTSection)
        
        //Switchboard Section
        let switchBoardSupport = ItemApp(id: "157", name: "Hỗ trợ người dùng 87333", type: "75", icon: UIImage.init(named: "ic_support_uservice")!)
        switchBoardItems.append(switchBoardSupport)
        let switchBoardSection = Section(name: "TỔNG ĐÀI HỖ TRỢ 87333", arrayItems: switchBoardItems)
        self.arrSection.append(switchBoardSection)
    }
    
    private func setupRightBarButton() {
        let searchBarBtn = UIBarButtonItem(image: UIImage.init(named: "Search"), style: .plain, target: self, action: #selector(showSearchBar))
        let historyUserviceBtn = UIBarButtonItem(image: UIImage.init(named: "ic_history_uservice"), style: .plain, target: self, action: #selector(gotoHistoryScreen))
        
        self.navigationItem.rightBarButtonItems = [historyUserviceBtn, searchBarBtn]
    }
    
    private func filterContentForSearchText(searchText: String) {
        itemAfterSearched = arrSection.filter { item in
            return item.sectionName.lowercased().contains(searchText.lowercased())
        }
    }
    
    @objc private func gotoHistoryScreen() {
        let vc = HistoryUserviceScreen()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func pushToScreen(_ type: String, id: String) {
        var check: Bool = false
        for item in Cache.ruleMenus {
            if item.p_messagess == type {
                check = true
                break
            }
        }
        if check {
            if id == "156" {
                let vc = CreateAddIPScreen()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if id == "157" {
                let vc = CreateSupportUservice()
                self.navigationController?.pushViewController(vc, animated: true)
            } else if id == "158" {
                let vc = CreateErrNetworkScreen()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let popup = PopupDialog(title: "Thông báo", message: "Bạn không được cấp quyền sử dụng chức năng này. Vui lòng kiểm tra lại.", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let buttonOne = CancelButton(title: "OK") {
                
            }
            popup.addButtons([buttonOne])
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func showSearchBar() {
        let textfieldInsideSearchBar = searchViolation.value(forKey: "searchField") as? UITextField
        textfieldInsideSearchBar?.textColor = .black
        searchViolation.showsCancelButton = true
        searchViolation.tintColor = Constants.COLORS.light_green
        searchViolation.placeholder = "Vui lòng nhập thông tin cần tìm"
        searchViolation.delegate = self
        searchViolation.isHidden = false
        searchViolation.alpha = 0
        navigationItem.titleView = searchViolation
        self.navigationItem.rightBarButtonItems?.removeAll()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.searchViolation.alpha = 1
        }, completion: { finished in
            self.searchViolation.becomeFirstResponder()
        })
    }
    
    private func hideSearchBar() {
        searchViolation.alpha = 0
        self.navigationItem.titleView = nil
        self.navigationItem.title = "Phạt"
        let searchBarBtn = UIBarButtonItem(image: UIImage.init(named: "Search"), style: .plain, target: self, action: #selector(showSearchBar))
        let historyUserviceBtn = UIBarButtonItem(image: UIImage.init(named: "ic_history_uservice"), style: .plain, target: self, action: #selector(gotoHistoryScreen))
        self.navigationItem.rightBarButtonItems = [historyUserviceBtn, searchBarBtn]
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension HomeUserviceScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearched = true
//        let itemFiltered = arrSection.filter{$0.sectionName.range(of: searchText, options: .caseInsensitive) != nil}
        filterContentForSearchText(searchText: searchText)
        self.searchText = searchText
//        itemAfterSearched = itemFiltered
        collectionView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        hideSearchBar()
        collectionView.reloadData()
    }
}

extension HomeUserviceScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isSearched {
            switch itemAfterSearched[indexPath.section].sectionName {
            case contentITService:
                let iTItem = iTItems[indexPath.row]
                self.pushToScreen(iTItem.type, id: iTItem.id)
            case contentSupport:
                let switchBoardItem = switchBoardItems[indexPath.row]
                self.pushToScreen(switchBoardItem.type, id: switchBoardItem.id)
            default:
                break
            }
        } else {
            switch arrSection[indexPath.section].sectionName {
            case contentITService:
                let iTItem = iTItems[indexPath.row]
                self.pushToScreen(iTItem.type, id: iTItem.id)
            case contentSupport:
                let switchBoardItem = switchBoardItems[indexPath.row]
                self.pushToScreen(switchBoardItem.type, id: switchBoardItem.id)
            default:
                break
            }
        }
    }
}

extension HomeUserviceScreen: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if isSearched {
            return itemAfterSearched.count
        } else {
            return arrSection.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearched {
            switch section {
            case 0:
                if contentITService.contains(searchText){
                    return iTItems.count
                } else if contentSupport.contains(searchText) {
                    return switchBoardItems.count
                } else {
                    return 0
                }
            case 1:
                if contentSupport.contains(searchText){
                    return switchBoardItems.count
                } else if contentITService.contains(searchText){
                    return iTItems.count
                } else {
                    return 0
                }
            default:
                return 0
            }
        } else {
            switch section {
            case 0:
                return iTItems.count
            case 1:
                return switchBoardItems.count
            default:
                return 0
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserviceCollectionViewCell.identifier, for: indexPath) as! UserviceCollectionViewCell
        if isSearched {
            switch itemAfterSearched[indexPath.section].sectionName {
            case contentITService:
                let iTItem = iTItems[indexPath.item]
                cell.setupListFeatureCollectionViewCell(image: iTItem.icon, content: iTItem.name)
            case contentSupport:
                let switchboardItem = switchBoardItems[indexPath.item]
                cell.setupListFeatureCollectionViewCell(image: switchboardItem.icon, content: switchboardItem.name)
            default:
                break
            }
        } else {
            switch arrSection[indexPath.section].sectionName {
            case contentITService:
                let iTItem = iTItems[indexPath.row]
                cell.setupListFeatureCollectionViewCell(image: iTItem.icon, content: iTItem.name)
            case contentSupport:
                let switchboardItem = switchBoardItems[indexPath.row]
                cell.setupListFeatureCollectionViewCell(image: switchboardItem.icon, content: switchboardItem.name)
            default:
                break
            }
        }
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if isSearched {
            if kind == UICollectionView.elementKindSectionHeader {
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSectionUserviceView.identifier, for: indexPath) as! HeaderSectionUserviceView
                sectionHeader.setupTitle(itemAfterSearched[indexPath.section].sectionName)
                return sectionHeader
            } else {
                return UICollectionReusableView()
            }
        } else {
            if kind == UICollectionView.elementKindSectionHeader {
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderSectionUserviceView.identifier, for: indexPath) as! HeaderSectionUserviceView
                sectionHeader.setupTitle(arrSection[indexPath.section].sectionName)
                return sectionHeader
            } else {
                return UICollectionReusableView()
            }
        }
        
    }
}

extension HomeUserviceScreen: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = (bounds.width - minimumInternSpacing) / 3
        
        return CGSize(width: width, height: heightItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minimumInternSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
}
