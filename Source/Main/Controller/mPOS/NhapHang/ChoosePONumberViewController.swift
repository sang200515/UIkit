//
//  ChoosePONumberViewController.swift
//  mPOS
//
//  Created by tan on 8/16/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation
import UIKit
import DLRadioButton
class ChoosePONumberViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate,ItemPONumberTableViewCellDelegate{
    
    
    
    
    
    var listPO:[PO]?
    var scrollView:UIScrollView!
    var viewTablePO:UITableView = UITableView()
    var btHoanTat:UIButton!
    var listPoNum:[Int] = []
    
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Chọn số PO"
        
        self.setupUI(list: listPO!)
        
    }
    
    
    
    func setupUI(list: [PO]){
        let width:CGFloat = UIScreen.main.bounds.size.width
        
        viewTablePO.frame = CGRect(x: 0, y: Common.Size(s: 5), width: width, height: Common.Size(s: 300) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTablePO.dataSource = self
        viewTablePO.delegate = self
        viewTablePO.register(ItemPONumberTableViewCell.self, forCellReuseIdentifier: "ItemPONumberTableViewCell")
        viewTablePO.tableFooterView = UIView()
        viewTablePO.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTablePO)
        
        btHoanTat = UIButton()
        btHoanTat.frame = CGRect(x: Common.Size(s: 30), y: viewTablePO.frame.origin.y + viewTablePO.frame.size.height , width: scrollView.frame.size.width - Common.Size(s:60),height: Common.Size(s:40))
        btHoanTat.backgroundColor = UIColor(netHex:0x47B054)
        btHoanTat.setTitle("Hoàn tất", for: .normal)
        btHoanTat.addTarget(self, action: #selector(actionHoanTat), for: .touchUpInside)
        btHoanTat.layer.borderWidth = 0.5
        btHoanTat.layer.borderColor = UIColor.white.cgColor
        btHoanTat.layer.cornerRadius = 3
        scrollView.addSubview(btHoanTat)
        btHoanTat.clipsToBounds = true
        
        //navigationController?.navigationBar.isTranslucent = false
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: btHoanTat.frame.origin.y + btHoanTat.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height + Common.Size(s: 60))
    }
    
    @objc func actionHoanTat(){
        
        Cache.listPONum = []
        Cache.listPONum = self.listPoNum
        navigationController?.popViewController(animated: true)
        //        let newViewController = NhapHangViewController()
        //        newViewController.listPoNum = self.listPoNum
        //        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listPO!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemPONumberTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemPONumberTableViewCell")
        let item:PO = self.listPO![indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:40);
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            
            //    let so:SimBookByShop = self.listSimBookByShop[indexPath.row]
            
        }
        
    }
    
    
    func tabChoosePO(poNum: Int,isWas: Bool) {
        if(isWas == true){
            self.listPoNum.append(poNum)
        }else{
            if let index = self.listPoNum.firstIndex(of: poNum) {
                self.listPoNum.remove(at: index)
            }
            
        }
        
    }
    
    
    
}

protocol ItemPONumberTableViewCellDelegate {
    
    func tabChoosePO(poNum:Int,isWas:Bool)
}

class ItemPONumberTableViewCell: UITableViewCell {
    
    var date: UILabel!
    var radioChoose:DLRadioButton!
    var delegate: ItemPONumberTableViewCellDelegate?
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        
        
        date = UILabel()
        date.textColor = UIColor.gray
        date.numberOfLines = 1
        date.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(date)
        
        radioChoose = DLRadioButton()
        radioChoose.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioChoose.setTitleColor(UIColor.black, for: UIControl.State());
        radioChoose.iconColor = UIColor.black;
        radioChoose.indicatorColor = UIColor.black;
        radioChoose.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioChoose.isMultipleSelectionEnabled = true
        contentView.addSubview(radioChoose)
        
        
        
    }
    var so1:PO?
    func setup(so:PO){
        so1 = so
        
        radioChoose.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:20))
        
        radioChoose.setTitle("\(so.poNumber)", for: UIControl.State());
        
        radioChoose.addTarget(self, action: #selector(logselectButtonPO), for: UIControl.Event.touchUpInside);
        
        
        
        date.frame = CGRect(x:radioChoose.frame.origin.x + Common.Size(s:150) ,y: Common.Size(s:10),width: radioChoose.frame.size.width ,height: Common.Size(s:20))
        date.text = so.date
        
        
        
    }
    
    @objc @IBAction fileprivate func logselectButtonPO(_ radioButton : DLRadioButton) {
        
        
        if (radioButton.isMultipleSelectionEnabled) {
            if(radioButton == radioChoose){
                //radioButton.isSelected = true
                if(radioChoose.isSelected == true){
                    print("true")
                    
                    delegate?.tabChoosePO(poNum: (so1?.poNumber)!,isWas: true)
                    print("\((so1?.poNumber)!)")
                    
                }else{
                    delegate?.tabChoosePO(poNum: (so1?.poNumber)!,isWas: false)
                    print("false")
                }
            }
            
        }
    }
    
    
}
