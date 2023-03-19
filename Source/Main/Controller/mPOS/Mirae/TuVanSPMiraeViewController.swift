//
//  TuVanSPMiraeViewController.swift
//  fptshop
//
//  Created by tan on 6/28/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import PopupDialog
class TuVanSPMiraeViewController:  UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView  =   UITableView()
    var items: [SPTuVanMirae] = []
    
    var loading:NVActivityIndicatorView!
    var loadingView:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SP hỗ trợ"
        self.view.backgroundColor = .white
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.subviews.forEach { $0.removeFromSuperview() }
        
        loadingView  = UIView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        //UIApplication.shared.statusBarFrame.height + Cache.heightNav
        self.view.addSubview(loadingView)
        
        //loading
        let frameLoading = CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y:loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50))
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor(netHex:0x47B054)
        loading = NVActivityIndicatorView(frame: frameLoading,
                                          type: .ballClipRotateMultiple)
        loading.startAnimating()
        loadingView.addSubview(loading)
        
        var logo : UIImageView
        logo  = UIImageView(frame:CGRect(x: loadingView.frame.size.width/2 - Common.Size(s:25), y: loadingView.frame.height/2 - Common.Size(s:25), width: Common.Size(s:50), height: Common.Size(s:50)));
        logo.image = UIImage(named:"Cancel File-100")
        logo.contentMode = .scaleAspectFit
        loadingView.addSubview(logo)
        
        logo.isHidden = true
        
        let productNotFound = "Đang load danh sách SP"
        let lbNotFound = UILabel(frame: CGRect(x: 0, y: loading.frame.origin.y + loading.frame.size.height + Common.Size(s:10), width: UIScreen.main.bounds.size.width, height: Common.Size(s:22)))
        lbNotFound.textAlignment = .center
        lbNotFound.textColor = UIColor.lightGray
        lbNotFound.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        lbNotFound.text = productNotFound
        loadingView.addSubview(lbNotFound)
        MPOSAPIManager.mpos_FRT_SP_Mirae_DS_sanpham(handler: { (results, err) in
            if(results.count > 0){
                self.loading.stopAnimating()
                lbNotFound.isHidden = true
                self.items = results
                self.setupUI(list: results)
            }else{
                lbNotFound.text = "Không tìm thấy SP!"
                logo.isHidden = false
                lbNotFound.isHidden = false
                self.loading.stopAnimating()
            }
        })
    }
    func setupUI(list: [SPTuVanMirae]){
        tableView.frame = CGRect(x: 0, y:0, width: loadingView.frame.size.width, height: self.view.frame.size.height )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemSPTVMiraeTableViewCell.self, forCellReuseIdentifier: "ItemSPTVMiraeTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        
        loadingView.addSubview(tableView)
        navigationController?.navigationBar.isTranslucent = false
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemSPTVMiraeTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemSPTVMiraeTableViewCell")
        let item:SPTuVanMirae = items[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:80);
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    ////        if(Cache.indexRow != -1){
    ////            self.items.remove(at: Cache.indexRow)
    ////            tableView.reloadData()
    ////            Cache.indexRow = -1
    ////        }
    //    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class ItemSPTVMiraeTableViewCell: UITableViewCell {
    
    //
    var tenSP:UILabel!
    var gia:UILabel!

   
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        

        
        tenSP = UILabel()
        tenSP.textColor = UIColor.red
        tenSP.numberOfLines = 0
        tenSP.font = UIFont.boldSystemFont(ofSize: 13)
        
        tenSP = UILabel()
        tenSP.textColor = UIColor.black
  
        
        contentView.addSubview(tenSP)
        
        gia = UILabel()
        gia.textColor = UIColor.black
        gia.numberOfLines = 0
        gia.font = UIFont.systemFont(ofSize: Common.Size(s:13))
        contentView.addSubview(gia)
        
 
        
 
    }
    var so1:SPTuVanMirae?
    func setup(so:SPTuVanMirae){
        so1 = so
        
    
        //idDK.text = "IDDK: \(so.IDDK)"
        
        tenSP.frame = CGRect(x: Common.Size(s:10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        tenSP.text = so.TenSP
        
        tenSP.lineBreakMode = .byWordWrapping
        tenSP.numberOfLines = 0
        tenSP.sizeToFit()
        
        gia.frame = CGRect(x: Common.Size(s:10),y: tenSP.frame.origin.y + tenSP.frame.size.height + Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s:20) ,height: Common.Size(s:16))
        gia.text = "SL: \(so.SLCoTheBan). Giá: \(Common.convertCurrency(value: so.DonGia))"
        
 
        
        
    }
    
    
}
