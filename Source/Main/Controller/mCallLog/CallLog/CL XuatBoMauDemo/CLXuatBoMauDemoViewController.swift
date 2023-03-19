//
//  CLXuatBoMauDemoViewController.swift
//  fptshop
//
//  Created by Apple on 5/27/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class CLXuatBoMauDemoViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var lbFromShopName: UILabel!
    var lbToShopName: UILabel!
    var lbContentHeaderText: UILabel!
    var nhapDemoView: UIView!
    
    var tableViewProductDemo: UITableView!
    var tableViewImportDemo: UITableView!
    var lbNDTraoDoiNewText: UILabel!
    var tvNDTraoDoi: UITextView!
    var btnFinish: UIButton!
    var hangDemoView: UIView!
    
    var callog:CallLog?
    var productDemoCellHeight:CGFloat = 0
    var importProductDemoCellHeight:CGFloat = 0
    
    var arrHangDemo:[DetailXuatDemo] = []
    var arrNhapDemo:[DetailXuatDemo] = []
    var tableViewProductDemoHeight:CGFloat = 0
    
    var bottomView: UIView!
    var imagePicker = UIImagePickerController()
    var lastImg: UIImage!
    var lastSelectedIndex:IndexPath?
    var headerItem: HeaderXuatDemo?
    var conversationItem:ConversationXuatDemo?
    var detailItem:DetailXuatDemo?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "Callog Xuất - Bỏ mẫu demo"
        
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let arrHeader = mCallLogApiManager.DemoReq__GetHeader_ByReqId(p_RequestId: "\(self.callog?.RequestID ?? 0)").Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if arrHeader.count > 0 {
                    self.headerItem = arrHeader[0]
                } else {
                    debugPrint("load api header fail")
                }
                
                self.setUpHeader()
                
                //detail
                let resultDemo = mCallLogApiManager.DemoReq__GetDetail_ByReqId(p_RequestId: "\(self.callog?.RequestID ?? 0)").Data ?? []
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if resultDemo.count > 0 {
                        for item in resultDemo {
                            
                            if item.PhanLoai == CallLogType.CLXuatBoMauDemo_HangDemo {
                                self.arrHangDemo.append(item)
                            } else if item.PhanLoai == CallLogType.CLXuatBoMauDemo_NhapDemo {
                                self.arrNhapDemo.append(item)
                            }
                        }
                    } else {
                        debugPrint("load api detail fail")
                    }
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        self.setUpTableViewProductDemo()
                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                            self.setUpNhapDemoView()
                            
                            let conversationResult = mCallLogApiManager.DemoReq__GetConv_ByReqId(p_RequestId: "\(self.callog?.RequestID ?? 0)").Data ?? []
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                if conversationResult.count > 0 {
                                    self.conversationItem = conversationResult[0]
                                } else {
                                    debugPrint("load api noi dug trao doi fail")
                                }
                                self.setUpBottomView()
                            }
                        }
                    }
                }
            }
        }

    }
    

        func setUpBottomView() {
        bottomView = UIView(frame: CGRect(x: 0, y: tableViewImportDemo.frame.origin.y + tableViewImportDemo.frame.height, width: scrollView.frame.width, height: Common.Size(s: 300)))
        bottomView.backgroundColor = UIColor.white
        scrollView.addSubview(bottomView)
        
        let discussView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 35)))
        discussView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        bottomView.addSubview(discussView)
        
        let lbDiscussName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: discussView.frame.width - Common.Size(s: 30), height: discussView.frame.height))
        lbDiscussName.text = "TRAO ĐỔI"
        lbDiscussName.font = UIFont.boldSystemFont(ofSize: 15)
        lbDiscussName.textColor = UIColor.black
        discussView.addSubview(lbDiscussName)
        
        let lbNDTraoDoiNew = UILabel(frame: CGRect(x: Common.Size(s: 15), y: discussView.frame.origin.y + discussView.frame.height + Common.Size(s: 10), width: discussView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbNDTraoDoiNew.text = "Nội dung trao đổi mới nhất:"
        lbNDTraoDoiNew.font = UIFont.systemFont(ofSize: 14)
        lbNDTraoDoiNew.textColor = UIColor.lightGray
        bottomView.addSubview(lbNDTraoDoiNew)
        
        lbNDTraoDoiNewText = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNDTraoDoiNew.frame.origin.y + lbNDTraoDoiNew.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
            lbNDTraoDoiNewText.text = "\(self.conversationItem?.NoiDung ?? "")".htmlToString
        lbNDTraoDoiNewText.font = UIFont.systemFont(ofSize: 14)
        lbNDTraoDoiNewText.textColor = UIColor.black
        bottomView.addSubview(lbNDTraoDoiNewText)
        
        let lbNDTraoDoiNewTextHeight = lbNDTraoDoiNewText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNDTraoDoiNewText.optimalHeight
        lbNDTraoDoiNewText.numberOfLines = 0
        
        lbNDTraoDoiNewText.frame = CGRect(x: lbNDTraoDoiNewText.frame.origin.x, y: lbNDTraoDoiNewText.frame.origin.y, width: lbNDTraoDoiNewText.frame.width, height: lbNDTraoDoiNewTextHeight)
        
        tvNDTraoDoi = UITextView(frame: CGRect(x: Common.Size(s: 15), y: lbNDTraoDoiNewText.frame.origin.y + lbNDTraoDoiNewTextHeight + Common.Size(s: 5), width: lbNDTraoDoiNewText.frame.width, height: Common.Size(s: 80)))
        tvNDTraoDoi.layer.cornerRadius = 5
        tvNDTraoDoi.layer.borderColor = UIColor.lightGray.cgColor
        tvNDTraoDoi.layer.borderWidth = 1
        tvNDTraoDoi.backgroundColor = UIColor.white
        tvNDTraoDoi.text = "Nhập nội dung trao đổi"
        tvNDTraoDoi.textColor = UIColor.lightGray
        tvNDTraoDoi.font = UIFont.systemFont(ofSize: 14)
        tvNDTraoDoi.delegate = self
        bottomView.addSubview(tvNDTraoDoi)
        
        
        btnFinish = UIButton(frame: CGRect(x: Common.Size(s: 15), y: tvNDTraoDoi.frame.origin.y + tvNDTraoDoi.frame.height + Common.Size(s: 15), width: lbNDTraoDoiNewText.frame.width, height: Common.Size(s: 40)))
        btnFinish.setTitle("HOÀN TẤT", for: .normal)
        btnFinish.setTitleColor(UIColor.white, for: .normal)
        btnFinish.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnFinish.layer.cornerRadius = 5
        btnFinish.backgroundColor = UIColor(red: 34/255, green: 134/255, blue: 70/255, alpha: 1)
        btnFinish.addTarget(self, action: #selector(finishCalllog), for: .touchUpInside)
        bottomView.addSubview(btnFinish)
            
        bottomView.frame = CGRect(x: bottomView.frame.origin.x, y: bottomView.frame.origin.y, width: bottomView.frame.width, height: btnFinish.frame.origin.y + btnFinish.frame.height)
        
        scrollViewHeight = bottomView.frame.origin.y + bottomView.frame.height + Common.Size(s: 80)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    
    func setUpNhapDemoView() {
        
        /// view nhap demo
        nhapDemoView = UIView(frame: CGRect(x: 0, y: tableViewProductDemo.frame.origin.y + tableViewProductDemo.frame.height, width: scrollView.frame.width, height: Common.Size(s: 35)))
        nhapDemoView.backgroundColor = UIColor.blue
        scrollView.addSubview(nhapDemoView)
        
        let lbNhapDemo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: nhapDemoView.frame.width - Common.Size(s: 30), height: nhapDemoView.frame.height))
        lbNhapDemo.text = "NHẬP DEMO"
        lbNhapDemo.font = UIFont.boldSystemFont(ofSize: 15)
        lbNhapDemo.textColor = UIColor.white
        nhapDemoView.addSubview(lbNhapDemo)
        
        tableViewImportDemo = UITableView(frame: CGRect(x: 0, y: nhapDemoView.frame.origin.y + nhapDemoView.frame.height, width: scrollView.frame.width, height: Common.Size(s: 40)))
        tableViewImportDemo.backgroundColor = UIColor.white
        tableViewImportDemo.delegate = self
        tableViewImportDemo.dataSource = self
        tableViewImportDemo.register(ImportProductDemoCell.self, forCellReuseIdentifier: "importProductDemoCell")
        tableViewImportDemo.allowsSelection = false
        tableViewImportDemo.isScrollEnabled = false
        tableViewImportDemo.showsVerticalScrollIndicator = false
        tableViewImportDemo.tableFooterView = UIView()
        scrollView.addSubview(tableViewImportDemo)
        
    }
    
    //-----------
    
    func setUpHeader(){
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let lbTitle = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: scrollView.frame.width/2 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTitle.text = "\(headerItem?.TenShop ?? "")"
        lbTitle.textColor = UIColor(red: 36/255, green: 143/255, blue: 52/255, alpha: 1)
        lbTitle.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbTitle)
        
        let lbTitleHeight = lbTitle.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbTitle.optimalHeight
        lbTitle.numberOfLines = 0
        
        lbTitle.frame = CGRect(x: lbTitle.frame.origin.x, y: lbTitle.frame.origin.y, width: lbTitle.frame.width, height: lbTitleHeight)
        
        let lbDate = UILabel(frame: CGRect(x: lbTitle.frame.width + Common.Size(s: 15), y: lbTitle.frame.origin.y, width: scrollView.frame.width/2 - Common.Size(s: 15), height: lbTitle.frame.height))
//        lbDate.text = Common.GetDateStringFrom(jsonStr: "\(headerItem?.ThoiGianTao ?? "")")
        lbDate.text = "\(headerItem?.ThoiGianTao ?? "")"
        lbDate.textColor = UIColor.lightGray
        lbDate.font = UIFont.systemFont(ofSize: 13)
        lbDate.textAlignment = .right
        scrollView.addSubview(lbDate)
        
        let line = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbTitle.frame.origin.y + lbTitleHeight + Common.Size(s: 3), width: scrollView.frame.width - Common.Size(s: 30), height: 1))
        line.backgroundColor = UIColor.lightGray
        scrollView.addSubview(line)
        
        //tu - den - noi dung
        
        let lbFrom = UILabel(frame: CGRect(x: Common.Size(s: 15), y: line.frame.origin.y + line.frame.height + Common.Size(s: 10), width: scrollView.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbFrom.text = "Từ: "
        lbFrom.textColor = UIColor.black
        lbFrom.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbFrom)
        
        lbFromShopName = UILabel(frame: CGRect(x: lbFrom.frame.origin.x + lbFrom.frame.width, y: lbFrom.frame.origin.y, width: scrollView.frame.width - lbFrom.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbFromShopName.text = self.headerItem?.NguoiTao ?? ""
        lbFromShopName.textColor = UIColor.black
        lbFromShopName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbFromShopName)
        
        let lbFromShopNameHeight = lbFromShopName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbFromShopName.optimalHeight
        lbFromShopName.numberOfLines = 0
        
        lbFromShopName.frame = CGRect(x: lbFromShopName.frame.origin.x, y: lbFromShopName.frame.origin.y, width: lbFromShopName.frame.width, height: lbFromShopNameHeight)
        
        let lbTo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbFromShopName.frame.origin.y + lbFromShopNameHeight + Common.Size(s: 5), width: lbFrom.frame.width, height: Common.Size(s: 20)))
        lbTo.text = "Đến: "
        lbTo.textColor = UIColor.black
        lbTo.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbTo)
        
        lbToShopName = UILabel(frame: CGRect(x: lbTo.frame.origin.x + lbTo.frame.width, y: lbTo.frame.origin.y, width: lbFromShopName.frame.width, height: Common.Size(s: 20)))
        lbToShopName.text = self.headerItem?.NguoiXuLy ?? ""
        lbToShopName.textColor = UIColor.black
        lbToShopName.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbToShopName)
        
        let lbToShopNameHeight = lbToShopName.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbToShopName.optimalHeight
        lbToShopName.numberOfLines = 0
        
        lbToShopName.frame = CGRect(x: lbToShopName.frame.origin.x, y: lbToShopName.frame.origin.y, width: lbToShopName.frame.width, height: lbToShopNameHeight)
        
        let lbHeaderContent = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbToShopName.frame.origin.y + lbToShopNameHeight + Common.Size(s: 5), width: lbFrom.frame.width, height: Common.Size(s: 20)))
        lbHeaderContent.text = "Nội dung: "
        lbHeaderContent.textColor = UIColor.black
        lbHeaderContent.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbHeaderContent)
        
        lbContentHeaderText = UILabel(frame: CGRect(x: lbHeaderContent.frame.origin.x + lbHeaderContent.frame.width, y: lbHeaderContent.frame.origin.y, width: lbFromShopName.frame.width, height: Common.Size(s: 20)))
        lbContentHeaderText.text = self.headerItem?.NoiDungYeuCau ?? ""
        lbContentHeaderText.textColor = UIColor.black
        lbContentHeaderText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbContentHeaderText)
        
        let lbContentHeaderTextHeight = lbContentHeaderText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbContentHeaderText.optimalHeight
        lbContentHeaderText.numberOfLines = 0
        
        lbContentHeaderText.frame = CGRect(x: lbContentHeaderText.frame.origin.x, y: lbContentHeaderText.frame.origin.y, width: lbContentHeaderText.frame.width, height: lbContentHeaderTextHeight)
        
        /// view hang demo
        hangDemoView = UIView(frame: CGRect(x: 0, y: lbContentHeaderText.frame.origin.y + lbContentHeaderTextHeight + Common.Size(s:15), width: scrollView.frame.width, height: Common.Size(s: 35)))
        hangDemoView.backgroundColor = UIColor(red: 193/255, green: 37/255, blue: 44/255, alpha: 1)
        scrollView.addSubview(hangDemoView)
        
        let lbHangDemo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: hangDemoView.frame.width - Common.Size(s: 30), height: hangDemoView.frame.height))
        lbHangDemo.text = "HÀNG DEMO"
        lbHangDemo.font = UIFont.boldSystemFont(ofSize: 15)
        lbHangDemo.textColor = UIColor.white
        hangDemoView.addSubview(lbHangDemo)
        
        
    }
    
    func setUpTableViewProductDemo(){
        tableViewProductDemo = UITableView(frame: CGRect(x: 0, y: hangDemoView.frame.origin.y + hangDemoView.frame.height, width: scrollView.frame.width, height: Common.Size(s: 40)))
        tableViewProductDemo.backgroundColor = UIColor.white
        tableViewProductDemo.delegate = self
        tableViewProductDemo.dataSource = self
        tableViewProductDemo.register(ProductDemoCell.self, forCellReuseIdentifier: "productDemoCell")
        tableViewProductDemo.allowsSelection = false
        tableViewProductDemo.isScrollEnabled = false
        tableViewProductDemo.showsVerticalScrollIndicator = false
        tableViewProductDemo.tableFooterView = UIView()
        scrollView.addSubview(tableViewProductDemo)
    }
    
    @objc func finishCalllog(){
        //check NDTD
        var strImg = ""
        guard var ndTraoDoiString = self.tvNDTraoDoi.text, !ndTraoDoiString.isEmpty, ndTraoDoiString != "Nhập nội dung trao đổi" else {
            self.showAlert(title: "Thông báo", message: "Bạn chưa nhập nội dung trao đổi!")
            return
        }
        
        if ndTraoDoiString == "Nhập nội dung trao đổi" {
            ndTraoDoiString = ""
        }
        
        if self.arrHangDemo.count > 0 {
            var arrHangDemoImageStr = [String]()
            
            for item in arrHangDemo {
                if item.Images == "" || item.Images == nil {
                    self.showAlert(title: "Thông báo", message: "Bạn chưa up đủ hình. Vui lòng cập nhật!")
                    return
                } else {
                    let productImgResult = mCallLogApiManager.UploadImage(fileName: "hangdemo.jpg", encodedImg: "\(item.Images ?? "")", username: "\(Cache.user?.UserName ?? "")").Data;
                    arrHangDemoImageStr.append("\(item.Id_Detail ?? 0)|\(productImgResult?.FilePath ?? "")")
                }
            }

            strImg = arrHangDemoImageStr.joined(separator: ";")
            debugPrint("str img: \(strImg)")
            
        }
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let results = mCallLogApiManager.DemoReq__XuLy(p_RequestId: "\(self.callog?.RequestID ?? 0)", p_NoiDungTraoDoi: ndTraoDoiString, p_Images: strImg).Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if results.count > 0 {
                    if results[0].Result == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: results[0].Msg?.htmlToString ?? "", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            for vc in self.navigationController?.viewControllers ?? [] {
                                if vc is CallLogTableViewController {
                                    self.navigationController?.popToViewController(vc, animated: true)
                                }
                            }
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)

                    } else {
//                        let alertVC = UIAlertController(title: "Thông báo", message: results[0].Msg?.htmlToString ?? "Xử lý thất bại!", preferredStyle: .alert)
                        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
                        //Custom Alert
                        
                        // Create custom title
                        let customTitle = NSMutableAttributedString(string: "Thông báo", attributes: [
                            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15),
                            NSAttributedString.Key.foregroundColor: UIColor.black
                            ])
                        alertVC.setValue(customTitle, forKey: "attributedTitle")
                        
                        // Create custom message
                        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
                        let customMessage = NSMutableAttributedString(string: "\(results[0].Msg?.htmlToString ?? "Xử lý thất bại!")", attributes: [
                            NSAttributedString.Key.paragraphStyle: paragraphStyle,
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                            NSAttributedString.Key.foregroundColor: UIColor.black
                            ])
                        alertVC.setValue(customMessage, forKey: "attributedMessage")
                        
                        //------------------------
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
//
                            self.arrHangDemo.removeAll()
                            self.arrNhapDemo.removeAll()
                            
                            self.tableViewProductDemo.removeFromSuperview()
                            self.nhapDemoView.removeFromSuperview()
                            self.tableViewImportDemo.removeFromSuperview()
                            self.bottomView.removeFromSuperview()
                            //detail
                            let resultDemo = mCallLogApiManager.DemoReq__GetDetail_ByReqId(p_RequestId: "\(self.callog?.RequestID ?? 0)").Data ?? []
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                if resultDemo.count > 0 {
                                    for item in resultDemo {
                                        
                                        if item.PhanLoai == CallLogType.CLXuatBoMauDemo_HangDemo {
                                            self.arrHangDemo.append(item)
                                        } else if item.PhanLoai == CallLogType.CLXuatBoMauDemo_NhapDemo {
                                            self.arrNhapDemo.append(item)
                                        }
                                    }
                                } else {
                                    debugPrint("load api detail fail")
                                }
                                
                                self.setUpTableViewProductDemo()
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                                    self.setUpNhapDemoView()
                                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                                        self.setUpBottomView()
                                    }
                                })
                            }
                        })
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                    }
                } else {
                    debugPrint("khong lay duoc api xu ly")
                }
            }
        }
    }
    
    func resizeImageWidth(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension CLXuatBoMauDemoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableViewProductDemo {
            return self.arrHangDemo.count
        } else {
            return self.arrNhapDemo.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == self.tableViewProductDemo {
            let productDemoCell:ProductDemoCell = tableView.dequeueReusableCell(withIdentifier: "productDemoCell", for: indexPath) as! ProductDemoCell
            
            let itemHangDemo = self.arrHangDemo[indexPath.row]
            productDemoCell.setUpCell(item: itemHangDemo)
            productDemoCell.cellIndexPath = indexPath
            self.productDemoCellHeight = productDemoCell.estimateCellHeight
            self.tableViewProductDemoHeight = (self.productDemoCellHeight * CGFloat(self.arrHangDemo.count)) + (Common.Size(s: 15) * CGFloat(self.arrHangDemo.count))
            
            //update tableview height
            tableViewProductDemo.frame = CGRect(x: tableViewProductDemo.frame.origin.x, y: tableViewProductDemo.frame.origin.y, width: tableViewProductDemo.frame.width, height: self.tableViewProductDemoHeight)
            
            productDemoCell.delegate = self
            //set img
            if self.lastImg != nil {
                let heightImage:CGFloat = Common.Size(s: 120)
                productDemoCell.imgViewTakePhoto.frame = CGRect(x: productDemoCell.imgViewTakePhoto.frame.origin.x, y: productDemoCell.imgViewTakePhoto.frame.origin.y, width: productDemoCell.imgViewTakePhoto.frame.width, height: heightImage)
                productDemoCell.imgViewTakePhoto.image = self.lastImg
                productDemoCell.imgViewTakePhoto.contentMode = .scaleAspectFit
                
                let img:UIImage = self.resizeImageWidth(image: self.lastImg,newWidth: Common.resizeImageWith)!
                let imageData:NSData = (img.jpegData(compressionQuality: Common.resizeImageValueFF) as NSData?)!
                let strBase64 = imageData.base64EncodedString(options: .endLineWithLineFeed)

                debugPrint("strBase64: \(strBase64)")
                itemHangDemo.Images = strBase64
            }
            
            return productDemoCell
            
        } else {
            
            let importProductCell:ImportProductDemoCell = tableView.dequeueReusableCell(withIdentifier: "importProductDemoCell", for: indexPath) as! ImportProductDemoCell
            
            let importDemoItem = self.arrNhapDemo[indexPath.row]
            importProductCell.setUpCell(item: importDemoItem)
            self.importProductDemoCellHeight = importProductCell.estimateCellHeight
            
            let tableViewImportDemoHeight:CGFloat = self.importProductDemoCellHeight * CGFloat(self.arrNhapDemo.count)
            
            tableViewImportDemo.frame = CGRect(x: tableViewImportDemo.frame.origin.x, y: tableViewImportDemo.frame.origin.y, width: tableViewImportDemo.frame.width, height: tableViewImportDemoHeight)
            
            
            return importProductCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableViewProductDemo {
            return self.productDemoCellHeight
        } else {
            return self.importProductDemoCellHeight
        }
    }
}

extension CLXuatBoMauDemoViewController: ProductDemoCellDelagate {
    func showCamera(at indexpath: IndexPath) {
        self.lastSelectedIndex = indexpath
        self.openCamera()
//        self.thisIsTheFunctionWeAreCalling()
    }
}

extension CLXuatBoMauDemoViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView){
        if(textView.text! == "Nhập nội dung trao đổi"){
            textView.text = ""
            textView.textColor = UIColor.black
            tvNDTraoDoi.font = UIFont.systemFont(ofSize: 14)
        }
    }
}

extension CLXuatBoMauDemoViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func thisIsTheFunctionWeAreCalling() {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            //            alert.popoverPresentationController?.sourceView = sender
            //            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
//        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        // image is our desired image
//        self.setImage(image: image)
        
        picker.dismiss(animated: true, completion: nil)
        self.lastImg = UIImage()
        self.lastImg = image
        self.tableViewProductDemo.reloadRows(at: [self.lastSelectedIndex!], with: UITableView.RowAnimation.automatic)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
    //MARK: - Open the camera
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}

protocol ProductDemoCellDelagate: AnyObject {
    func showCamera(at indexpath:IndexPath)
}

class ProductDemoCell: UITableViewCell {
    
    var lbProductNameText: UILabel!
    var lbSeriNumber: UILabel!
    var lbProductCount: UILabel!
    var lbProductDemoReason: UILabel!
    var imgViewTakePhoto: UIImageView!
    
    var estimateCellHeight: CGFloat = 0
    var cellIndexPath:IndexPath?
    
    weak var delegate:ProductDemoCellDelagate?
    
    func setUpCell(item:DetailXuatDemo) {
        //ten hang
        
        self.subviews.forEach({$0.removeFromSuperview()})
        let lbTenHang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTenHang.text = "Tên hàng: "
        lbTenHang.textColor = UIColor.lightGray
        lbTenHang.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTenHang)
        
