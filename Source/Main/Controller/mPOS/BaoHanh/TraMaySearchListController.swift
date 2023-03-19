//
//  TraMaySearchListController.swift
//  mPOS
//
//  Created by sumi on 8/23/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import UIKit

class TraMaySearchListController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    var arrPhieuBH:[TraMay_LoadThongTinPhieuTraKHResult]?
    var countRow:Int = 0
    var thuHoSearchView:ThuHoSearchView!
    var mProvideFTel:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Tìm Kiếm"
        
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(netHex:0x47B054)
        
        thuHoSearchView = ThuHoSearchView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        self.view.addSubview(thuHoSearchView)
        
        self.thuHoSearchView.tableViewSearchTenKH.register(ItemSearchKHFTelTableViewCell.self, forCellReuseIdentifier: "ItemSearchKHFTelTableViewCell")
        self.thuHoSearchView.tableViewSearchTenKH.dataSource = self
        self.thuHoSearchView.tableViewSearchTenKH.delegate = self
        
        
        
        
        
        
    }
    @objc func backButton(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countRow = (arrPhieuBH?.count)!
        print("rowwww \(countRow)")
        return countRow
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellSearch: ItemSearchTraMayTableViewCell?
        cellSearch = ItemSearchTraMayTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSearchTraMayTableViewCell")
        
        if((arrPhieuBH?.count)! > 0 )
        {
            
            cellSearch?.name.text =  "\(arrPhieuBH![indexPath.row].TenKH)";
            cellSearch?.maHD.text =  "\(arrPhieuBH![indexPath.row].TenSanPham)";
            
            cellSearch?.tenDV.text = "\(arrPhieuBH![indexPath.row].MaPhieuBH)";
            cellSearch?.nhaCC.text = "\(arrPhieuBH![indexPath.row].Imei)";
            
        }
        return cellSearch!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        return (Common.Size(s:16)) * 2.4 * 2;
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newViewController = TraMayGetInfoController()
        newViewController.mSoDH = arrPhieuBH?[indexPath.row].MaPhieuBH
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
        
    }
    
}

class ItemSearchTraMayTableViewCell: UITableViewCell {
    var mDiaChi: UILabel!
    var name: UILabel!
    var maHD: UILabel!
    var tenDV: UILabel!
    var nhaCC: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(name)
        
        mDiaChi = UILabel()
        mDiaChi.textColor = UIColor.gray
        
        mDiaChi.numberOfLines = 0
        mDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        mDiaChi.numberOfLines = 0
        
        mDiaChi.lineBreakMode = .byWordWrapping;
        contentView.addSubview(mDiaChi)
        
        
        maHD = UILabel()
        maHD.textColor = UIColor.gray
        maHD.numberOfLines = 1
        maHD.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(maHD)
        
        
        
        tenDV = UILabel()
        tenDV.textColor = UIColor.black
        tenDV.numberOfLines = 1
        tenDV.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(tenDV)
        
        
        
        nhaCC = UILabel()
        nhaCC.numberOfLines = 1
        nhaCC.textColor = UIColor.red
        nhaCC.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(nhaCC)
        
        name.frame = CGRect(x: Common.Size(s:15),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        
        
        maHD.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:10))
        
        
        mDiaChi.frame = CGRect(x:maHD.frame.origin.x ,y: maHD.frame.origin.y + maHD.frame.size.height + Common.Size(s: 5)  ,width: maHD.frame.size.width ,height: Common.Size(s:13) * 3)
        
        let line1 = UIView(frame: CGRect(x: mDiaChi.frame.origin.x, y:mDiaChi.frame.origin.y , width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        
        
        tenDV.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        
        
        
        
        
        nhaCC.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3 * 2,height:line1.frame.size.height)
    }
    
    
    
}

class ItemSearchKHFTelTableViewCell: UITableViewCell {
    var mDiaChi: UILabel!
    var name: UILabel!
    var maHD: UILabel!
    var tenDV: UILabel!
    
    var nhaCC: UILabel!
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        name = UILabel()
        name.textColor = UIColor.black
        name.numberOfLines = 1
        name.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        contentView.addSubview(name)
        
        mDiaChi = UILabel()
        mDiaChi.textColor = UIColor.gray
        
        mDiaChi.numberOfLines = 0
        mDiaChi.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        
        mDiaChi.numberOfLines = 0
        
        mDiaChi.lineBreakMode = .byWordWrapping;
        contentView.addSubview(mDiaChi)
        
        
        maHD = UILabel()
        maHD.textColor = UIColor.gray
        maHD.numberOfLines = 1
        maHD.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(maHD)
        
        
        
        tenDV = UILabel()
        tenDV.textColor = UIColor.black
        tenDV.numberOfLines = 1
        tenDV.font = UIFont.boldSystemFont(ofSize: Common.Size(s:11))
        contentView.addSubview(tenDV)
        
        
        
        nhaCC = UILabel()
        nhaCC.numberOfLines = 1
        nhaCC.textColor = UIColor.red
        nhaCC.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        contentView.addSubview(nhaCC)
        
        name.frame = CGRect(x: Common.Size(s:15),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        
        
        maHD.frame = CGRect(x:name.frame.origin.x ,y: name.frame.origin.y + name.frame.size.height +  Common.Size(s:5),width: name.frame.size.width ,height: Common.Size(s:10))
        
        
        mDiaChi.frame = CGRect(x:maHD.frame.origin.x ,y: maHD.frame.origin.y + maHD.frame.size.height  ,width: maHD.frame.size.width ,height: Common.Size(s:13) * 3)
        
        let line1 = UIView(frame: CGRect(x: mDiaChi.frame.origin.x, y:mDiaChi.frame.origin.y + mDiaChi.frame.size.height + Common.Size(s:5), width: 1, height: Common.Size(s:16)))
        line1.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line1)
        
        let line2 = UIView(frame: CGRect(x: UIScreen.main.bounds.size.width/3 + Common.Size(s:10), y:line1.frame.origin.y, width: 1, height: Common.Size(s:16)))
        line2.backgroundColor = UIColor(netHex:0x47B054)
        contentView.addSubview(line2)
        
        
        
        tenDV.frame = CGRect(x:line1.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3,height:line1.frame.size.height)
        
        
        
        
        
        nhaCC.frame = CGRect(x:line2.frame.origin.x + Common.Size(s:5),y: line1.frame.origin.y ,width: name.frame.size.width/3 * 2,height:line1.frame.size.height)
    }
    
    
    
}

