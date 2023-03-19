//
//  SearchTripBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 17/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SearchTripBaoKimViewController: UIViewController {

    @IBOutlet weak var tfStart: UITextField!
    @IBOutlet weak var tfEnd: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    private var startLocation: BaoKimLocation = BaoKimLocation(JSON: [:])!
    private var endLocation: BaoKimLocation = BaoKimLocation(JSON: [:])!
    private var selectedDate: Date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        title = "Tìm chuyến xe"
        addBackButton()
        
        btnSearch.roundCorners(.allCorners, radius: 5)
        tfStart.withImage(direction: .left, image: UIImage(named: "ic_location")!)
        tfEnd.withImage(direction: .left, image: UIImage(named: "ic_location")!)
        tfDate.withImage(direction: .left, image: UIImage(named: "calendar_ic")!)
    }
    
    private func validateInputs() -> Bool {
        guard let start = tfStart.text, !start.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn điểm đi", titleButton: "OK")
            return false
        }
        
        guard let end = tfEnd.text, !end.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn điểm đến", titleButton: "OK")
            return false
        }
        
        guard let date = tfDate.text, !date.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn ngày khởi hành", titleButton: "OK")
            return false
        }
        
        return true
    }
    
    private func loadData() {
        Provider.shared.baokimAPIService.getCitiesAndDistricts(success: { result in
            guard let data = result else { return }
            BaoKimDataManager.shared.cities = data.data
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func prepareParam() {
        let param = BaoKimSearchTripParam(JSON: [:])!
        param.from = Int(startLocation.id) ?? 0
        param.to = Int(endLocation.id) ?? 0
        param.date = selectedDate.stringWith(format: "yyyy-MM-dd")
        
        BaoKimDataManager.shared.searchTripParam = param
    }
    
    private func loadTripData() {
        ProgressView.shared.show()
        let dispatchGroup = DispatchGroup()
        let vc = SelectTripBaoKimViewController()
        
        dispatchGroup.enter()
        Provider.shared.baokimAPIService.getTrips(param: BaoKimDataManager.shared.searchTripParam, success: { [weak self] result in
            guard let self = self, let data = result else { return }
            vc.trip = data
            vc.selectedDate = self.selectedDate
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.enter()
        Provider.shared.baokimAPIService.getFilters(from: Int(startLocation.id) ?? 0, to: Int(endLocation.id) ?? 0, date: selectedDate.stringWith(format: "yyyy-MM-dd"), success: { result in
            guard let data = result else { return }
            vc.filter = data
            BaoKimDataManager.shared.companies = data.data.companies.data
            dispatchGroup.leave()
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            dispatchGroup.leave()
        })
        
        dispatchGroup.notify(queue: .main) {
            ProgressView.shared.hide()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        guard validateInputs() else { return }
        prepareParam()
        
//        ProgressView.shared.show()
//        let dispatchGroup = DispatchGroup()
        
//        dispatchGroup.enter()
//        Provider.shared.baokimAPIService.getDistricts(cityId: startLocation.id, success: { result in
//            guard let data = result else { return }
//            BaoKimDataManager.shared.searchTripParam.pickupPoints.removeAll()
//            for district in data.districts {
//                let point = BaoKimPointParam(JSON: [:])!
//                point.district = district.name
//
//                BaoKimDataManager.shared.searchTripParam.pickupPoints.append(point)
//            }
//            dispatchGroup.leave()
//        }, failure: { [weak self] error in
//            guard let self = self else { return }
//            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
//            dispatchGroup.leave()
//        })
        
//        dispatchGroup.enter()
//        Provider.shared.baokimAPIService.getDistricts(cityId: endLocation.id, success: { result in
//            guard let data = result else { return }
//            BaoKimDataManager.shared.searchTripParam.dropoffPoints.removeAll()
//            for district in data.districts {
//                let point = BaoKimPointParam(JSON: [:])!
//                point.district = district.name
//
//                BaoKimDataManager.shared.searchTripParam.dropoffPoints.append(point)
//            }
//            dispatchGroup.leave()
//        }, failure: { [weak self] error in
//            guard let self = self else { return }
//            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
//            dispatchGroup.leave()
//        })
        
//        dispatchGroup.notify(queue: .main) {
//            ProgressView.shared.hide()
        
        let startDistricts = startLocation.cityId == "0" ? (BaoKimDataManager.shared.cities.filter { $0.cityId == startLocation.id }) : [startLocation]
        BaoKimDataManager.shared.searchTripParam.pickupPoints.removeAll()
        for district in startDistricts {
            let point = BaoKimPointParam(JSON: [:])!
            point.district = district.name
            
            BaoKimDataManager.shared.searchTripParam.pickupPoints.append(point)
        }
        
        let endDistricts = endLocation.cityId == "0" ? (BaoKimDataManager.shared.cities.filter { $0.cityId == endLocation.id }) : [endLocation]
        BaoKimDataManager.shared.searchTripParam.dropoffPoints.removeAll()
        for district in endDistricts {
            let point = BaoKimPointParam(JSON: [:])!
            point.district = district.name
            
            BaoKimDataManager.shared.searchTripParam.dropoffPoints.append(point)
        }
        
            guard BaoKimDataManager.shared.searchTripParam.pickupPoints.count > 0 && BaoKimDataManager.shared.searchTripParam.dropoffPoints.count > 0 else { return }
            
            self.loadTripData()
//        }
    }
}

extension SearchTripBaoKimViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfStart {
            let vc = SelectLocationBaoKimViewController()
            vc.titleString = "Chọn điểm đi"
            vc.didSelectLocation = { location in
                self.startLocation = location
                self.tfStart.text = location.name
            }
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
            
            return false
        } else if textField == tfEnd {
            let vc = SelectLocationBaoKimViewController()
            vc.titleString = "Chọn điểm đi"
            vc.didSelectLocation = { location in
                self.endLocation = location
                self.tfEnd.text = location.name
            }
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
            
            return false
        } else if textField == tfDate {
            let vc = SelectDateBaoKimViewController()
            vc.selectedDate = selectedDate
            vc.didSelectDate = { date in
                self.selectedDate = date
                self.tfDate.text = date.stringWith(format: "dd/MM/yyyy")
            }
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
}
