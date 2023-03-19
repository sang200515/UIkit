//
//  ContactDetailsViewController.swift
//  mSM
//
//  Created by Trần Thành Phương Đăng on 6/21/18.
//  Copyright © 2018 FPT. All rights reserved.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblOrganization: UILabel!
    @IBOutlet weak var lblShopName: UILabel!
    @IBOutlet weak var lblProvince: UILabel!
    @IBOutlet weak var lblOffice: UILabel!
    @IBOutlet weak var lblPhonenum: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblIPPhone: UILabel!
    @IBOutlet weak var lblJobDetail: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    
    var contactDetails:Contact!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        LoadData();
    }

    func LoadData(){
        lblEmail.text! = contactDetails.Email!;
        lblOffice.text! = contactDetails.JobtitleName!;
        lblIPPhone.text! = contactDetails.IPPhone == nil ? "": contactDetails.IPPhone!;
        lblFullname.text! = contactDetails.EmployeeName!;
        lblPhonenum.text! = contactDetails.Phone!;
        lblProvince.text! = contactDetails.Tinh ?? "";
        lblShopName.text! = contactDetails.WarehouseName == nil ? "": contactDetails.WarehouseName!;
        lblJobDetail.text! = contactDetails.NoteContact == nil ? "" : contactDetails.NoteContact!;
        lblOrganization.text! = contactDetails.OrganizationHierachyName == nil ? "": contactDetails.OrganizationHierachyName!;
    }
}
