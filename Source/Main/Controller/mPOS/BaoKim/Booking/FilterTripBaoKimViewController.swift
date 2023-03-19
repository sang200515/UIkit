//
//  FilterTripBaoKimViewController.swift
//  fptshop
//
//  Created by Doan Minh Hoang on 22/11/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class FilterTripBaoKimViewController: UIViewController {

    @IBOutlet weak var btn0012: UIButton!
    @IBOutlet weak var btn1219: UIButton!
    @IBOutlet weak var btn1924: UIButton!
    @IBOutlet weak var btnVIP: UIButton!
    @IBOutlet weak var btnSeat1: UIButton!
    @IBOutlet weak var btnSeat2: UIButton!
    @IBOutlet weak var btnSeat3: UIButton!
    @IBOutlet weak var lbCompanies: UILabel!
    
    var seletedCompanies: [BaoKimFilterCompaniesData] = []
    var is0012: Bool = false
    var is1219: Bool = false
    var is1924: Bool = false
    var isVIP: Bool = false
    var isSeat1: Bool = false
    var isSeat2: Bool = false
    var isSeat3: Bool = false
    var didApplyFilter: ((Bool, Bool, Bool, Bool, Bool, Bool, Bool, [BaoKimFilterCompaniesData]) -> Void)?
    
    private var selectedColor: String = "42935D"
    private var unselectedColor: String = "F1EFEE"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbCompanies.text = seletedCompanies.count == 0 ? "Tất cả" : "Đã chọn \(seletedCompanies.count) nhà xe"
        setupFilter()
    }
    
    private func setupFilter() {
        if is0012 {
            btn0012.backgroundColor = UIColor(hexString: selectedColor)
            btn0012.setTitleColor(.white, for: .normal)
            btn1219.backgroundColor = UIColor(hexString: unselectedColor)
            btn1219.setTitleColor(.black, for: .normal)
            btn1924.backgroundColor = UIColor(hexString: unselectedColor)
            btn1924.setTitleColor(.black, for: .normal)
        } else {
            btn0012.backgroundColor = UIColor(hexString: unselectedColor)
            btn0012.setTitleColor(.black, for: .normal)
        }
        
        if is1219 {
            btn1219.backgroundColor = UIColor(hexString: selectedColor)
            btn1219.setTitleColor(.white, for: .normal)
            btn0012.backgroundColor = UIColor(hexString: unselectedColor)
            btn0012.setTitleColor(.black, for: .normal)
            btn1924.backgroundColor = UIColor(hexString: unselectedColor)
            btn1924.setTitleColor(.black, for: .normal)
        } else {
            btn1219.backgroundColor = UIColor(hexString: unselectedColor)
            btn1219.setTitleColor(.black, for: .normal)
        }
        
        if is1924 {
            btn1924.backgroundColor = UIColor(hexString: selectedColor)
            btn1924.setTitleColor(.white, for: .normal)
            btn1219.backgroundColor = UIColor(hexString: unselectedColor)
            btn1219.setTitleColor(.black, for: .normal)
            btn0012.backgroundColor = UIColor(hexString: unselectedColor)
            btn0012.setTitleColor(.black, for: .normal)
        } else {
            btn1924.backgroundColor = UIColor(hexString: unselectedColor)
            btn1924.setTitleColor(.black, for: .normal)
        }
        
        if isVIP {
            btnVIP.backgroundColor = UIColor(hexString: selectedColor)
            btnVIP.setTitleColor(.white, for: .normal)
        } else {
            btnVIP.backgroundColor = UIColor(hexString: unselectedColor)
            btnVIP.setTitleColor(.black, for: .normal)
        }
        
        if isSeat1 {
            btnSeat1.backgroundColor = UIColor(hexString: selectedColor)
            btnSeat1.setTitleColor(.white, for: .normal)
        } else {
            btnSeat1.backgroundColor = UIColor(hexString: unselectedColor)
            btnSeat1.setTitleColor(.black, for: .normal)
        }
        
        if isSeat2 {
            btnSeat2.backgroundColor = UIColor(hexString: selectedColor)
            btnSeat2.setTitleColor(.white, for: .normal)
        } else {
            btnSeat2.backgroundColor = UIColor(hexString: unselectedColor)
            btnSeat2.setTitleColor(.black, for: .normal)
        }
        
        if isSeat3 {
            btnSeat3.backgroundColor = UIColor(hexString: selectedColor)
            btnSeat3.setTitleColor(.white, for: .normal)
        } else {
            btnSeat3.backgroundColor = UIColor(hexString: unselectedColor)
            btnSeat3.setTitleColor(.black, for: .normal)
        }
    }
    
    @IBAction func button0012Pressed(_ sender: Any) {
        if is0012 {
            is0012 = false
        } else {
            is0012 = true
            is1219 = false
            is1924 = false
        }
        
        setupFilter()
    }
    
    @IBAction func button1219Pressed(_ sender: Any) {
        if is1219 {
            is1219 = false
        } else {
            is1219 = true
            is0012 = false
            is1924 = false
        }
        
        setupFilter()
    }
    
    @IBAction func button1924Pressed(_ sender: Any) {
        if is1924 {
            is1924 = false
        } else {
            is1924 = true
            is0012 = false
            is1219 = false
        }
        
        setupFilter()
    }
    
    @IBAction func vipButtonPressed(_ sender: Any) {
        if isVIP {
            isVIP = false
        } else {
            isVIP = true
        }
        
        setupFilter()
    }
    
    @IBAction func seat1ButtonPressed(_ sender: Any) {
        if isSeat1 {
            isSeat1 = false
        } else {
            isSeat1 = true
        }
        
        setupFilter()
    }
    
    @IBAction func seat2ButtonPressed(_ sender: Any) {
        if isSeat2 {
            isSeat2 = false
        } else {
            isSeat2 = true
        }
        
        setupFilter()
    }
    
    @IBAction func seat3ButtonPressed(_ sender: Any) {
        if isSeat3 {
            isSeat3 = false
        } else {
            isSeat3 = true
        }
        
        setupFilter()
    }
    
    @IBAction func companiesButtonPressed(_ sender: Any) {
        let vc = SelectCompaniesBaoKimViewController()
        vc.titleString = "Chọn nhà xe"
        vc.selectedCompanies = seletedCompanies
        vc.didSelectCompanies = { companies in
            self.seletedCompanies = companies
            self.lbCompanies.text = companies.count == 0 ? "Tất cả" : "Đã chọn \(companies.count) nhà xe"
        }
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.didApplyFilter?(self.is0012, self.is1219, self.is1924, self.isVIP, self.isSeat1, self.isSeat2, self.isSeat3, self.seletedCompanies)
        })
    }
}
