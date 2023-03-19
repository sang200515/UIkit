//
//  PhoneBookViewController.swift
//  TestMoya
//
//  Created by Trần Thành Phương Đăng on 5/21/18.
//  Copyright © 2018 fpt. All rights reserved.
//

import UIKit;

class PhoneBookViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var tbxSearch: IconizedTextField!
    @IBOutlet weak var contactListView: UITableView!
    
    let btnCancel:UIBarButtonItem = UIBarButtonItem();
    var textFieldSize:CGSize = CGSize.init();
    var contacts: [Contact] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        contactListView.dataSource = self;
        contactListView.delegate = self;
        
        let cellViewNib = UINib.init(nibName: "ContactTableViewCell", bundle: nil);
        contactListView.register(cellViewNib, forCellReuseIdentifier: "cell");
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        AddTextField();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.navigationItem.titleView = nil;
    }
    
    func AddRightBarButton() {
        //Initiate right bar button properties
        btnCancel.title = "Huỷ";
        btnCancel.style = UIBarButtonItem.Style.plain;
        btnCancel.tintColor = UIColor.white;
        btnCancel.action = #selector(self.CancelSearchBoxTextEditing);
        
        self.textFieldSize = tbxSearch.frame.size;
        self.navigationItem.setRightBarButton(btnCancel, animated: true);
    }
    
    @objc func CancelSearchBoxTextEditing(){
        self.tbxSearch.resignFirstResponder();
        self.navigationItem.setRightBarButton(nil, animated: true);
        self.tbxSearch.frame.size = self.textFieldSize;
    }
    
    func AddTextField(){
        tbxSearch = IconizedTextField(frame: CGRect(x: 0, y: 30, width: (self.navigationController?.navigationBar.frame.size.width)! - 30, height: 30));
        tbxSearch.leftImage = UIImage(named: "magnifyingIcon.png");
        tbxSearch.leftViewMode = .unlessEditing;
        tbxSearch.imageTintColor = .white;
        tbxSearch.placeholderColor = .lightText;
        tbxSearch.placeholder = "Bạn muốn tìm ai?";
        tbxSearch.textColor = UIColor.white;
        tbxSearch.borderThickness = 0.5;
        tbxSearch.rightPadding = 5;
        tbxSearch.returnKeyType = .search;
        self.navigationItem.titleView = tbxSearch;
        tbxSearch.delegate = self;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!);
        self.tbxSearch.resignFirstResponder();
        
        var contactList: Response<[Contact]>?;
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            contactList = mSMApiManager.GetContactList(keyword: textField.text!);
        }
        WaitingNetworkResponseAlert.DismissWaitingAlert {
            if(contactList!.Data != nil){
                self.contacts = contactList!.Data!;
            self.contactListView.reloadData();
            }
        }
        return true;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ContactTableViewCell;
        let contact = contacts[indexPath.row];
            cell.lblContactFullname.text! = contact.EmployeeName!;
            cell.lblEmail.text! = contact.Email == nil ? "": contact.Email!;
            cell.lblShopName.text! = contact.WarehouseName == nil ? "": contact.WarehouseName!;
            cell.lblPhoneNum.text! = contact.Phone!;
            cell.lblOffice.text! = contact.JobtitleName!;
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contactDetailsVC = ContactDetailsViewController();
        if(contacts.count > 0){
            contactDetailsVC.contactDetails = contacts[indexPath.row];
        }
        self.navigationController?.pushViewController(contactDetailsVC, animated: true);
        self.navigationItem.title = "Tìm liên hệ";
        tableView.deselectRow(at: indexPath, animated: true);
    }
}
