//
//  NewsViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 3/25/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class NewsViewController: UIViewController {

    var tableView: UITableView!
//    var viewHeader: UIView!
    var listTinTuc = [LoaiTinItem]()
    static let domainNews = "http://news.fptshop.com.vn"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initNavigationBar()
        self.tabBarController?.tabBar.isHidden = true
        self.title = "Tin tức"
        self.view.backgroundColor = .white

        var sizeHeight = UIApplication.shared.statusBarFrame.height
        if(sizeHeight > 20){
            sizeHeight = sizeHeight/2
        }
//        viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.navigationController!.navigationBar.frame.size.height + sizeHeight))
//        self.view.addSubview(viewHeader)

//        let imageAvatar = UIImageView(frame: CGRect(x: Common.Size(s:5), y: Common.Size(s:5), width: viewHeader.frame.size.height - Common.Size(s:10), height: viewHeader.frame.size.height - Common.Size(s:10)))
//        imageAvatar.image = UIImage(named: "avatar")
//        imageAvatar.layer.borderWidth = 1
//        imageAvatar.layer.masksToBounds = false
//        imageAvatar.layer.borderColor = UIColor.white.cgColor
//        imageAvatar.layer.cornerRadius = imageAvatar.frame.height/2
//        imageAvatar.clipsToBounds = true
////        viewHeader.addSubview(imageAvatar)
//        imageAvatar.contentMode = .scaleAspectFill
//        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
//
//        let url_avatar = "\(Cache.user!.AvatarImageLink)".replacingOccurrences(of: "~", with: "")
//        if(url_avatar != ""){
//            if let escapedString = "https://inside.fptshop.com.vn/\(url_avatar)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
//                print(escapedString)
//                let url = URL(string: "\(escapedString)")!
//                imageAvatar.kf.setImage(with: url,
//                                        placeholder: nil,
//                                        options: [.transition(.fade(1))],
//                                        progressBlock: nil,
//                                        completionHandler: nil)
//            }
//        }
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(TabMPOSHomeViewController.tapUserInfo))
//        imageAvatar.isUserInteractionEnabled = true
//        imageAvatar.addGestureRecognizer(singleTap)


