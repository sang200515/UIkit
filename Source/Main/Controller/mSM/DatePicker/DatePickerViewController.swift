//
//  DatePickerViewController.swift
//  mSM
//
//  Created by Trần Thành Phương Đăng on 06/09/18.
//  Copyright © 2018 fptshop.com.vn. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var reportSection: ReportCase!;
    override func viewDidLoad() {
        super.viewDidLoad();
        
        datePicker.datePickerMode = UIDatePicker.Mode.date;
        datePicker.setDate(Date(), animated: true)
    }
    
    @IBAction func AcceptButtonSelected(){
        let viewController = ReportCollectionViewController();
        let dateFormatter = DateFormatter();
        let username = (Cache.user?.UserName)!;
        
        dateFormatter.dateFormat = "dd/MM/yyyy";
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            let data = mSMApiManager.GetASMAgreement(username: username, reportDate: dateFormatter.string(from: self.datePicker.date)).Data;
            
            if(data != nil){
                var counter = 0;
                viewController.cellData = [[String]]()
                viewController.header = ["STT", "ASM", "Tên shop", "Ngày đánh giá", "Kết quả ASM chọn"];
                data?.forEach{ item in
                    counter += 1;
                    viewController.cellData.append([
                        "\(counter)",
                        "\(item.ShopCode!) - \(item.ASMFullname!)",
                        "\(item.ShopName!)",
                        "\(item.ApprovedDate!)",
                        "\(item.ASMChoice!)"
                        ]);
                }
            }
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                viewController.reportSection = self.reportSection;
                self.navigationController?.pushViewController(viewController, animated: true);
            }
        }
    }
}
