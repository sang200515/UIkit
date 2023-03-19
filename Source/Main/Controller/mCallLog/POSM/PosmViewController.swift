//
//  PosmViewController.swift
//  fptshop
//
//  Created by Ngo Dang tan on 7/22/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import FZAccordionTableView
struct Posm{
    var titleHeader:String
    let lstPosmItem:[WorkPosm]
}


class PosmViewController: UIViewController {
    var listPosm = [Posm]()
    var tableView: FZAccordionTableView!
    var cellHeight: CGFloat = 0
    var btnBack: UIBarButtonItem!
    override func viewDidLoad() {
        self.title = "Danh sách công việc"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.frame = CGRect(x: 0, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btnBack = UIBarButtonItem(customView: btBackIcon)
        self.navigationItem.leftBarButtonItems = [btnBack]
      
        
     
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.subviews.forEach { $0.removeFromSuperview() }
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        
        mCallLogApiManager.mCallLog_DanhSachCongViec_GetRequest() { [weak self](results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    self.listPosm.removeAll()
                    self.listPosm.append(Posm(titleHeader: "Báo cáo hình ảnh POSM", lstPosmItem: results!))
                    self.setUpView()
                    
                    
                }else{
              
                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                }
            }
        }
        
    }
    func setUpView() {
        tableView = FZAccordionTableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.initialOpenSections = Set([0])
        tableView.register(PosmViewItemCell.self, forCellReuseIdentifier: "PosmViewItemCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
   
        
        
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
class PosmViewItemCell: UITableViewCell {
    
    var lbCallLog: UILabel!
    var lbEmployeeTitle: UILabel!
    var lbStatusTitle: UILabel!
    var lbDateTitle: UILabel!
    
    
    var lbEmployeeValue: UILabel!
    var lbStatusValue: UILabel!
    var lbDateValue: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item: WorkPosm) {
        self.subviews.forEach({$0.removeFromSuperview()})
        
        
        lbCallLog = UILabel(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: self.frame.width - Common.Size(s:20), height: Common.Size(s: 30)))
        lbCallLog.text = "\(item.RequestTitle)"
        lbCallLog.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbCallLog.backgroundColor = UIColor.init(netHex: 0xEEEEEE)
        lbCallLog.textColor = .black
        self.addSubview(lbCallLog)
        
        lbEmployeeTitle = UILabel(frame: CGRect(x: lbCallLog.frame.origin.x, y: lbCallLog.frame.size.height + lbCallLog.frame.origin.y + Common.Size(s:10), width: lbCallLog.frame.size.width/2.5, height: Common.Size(s: 20)))
        lbEmployeeTitle.text = "Người phân công"
        lbEmployeeTitle.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbEmployeeTitle.textColor = .black
        self.addSubview(lbEmployeeTitle)
        
        lbEmployeeValue = UILabel(frame: CGRect(x: lbEmployeeTitle.frame.size.width + lbEmployeeTitle.frame.origin.x, y: lbEmployeeTitle.frame.origin.y, width: lbCallLog.frame.size.width, height: Common.Size(s: 20)))
        lbEmployeeValue.text = "\(item.AssignerName)"
        lbEmployeeValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbEmployeeValue.textColor = .black
        lbEmployeeValue.textAlignment = .left
        self.addSubview(lbEmployeeValue)
        
        
        
        lbStatusTitle = UILabel(frame: CGRect(x: lbCallLog.frame.origin.x, y: lbEmployeeTitle.frame.size.height + lbEmployeeTitle.frame.origin.y + Common.Size(s:10), width: lbEmployeeTitle.frame.size.width, height: Common.Size(s: 20)))
        lbStatusTitle.text = "Trạng thái"
        lbStatusTitle.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbStatusTitle.textColor = .black
        self.addSubview(lbStatusTitle)
        
        lbStatusValue = UILabel(frame: CGRect(x: lbStatusTitle.frame.size.width + lbStatusTitle.frame.origin.x, y: lbStatusTitle.frame.origin.y, width: lbCallLog.frame.size.width, height: Common.Size(s: 20)))
        //lbStatusValue.text = "\(item.Status)"
        lbStatusValue.attributedText = "\(item.Status)".convertHtmlToNSAttributedString
        lbStatusValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        //lbStatusValue.textColor = UIColor(netHex:0x00955E)
        lbStatusValue.textAlignment = .left
        self.addSubview(lbStatusValue)
        
        lbDateTitle = UILabel(frame: CGRect(x: lbCallLog.frame.origin.x, y: lbStatusTitle.frame.size.height + lbStatusTitle.frame.origin.y + Common.Size(s:10), width: lbEmployeeTitle.frame.size.width, height: Common.Size(s: 20)))
        lbDateTitle.text = "Ngày yêu cầu"
        lbDateTitle.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbDateTitle.textColor = .black
        self.addSubview(lbDateTitle)
        
        
        lbDateValue = UILabel(frame: CGRect(x: lbDateTitle.frame.size.width + lbDateTitle.frame.origin.x, y: lbDateTitle.frame.origin.y, width: lbCallLog.frame.size.width, height: Common.Size(s: 20)))
        lbDateValue.text = "\(item.CreateDateTime)"
        lbDateValue.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbDateValue.textColor = .black
        lbDateValue.textAlignment = .left
        self.addSubview(lbDateValue)
        
        if !(item.CreateDateTime.isEmpty) {
            let dateStrOld = item.CreateDateTime
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            lbDateValue.text = str
        } else {
            lbDateValue.text = item.CreateDateTime
        }
        
        let lbTinhTrangDuyetTitle = UILabel(frame: CGRect(x: lbCallLog.frame.origin.x, y: lbDateTitle.frame.size.height + lbDateTitle.frame.origin.y + Common.Size(s:10), width: lbEmployeeTitle.frame.size.width, height: Common.Size(s: 20)))
         lbTinhTrangDuyetTitle.text = "Tình trạng duyệt"
         lbTinhTrangDuyetTitle.font = UIFont.systemFont(ofSize: Common.Size(s:14))
         lbTinhTrangDuyetTitle.textColor = .black
         self.addSubview(lbTinhTrangDuyetTitle)
         
         let lbTinhTrangDuyetValue = UILabel(frame: CGRect(x: lbTinhTrangDuyetTitle.frame.size.width + lbTinhTrangDuyetTitle.frame.origin.x, y: lbTinhTrangDuyetTitle.frame.origin.y, width: lbCallLog.frame.size.width, height: Common.Size(s: 20)))
         //lbStatusValue.text = "\(item.Status)"
         lbTinhTrangDuyetValue.attributedText = "\(item.StatusApprove)".convertHtmlToNSAttributedString
         lbTinhTrangDuyetValue.font = UIFont.systemFont(ofSize: Common.Size(s:14))
     
         lbTinhTrangDuyetValue.textAlignment = .left
         self.addSubview(lbTinhTrangDuyetValue)
         
         estimateCellHeight = lbTinhTrangDuyetTitle.frame.origin.y + lbTinhTrangDuyetTitle.frame.height + Common.Size(s: 5)

        
     
        
    }
}
extension PosmViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPosm[section].lstPosmItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PosmViewItemCell = tableView.dequeueReusableCell(withIdentifier: "PosmViewItemCell", for: indexPath) as! PosmViewItemCell
        
