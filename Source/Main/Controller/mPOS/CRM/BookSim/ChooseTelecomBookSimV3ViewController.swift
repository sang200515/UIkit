//
//  ChooseTelecomBookSimV2.swift
//  fptshop
//
//  Created by tan on 2/22/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import NVActivityIndicatorView
import MIBadgeButton_Swift
class ChooseTelecomBookSimV3ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,ItemGoiCuocV3TableViewCellDelegate,UITextFieldDelegate{
    
    func tapXemChiTiet(goiCuocEcom: GoiCuocEcom) {
        
        let newViewController = DetailGoiCuocVC()
        for item2 in self.listCompany{
            if(item2.NhaMang == goiCuocEcom.Provider){
                self.telecom = item2
                break
            }
        }
        newViewController.telecom = self.telecom
        newViewController.goiCuocEcom = goiCuocEcom
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    var scrollView:UIScrollView!
    var listCompany:[ProviderName] = []
    var viewCardType: [UIView] = []
    var indexTypeCard:Int = 0
    var provider:String! = ""
    
    var barSearchRight : UIBarButtonItem!
    var telecomView:UIView!
    var collectionView: UICollectionView!
    var bottomTelecomView:UIView!
    var viewTableListGoiCuoc:UITableView  =   UITableView()
    var mobiStackView: UIStackView!
    var btnNormal: UIButton!
    var btnESim: UIButton!
    var listGoiCuoc:[GoiCuocEcom] = []
    var listGoiCuocFull:[GoiCuocEcom] = []
    var shops: [String:NSMutableArray] = [:]
    var telecom:ProviderName?
    var isNormal: Bool = true
    
    deinit {
        print("DEBUG: Deinit ChooseTelecomBookSimV3ViewController")
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.blue
        self.title = "Chọn nhà mạng"
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        //left menu icon
        let btLeftIcon = UIButton.init(type: .custom)
        
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.addTarget(self, action: #selector(ChooseTelecomBookSimV3ViewController.backButton), for: UIControl.Event.touchUpInside)
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        
        self.navigationItem.leftBarButtonItem = barLeft
        
        let btSearchIcon = UIButton.init(type: .custom)
        
        btSearchIcon.setImage(#imageLiteral(resourceName: "list"), for: UIControl.State.normal)
        btSearchIcon.imageView?.contentMode = .scaleAspectFit
        btSearchIcon.addTarget(self, action: #selector(ChooseTelecomBookSimV3ViewController.showListSimByShop), for: UIControl.Event.touchUpInside)
        btSearchIcon.frame = CGRect(x: 0, y: 0, width: 35, height: 51/2)
        barSearchRight = UIBarButtonItem(customView: btSearchIcon)
        
        self.navigationItem.rightBarButtonItems = [barSearchRight]
        
        scrollView = UIScrollView(frame: CGRect(x: CGFloat(0), y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height )
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy thông tin nhà mạng..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        
        MPOSAPIManager.FRT_SP_CRM_DSNhaMang_bookSim() {[weak self] (results, err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
//                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    MPOSAPIManager.sp_mpos_FRT_SP_SIM_loadDSGoiCuoc_ecom() { (results2, err) in
                        let when = DispatchTime.now() + 0.5
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            nc.post(name: Notification.Name("dismissLoading"), object: nil)
                            if(err.count <= 0){
                                var listCom: [String] = []
                                self.listCompany = results
                                for item in results {
                                    listCom.append("\(item.NhaMang)")
                                }
                                //parse goi cuoc
                                self.listGoiCuoc.removeAll()
                           
                                self.listGoiCuocFull.removeAll()
                                self.listGoiCuocFull = results2
                                self.listGoiCuoc = results2
                                 self.viewTableListGoiCuoc.reloadData()
                              
                                self.loadUI()
                            }else{
                        
                                self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                            }
                        }
                    }
                }else{
                     nc.post(name: Notification.Name("dismissLoading"), object: nil)
                    self.showPopUp(err, "Thông báo", buttonTitle: "OK")
                }
            }
        }
        
    }
    @objc func showListSimByShop(){
        let newViewController = DanhSachSimBookV2ViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func backButton(){
        _ = self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    func loadGoiCuoc(){
     
    }
    
    func loadUI(){
        let width:CGFloat = UIScreen.main.bounds.size.width
        
        // step 1
        let lbTep1 = UILabel(frame: CGRect(x:Common.Size(s:10), y: 0, width: width - Common.Size(s:20), height: Common.Size(s:35)))
        lbTep1.textAlignment = .left
        lbTep1.textColor = UIColor.black
        lbTep1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTep1.text = "Chọn nhà mạng"
        scrollView.addSubview(lbTep1)
        
        telecomView = UIView()
        telecomView.frame = CGRect(x: Common.Size(s: 2), y:lbTep1.frame.origin.y + lbTep1.frame.size.height , width: scrollView.frame.size.width, height: Common.Size(s: 60))
        telecomView.backgroundColor = UIColor.white
        scrollView.addSubview(telecomView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom:0, right: 0)
        layout.itemSize = CGSize(width: 111, height: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.telecomView.frame.width, height: self.telecomView.frame.height), collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ItemTelecomCollectionViewCellBookSim.self, forCellWithReuseIdentifier: "ItemTelecomCollectionViewCellBookSim")
        telecomView.addSubview(collectionView)
        collectionView.isScrollEnabled = false
        
        bottomTelecomView = UIView()
        
        bottomTelecomView.frame = CGRect(x: 0, y:telecomView.frame.origin.y + telecomView.frame.size.height, width: scrollView.frame.size.width, height: 0)
        bottomTelecomView.backgroundColor = UIColor.clear
        scrollView.addSubview(bottomTelecomView)
        
        let lbTep2 = UILabel(frame: CGRect(x:Common.Size(s:10), y: bottomTelecomView.frame.size.height + bottomTelecomView.frame.origin.y, width: width - Common.Size(s:20), height: Common.Size(s:35)))
        lbTep2.textAlignment = .left
        lbTep2.textColor = UIColor.black
        lbTep2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:15))
        lbTep2.text = "Gói cước"
        scrollView.addSubview(lbTep2)
        
        mobiStackView = UIStackView()
        mobiStackView.frame = CGRect(x: 20, y: lbTep2.frame.origin.y + lbTep2.frame.size.height, width: self.telecomView.frame.width - 40, height: 40)
        mobiStackView.axis = .horizontal
        mobiStackView.alignment = .fill
        mobiStackView.distribution = .fillEqually
        mobiStackView.spacing = 20
        
        btnNormal = UIButton()
        btnNormal.setTitle("SIM THƯỜNG", for: .normal)
        btnNormal.setTitleColor(.white, for: .normal)
        btnNormal.cornerRadius = 5
        btnNormal.borderWidth = 1
        btnNormal.borderColor = UIColor(hexString: "04AB6E")
        btnNormal.backgroundColor = UIColor(hexString: "04AB6E")
        btnNormal.addTarget(self, action: #selector(normalButtonAction), for: .touchUpInside)
        
        btnESim = UIButton()
        btnESim.setTitle("ESIM", for: .normal)
        btnESim.setTitleColor(UIColor(hexString: "04AB6E"), for: .normal)
        btnESim.cornerRadius = 5
        btnESim.borderWidth = 1
        btnESim.borderColor = UIColor(hexString: "04AB6E")
        btnESim.backgroundColor = .white
        btnESim.addTarget(self, action: #selector(esimButtonAction), for: .touchUpInside)
        
        mobiStackView.addArrangedSubview(btnNormal)
        mobiStackView.addArrangedSubview(btnESim)
        scrollView.addSubview(mobiStackView)
        mobiStackView.isHidden = true
        
        viewTableListGoiCuoc.frame = CGRect(x: Common.Size(s: 5), y: mobiStackView.frame.origin.y + mobiStackView.frame.size.height + 20, width: width - Common.Size(s:10), height: Common.Size(s: 360) )
        viewTableListGoiCuoc.dataSource = self
        viewTableListGoiCuoc.delegate = self
        viewTableListGoiCuoc.register(UINib(nibName: "BookSimTableViewCell", bundle: nil), forCellReuseIdentifier: "BookSimTableViewCell")
        viewTableListGoiCuoc.tableFooterView = UIView()
        viewTableListGoiCuoc.backgroundColor = UIColor.white
        
      
        navigationController?.navigationBar.isTranslucent = false
        scrollView.addSubview(viewTableListGoiCuoc)
        
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewTableListGoiCuoc.frame.origin.y + viewTableListGoiCuoc.frame.size.height + Common.Size(s: 100))
        
        
    }
    
    @objc func normalButtonAction() {
        isNormal = true
        btnNormal.setTitleColor(.white, for: .normal)
        btnESim.setTitleColor(UIColor(hexString: "04AB6E"), for: .normal)
        btnNormal.backgroundColor = UIColor(hexString: "04AB6E")
        btnESim.backgroundColor = .white
        
        self.listGoiCuoc.removeAll()
        for item in shops {
            if item.key == "Mobifone" {
                self.listGoiCuoc.append(contentsOf: (item.value as! [GoiCuocEcom]).filter { $0.PackageType == 1 })
            }
        }
        self.viewTableListGoiCuoc.reloadData()
    }
    
    @objc func esimButtonAction() {
        isNormal = false
        btnESim.setTitleColor(.white, for: .normal)
        btnNormal.setTitleColor(UIColor(hexString: "04AB6E"), for: .normal)
        btnESim.backgroundColor = UIColor(hexString: "04AB6E")
        btnNormal.backgroundColor = .white
        
        self.listGoiCuoc.removeAll()
        for item in shops {
            if item.key == "Mobifone" {
                self.listGoiCuoc.append(contentsOf: (item.value as! [GoiCuocEcom]).filter { $0.PackageType == 2 })
            }
        }
        self.viewTableListGoiCuoc.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGoiCuoc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = viewTableListGoiCuoc.dequeueReusableCell(withIdentifier: "BookSimTableViewCell", for: indexPath) as! BookSimTableViewCell
        let item:GoiCuocEcom = self.listGoiCuoc[indexPath.row]
        cell.setup(so: item)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
       
        let item:GoiCuocEcom = self.listGoiCuoc[indexPath.row]
      
		let newViewController = ChonSoV2ViewController()
        newViewController.itemCode = self.listGoiCuoc[indexPath.row].Code
        let goiCuoc:GoiCuocBookSimV2 = GoiCuocBookSimV2(MaSP:"",TenSP:"",GiaCuoc:0,DanhDauSS:false,isRule:false,tenKH:"")
        goiCuoc.TenSP = item.Name
        goiCuoc.GiaCuoc = item.Price
        goiCuoc.MaSP = item.Code
        for item2 in self.listCompany{
            if(item2.NhaMang == item.Provider){
                self.telecom = item2
                break
            }
        }
        newViewController.telecom = self.telecom
        newViewController.goiCuoc = goiCuoc
        newViewController.itemGoiCuocEcom = item
        debugPrint("pakagetype = \(item.PackageType)")
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}
extension ChooseTelecomBookSimV3ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCompany.count
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let it = listCompany[indexPath.item]
      
        if(it.id != -1){
            self.shops.removeAll()
            for i in 0..<listCompany.count{
                listCompany[i].isSelect = false
            }
            listCompany[indexPath.item].isSelect = true
            self.collectionView.reloadData()
        
            for item in self.listGoiCuocFull {
                if let val:NSMutableArray = self.shops["\(item.Provider)"] {
                    val.add(item)
                    self.shops.updateValue(val, forKey: "\(item.Provider)")
                } else {
                    let arr: NSMutableArray = NSMutableArray()
                    arr.add(item)
                    self.shops.updateValue(arr, forKey: "\(item.Provider)")
                }
            }
            print(self.shops)
            self.listGoiCuoc.removeAll()
            for item in shops{
                if(item.key == it.NhaMang){
                    if it.NhaMang == "Mobifone" {
                        self.listGoiCuoc.append(contentsOf: (item.value as! [GoiCuocEcom]).filter { $0.PackageType == (isNormal ? 1 : 2) })
                    } else {
                        self.listGoiCuoc.append(contentsOf: item.value as! [GoiCuocEcom])
                    }
                }
            }
            if it.NhaMang == "Mobifone" {
                mobiStackView.isHidden = false
            } else {
                mobiStackView.isHidden = true
            }
            self.viewTableListGoiCuoc.reloadData()
            
          
        }else{
         
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coCell: ItemTelecomCollectionViewCellBookSim = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemTelecomCollectionViewCellBookSim", for: indexPath) as! ItemTelecomCollectionViewCellBookSim
        let item = listCompany[indexPath.item]
        coCell.setUpCollectionViewCell(item: item)
        return coCell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = CGSize(width: self.view.frame.size.width/5, height: self.view.frame.size.width/5)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
      return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
class ItemTelecomCollectionViewCellBookSim: UICollectionViewCell {
    
    var icon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCollectionViewCell(item: ProviderName) {
        self.subviews.forEach({ $0.removeFromSuperview() })
        contentView.backgroundColor = UIColor.white
        
        let footer = UIView()
        footer.frame = CGRect(x: contentView.frame.width/2 - (contentView.frame.width * 8/10)/2, y: contentView.frame.height/2 - (contentView.frame.width * 8/10)/2, width: contentView.frame.width * 8/10, height: contentView.frame.width * 8/10)
        footer.backgroundColor = UIColor.white
        self.addSubview(footer)
        
        footer.layer.borderWidth = 1
        footer.layer.masksToBounds = false
        footer.layer.borderColor = UIColor(netHex: 0xDADADA).cgColor
        footer.layer.cornerRadius = footer.frame.height/2
        footer.clipsToBounds = true
        
        if(item.isSelect){
            footer.layer.borderWidth = 2
            footer.layer.borderColor = UIColor(netHex: 0x00955E).cgColor
        }
        
        icon = UIImageView()
        icon = UIImageView(frame: CGRect(x: footer.frame.width/2 - (footer.frame.width * 8/10)/2, y: footer.frame.width/2 - (footer.frame.width * 8/10)/2, width: footer.frame.width * 8/10, height: footer.frame.width * 8/10))
        icon.contentMode = .scaleAspectFit
        footer.addSubview(icon)
        if(item.NhaMang == "VietnamMobile"){
            icon.image = UIImage(named:"\("Vietnamobile")")
        }else{
            icon.image = UIImage(named:"\(item.NhaMang)")
        }
    }
    
}
protocol ItemGoiCuocV3TableViewCellDelegate:AnyObject {
    
    func tapXemChiTiet(goiCuocEcom:GoiCuocEcom)
}
class ItemGoiCuocV3TableViewCell: UITableViewCell {
    var tenGoiCuoc: UILabel!
    var data: UILabel!
    var dataunit:UILabel!
    var phiGoiNoiMang: UILabel!
    var phiGoiNoiMangUnit:UILabel!
    var phiGoiNgoaiMang: UILabel!
    var phiGoiNgoaiMangUnit:UILabel!
    
    var mienphi: UILabel!
    var khuyenmai: UILabel!
    var phigoi2:UILabel!
    var mienphimobi: UILabel!
    var xemchitiet: UILabel!
  
    var lblLine: UILabel!
    var icondata:UIImageView!
    var iconPhiGoiNoiManng: UIImageView!
    var iconPhiGoiNgoaiMang: UIImageView!
    var gia:UILabel!
    
    var iconmienphi: UIImageView!
    var iconCheckKM:UIImageView!
    var iconPhiGoi2:UIImageView!
    var iconmienphimobi:UIImageView!
    weak var delegate: ItemGoiCuocV3TableViewCellDelegate?
    
    
    

    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:)")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.white
        
        tenGoiCuoc = UILabel()
        tenGoiCuoc.textColor = UIColor.white
        tenGoiCuoc.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        tenGoiCuoc.numberOfLines = 1
        contentView.addSubview(tenGoiCuoc)
        
        data = UILabel()
        data.textColor = UIColor.black
        data.font = data.font.withSize(12)
        data.numberOfLines = 1
        contentView.addSubview(data)
     
        
        phiGoiNoiMang = UILabel()
        phiGoiNoiMang.textColor = UIColor.black
        phiGoiNoiMang.font = data.font.withSize(12)
        phiGoiNoiMang.numberOfLines = 1
        contentView.addSubview(phiGoiNoiMang)
        
      
        
        phiGoiNgoaiMang = UILabel()
        phiGoiNgoaiMang.textColor = UIColor.black
        phiGoiNgoaiMang.font = data.font.withSize(13)
        phiGoiNgoaiMang.numberOfLines = 1
        contentView.addSubview(phiGoiNgoaiMang)
        
    

        
        lblLine = UILabel()
        lblLine.backgroundColor = UIColor(netHex:0xEEEEEE)
//        lblLine.frame = CGRect(x: 0 ,y: lblSoDonHang.frame.origin.y + lblSoDonHang.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:5))
        contentView.addSubview(lblLine)
        
        icondata = UIImageView()
        icondata.image = #imageLiteral(resourceName: "data-booksim")
        icondata.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(icondata)
        
        iconPhiGoiNoiManng = UIImageView()
        iconPhiGoiNoiManng.image = #imageLiteral(resourceName: "call-booksim")
        iconPhiGoiNoiManng.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconPhiGoiNoiManng)
        
        iconPhiGoiNgoaiMang = UIImageView()
        iconPhiGoiNgoaiMang.image = #imageLiteral(resourceName: "call-booksim")
        iconPhiGoiNgoaiMang.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconPhiGoiNgoaiMang)
        
        
        iconmienphi = UIImageView()
        iconmienphi.image = #imageLiteral(resourceName: "check-booksim")
        iconmienphi.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconmienphi)
        
        
        mienphi = UILabel()
        mienphi.textColor = UIColor.black
        mienphi.font = data.font.withSize(13)
        mienphi.numberOfLines = 1
        contentView.addSubview(mienphi)
        
