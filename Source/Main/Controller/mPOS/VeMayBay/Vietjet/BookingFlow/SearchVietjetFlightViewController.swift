//
//  SearchVietjetFlightViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 19/04/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class SearchVietjetFlightViewController: UIViewController {
    
    @IBOutlet weak var imvFlightType: UIImageView!
    @IBOutlet weak var lbFlightType: UILabel!
    @IBOutlet weak var vSelect: UIView!
    @IBOutlet weak var vFrom: UIStackView!
    @IBOutlet weak var tfFrom: UITextField!
    @IBOutlet weak var lbFromRegion: UILabel!
    @IBOutlet weak var lbFromCity: UILabel!
    @IBOutlet weak var lbFromAirport: UILabel!
    @IBOutlet weak var vTo: UIStackView!
    @IBOutlet weak var tfTo: UITextField!
    @IBOutlet weak var lbToRegion: UILabel!
    @IBOutlet weak var lbToCity: UILabel!
    @IBOutlet weak var lbToAirport: UILabel!
    @IBOutlet weak var vAirport: UIView!
    @IBOutlet weak var tbvAirport: UITableView!
    @IBOutlet weak var btnContinue: UIButton!
    
    private var isExpand: [Bool] = [true, false]
    private var isFrom: Bool = true
    private var fromDomestics: [Departure] = []
    private var fromInternationals: [Departure] = []
    private var filtedFromDomestics: [Departure] = []
    private var filtedFromInternationals: [Departure] = []
    private var toDomestics: [Departure] = []
    private var toInternationals: [Departure] = []
    private var filtedToDomestics: [Departure] = []
    private var filtedToInternationals: [Departure] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadData()
        setupData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vAirport.roundCorners(.allCorners, radius: 10)
    }
    
    private func setupUI() {
        title = "Điểm khởi hành/Điểm đến"
        addBackButton()
        
        vSelect.roundCorners(.allCorners, radius: 8)
        btnContinue.roundCorners(.allCorners, radius: 5)
        
        if VietjetDataManager.shared.isOneWay {
            imvFlightType.image = UIImage(named: "from_ic")
            lbFlightType.text = "Một chiều"
        } else {
            imvFlightType.image = UIImage(named: "return_ic")
            lbFlightType.text = "Khứ hồi"
        }
        
        VietjetDataManager.shared.departureCity = VietjetDataManager.shared.selectedDepartureCity
        VietjetDataManager.shared.arrivalCity = VietjetDataManager.shared.selectedArrivalCity
        setupAirportLabel()
    }
    
    private func setupTableView() {
        tbvAirport.registerTableCell(VietjetRegionTableViewCell.self)
        tbvAirport.registerTableCell(VietjetAirportTableViewCell.self)
    }
    
    private func loadData() {
        Provider.shared.vietjetAPIService.getCityPairs(success:  { [weak self] data in
            guard let self = self, let result = data else { return }
            VietjetDataManager.shared.cityPairs = result
            self.setupData()
            if self.vFrom.isHidden {
                self.tfFrom.becomeFirstResponder()
            }
        }, failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    
    private func setupData() {
        fromDomestics = VietjetDataManager.shared.cityPairs.departures.filter { $0.type == "Việt Nam" }
        fromInternationals = VietjetDataManager.shared.cityPairs.departures.filter { $0.type == "Quốc Tế" }
        filtedFromDomestics = fromDomestics
        filtedFromInternationals = fromInternationals
        
        tbvAirport.reloadData()
    }
    
    private func filterArrivalCities(_ airport: Departure) {
        toDomestics = airport.arrivals.filter { $0.type == "Việt Nam" }
        toInternationals = airport.arrivals.filter { $0.type == "Quốc Tế" }
        filtedToDomestics = toDomestics
        filtedToInternationals = toInternationals
        
        tbvAirport.reloadData()
    }
    
    private func setupAirportLabel() {
        if VietjetDataManager.shared.departureCity.name.isEmpty {
            tfFrom.isHidden = false
            vFrom.isHidden = true
        } else {
            tfFrom.text = ""
            filtedFromDomestics = fromDomestics
            filtedFromInternationals = fromInternationals
            tfFrom.isHidden = true
            vFrom.isHidden = false
        }
        
        if VietjetDataManager.shared.arrivalCity.name.isEmpty {
            tfTo.isHidden = false
            vTo.isHidden = true
        } else {
            tfTo.text = ""
            filtedToDomestics = toDomestics
            filtedToInternationals = toInternationals
            tfTo.isHidden = true
            vTo.isHidden = false
        }
        
        lbFromRegion.text = "Điểm khởi hành"
        lbFromCity.text = "\(VietjetDataManager.shared.departureCity.name) - \(VietjetDataManager.shared.departureCity.code)"
        lbFromAirport.text = VietjetDataManager.shared.departureCity.type
        
        lbToRegion.text = "Điểm đến"
        lbToCity.text = "\(VietjetDataManager.shared.arrivalCity.name) - \(VietjetDataManager.shared.arrivalCity.code)"
        lbToAirport.text = VietjetDataManager.shared.arrivalCity.type
        
        tbvAirport.reloadData()
    }
    
    @IBAction func switchButtonPressed(_ sender: Any) {
        let temp = VietjetDataManager.shared.departureCity
        VietjetDataManager.shared.departureCity = VietjetDataManager.shared.arrivalCity
        VietjetDataManager.shared.arrivalCity = temp
        
        setupAirportLabel()
    }
    
    @IBAction func fromButtonPressed(_ sender: Any) {
        tfFrom.isHidden = false
        vFrom.isHidden = true
        view.endEditing(true)
        tfFrom.becomeFirstResponder()
        tbvAirport.reloadData()
    }
    
    @IBAction func toButtonPressed(_ sender: Any) {
        tfTo.isHidden = false
        vTo.isHidden = true
        filterArrivalCities(VietjetDataManager.shared.departureCity)
        view.endEditing(true)
        tfTo.becomeFirstResponder()
        tbvAirport.reloadData()
    }
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if VietjetDataManager.shared.departureCity.name.isEmpty || VietjetDataManager.shared.arrivalCity.name.isEmpty {
            showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn đầy đủ thông tin điểm khởi hành/điểm đến", titleButton: "OK")
            return
        }
        if VietjetDataManager.shared.departureCity.name == VietjetDataManager.shared.arrivalCity.name {
            showAlertOneButton(title: "Thông báo", with: "Điểm khởi hành và điểm đến phải không cùng một sân bay", titleButton: "OK")
            return
        }
        
        VietjetDataManager.shared.selectedDepartureCity = VietjetDataManager.shared.departureCity
        VietjetDataManager.shared.selectedArrivalCity = VietjetDataManager.shared.arrivalCity
        navigationController?.popViewController(animated: true)
    }
}