        let item = listPosm[indexPath.section].lstPosmItem[indexPath.row]
        cell.setUpCell(item: item)
        cell.selectionStyle = .none
        self.cellHeight = cell.estimateCellHeight
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Common.Size(s:32)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let viewHeader = FZAccordionTableViewHeaderView(frame: CGRect(x:0,y: 0,width: tableView.frame.size.width,height: Common.Size(s:38)))
        let view = UIView(frame: CGRect(x:0,y: 0,width: tableView.frame.size.width,height: viewHeader.frame.size.height))
     
        viewHeader.addSubview(view)
        view.backgroundColor = UIColor.white
        
        let icon = UIImageView(frame: CGRect(x: Common.Size(s:10), y:  0,width:view.frame.size.height/2, height:  view.frame.size.height))
        icon.contentMode = UIView.ContentMode.scaleAspectFit
        view.addSubview(icon)
        icon.image = #imageLiteral(resourceName: "dropdown")
        
        let lbTitleHeader = UILabel(frame: CGRect(x: icon.frame.origin.x + icon.frame.size.width + Common.Size(s:10), y: Common.Size(s:10), width: view.frame.size.width, height: Common.Size(s: 20)))
        lbTitleHeader.text = listPosm[section].titleHeader
        lbTitleHeader.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 14))
        lbTitleHeader.textColor = UIColor(netHex:0x00955E)
        view.addSubview(lbTitleHeader)
        return viewHeader
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return self.tableView(tableView, heightForHeaderInSection:section)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:WorkPosm = listPosm[indexPath.section].lstPosmItem[indexPath.row]
        let newViewController = PosmDetailViewController()
        newViewController.posmItem = item
        self.navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
}
extension PosmViewController : FZAccordionTableViewDelegate {
    
    func tableView(_ tableView: FZAccordionTableView, willOpenSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
    }
    
    func tableView(_ tableView: FZAccordionTableView, didOpenSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
    }
    
    func tableView(_ tableView: FZAccordionTableView, willCloseSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, didCloseSection section: Int, withHeader header: UITableViewHeaderFooterView?) {
        
    }
    
    func tableView(_ tableView: FZAccordionTableView, canInteractWithHeaderAtSection section: Int) -> Bool {
        return true
    }
}
