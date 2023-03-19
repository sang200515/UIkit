//
//  PopUpPickColorView.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
private let reuseIdentifier = "PlansGalaxyPayCell"
class PopUpGalaxyPay: UIViewController {
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    private var myTargetView:UIView?
    private var myViewController:UIViewController?
    private var parameDetailImages:[ParameDetailImage]?
    private var tableView = UITableView()
    private var listPlans = [GalaxyPlayPlans]()
    
    func showAlert(with title:String, on viewController: UIViewController,plans:[GalaxyPlayPlans]){
        guard let targetView = viewController.view else{
            return
        }
        backgroundView.frame = targetView.bounds
        myTargetView = targetView
        myViewController = viewController
        listPlans = plans
        
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -250, width: targetView.frame.size.width - 80, height: 200)
        
        let viewTitle = UIView(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 40))
        viewTitle.backgroundColor = UIColor(netHex:0x00955E)
        alertView.addSubview(viewTitle)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 10, width: alertView.frame.size.width, height: 20))
        titleLabel.text = title
        titleLabel.font = UIFont.boldFont(size: Common.Size(s: 15))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        viewTitle.addSubview(titleLabel)
        

        tableView = UITableView(frame: CGRect(x:10 , y: viewTitle.frame.size.height + viewTitle.frame.origin.y + 10, width: alertView.frame.size.width - 16, height: Common.Size(s:35) * 2 ))
        tableView.register(PlansGalaxyPayCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        alertView.addSubview(tableView)
        
        let btComplete = Common.buttonAction(x: alertView.frame.size.width/3.2, y: tableView.frame.origin.y + tableView.frame.size.height + Common.Size(s:5) , width: 120, height: 40, title: "Đóng")
        btComplete.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(btComplete)
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        },completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    //self.alertView.center = targetView.center
                    self.alertView.frame.origin.y = targetView.frame.size.width/1.8
                })
            }
        })
        
        
    }
    
    @objc func dismissAlert(){
        guard let targetView = myTargetView else{return}
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 300)
        },completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                },completion: {done in
                    if done{
                        
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                    
                } )
            }
        })
    }
  
}
    
    // MARK: - UITableViewDelegate - UITableViewDataSource
extension PopUpGalaxyPay: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPlans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:PlansGalaxyPayCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! PlansGalaxyPayCell
        let item = listPlans[indexPath.row]
        
        cell.setUpCell(item: item)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
class PlansGalaxyPayCell: UITableViewCell {
    
    var lbTitleGoiCuoc:UILabel!
    var lbNgayDK:UILabel!
    var lnNgayHetHan:UILabel!
    func setUpCell(item: GalaxyPlayPlans) {
        
        self.subviews.forEach({$0.removeFromSuperview()})
        
        lbTitleGoiCuoc = Common.tileLabel(x: 0, y: 0, width: frame.size.width, height: 16, title: item.productName, fontSize: Common.Size(s:12),isBoldStyle: true)
        lbTitleGoiCuoc.textAlignment = .center
        self.addSubview(lbTitleGoiCuoc)
        
        
        lbNgayDK = Common.tileLabel(x: 0, y: lbTitleGoiCuoc.frame.size.height + lbTitleGoiCuoc.frame.origin.y + Common.Size(s:10), width: frame.size.width, height: 16, title: item.startAt, fontSize: Common.Size(s:12))
        lbNgayDK.textAlignment = .center
        self.addSubview(lbNgayDK)
        
        
        lnNgayHetHan = Common.tileLabel(x: 0, y: lbNgayDK.frame.size.height + lbNgayDK.frame.origin.y + Common.Size(s: 10), width: frame.size.width, height: 16, title: item.expireAt, fontSize: Common.Size(s:12))
        lnNgayHetHan.textAlignment = .center
        self.addSubview(lnNgayHetHan)
        
        if !(item.startAt.isEmpty) {
            let dateStrOld = item.startAt
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            lbNgayDK.text = "Ngày Đăng Ký: \(str)"
        } else {
            lbNgayDK.text = item.startAt
        }
        if !(item.expireAt.isEmpty) {
            let dateStrOld = item.expireAt
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            let str = newFormatter.string(from: date2 ?? Date())
            lnNgayHetHan.text = "Ngày Hết Hạn: \(str)"
        } else {
            lnNgayHetHan.text = item.startAt
        }
        
        
    }
    
    
}


