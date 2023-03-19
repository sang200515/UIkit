//
//  WeLoveViewController.swift
//  mCallLog_v2
//
//  Created by Trần Thành Phương Đăng on 20/09/18.
//  Copyright © 2018 vn.com.fptshop. All rights reserved.
//

import UIKit;
import DropDown;


class WeLoveViewController: UIViewController, UITextViewDelegate {
    
    var evaluationDepartments: [WeLoveEvaluation] = [];
    var evaluationCriterias: [WeLoveEvaluation] = [];
    var departmentsTitle: [String] = [];
    var criteriasTitle: [String] = [];
    
    let evaluationType: [String] = ["Khen", "Khiếu nại"];
    
    let dropMenuEvaluationType = DropDown();
    let dropMenuEvaluationDepartment = DropDown();
    let dropMenuEvaluationCriteria = DropDown();
    
    var selectedEvalDepartment: String!;
    var selectedEvalType: String!;
    var selectedEvalCriteria: String!;
    
    @IBOutlet weak var menuEvaluationType: UIButton!
    @IBOutlet weak var menuEvaluationDepartment: UIButton!
    @IBOutlet weak var menuEvaluationCriteria: UIButton!
    @IBOutlet weak var tbxRequestDetail: UITextView!
    @IBOutlet weak var btnSendRequest: UIButton!
    
    lazy var dropDownMenus: [DropDown] = {
        return [
            self.dropMenuEvaluationType,
            self.dropMenuEvaluationCriteria,
            self.dropMenuEvaluationDepartment
        ]
    }();
    
    @IBAction func ShowMenuEvaluationType(){
        dropMenuEvaluationType.show();
    }
    
    @IBAction func ShowMenuEvaluationDepartment(){
        dropMenuEvaluationDepartment.show();
    }
    
    @IBAction func ShowMenuEvaluationCriteria(){
        if(departmentsTitle.count > 0){
            dropMenuEvaluationCriteria.dataSource = criteriasTitle;
            dropMenuEvaluationCriteria.show();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        let username = (Cache.user?.UserName)!;
        let token = (Cache.user?.Token)!;
        
        self.navigationItem.title = "We Love"
        RetrieveDepartmentsData(username: username, token: token);
        tbxRequestDetail.delegate = self;
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.text! == "Nhập nội dung trao đổi"){
            textView.text = "";
            textView.textColor = UIColor.darkGray;
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(textView == tbxRequestDetail){
            if(text == "\n"){
                textView.resignFirstResponder();
                return false;
            }
        }
        return true;
    }
    
    func SetupDropMenus(){
        DropDown.setupDefaultAppearance();
        
        let username = (Cache.user?.UserName)!;
        let token = (Cache.user?.Token)!;
        
        dropDownMenus.forEach {
            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self));
            $0.customCellConfiguration = nil;
        }
        
        dropDownMenus.forEach { $0.dismissMode = .onTap; }
        dropDownMenus.forEach { $0.direction = .any; }
        
        //Setup DropMenu anchor point
        dropMenuEvaluationType.anchorView = menuEvaluationType;
        dropMenuEvaluationCriteria.anchorView = menuEvaluationCriteria;
        dropMenuEvaluationDepartment.anchorView = menuEvaluationDepartment;
        DropDown.startListeningToKeyboard();
        
        //Setup datasources
        dropMenuEvaluationDepartment.dataSource = departmentsTitle;
        dropMenuEvaluationDepartment.selectRow(0);
        
        dropMenuEvaluationType.dataSource = evaluationType;
        dropMenuEvaluationType.selectRow(0);
        
        dropMenuEvaluationDepartment.selectionAction = { [weak self] (index, item) in
            var selectedDepartment: WeLoveEvaluation!;
            self?.evaluationDepartments.forEach{
                if($0.EvaluationName! == item){
                    self?.selectedEvalDepartment = "\($0.Id!)";
                    selectedDepartment = $0;
                }
            }
            self?.RetrieveCriteriasData(parentId: "\(selectedDepartment.Id!)", username: username, token: token);
            self?.menuEvaluationDepartment.setTitle(item, for: .normal);
        }
        