        lbProductNameText = UILabel(frame: CGRect(x: lbTenHang.frame.origin.x + lbTenHang.frame.width, y: lbTenHang.frame.origin.y, width: self.frame.width - lbTenHang.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbProductNameText.text = "\(item.MaSanPham ?? "") - \(item.TenSanPham ?? "")"
        lbProductNameText.textColor = UIColor.black
        lbProductNameText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductNameText)
        
        let lbProductNameTextHeight = lbProductNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbProductNameText.optimalHeight
        lbProductNameText.numberOfLines = 0
        
        lbProductNameText.frame = CGRect(x: lbProductNameText.frame.origin.x, y: lbProductNameText.frame.origin.y, width: lbProductNameText.frame.width, height: lbProductNameTextHeight)
        
        //seri
        let lbSeri = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductNameText.frame.origin.y + lbProductNameTextHeight + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbSeri.text = "Seri: "
        lbSeri.textColor = UIColor.lightGray
        lbSeri.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSeri)
        
        lbSeriNumber = UILabel(frame: CGRect(x: lbSeri.frame.origin.x + lbSeri.frame.width, y: lbSeri.frame.origin.y, width: lbProductNameText.frame.width, height: Common.Size(s: 20)))
        lbSeriNumber.text = "\(item.Serial ?? "")"
        lbSeriNumber.textColor = UIColor.black
        lbSeriNumber.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSeriNumber)
        
        //so luong
        
        let lbSL = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSeriNumber.frame.origin.y + lbSeriNumber.frame.height + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbSL.text = "Số lượng: "
        lbSL.textColor = UIColor.lightGray
        lbSL.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSL)
        
        lbProductCount = UILabel(frame: CGRect(x: lbSL.frame.origin.x + lbSL.frame.width, y: lbSL.frame.origin.y, width: lbProductNameText.frame.width, height: Common.Size(s: 20)))
        lbProductCount.text = "\(item.SoLuong ?? 0)"
        lbProductCount.textColor = UIColor.black
        lbProductCount.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductCount)
        
        //ly do
        let lbLyDo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductCount.frame.origin.y + lbProductCount.frame.height + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbLyDo.text = "Lý do: "
        lbLyDo.textColor = UIColor.lightGray
        lbLyDo.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbLyDo)
        
        lbProductDemoReason = UILabel(frame: CGRect(x: lbLyDo.frame.origin.x + lbLyDo.frame.width, y: lbLyDo.frame.origin.y, width: lbProductNameText.frame.width, height: Common.Size(s: 20)))
        lbProductDemoReason.text = "\(item.LyDo ?? "")"
        lbProductDemoReason.textColor = UIColor.black
        lbProductDemoReason.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductDemoReason)
        
        let lbProductDemoReasonHeight = lbProductDemoReason.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbProductDemoReason.optimalHeight
        lbProductDemoReason.numberOfLines = 0
        
        lbProductDemoReason.frame = CGRect(x: lbProductDemoReason.frame.origin.x, y: lbProductDemoReason.frame.origin.y, width: lbProductDemoReason.frame.width, height: lbProductDemoReasonHeight)
        
        //hinh anh
        let lbHinhAnh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductDemoReason.frame.origin.y + lbProductDemoReasonHeight + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbHinhAnh.text = "Hình ảnh: "
        lbHinhAnh.textColor = UIColor.lightGray
        lbHinhAnh.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbHinhAnh)
        
        imgViewTakePhoto = UIImageView(frame: CGRect(x: Common.Size(s: 15), y: lbHinhAnh.frame.origin.y + lbHinhAnh.frame.height + Common.Size(s: 5), width: self.frame.width - Common.Size(s: 30), height: Common.Size(s: 120)))
        imgViewTakePhoto.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        imgViewTakePhoto.contentMode = .scaleAspectFit
        self.addSubview(imgViewTakePhoto)
        
