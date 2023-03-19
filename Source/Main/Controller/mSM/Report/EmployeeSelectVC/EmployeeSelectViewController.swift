//
//  EmployeeSelectViewController.swift
//  fptshop
//
//  Created by Trần Thành Phương Đăng on 25/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit;

class EmployeeSelectViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    var searchBar = UITextField();
    var tableView = UITableView();
    var employees: [ViolateEmployee] = [];
    var filteredEmployee: [ViolateEmployee] = [];
    var reportCase: ReportCase!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        SetupView();
    }
    
    func SetupView(){
        searchBar = UITextField(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40));
        searchBar.attributedPlaceholder = NSAttributedString(string: "Nhập mã/tên nhân viên", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightText]);
        searchBar.textColor = UIColor.white;
        searchBar.returnKeyType = .search;
        searchBar.inputAccessoryView = UIView();
        navigationItem.titleView = searchBar;
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height));
        self.view.addSubview(tableView);
        
        self.searchBar.delegate = self;
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.tableFooterView = UIView();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmployee.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell");
        let font = cell?.textLabel?.font;
        cell!.textLabel!.font = font?.withSize(13);
        cell!.textLabel!.text = "\(filteredEmployee[indexPath.row].EmployeeCode!) - \(filteredEmployee[indexPath.row].EmployeeName!)";
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = ReportCollectionViewController();
        Cache.selectedEmployeeCode = filteredEmployee[indexPath.row].EmployeeCode!;
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            detailView.header = self.reportCase.reportHeader;
            detailView.cellData = self.reportCase.reportData;
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                detailView.reportSection = self.reportCase;
                self.navigationController?.pushViewController(detailView, animated: true);
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        filteredEmployee.removeAll();
        
        employees.forEach{ employee in
            if(employee.EmployeeCode!.contains(textField.text!) ||
                employee.EmployeeName!.contains(textField.text!)){
                filteredEmployee.append(employee);
            }
        }
        if(filteredEmployee.count > 0){
            tableView.reloadData();
        }
        else{
            let alertVC = UIAlertController(title: "Thông báo", message: "Không tìm thấy nhân viên vi phạm", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                alertVC.dismiss(animated: true, completion: nil);
            });
            alertVC.addAction(okAction);
            self.present(alertVC, animated: true, completion: nil);
        }
        textField.resignFirstResponder();
        return true;
    }
}