extension SearchVietjetFlightViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExpand[section] {
            switch section {
            case 0:
                if isFrom {
                    return filtedFromDomestics.count
                } else {
                    return filtedToDomestics.count
                }
            case 1:
                if isFrom {
                    return filtedFromInternationals.count
                } else {
                    return filtedToInternationals.count
                }
            default:
                return 0
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueTableCell(VietjetRegionTableViewCell.self)
        let isDomestic = section == 0
        header.setupCell(isDomestic: isDomestic, isExpand: isExpand[section])
        header.expandButtonDidPressed = { [weak self] in
            guard let self = self else { return }
            self.isExpand[section] = !self.isExpand[section]
            DispatchQueue.main.async {
                self.tbvAirport.reloadData()
            }
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueTableCell(VietjetAirportTableViewCell.self)
        var airport: Departure = Departure(JSON: [:])!
        switch indexPath.section {
        case 0:
            if isFrom {
                airport = filtedFromDomestics[indexPath.row]
            } else {
                airport = filtedToDomestics[indexPath.row]
            }
        case 1:
            if isFrom {
                airport = filtedFromInternationals[indexPath.row]
            } else {
                airport = filtedToInternationals[indexPath.row]
            }
        default:
            break
        }
        cell.setupCell(airport)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if isFrom {
                VietjetDataManager.shared.departureCity = filtedFromDomestics[indexPath.row]
            } else {
                VietjetDataManager.shared.arrivalCity = filtedToDomestics[indexPath.row]
            }
        } else {
            if isFrom {
                VietjetDataManager.shared.departureCity = filtedFromInternationals[indexPath.row]
            } else {
                VietjetDataManager.shared.arrivalCity = filtedToInternationals[indexPath.row]
            }
        }
        
        if isFrom {
            toButtonPressed(self)
        }
        setupAirportLabel()
    }
}

extension SearchVietjetFlightViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfTo {
            if VietjetDataManager.shared.departureCity.name.isEmpty {
                view.endEditing(true)
                showAlertOneButton(title: "Thông báo", with: "Bạn vui lòng chọn điểm khởi hành trước", titleButton: "OK", handleOk: {
                    self.tfFrom.becomeFirstResponder()
                })
                return false
            } else {
                isFrom = false
                VietjetDataManager.shared.arrivalCity = Departure(JSON: [:])!
                return true
            }
        } else {
            isFrom = true
            VietjetDataManager.shared.departureCity = Departure(JSON: [:])!
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchText = ""
        if let text = textField.text, let textRange = Range(range, in: text) {
            searchText = text.replacingCharacters(in: textRange, with: string)
        }
        
        if searchText.count > 0 {
            if textField == tfFrom {
                filtedFromDomestics = fromDomestics.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.code.lowercased().contains(searchText.lowercased()) }
                filtedFromInternationals = fromInternationals.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.code.lowercased().contains(searchText.lowercased()) }
            } else if textField == tfTo {
                filtedToDomestics = toDomestics.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.code.lowercased().contains(searchText.lowercased()) }
                filtedToInternationals = toInternationals.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.code.lowercased().contains(searchText.lowercased()) }
            }
        } else {
            if textField == tfFrom {
                filtedFromDomestics = fromDomestics
                filtedFromInternationals = fromInternationals
            } else if textField == tfTo {
                filtedToDomestics = toDomestics
                filtedToInternationals = toInternationals
            }
        }
        
        tbvAirport.reloadData()
        return true
    }
}