        dropMenuEvaluationCriteria.selectionAction = { [weak self] (index, item) in
            self?.menuEvaluationCriteria.setTitle(item, for: .normal);
            self?.evaluationCriterias.forEach{
                if($0.EvaluationName! == item){
                    self?.selectedEvalCriteria = "\($0.Id!)";
                }
            }
        }
        
        dropMenuEvaluationType.selectionAction = { [weak self] (index, item) in
            self?.evaluationType.forEach{
                if($0 == "Khen"){
                    self?.selectedEvalType = "\(1)";
                }
                else{
                    self?.selectedEvalType = "\(2)";
                }
            }
            self?.menuEvaluationType.setTitle(item, for: .normal);
        }
    }
    
    func RetrieveDepartmentsData(username: String, token: String){
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
            let departments = mCallLogApiManager.GetEvaluationDepartment(username: username, token: token).Data;
            if(departments != nil){
                self.evaluationDepartments = departments!;
                departments!.forEach{
                    self.departmentsTitle.append($0.EvaluationName!);
                }
                self.SetupDropMenus();
            }
            WaitingNetworkResponseAlert.DismissWaitingAlert {
            }
        }
    }
    
    func RetrieveCriteriasData(parentId: String, username: String, token: String){
        let criterias = mCallLogApiManager.GetEvaluationCriteria(parentId: parentId, token: token, username: username).Data;
        if(criterias != nil){
            self.evaluationCriterias = criterias!;
            self.criteriasTitle.removeAll();
            criterias!.forEach{
                self.criteriasTitle.append($0.EvaluationName!);
            }
        }
    }
    
    @IBAction func SendRequest(){
        if(self.selectedEvalType.isEmpty && self.selectedEvalDepartment.isEmpty && self.selectedEvalCriteria.isEmpty){
            let alertVC = UIAlertController(title: "Thông báo", message: "Bạn chưa chọn đủ các mục để tạo callLog", preferredStyle: .alert);
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
                alertVC.dismiss(animated: true, completion: nil);
            })
            alertVC.addAction(okAction);
            self.present(alertVC, animated: true, completion: nil);
        }
        else{
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self){
                
                let username = (Cache.user?.UserName)!;
                let token = (Cache.user?.Token)!;
                
                let response = mCallLogApiManager.PostRequest(evaluationType: self.selectedEvalType, evaluationDepartment: self.selectedEvalDepartment, evaluationCriteria: self.selectedEvalCriteria, requestDetails: self.tbxRequestDetail.text!, updatedBy: username, token: token, username: username).Data!;
                
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if(!response.isEmpty && response.count > 0){
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(response[0].Message!)\nSố Call Log:\(response[0].RequestId!)", preferredStyle: .alert);
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                            alertVC.dismiss(animated: true, completion: nil);
                            self.menuEvaluationType.setTitle("Chọn loại đánh giá", for: .normal);
                            self.menuEvaluationCriteria.setTitle("Chọn tiêu chí đánh giá", for: .normal);
                            self.menuEvaluationDepartment.setTitle("Chọn bộ phận đánh giá", for: .normal);
                            self.tbxRequestDetail.text = "Nhập nội dung trao đổi";
                        });
                        
                        alertVC.addAction(okAction);
                        self.present(alertVC, animated: true, completion: nil);
                    }
                    else if(response.count <= 0){
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(response[0].Message!)", preferredStyle: .alert);
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
                            alertVC.dismiss(animated: true, completion: nil);
                        });
                        
                        alertVC.addAction(okAction);
                        self.present(alertVC, animated: true, completion: nil);
                    }
                    else{
                        self.ShowUserLoginOtherDevice();
                    }
                }
            }
        }
    }
    
    func ShowUserLoginOtherDevice(){
        let alertVC = UIAlertController(title: "Thông báo", message: "User đã đăng nhập trên thiết bị khác. \nVui lòng kiểm tra lại", preferredStyle: .alert);
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertVC.dismiss(animated: true, completion: nil);
        });
        
        alertVC.addAction(okAction);
        self.present(alertVC, animated: true, completion: nil);
    }
    
    @objc func keyboardWillShow(notification: NSNotification){
        if(self.view.frame.origin.y >= 0){
            self.view.frame.origin.y -= 100;
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        if(self.view.frame.origin.y < 0){
            self.view.frame.origin.y += 100;
        }
    }
}