        iconCheckKM = UIImageView()
        iconCheckKM.image = #imageLiteral(resourceName: "check-booksim")
        iconCheckKM.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconCheckKM)
        
        khuyenmai = UILabel()
        khuyenmai.textColor = UIColor.black
        khuyenmai.font = data.font.withSize(13)
        khuyenmai.numberOfLines = 1
        contentView.addSubview(khuyenmai)
        
        iconPhiGoi2 = UIImageView()
        iconPhiGoi2.image = #imageLiteral(resourceName: "check-booksim")
        iconPhiGoi2.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconPhiGoi2)
        
        phigoi2 = UILabel()
        phigoi2.textColor = UIColor.black
        phigoi2.font = data.font.withSize(13)
        phigoi2.numberOfLines = 1
        contentView.addSubview(phigoi2)
        
        iconmienphimobi = UIImageView()
        iconmienphimobi.image = #imageLiteral(resourceName: "check-booksim")
        iconmienphimobi.contentMode = UIView.ContentMode.scaleAspectFit
        contentView.addSubview(iconmienphimobi)
        
        mienphimobi = UILabel()
        mienphimobi.textColor = UIColor.black
        mienphimobi.font = data.font.withSize(13)
        mienphimobi.numberOfLines = 1
        contentView.addSubview(mienphimobi)
        
        gia = UILabel()
        gia.textColor = UIColor.red
        gia.font = UIFont.boldSystemFont(ofSize: Common.Size(s:12))
        gia.numberOfLines = 1
        contentView.addSubview(gia)
        
        xemchitiet = UILabel()
        xemchitiet.textColor = UIColor.init(netHex: 0x0000EE)
        xemchitiet.font = data.font.withSize(13)
        xemchitiet.numberOfLines = 1
        contentView.addSubview(xemchitiet)
        
        
        
    }
    var so1:GoiCuocEcom?
    func setup(so:GoiCuocEcom){
        so1 = so
        
        tenGoiCuoc.frame = CGRect(x: Common.Size(s:10),y: 0 ,width: UIScreen.main.bounds.size.width - Common.Size(s: 5) ,height: Common.Size(s:18))
        tenGoiCuoc.text = "\(so.Name)"
        if(so.Provider == "VietnamMobile"){
             tenGoiCuoc.backgroundColor = UIColor(netHex: 0xFF6600)
        }
        if(so.Provider == "Vinaphone"){
            tenGoiCuoc.backgroundColor = UIColor(netHex: 0x0099FF)
        }
        if(so.Provider == "Mobifone"){
            tenGoiCuoc.backgroundColor = UIColor(netHex: 0x3300CC)
        }
        if(so.Provider == "Viettel"){
            tenGoiCuoc.backgroundColor = UIColor(netHex: 0x006666)
        }
        if(so.Provider == "Itelecom"){
            tenGoiCuoc.backgroundColor = UIColor.red
        }
        icondata.frame = CGRect(x: Common.Size(s:10),y: tenGoiCuoc.frame.origin.y + tenGoiCuoc.frame.size.height + Common.Size(s: 5) ,width:  Common.Size(s: 16) ,height: Common.Size(s:16))
        
        data.frame = CGRect(x: icondata.frame.origin.x + icondata.frame.size.width,y: tenGoiCuoc.frame.origin.y + tenGoiCuoc.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 205) ,height: Common.Size(s:16))
        data.text = "\(so.Data1Home) \(so.Data1HomeDes)"
        
    
        
        iconPhiGoiNoiManng.frame = CGRect(x: data.frame.origin.x + data.frame.size.width,y: tenGoiCuoc.frame.origin.y + tenGoiCuoc.frame.size.height + Common.Size(s: 5),width:  Common.Size(s: 15) ,height: Common.Size(s:16))
        
        phiGoiNoiMang.frame = CGRect(x: iconPhiGoiNoiManng.frame.origin.x + iconPhiGoiNoiManng.frame.size.width,y: tenGoiCuoc.frame.origin.y + tenGoiCuoc.frame.size.height + Common.Size(s: 5),width:  Common.Size(s: 130) ,height: Common.Size(s:16))
        phiGoiNoiMang.text = "\(so.CallInsideHome) \(so.CallInsideHomeDes)"
        
       
        
        iconPhiGoiNgoaiMang.frame = CGRect(x: Common.Size(s:10),y: iconPhiGoiNoiManng.frame.origin.y + iconPhiGoiNoiManng.frame.size.height + Common.Size(s: 5),width:  Common.Size(s: 15) ,height: Common.Size(s:16))
        
        
        phiGoiNgoaiMang.frame = CGRect(x: iconPhiGoiNgoaiMang.frame.origin.x + iconPhiGoiNgoaiMang.frame.size.width,y: iconPhiGoiNoiManng.frame.origin.y + iconPhiGoiNoiManng.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 200) ,height: Common.Size(s:16))
        phiGoiNgoaiMang.text = "\(so.CallOutHome) \(so.CallOutsideHomeDes)"
        
     
        if(so.CallOutHome == ""){
            iconPhiGoiNgoaiMang.frame.size.height = 0
            phiGoiNgoaiMang.frame.size.height = 0
          
        }
        if(so.CallInsideHome == ""){
            iconPhiGoiNoiManng.frame.size.height = 0
            phiGoiNoiMang.frame.size.height = 0
        }
        
        lblLine.frame = CGRect(x: Common.Size(s:10) ,y: iconPhiGoiNgoaiMang.frame.origin.y + iconPhiGoiNgoaiMang.frame.size.height + Common.Size(s: 5) ,width: UIScreen.main.bounds.size.width  ,height: Common.Size(s:1))
        //-----//
        
        
        iconmienphi.frame = CGRect(x: Common.Size(s: 10) ,y: lblLine.frame.origin.y + lblLine.frame.size.height + Common.Size(s: 5),width:  Common.Size(s: 35) ,height: Common.Size(s:16))
        
        mienphi.frame = CGRect(x: iconmienphi.frame.origin.x + iconmienphi.frame.size.width,y: lblLine.frame.origin.y + lblLine.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
        
        iconCheckKM.frame = CGRect(x: Common.Size(s: 10),y: mienphi.frame.origin.y + mienphi.frame.size.height + Common.Size(s: 5),width:  Common.Size(s: 35) ,height: Common.Size(s:16))
        
        khuyenmai.frame = CGRect(x: iconCheckKM.frame.origin.x + iconCheckKM.frame.size.width,y: mienphi.frame.origin.y + mienphi.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
        
        iconPhiGoi2.frame = CGRect(x: Common.Size(s: 10),y: khuyenmai.frame.origin.y + khuyenmai.frame.size.height + Common.Size(s: 5),width:  Common.Size(s: 35) ,height: Common.Size(s:16))
        
        phigoi2.frame = CGRect(x: iconPhiGoi2.frame.origin.x + iconPhiGoi2.frame.size.width,y: khuyenmai.frame.origin.y + khuyenmai.frame.size.height + Common.Size(s: 5),width: UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
        
        iconmienphimobi.frame = CGRect(x: Common.Size(s: 10),y: phigoi2.frame.origin.y + phigoi2.frame.size.height + Common.Size(s: 5) ,width:  Common.Size(s: 35) ,height: Common.Size(s:16))
        
        mienphimobi.frame = CGRect(x: iconmienphimobi.frame.origin.x + iconmienphimobi.frame.size.width,y: phigoi2.frame.origin.y + phigoi2.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
        
        gia.frame = CGRect(x: Common.Size(s: 10),y: mienphimobi.frame.origin.y + mienphimobi.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
        
        gia.text = "Giá: \(Common.convertCurrencyV2(value:  so.Price))"
        
        xemchitiet.frame = CGRect(x: Common.Size(s: 15),y: gia.frame.origin.y + gia.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
        xemchitiet.text = "Xem chi tiết"
        
        let tapXemChiTiet = UITapGestureRecognizer(target: self, action: #selector(ItemGoiCuocV3TableViewCell.tapXemChiTiet))
        xemchitiet.isUserInteractionEnabled = true
        xemchitiet.addGestureRecognizer(tapXemChiTiet)
       
        let listString = so.NoteHome.components(separatedBy: ";")
        if(listString.count == 2){
            mienphi.text = "\(listString[0].replacingOccurrences(of: "\r\n", with: ""))"
            khuyenmai.text = "\(listString[1].replacingOccurrences(of: "\r\n", with: ""))"
            
            iconPhiGoi2.frame.size.height = 0
            iconmienphimobi.frame.size.height = 0
            
            gia.frame = CGRect(x: Common.Size(s: 10),y: khuyenmai.frame.origin.y + khuyenmai.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
            
            xemchitiet.frame = CGRect(x: Common.Size(s: 10),y: gia.frame.origin.y + gia.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
            
            phigoi2.frame.size.height = 0
            mienphimobi.frame.size.height = 0
        }
        if(listString.count == 3){
            mienphi.text = "\(listString[0].replacingOccurrences(of: "\r\n", with: ""))"
            khuyenmai.text = "\(listString[1].replacingOccurrences(of: "\r\n", with: ""))"
            phigoi2.text = "\(listString[2].replacingOccurrences(of: "\r\n", with: ""))"
            
            gia.frame = CGRect(x: Common.Size(s: 10),y: phigoi2.frame.origin.y + phigoi2.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
            
            xemchitiet.frame = CGRect(x: Common.Size(s: 10),y: gia.frame.origin.y + gia.frame.size.height + Common.Size(s: 5),width:  UIScreen.main.bounds.size.width - Common.Size(s: 30) ,height: Common.Size(s:16))
            
            iconmienphimobi.frame.size.height = 0
            mienphimobi.frame.size.height = 0
            
            
        }
        if(listString.count == 4){
            mienphi.text = "\(listString[0].replacingOccurrences(of: "\r\n", with: ""))"
            khuyenmai.text = "\(listString[1].replacingOccurrences(of: "\r\n", with: ""))"
            phigoi2.text = "\(listString[2].replacingOccurrences(of: "\r\n", with: ""))"
            mienphimobi.text = "\(listString[3].replacingOccurrences(of: "\r\n", with: ""))"
            
        }
        
        
    
    
        
     
        
        
      //  tenGoiCuoc.text = "\(so.)"
       
    
        
        
    }
    @objc func tapXemChiTiet(){
        delegate?.tapXemChiTiet(goiCuocEcom: so1!)
        
        
    }
    
    
}
