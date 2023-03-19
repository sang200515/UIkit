//
//  HomeBackToSchoolScreen.swift
//  fptshop
//
//  Created by KhanhNguyen on 8/19/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class HomeBackToSchoolScreen: BaseController {
    
    let listFeatureBackToSchoolView: ListFeatureBackToSchoolView = {
        let view = ListFeatureBackToSchoolView()
        return view
    }()
    
    var showFull = false
    var phone = ""
    var isFromSearch = true
    var tracocItem: CustomerTraCoc?
    var isFromModule:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setupViews() {
        super.setupViews()
        listFeatureBackToSchoolView.showFull = showFull
        listFeatureBackToSchoolView.isFromSearch = isFromSearch
        self.title = "Back To School"
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
        
        view.addSubview(listFeatureBackToSchoolView)
        listFeatureBackToSchoolView.myCustomAnchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, trailing: self.view.trailingAnchor, bottom: self.view.bottomAnchor, centerX: nil, centerY: nil, width: nil, height: nil, topConstant: 0, leadingConstant: 0, trailingConstant: 0, bottomConstant: 0, centerXConstant: 0, centerYConstant: 0, widthConstant: 0, heightConstant: 0)
        listFeatureBackToSchoolView.listFeatureBackToSchoolViewDelegate = self
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate func gotoScreenInListFeature(_ type: ListFeatureBackToSchool) {
        switch type {
        case .students:
            // tan sv
            let newViewController = CheckSBDViewController()
            newViewController.tracocItem = self.tracocItem
            newViewController.phone = phone
            newViewController.isFromSearch = isFromSearch
           newViewController.isFromModule = isFromModule
            self.navigationController?.pushViewController(newViewController, animated: true)
        case .studentsFPT:
            let newViewController = BackToSchoolNewVC()
            newViewController.isNewStudent = false
            newViewController.tracocItem = self.tracocItem
            newViewController.isFromSearch = isFromSearch
            newViewController.phone = phone
            newViewController.isFromModule = isFromModule
            self.navigationController?.pushViewController(newViewController, animated: true)
        case .directOffer:
            let newViewController = BackToSchoolDirectVC()
            newViewController.isNewStudent = false
            newViewController.tracocItem = self.tracocItem
            newViewController.isFromSearch = isFromSearch
            newViewController.phone = phone
                newViewController.isFromModule = isFromModule
            self.navigationController?.pushViewController(newViewController, animated: true)
        case .searchStudents:
            let newVC = SearchInfoStudentScreen()
            self.navigationController?.pushViewController(newVC, animated: true)
		case .polytechnic:
			let newViewController = BackToSchoolDirectVC()
				newViewController.isNewStudent = false
				newViewController.isPolytecnic = true
				newViewController.tracocItem = self.tracocItem
				newViewController.isFromSearch = isFromSearch
				newViewController.phone = phone
				newViewController.isFromModule = isFromModule
				self.navigationController?.pushViewController(newViewController, animated: true)

        }
    }
    
}

extension HomeBackToSchoolScreen : ListFeatureBackToSchoolDelegate {
    func gotoScreen(_ listFeatureScreen: ListFeatureBackToSchoolView, type: ListFeatureBackToSchool) {
        gotoScreenInListFeature(type)
    }
    
    
}
