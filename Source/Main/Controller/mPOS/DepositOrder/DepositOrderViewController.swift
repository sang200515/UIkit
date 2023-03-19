//
//  DepositOrderViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/18/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import PopupDialog
import Toaster
class DepositOrderViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    var tableView: UITableView  =   UITableView()
    var items: [DepositInfo] = []
    var parentNavigationController : UINavigationController?
    var parentTabBarController: UITabBarController?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đơn hàng đặt cọc"
        self.view.backgroundColor = .white
        
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(DepositOrderViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        tableView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemDepositInfoTableViewCell.self, forCellReuseIdentifier: "ItemDepositInfoTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Common.Size(s:110)
        self.view.addSubview(tableView)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang tải danh sách đơn hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.getThongTinDatCoc(userCode: "\(Cache.user!.UserName)", shopCode: "\(Cache.user!.ShopCode)") { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                self.items = results
                if(results.count <= 0){
                    TableViewHelper.EmptyMessage(message: "Không có đơn hàng.\n:/", viewController: self.tableView)
                }else{
                    TableViewHelper.removeEmptyMessage(viewController: self.tableView)
                }
                self.tableView.reloadData()
            }
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let item:DepositInfo = items[indexPath.row]
        if let url = URL(string: "tel://\(item.SDT)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemDepositInfoTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemDepositInfoTableViewCell")
        let item:DepositInfo = items[indexPath.row]
        cell.title.text = "\(item.TenKH)"
        
        cell.product.text = "SP: \(item.TenSP)"
        cell.amount.text = "Số lượng: \(item.SL)"
        cell.soPOS.text = "Số ĐH: \(item.SoDH_POS)"
        cell.phone.text = "\(item.SDT)"
        if(item.NgayDatCoc != ""){
            let dateFormatter = DateFormatter()
            let tempLocale = dateFormatter.locale
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
            let date = dateFormatter.date(from: "\(item.NgayDatCoc)")!
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateFormatter.locale = tempLocale
            let dateString = dateFormatter.string(from: date)
            cell.soDate.text = "Ngày: \(dateString)"
        }else{
            cell.soDate.text = "Ngày: ..."
        }
        cell.selectionStyle = .none
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    //    {
    //        return Common.Size(s:110);
    //    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
class ItemDepositInfoTableViewCell: UITableViewCell {
    var phone = UILabel()
    var amount = UILabel()
    var viewBottom = UIView()
    var line1 = UIView()
    
    var line2 = UIView()
    var line3 = UIView()
    var soPOS = UILabel()
    var soDate = UILabel()
    
    let title = UILabel()
    let product = UILabel()
    var iconPhone = UIImageView()
    
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure titleLabel
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        title.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        title.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        
        // configure authorLabel
        contentView.addSubview(product)
        product.translatesAutoresizingMaskIntoConstraints = false
        product.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        //        product.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        product.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        product.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Common.Size(s:5)).isActive = true
        product.numberOfLines = 0
        product.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        product.textColor = UIColor.darkGray
        
        contentView.addSubview(viewBottom)
        viewBottom.translatesAutoresizingMaskIntoConstraints = false
        viewBottom.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        viewBottom.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        viewBottom.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        viewBottom.topAnchor.constraint(equalTo: product.bottomAnchor, constant: Common.Size(s:5)).isActive = true
        
        //        viewBottom.backgroundColor = .red
        
        line1.frame = CGRect(x: 0, y:Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        viewBottom.addSubview(line1)
        line2.frame = CGRect(x: UIScreen.main.bounds.size.width/2 - Common.Size(s:20) , y:Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        viewBottom.addSubview(line2)
        
        viewBottom.addSubview(amount)
        amount.frame = CGRect(x: line1.frame.origin.x + line1.frame.size.width + Common.Size(s: 3),y: line1.frame.origin.y,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:25) ,height: line2.frame.size.height)
        amount.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        amount.textColor = UIColor.black
        
        viewBottom.addSubview(soPOS)
        soPOS.frame = CGRect(x: line2.frame.origin.x + line2.frame.size.width + Common.Size(s: 3),y: line2.frame.origin.y,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:25) ,height: line2.frame.size.height)
        soPOS.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        soPOS.textColor = UIColor.black
        
        line3.frame = CGRect(x: 0, y: line1.frame.size.height + line1.frame.origin.y + Common.Size(s:5), width: Common.Size(s:1), height: Common.Size(s:16))
        line3.backgroundColor = UIColor(netHex:0x47B054)
        viewBottom.addSubview(line3)
        
        viewBottom.addSubview(soDate)
        soDate.frame = CGRect(x: line3.frame.origin.x + line3.frame.size.width + Common.Size(s: 3),y: line3.frame.origin.y,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:25) ,height: line2.frame.size.height)
        soDate.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        soDate.textColor = UIColor.black
        
        viewBottom.heightAnchor.constraint(equalToConstant: line3.frame.size.height + line3.frame.origin.y).isActive = true
        
        iconPhone.frame =  CGRect(x: line2.frame.origin.x - line3.frame.size.height/2, y: line3.frame.origin.y, width: line3.frame.size.height, height: line3.frame.size.height)
        iconPhone.image = #imageLiteral(resourceName: "Phone-50")
        iconPhone.contentMode = .scaleAspectFit
        
        
        viewBottom.addSubview(phone)
        phone.frame = CGRect(x: iconPhone.frame.origin.x + iconPhone.frame.size.width + Common.Size(s: 3),y: line3.frame.origin.y,width: UIScreen.main.bounds.size.width/2 - Common.Size(s:25) ,height: line2.frame.size.height)
        phone.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        phone.textColor = UIColor(netHex:0x0645AD)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
