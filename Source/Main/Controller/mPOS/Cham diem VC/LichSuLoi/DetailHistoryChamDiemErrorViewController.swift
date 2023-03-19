//
//  DetailHistoryChamDiemErrorViewController.swift
//  fptshop
//
//  Created by Apple on 6/12/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailHistoryChamDiemErrorViewController: UIViewController {
    
    var tableView: UITableView!
    var cellHeight:CGFloat = 0
    var btnSendToSM: UIButton!
    var bottomView: UIView!
    var scoreErrorItem: ScoreError?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "MÃ KIỂM TRA #\(scoreErrorItem?.HeaderID ?? 0)"
        
        self.view.backgroundColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - Common.Size(s: 70) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        self.view.addSubview(tableView)
        tableView.register(DetailHistoryScoreErrorCell.self, forCellReuseIdentifier: "detailHistoryScoreErrorCell")
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        
        bottomView = UIView(frame: CGRect(x: 0, y: self.view.frame.height - (self.navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height) - Common.Size(s: 70), width: self.view.frame.width, height: Common.Size(s: 70)))
        bottomView.backgroundColor = UIColor.white
        self.view.addSubview(bottomView)
        
        btnSendToSM = UIButton(frame: CGRect(x: Common.Size(s: 15), y: 0, width: bottomView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        btnSendToSM.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        btnSendToSM.setTitle("GỬI SM", for: .normal)
        btnSendToSM.titleLabel?.textColor = UIColor.white
        btnSendToSM.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnSendToSM.layer.cornerRadius = 5
        bottomView.addSubview(btnSendToSM)
        btnSendToSM.addTarget(self, action: #selector(sendRequestToSM), for: .touchUpInside)
        
        if self.scoreErrorItem?.StatusCode == 1 {//dang thuc hien
            btnSendToSM.setTitle("GỬI SM", for: .normal)
        } else if self.scoreErrorItem?.StatusCode == 2 {//dang xu ly
            btnSendToSM.setTitle("XÁC NHẬN", for: .normal)
            
            ////
            if (Cache.user?.JobTitle == "00375") || (Cache.user?.JobTitle == "00701") || (Cache.user?.JobTitle == "00358") || (Cache.user?.JobTitle == "00292") {

                bottomView.isHidden = true
            } else {
                bottomView.isHidden = false
            }
        } else {
            bottomView.isHidden = true
        }
        
        if bottomView.isHidden {
            tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height -  ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        } else {
            tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - Common.Size(s: 70) - ((navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height))
        }
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendRequestToSM(){
        
        if self.btnSendToSM.titleLabel?.text == "GỬI SM" {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                MPOSAPIManager.Score_SendRequestScoreToSM(HeaderID: self.scoreErrorItem?.HeaderID ?? 0, handler: { (success, message, err) in
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        if success {
                            let alertVC = UIAlertController(title: "Thông báo", message: "\(message)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                self.navigationController?.popViewController(animated: true)
                            })
                            alertVC.addAction(action)
                            self.present(alertVC, animated: true, completion: nil)
                        } else {
                            self.showAlert(title: "Thông báo", message: "\(message)")
                        }
                    }
                    
                })
            }
        } else { //XÁC NHẬN
            var isHaveImg = true
            var arrContent = [String]()
            for item in self.scoreErrorItem?.DetailScores ?? [] {
                if item.UrlImgComplete.contains(".jpg") == false {
                    isHaveImg = false
                }
            }
            
            if isHaveImg == false {
                self.showAlert(title: "Thông báo", message: "Bạn chưa up đủ hình!")
            } else {
                arrContent.removeAll()

                for item in self.scoreErrorItem?.DetailScores ?? [] {
                    arrContent.append("<item U_DetailID=\"\(item.DetailID)\" U_UrlImage=\"\(item.UrlImgComplete)\"/>")
                }
                
                let strContent = arrContent.joined(separator: "")
                let submitContent = "<line>\(strContent)</line>"
                debugPrint("submitContentHistory: \(submitContent)")
                
                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                    MPOSAPIManager.Score_UpdateRequestScore(HeaderID: self.scoreErrorItem?.HeaderID ?? 0, ContentBody: submitContent.toBase64(), handler: { (results, err) in
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            if results.count > 0 {
                                if results[0].Result == 1 {
                                    let alertVC = UIAlertController(title: "Thông báo", message: "\(results[0].Message)", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                        self.navigationController?.popViewController(animated: true)
                                    })
                                    alertVC.addAction(action)
                                    self.present(alertVC, animated: true, completion: nil)
                                } else {
                                    self.showAlert(title: "Thông báo", message: "\(results[0].Message)")
                                }
                            } else {
                                self.showAlert(title: "Thông báo", message: "\(err)")
                            }
                        }
                    })
                }
            }
        }
        
        
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension DetailHistoryChamDiemErrorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreErrorItem?.DetailScores.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:DetailHistoryScoreErrorCell = tableView.dequeueReusableCell(withIdentifier: "detailHistoryScoreErrorCell", for: indexPath) as! DetailHistoryScoreErrorCell
        let itemScoreDetail = scoreErrorItem?.DetailScores[indexPath.row]
        cell.setUpCell(item: itemScoreDetail!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Common.Size(s: 170)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemScoreDetail = scoreErrorItem?.DetailScores[indexPath.row]
        
        let newViewController = DetailContentErrorViewController()
        newViewController.scoreErrorItem = self.scoreErrorItem
        newViewController.detailScoreError = itemScoreDetail
        newViewController.delegate = self
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
}

