//
//  NhapHangViewHistoryViewController.swift
//  mPOS
//
//  Created by tan on 8/24/18.
//  Copyright © 2018 MinhDH. All rights reserved.
//

import Foundation

import PopupDialog
class NhapHangViewHistoryViewController: UIViewController,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate{
    
    var scrollView:UIScrollView!
    var tfSearch:SearchTextField!
    
    var listGroupNCC:[GroupNCCHistory] = []
    var viewTableSimBook:UITableView  =   UITableView()
    
    
    override func viewDidLoad() {
        scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: self.view.frame.size.height  - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView)
        self.title = "Lịch sử nhập hàng"
        
        //
        //        tfImei = UITextField(frame: CGRect(x: Common.Size(s:15), y: Common.Size(s:10), width: scrollView.frame.size.width - Common.Size(s:80) , height: Common.Size(s:40)));
        //        tfImei.placeholder = "Tìm "
        //        tfImei.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        //        tfImei.borderStyle = UITextBorderStyle.roundedRect
        //        tfImei.autocorrectionType = UITextAutocorrectionType.no
        //        tfImei.keyboardType = UIKeyboardType.default
        //        tfImei.returnKeyType = UIReturnKeyType.done
        //        tfImei.clearButtonMode = UITextFieldViewMode.whileEditing;
        //        tfImei.delegate = self
        //        scrollView.addSubview(tfImei)
        //        tfImei.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingDidEnd)
        
        
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy lịch sử nhập hàng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
         MPOSAPIManager.getHistoryNhapHang() { (results, err) in
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    
                    
                    var pos: [String:[LichSuNhapPO]] = [:]
                    for item in results {
                        if var val:[LichSuNhapPO] = pos["\(item.CardName)"] {
                            val.append(item)
                            pos.updateValue(val, forKey: "\(item.CardName)")
                        } else {
                            var arr: [LichSuNhapPO] = []
                            arr.append(item)
                            pos.updateValue(arr, forKey: "\(item.CardName)")
                        }
                    }
                    
                    
                    self.parsePONCC(pos: pos)
                    self.setupUI(list: self.listGroupNCC)
                    
                }else{
                    
                    self.showDialog(message: err)
                
                }
            }
        }
        
        
    }
    
    func setupUI(list: [GroupNCCHistory]){
        let width:CGFloat = UIScreen.main.bounds.size.width
        
        viewTableSimBook.frame = CGRect(x: 0, y: Common.Size(s: 5), width: width, height: Common.Size(s: 800) )
        //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)
        viewTableSimBook.dataSource = self
        viewTableSimBook.delegate = self
        viewTableSimBook.register(ItemLichSuPOTableViewCell.self, forCellReuseIdentifier: "ItemLichSuPOTableViewCell")
        viewTableSimBook.tableFooterView = UIView()
        viewTableSimBook.backgroundColor = UIColor.white
        
        scrollView.addSubview(viewTableSimBook)
        navigationController?.navigationBar.isTranslucent = false
        
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableSimBook.frame.origin.y + viewTableSimBook.frame.size.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.listGroupNCC.count > 0){
            if !self.listGroupNCC[section].isExpand {
                return 0
            }
            return self.listGroupNCC[section].listPO.count
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = ItemLichSuPOTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemLichSuPOTableViewCell")
        
        let item:LichSuNhapPO = self.listGroupNCC[indexPath.section].listPO[indexPath.row]
        cell.setup(so: item)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //        let label = UILabel()
        //        if(self.listGroupNCC.count > 0){
        //            label.text = "\(self.listGroupNCC[section].nccName)"
        //        }
        //
        //        label.textColor = UIColor.white
        //        label.font = UIFont.boldSystemFont(ofSize: Common.Size(s:13))
        //        label.backgroundColor = UIColor(netHex:0x47B054)
        //
        //        label.numberOfLines = 0
        //        label.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        //        label.minimumScaleFactor = 0.8
        //
        //        let tapImei = UITapGestureRecognizer(target: self, action: #selector(handlerExpand))
        //        label.isUserInteractionEnabled = true
        //        label.addGestureRecognizer(tapImei)
        //
        //
        //        label.tag = section
        
        let label = UIButton()
        if(self.listGroupNCC.count > 0){
            
            
            label.setTitle("\(self.listGroupNCC[section].nccName)", for: .normal)
        }
        
        label.setTitleColor( UIColor.white, for: .normal)
        //label.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        label.backgroundColor = UIColor(netHex:0x47B054)
        label.contentHorizontalAlignment = .left
        
        label.titleLabel?.numberOfLines = 2
        label.titleLabel?.lineBreakMode = .byWordWrapping // or .byWrappingWord
        
        label.titleLabel?.font = label.titleLabel?.font.withSize(14)
        label.addTarget(self, action: #selector(handlerExpand), for: .touchUpInside)
        
        label.tag = section
        
        
        return label
    }
    @objc func handlerExpand(label: UILabel){
        print("Trying to expand and close section...")
        
        let section = label.tag
        
        // we'll try to close the section first by deleting the rows
        var indexPaths = [IndexPath]()
        for row in self.listGroupNCC[section].listPO.indices {
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = self.listGroupNCC[section].isExpand
        self.listGroupNCC[section].isExpand = !isExpanded
        
        //button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded {
            self.viewTableSimBook.deleteRows(at: indexPaths, with: .fade)
        } else {
            self.viewTableSimBook.insertRows(at: indexPaths, with: .fade)
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listGroupNCC.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return Common.Size(s:180);
    }
    
    
    func parsePONCC(pos: [String:[LichSuNhapPO]]){
        for item in pos{
            let lichsu:GroupNCCHistory = GroupNCCHistory(nccName: "", listPO: [],isExpand: true)
            
            
            lichsu.nccName = item.key
            lichsu.listPO = item.value
            
            self.listGroupNCC.append(lichsu)
            
        }
        
        // parse group po//bgjlhftui
        
    }
    
    @objc func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
    
}


class ItemLichSuPOTableViewCell: UITableViewCell {
    var poNum: UILabel!
    var tenSanPham: UILabel!
    var SLDat: UILabel!
    var SLNhap: UILabel!
    var imei: UILabel!
    var NgayNhap:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        poNum = UILabel()
        poNum.textColor = UIColor.black
        poNum.numberOfLines = 1
        poNum.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        contentView.addSubview(poNum)
        
        tenSanPham = UILabel()
        tenSanPham.textColor = UIColor.red
        tenSanPham.numberOfLines = 1
        tenSanPham.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        
        
        tenSanPham.numberOfLines = 0
        tenSanPham.lineBreakMode = .byTruncatingTail // or .byWrappingWord
        tenSanPham.minimumScaleFactor = 0.8
        contentView.addSubview(tenSanPham)
        
        SLDat = UILabel()
        SLDat.textColor = UIColor.black
        SLDat.numberOfLines = 1
        SLDat.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        contentView.addSubview(SLDat)
        
        
        SLNhap = UILabel()
        SLNhap.textColor = UIColor.black
        SLNhap.numberOfLines = 1
        SLNhap.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        contentView.addSubview(SLNhap)
        
        imei = UILabel()
        imei.textColor = UIColor.black
        imei.numberOfLines = 1
        imei.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        contentView.addSubview(imei)
        
        NgayNhap = UILabel()
        NgayNhap.textColor = UIColor.black
        NgayNhap.numberOfLines = 1
        NgayNhap.font = UIFont.boldSystemFont(ofSize: Common.Size(s:10))
        contentView.addSubview(NgayNhap)
        
        
        
    }
    var so1:LichSuNhapPO?
    func setup(so:LichSuNhapPO){
        so1 = so
        
        poNum.frame = CGRect(x: Common.Size(s: 10),y: Common.Size(s:10) ,width: UIScreen.main.bounds.size.width - Common.Size(s: 10) ,height: Common.Size(s:16))
        poNum.text = "PO: \(so.PONum)"
        
        
        tenSanPham.frame = CGRect(x: Common.Size(s: 10),y: poNum.frame.origin.y + poNum.frame.size.height,width: UIScreen.main.bounds.size.width - Common.Size(s: 20)  ,height: Common.Size(s:60))
        tenSanPham.text = "\(so.ItemName)"
        
        
        SLDat.frame = CGRect(x: Common.Size(s: 10),y: tenSanPham.frame.origin.y + tenSanPham.frame.size.height ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        SLDat.text = "SL đặt: \(so.SLPO)"
        
        SLNhap.frame = CGRect(x: Common.Size(s: 10),y: SLDat.frame.origin.y + SLDat.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:16))
        SLNhap.text = "SL nhập: \(so.SLNhap)"
        
        
        
        imei.frame = CGRect(x: Common.Size(s: 10),y: SLNhap.frame.origin.y + SLNhap.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        imei.text = "Imei: \(so.IMEI)"
        
        NgayNhap.frame = CGRect(x: Common.Size(s: 10),y: imei.frame.origin.y + imei.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width ,height: Common.Size(s:16))
        NgayNhap.text = "Ngày Nhập: \(so.Gio)"
        
    }
    
    
    
    
}