//        if ((item.Images == "") || (item.Images == nil)) {
//            imgViewTakePhoto.image = UIImage(named: "AddImage")
//        } else {
//            imgViewTakePhoto.image = UIImage(named: "\(item.Images ?? "")")
//        }
        item.Images = ""
        imgViewTakePhoto.image = UIImage(named: "AddImage")
        
        
        let tapTakePhoto = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        imgViewTakePhoto.isUserInteractionEnabled = true
        imgViewTakePhoto.addGestureRecognizer(tapTakePhoto)
        
        estimateCellHeight = imgViewTakePhoto.frame.origin.y + imgViewTakePhoto.frame.height + Common.Size(s: 20)
    }
    
    @objc func takePhoto(){
        debugPrint("takephoto")
        //show camera
        self.delegate?.showCamera(at: cellIndexPath!)
    }
    
    
}

class ImportProductDemoCell: UITableViewCell {
    
    var lbProductNameText: UILabel!
    var lbSeriNumber: UILabel!
    var lbProductCount: UILabel!
    var lbProductDemoReason: UILabel!
    
    var estimateCellHeight: CGFloat = 0
    
    func setUpCell(item:DetailXuatDemo) {
        self.subviews.forEach({$0.removeFromSuperview()})
        //ten hang
        let lbTenHang = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 10), width: self.frame.width/3 - Common.Size(s: 15), height: Common.Size(s: 20)))
        lbTenHang.text = "Tên hàng: "
        lbTenHang.textColor = UIColor.lightGray
        lbTenHang.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbTenHang)
        
        lbProductNameText = UILabel(frame: CGRect(x: lbTenHang.frame.origin.x + lbTenHang.frame.width, y: lbTenHang.frame.origin.y, width: self.frame.width - lbTenHang.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbProductNameText.text = "\(item.MaSanPham ?? "") - \(item.TenSanPham ?? "")"
        lbProductNameText.textColor = UIColor.black
        lbProductNameText.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductNameText)
        
        let lbProductNameTextHeight = lbProductNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbProductNameText.optimalHeight
        lbProductNameText.numberOfLines = 0
        
        lbProductNameText.frame = CGRect(x: lbProductNameText.frame.origin.x, y: lbProductNameText.frame.origin.y, width: lbProductNameText.frame.width, height: lbProductNameTextHeight)
        
        //seri
        let lbSeri = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductNameText.frame.origin.y + lbProductNameTextHeight + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbSeri.text = "Seri: "
        lbSeri.textColor = UIColor.lightGray
        lbSeri.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSeri)
        
        lbSeriNumber = UILabel(frame: CGRect(x: lbSeri.frame.origin.x + lbSeri.frame.width, y: lbSeri.frame.origin.y, width: lbProductNameText.frame.width, height: Common.Size(s: 20)))
        lbSeriNumber.text = "\(item.Serial ?? "")"
        lbSeriNumber.textColor = UIColor.black
        lbSeriNumber.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSeriNumber)
        
        let lbSeriNumberHeight = lbSeriNumber.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbSeriNumber.optimalHeight
        lbSeriNumber.numberOfLines = 0
        
        lbSeriNumber.frame = CGRect(x: lbSeriNumber.frame.origin.x, y: lbSeriNumber.frame.origin.y, width: lbSeriNumber.frame.width, height: lbSeriNumberHeight)
        
        //so luong
        
        let lbSL = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbSeriNumber.frame.origin.y + lbSeriNumberHeight + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbSL.text = "Số lượng: "
        lbSL.textColor = UIColor.lightGray
        lbSL.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbSL)
        
        lbProductCount = UILabel(frame: CGRect(x: lbSL.frame.origin.x + lbSL.frame.width, y: lbSL.frame.origin.y, width: lbProductNameText.frame.width, height: Common.Size(s: 20)))
        lbProductCount.text = "\(item.SoLuong ?? 0)"
        lbProductCount.textColor = UIColor.black
        lbProductCount.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductCount)
        
        //ly do
        let lbLyDo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbProductCount.frame.origin.y + lbProductCount.frame.height + Common.Size(s: 5), width: lbTenHang.frame.width, height: Common.Size(s: 20)))
        lbLyDo.text = "Lý do: "
        lbLyDo.textColor = UIColor.lightGray
        lbLyDo.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbLyDo)
        
        lbProductDemoReason = UILabel(frame: CGRect(x: lbLyDo.frame.origin.x + lbLyDo.frame.width, y: lbLyDo.frame.origin.y, width: lbProductNameText.frame.width, height: Common.Size(s: 20)))
        lbProductDemoReason.text = "\(item.LyDo ?? "")"
        lbProductDemoReason.textColor = UIColor.black
        lbProductDemoReason.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(lbProductDemoReason)
        
        let lbProductDemoReasonHeight = lbProductDemoReason.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbProductDemoReason.optimalHeight
        lbProductDemoReason.numberOfLines = 0
        
        lbProductDemoReason.frame = CGRect(x: lbProductDemoReason.frame.origin.x, y: lbProductDemoReason.frame.origin.y, width: lbProductDemoReason.frame.width, height: lbProductDemoReasonHeight)
        
        estimateCellHeight = lbProductDemoReason.frame.origin.y + lbProductDemoReasonHeight + Common.Size(s: 20)
    }
}