//        let lbName = UILabel(frame: CGRect(x: imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5), y: Common.Size(s: 5), width: viewHeader.frame.width - (imageAvatar.frame.origin.x + imageAvatar.frame.size.width + Common.Size(s: 5)) * 2, height: Common.Size(s: 20)))
//        lbName.text = "\(Cache.user!.UserName) - \(Cache.user!.EmployeeName)"
//        lbName.font = UIFont.boldSystemFont(ofSize: Common.Size(s: 13))
//        viewHeader.addSubview(lbName)
//
//        let lbShop = UILabel(frame: CGRect(x: lbName.frame.origin.x, y: lbName.frame.origin.y + lbName.frame.size.height, width: lbName.frame.width, height: Common.Size(s: 20)))
//        lbShop.text = "\(Cache.user!.ShopName)"
//        lbShop.font = UIFont.systemFont(ofSize: Common.Size(s: 13))
//        viewHeader.addSubview(lbShop)

        self.initTableView()
        self.getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        // MARK: - FIXED LOGIC LOGIN CACHED APP VERSION.
        if self.tableView == nil {
            self.initTableView()
        }
        let newViewController = LoadingViewController()
        newViewController.content = "Đang lấy dữ liệu..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        
        MPOSAPIManager.getTinTuc_New(limit: "3") { (rs, err) in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                NotificationCenter.default.post(name: Notification.Name("dismissLoading"), object: nil)
                if err.count <= 0 {
                    if rs.count > 0 {
                        self.listTinTuc = rs
                        self.tableView.reloadData()
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "Không có dữ liệu tin tức!", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
//        let tableViewHeight:CGFloat = self.view.frame.height - (self.tabBarController?.tabBar.frame.height)!
        let tableViewHeight: CGFloat = self.view.frame.height - 8
        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.width, height: tableViewHeight)
    }

    @objc func tapUserInfo() {
        let vc = UserInfoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getData() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.getTinTuc_New(limit: "3") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            self.listTinTuc = rs
                            self.tableView.reloadData()
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có dữ liệu tin tức!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func initTableView() {
        let tableViewHeight:CGFloat = self.view.frame.height -
        self.navigationController!.navigationBar.frame.size.height - UIApplication.shared.statusBarFrame.height
        tableView = UITableView(frame: CGRect(x: 0, y: self.view.frame.origin.y, width: self.view.frame.width, height: tableViewHeight))
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return listTinTuc.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listTinTuc.count > 0 {
            if listTinTuc[section].listSummary.count > 0 {
                if listTinTuc[section].listSummary.count < 3 {
                    return listTinTuc[section].listSummary.count
                } else {
                    return 3
                }
            }
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:NewsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as! NewsTableViewCell

        let itemSumary = listTinTuc[indexPath.section].listSummary[indexPath.row]
        cell.setUpCell(item: itemSumary)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 100)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let itemLoaiTinHeader = self.listTinTuc[section]
        let headerView = HeaderViewNews(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: Common.Size(s: 30)))
        headerView.delegate = self
        headerView.itemLoaiTin = itemLoaiTinHeader
        headerView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        headerView.lbTitle.text = "\(itemLoaiTinHeader.nameLoaiTin)"

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Common.Size(s: 30)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.listTinTuc.count > 0 {
            let itemSumary = self.listTinTuc[indexPath.section].listSummary[indexPath.row]
            let vc = NewsDetailViewController()
            vc.newsID = itemSumary.id
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension NewsViewController: HeaderViewNewsDelegate {
    func showTop10BanTin(itemLoaiTin: LoaiTinItem) {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.getTinTuc_New(limit: "10") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            for item in rs {
                                if item.idLoaiTin == itemLoaiTin.idLoaiTin {
                                    let vc = Top10BanTinViewController()
                                    vc.itemLoaiTin = item
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        } else {
                            let alert = UIAlertController(title: "Thông báo", message: "Không có dữ liệu tin tức!", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    } else {
                        let alert = UIAlertController(title: "Thông báo", message: "\(err)", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

class NewsTableViewCell: UITableViewCell {
    var imgSumary: UIImageView!
    var lbTitle: UILabel!
    var lbDescription: UILabel!
    var lbCreateDate: UILabel!

    func setUpCell(item: Sumary_TinTuc) {
        self.subviews.forEach({$0.removeFromSuperview()})

        self.layer.cornerRadius = 3
        self.clipsToBounds = true
        self.backgroundColor = .white

        imgSumary = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: self.frame.height/2 - Common.Size(s: 40), width: Common.Size(s: 100), height: Common.Size(s: 80)))
        imgSumary.contentMode = .scaleToFill
        imgSumary.layer.cornerRadius = 3
        imgSumary.clipsToBounds = true
        self.addSubview(imgSumary)

        let urlStr = "\(NewsViewController.domainNews)\(item.imgChuDe)"
        let url = URL(string: "\(urlStr)")
        imgSumary.kf.setImage(with: url,
                              placeholder: nil,
                              options: [.transition(.fade(1))],
                              progressBlock: nil,
                              completionHandler: nil)

        lbTitle = UILabel(frame: CGRect(x: imgSumary.frame.origin.x + imgSumary.frame.width + Common.Size(s: 5), y: imgSumary.frame.origin.y, width: self.frame.width - (imgSumary.frame.origin.x + imgSumary.frame.width + Common.Size(s: 5)) - Common.Size(s: 10), height: Common.Size(s: 20)))
        lbTitle.text = "\(item.title)"
        lbTitle.font = UIFont.boldSystemFont(ofSize: 16)
        self.addSubview(lbTitle)

        lbDescription = UILabel(frame: CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y + lbTitle.frame.height, width: lbTitle.frame.width, height: Common.Size(s: 45)))
        lbDescription.text = "\(item.field_description)"
        lbDescription.font = UIFont.systemFont(ofSize: 12)
        lbDescription.numberOfLines = 3
        self.addSubview(lbDescription)

        lbCreateDate = UILabel(frame: CGRect(x: lbTitle.frame.origin.x, y: lbDescription.frame.origin.y + lbDescription.frame.height + Common.Size(s: 5), width: lbTitle.frame.width, height: Common.Size(s: 15) ))
        lbCreateDate.font = UIFont.systemFont(ofSize: 12)
        lbCreateDate.textAlignment = .right
        self.addSubview(lbCreateDate)

        if !(item.created.isEmpty) {
            let dateStrOld = item.created
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)

            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "HH:mm dd/MM/yyyy"
            let str = newFormatter.string(from: date2 ?? Date())
            lbCreateDate.text = str
        } else {
            lbCreateDate.text = item.created
        }

        let line = UIView(frame: CGRect(x: Common.Size(s: 0), y: self.frame.height - Common.Size(s: 1), width: self.frame.width, height: Common.Size(s: 1)))
        line.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        self.addSubview(line)
    }
}

protocol HeaderViewNewsDelegate {
    func showTop10BanTin(itemLoaiTin: LoaiTinItem)
}

class HeaderViewNews: UIView {
    var lbTitle: UILabel!
    var itemLoaiTin:LoaiTinItem?
    var delegate:HeaderViewNewsDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 10), y: 0, width: self.frame.width - Common.Size(s: 20), height: self.frame.height - Common.Size(s: 1)))
        lbTitle.font = UIFont.boldSystemFont(ofSize: 15)
        lbTitle.textColor = UIColor.red
        self.addSubview(lbTitle)

        let tapHeader = UITapGestureRecognizer(target: self, action: #selector(showBanTin))
        lbTitle.isUserInteractionEnabled = true
        lbTitle.addGestureRecognizer(tapHeader)
    }

    @objc func showBanTin() {
        if itemLoaiTin != nil {
            self.delegate?.showTop10BanTin(itemLoaiTin: itemLoaiTin ?? LoaiTinItem(idLoaiTin: "", nameLoaiTin: "", listSummary: []))
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