extension DetailHistoryChamDiemErrorViewController:DetailContentErrorViewControllerDelegate {
    func updateHistoryImgKhacPhuc(detailID: Int, urlImg: String) {
        for item in self.scoreErrorItem?.DetailScores ?? [] {
            if item.DetailID == detailID {
                item.UrlImgComplete = "\(urlImg)"
                item.Status = "Đã up hình"
                tableView.reloadData()
            }
        }
    }
}


class DetailHistoryScoreErrorCell: UITableViewCell {
    var lbTitle: UILabel!
    var lbNVKiemTraText: UILabel!
    var lbNDText: UILabel!
    var lbTimeText: UILabel!
    var lbTrangThaiText: UILabel!
    var lbLoiStatusText: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item:DetailScoreError){
        self.subviews.forEach({$0.removeFromSuperview()})
        //Header
        lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))

        lbTitle.text = "STT \(item.DetailID)"
        lbTitle.textColor = UIColor(red: 36/255, green: 143/255, blue: 52/255, alpha: 1)
        lbTitle.font = UIFont.boldSystemFont(ofSize: 14)
        self.addSubview(lbTitle)
        
        let lbTitleHeight = lbTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 3), width: self.frame.width - Common.Size(s: 30), height: 1))
        line.backgroundColor = UIColor.black
        self.addSubview(line)
        
        let lbNDKiemTra = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 10), width: self.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbNDKiemTra.text = "ND kiểm tra:"
        lbNDKiemTra.textColor = UIColor.lightGray
        lbNDKiemTra.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbNDKiemTra)
        
        lbNVKiemTraText = UILabel(frame: CGRect(x: lbNDKiemTra.frame.origin.x + lbNDKiemTra.frame.width + Common.Size(s: 3), y: lbNDKiemTra.frame.origin.y , width: self.frame.width - Common.Size(s: 30) - lbNDKiemTra.frame.width, height: Common.Size(s: 20)))
        lbNVKiemTraText.text = "\(item.GroupName)"
        lbNVKiemTraText.textColor = UIColor.black
        lbNVKiemTraText.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbNVKiemTraText)
        
        let lbNVKiemTraTextHeight = lbNVKiemTraText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNVKiemTraText.optimalHeight
        lbNVKiemTraText.numberOfLines = 0
        lbNVKiemTraText.frame = CGRect(x: lbNVKiemTraText.frame.origin.x, y: lbNVKiemTraText.frame.origin.y, width: lbNVKiemTraText.frame.width, height: lbNVKiemTraTextHeight)
        
        let lbND = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNVKiemTraText.frame.origin.y + lbNVKiemTraTextHeight + Common.Size(s: 3), width: lbNDKiemTra.frame.width, height: Common.Size(s: 20)))
        lbND.text = "Nội dung:"
        lbND.textColor = UIColor.lightGray
        lbND.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbND)
        
        lbNDText = UILabel(frame: CGRect(x: lbND.frame.origin.x + lbND.frame.width + Common.Size(s: 3), y: lbND.frame.origin.y , width: lbNVKiemTraText.frame.width, height: Common.Size(s: 20)))
        lbNDText.text = "\(item.ContentName)"
        lbNDText.textColor = UIColor.black
        lbNDText.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbNDText)
        
        let lbNDTextHeight = lbNDText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNDText.optimalHeight
        lbNDText.numberOfLines = 0
        lbNDText.frame = CGRect(x: lbNDText.frame.origin.x, y: lbNDText.frame.origin.y, width: lbNDText.frame.width, height: lbNDTextHeight)
        
        let lbThoiGian = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNDText.frame.origin.y + lbNDTextHeight + Common.Size(s: 3), width: lbNDKiemTra.frame.width, height: Common.Size(s: 20)))
        lbThoiGian.text = "Thời gian:"
        lbThoiGian.textColor = UIColor.lightGray
        lbThoiGian.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbThoiGian)
        
        lbTimeText = UILabel(frame: CGRect(x: lbThoiGian.frame.origin.x + lbThoiGian.frame.width + Common.Size(s: 3), y: lbThoiGian.frame.origin.y , width: lbNVKiemTraText.frame.width, height: Common.Size(s: 20)))
        lbTimeText.text = "\(item.CreateDate)"
        lbTimeText.textColor = UIColor.black
        lbTimeText.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbTimeText)
        
        let lbTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTimeText.frame.origin.y + lbTimeText.frame.height + Common.Size(s: 3), width: lbNDKiemTra.frame.width, height: Common.Size(s: 20)))
        lbTrangThai.text = "Trạng thái:"
        lbTrangThai.textColor = UIColor.lightGray
        lbTrangThai.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbTrangThai)
        
        lbTrangThaiText = UILabel(frame: CGRect(x: lbTrangThai.frame.origin.x + lbTrangThai.frame.width + Common.Size(s: 3), y: lbTrangThai.frame.origin.y , width: lbNVKiemTraText.frame.width, height: Common.Size(s: 20)))
        lbTrangThaiText.text = "\(item.Status)"
        lbTrangThaiText.font = UIFont.boldSystemFont(ofSize: 13)
        self.addSubview(lbTrangThaiText)
        
        let lbLoi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTrangThaiText.frame.origin.y + lbTrangThaiText.frame.height + Common.Size(s: 3), width: lbNDKiemTra.frame.width, height: Common.Size(s: 20)))
        lbLoi.text = "Lỗi vi phạm:"
        lbLoi.textColor = UIColor.lightGray
        lbLoi.font = UIFont.systemFont(ofSize: 13)
        self.addSubview(lbLoi)
        
        lbLoiStatusText = UILabel(frame: CGRect(x: lbLoi.frame.origin.x + lbLoi.frame.width + Common.Size(s: 3), y: lbLoi.frame.origin.y , width: lbNVKiemTraText.frame.width, height: Common.Size(s: 20)))
        lbLoiStatusText.text = "\(item.Point)"
        lbLoiStatusText.font = UIFont.boldSystemFont(ofSize: 13)
        self.addSubview(lbLoiStatusText)

        if item.Status == "Chưa up hình" {
            lbTrangThaiText.textColor = UIColor(red: 24/255, green: 118/255, blue: 209/255, alpha: 1)
        } else {
            lbTrangThaiText.textColor = UIColor(red: 36/255, green: 143/255, blue: 52/255, alpha: 1)
        }
    }
}
