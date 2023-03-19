//
//  DetailCheckListShopASMViewController.swift
//  fptshop
//
//  Created by Apple on 8/8/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class DetailCheckListShopASMViewController: UIViewController {
    
    static let JOB_TITLE_CODE_ASM = "00241"
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    
    var lbChooseShop: UILabel!
    var btnSendThongBao: UIButton!
    static var shop: ShopByASM?
    
    var lbThongBaoText1: UILabel!
    var lbThongBaoText2: UILabel!
    var lbThongBaoText3: UILabel!
    var lbThongBaoText4: UILabel!
    
    var lbDSTargetPK: UILabel!
    var lbDSTargetTyTrongTraGop: UILabel!
    var lbDSSPHotSale: UILabel!
    
    var collectionViewDSTargetPK: UICollectionView!
    var collectionViewDSTargetTyTrongTraGop: UICollectionView!
    var collectionViewDSSPHotSale: UICollectionView!
    
    var headerDSTargetPK: [String] = ["Tên NV", "DS PK Còn lại", "DS Còn lại"];
    //    var headerDSTargetTyTrongTraGop: [String] = ["p_Target_index", "Current_Index"];
    var headerDSTargetTyTrongTraGop: [String] = ["Chỉ số hiện tại", "Target"];
    //    var headerDSSPHotSale: [String] = ["MaSP","Model","TenSP"];
    var headerDSSPHotSale: [String] = ["MaSP","TenSP"];
    
    
    var cellDataDSTargetPK: [[String]] = [];
    var cellDataDSTargetTyTrongTraGop: [[String]] = [];
    var cellDataDSSPHotSale: [[String]] = [];
    var contentView: UIView!
    
    var listNoiDung = [Checklistshop_ASM_getNoiDung]()
    var listDSTargetPK = [Checklistshop_ASM_getDSTargetPK]()
    var listDSTTTraGop = [Checklistshop_ASM_getDSTargetTyTrongTraGop]()
    var listDSHotSale = [Checklistshop_ASM_getDSSPHotSale]()
    
    //Setting up view to portrait when view disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.view.subviews.forEach({$0.removeFromSuperview()});
    }
    
    @objc func canRotate() -> Void{}
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                if DetailCheckListShopASMViewController.shop != nil {
                    
                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                        mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(DetailCheckListShopASMViewController.shop?.MaShop ?? "\(Cache.user!.ShopCode )")", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                
                                self.generateDSTargetPK(data: rsDSTargetPK)
                                self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                                self.generateDSSPHotSale(data: rsDSSPHotSale)
                                
                                self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                                self.lbChooseShop.text = "\(DetailCheckListShopASMViewController.shop?.TenShop ?? "")"
                            }
                        })
                    }
                } else {
                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                        mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(Cache.user!.ShopCode )", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                
                                self.generateDSTargetPK(data: rsDSTargetPK)
                                self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                                self.generateDSSPHotSale(data: rsDSSPHotSale)
                                
                                self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                                self.lbChooseShop.text = "\(Cache.user!.ShopName)"
                            }
                        })
                    }
                }
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                if DetailCheckListShopASMViewController.shop != nil {
                    
                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                        mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(DetailCheckListShopASMViewController.shop?.MaShop ?? "\(Cache.user!.ShopCode )")", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                
                                self.generateDSTargetPK(data: rsDSTargetPK)
                                self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                                self.generateDSSPHotSale(data: rsDSSPHotSale)
                                
                                self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                                self.lbChooseShop.text = "\(DetailCheckListShopASMViewController.shop?.TenShop ?? "")"
                            }
                        })
                    }
                } else {
                    WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                        mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(Cache.user!.ShopCode )", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                            
                            WaitingNetworkResponseAlert.DismissWaitingAlert {
                                
                                self.generateDSTargetPK(data: rsDSTargetPK)
                                self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                                self.generateDSSPHotSale(data: rsDSSPHotSale)
                                
                                self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                                self.lbChooseShop.text = "\(Cache.user!.ShopName)"
                            }
                        })
                    }
                }
            default:
                print("Upside down, and that is not supported");
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.subviews.forEach({ $0.removeFromSuperview() });
        
        if DetailCheckListShopASMViewController.shop != nil {
            
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(DetailCheckListShopASMViewController.shop?.MaShop ?? "\(Cache.user!.ShopCode )")", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        
                        self.generateDSTargetPK(data: rsDSTargetPK)
                        self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                        self.generateDSSPHotSale(data: rsDSSPHotSale)
                        
                        self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                        self.lbChooseShop.text = "\(DetailCheckListShopASMViewController.shop?.TenShop ?? "")"
                    }
                })
            }
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(Cache.user!.ShopCode )", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        
                        self.generateDSTargetPK(data: rsDSTargetPK)
                        self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                        self.generateDSSPHotSale(data: rsDSSPHotSale)
                        
                        self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                        self.lbChooseShop.text = "\(Cache.user!.ShopName)"
                    }
                })
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Shop ASM"
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 45)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        
        let viewRightNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 20, height: 20)))
        self.navigationItem.rightBarButtonItem  = UIBarButtonItem(customView: viewRightNav)
        let btnAdd = UIButton.init(type: .custom)
        btnAdd.setImage(#imageLiteral(resourceName: "add-1"), for: UIControl.State.normal)
        btnAdd.imageView?.contentMode = .scaleAspectFit
        btnAdd.addTarget(self, action: #selector(addNewShopASM), for: UIControl.Event.touchUpInside)
        btnAdd.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        viewRightNav.addSubview(btnAdd)
        
        //        self.listNoiDung = rsNoiDung
        //        self.listDSTargetPK = rsDSTargetPK
        //        self.listDSTTTraGop = rsDSTTTraGop
        //        self.listDSHotSale = rsDSSPHotSale
        
        if DetailCheckListShopASMViewController.shop != nil {
            
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(DetailCheckListShopASMViewController.shop?.MaShop ?? "\(Cache.user!.ShopCode)")", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        
                        self.generateDSTargetPK(data: rsDSTargetPK)
                        self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                        self.generateDSSPHotSale(data: rsDSSPHotSale)
                        
                        self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                        self.lbChooseShop.text = "\(DetailCheckListShopASMViewController.shop?.TenShop ?? "")"
                    }
                })
            }
        } else {
            WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(Cache.user!.ShopCode)", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                    
                    WaitingNetworkResponseAlert.DismissWaitingAlert {
                        
                        self.generateDSTargetPK(data: rsDSTargetPK)
                        self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                        self.generateDSSPHotSale(data: rsDSSPHotSale)
                        
                        self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                        self.lbChooseShop.text = "\(Cache.user!.ShopName)"
                    }
                })
            }
        }
    }
    
    
    func setUpViewNoiDung(rsNoiDung: [Checklistshop_ASM_getNoiDung]) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        //        let lbShop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: Common.Size(s: 15), width: (scrollView.frame.width - Common.Size(s: 15))/4, height: Common.Size(s: 25)))
        let lbShop = UILabel(frame: CGRect(x: 15, y: 15, width: (scrollView.frame.width - 15)/4, height: 25))
        lbShop.text = "Shop"
        lbShop.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbShop)
        
        //        lbChooseShop = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width, y: lbShop.frame.origin.y, width: scrollView.frame.width - lbShop.frame.width - Common.Size(s: 30), height: Common.Size(s: 25)))
        lbChooseShop = UILabel(frame: CGRect(x: lbShop.frame.origin.x + lbShop.frame.width, y: lbShop.frame.origin.y, width: scrollView.frame.width - lbShop.frame.width - 30, height: 30))
        lbChooseShop.text = "\(Cache.user!.ShopName)"
        lbChooseShop.textAlignment = .center
        lbChooseShop.font = UIFont.systemFont(ofSize: 14)
        lbChooseShop.layer.borderColor = UIColor.lightGray.cgColor
        lbChooseShop.layer.borderWidth = 1
        scrollView.addSubview(lbChooseShop)
        
        let lbChooseShopHeight: CGFloat = lbChooseShop.optimalHeight < 30 ? 30 : lbChooseShop.optimalHeight
        lbChooseShop.numberOfLines = 0
        lbChooseShop.frame = CGRect(x: lbChooseShop.frame.origin.x, y: lbChooseShop.frame.origin.y, width: lbChooseShop.frame.width, height: lbChooseShopHeight)
        
        let tapShowListShop = UITapGestureRecognizer(target: self, action: #selector(showListShop))
        lbChooseShop.isUserInteractionEnabled = true
        lbChooseShop.addGestureRecognizer(tapShowListShop)
        
        //        contentView = UIView(frame: CGRect(x: 0, y: lbChooseShop.frame.origin.y + lbChooseShopHeight + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 20)))
        contentView = UIView(frame: CGRect(x: 0, y: lbChooseShop.frame.origin.y + lbChooseShopHeight + 10, width: scrollView.frame.width, height: 20))
        contentView.backgroundColor = .white
        scrollView.addSubview(contentView)
        
        let lbTB1 = UILabel(frame: CGRect(x: 15, y: 0, width: scrollView.frame.width - 30, height: 20))
        lbTB1.text = "Thông báo 1"
        lbTB1.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbTB1)
        
        //        lbThongBaoText1 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTB1.frame.origin.y + lbTB1.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbThongBaoText1 = UILabel(frame: CGRect(x: 15, y: lbTB1.frame.origin.y + lbTB1.frame.height + 5, width: scrollView.frame.width - 30, height: 35))
        lbThongBaoText1.font = UIFont.systemFont(ofSize: 14)
        lbThongBaoText1.layer.cornerRadius = 5
        lbThongBaoText1.layer.borderColor = UIColor.lightGray.cgColor
        lbThongBaoText1.layer.borderWidth = 1
        contentView.addSubview(lbThongBaoText1)
        
        if rsNoiDung.count > 0 {
            lbThongBaoText1.text = " \(rsNoiDung[0].p_content)"
        } else {
            lbThongBaoText1.text = ""
        }
        
        let lbThongBaoText1Height: CGFloat = lbThongBaoText1.optimalHeight < 35 ? 35 : lbThongBaoText1.optimalHeight
        lbThongBaoText1.numberOfLines = 0
        lbThongBaoText1.frame = CGRect(x: lbThongBaoText1.frame.origin.x, y: lbThongBaoText1.frame.origin.y, width: lbThongBaoText1.frame.width, height: lbThongBaoText1Height)
        
        //--
        //        let lbTB2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbThongBaoText1.frame.origin.y + lbThongBaoText1Height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbTB2 = UILabel(frame: CGRect(x: 15, y: lbThongBaoText1.frame.origin.y + lbThongBaoText1Height + 10, width: scrollView.frame.width - 30, height: 20))
        lbTB2.text = "Thông báo 2"
        lbTB2.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbTB2)
        
        //        lbThongBaoText2 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTB2.frame.origin.y + lbTB2.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbThongBaoText2 = UILabel(frame: CGRect(x: 15, y: lbTB2.frame.origin.y + lbTB2.frame.height + 5, width: scrollView.frame.width - 30, height: 35))
        lbThongBaoText2.font = UIFont.systemFont(ofSize: 14)
        lbThongBaoText2.layer.cornerRadius = 5
        lbThongBaoText2.layer.borderColor = UIColor.lightGray.cgColor
        lbThongBaoText2.layer.borderWidth = 1
        contentView.addSubview(lbThongBaoText2)
        
        if rsNoiDung.count > 0 {
            lbThongBaoText2.text = " \(rsNoiDung[1].p_content)"
        } else {
            lbThongBaoText2.text = ""
        }
        
        let lbThongBaoText2Height: CGFloat = lbThongBaoText2.optimalHeight < 35 ? 35 : lbThongBaoText2.optimalHeight
        lbThongBaoText2.numberOfLines = 0
        lbThongBaoText2.frame = CGRect(x: lbThongBaoText2.frame.origin.x, y: lbThongBaoText2.frame.origin.y, width: lbThongBaoText2.frame.width, height: lbThongBaoText2Height)
        
        
        //--
        //        let lbTB3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbThongBaoText2.frame.origin.y + lbThongBaoText2Height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbTB3 = UILabel(frame: CGRect(x: 15, y: lbThongBaoText2.frame.origin.y + lbThongBaoText2Height + 10, width: scrollView.frame.width - 30, height: 20))
        lbTB3.text = "Thông báo 3"
        lbTB3.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbTB3)
        
        //        lbThongBaoText3 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTB3.frame.origin.y + lbTB3.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbThongBaoText3 = UILabel(frame: CGRect(x: 15, y: lbTB3.frame.origin.y + lbTB3.frame.height + 5, width: scrollView.frame.width - 30, height: 35))
        lbThongBaoText3.font = UIFont.systemFont(ofSize: 14)
        lbThongBaoText3.layer.cornerRadius = 5
        lbThongBaoText3.layer.borderColor = UIColor.lightGray.cgColor
        lbThongBaoText3.layer.borderWidth = 1
        contentView.addSubview(lbThongBaoText3)
        
        if rsNoiDung.count > 0 {
            lbThongBaoText3.text = " \(rsNoiDung[2].p_content)"
        } else {
            lbThongBaoText3.text = ""
        }
        
        let lbThongBaoText3Height: CGFloat = lbThongBaoText3.optimalHeight < 35 ? 35 : lbThongBaoText3.optimalHeight
        lbThongBaoText3.numberOfLines = 0
        lbThongBaoText3.frame = CGRect(x: lbThongBaoText3.frame.origin.x, y: lbThongBaoText3.frame.origin.y, width: lbThongBaoText3.frame.width, height: lbThongBaoText3Height)
        
        //--
        //        let lbTB4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbThongBaoText3.frame.origin.y + lbThongBaoText3Height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        let lbTB4 = UILabel(frame: CGRect(x: 15, y: lbThongBaoText3.frame.origin.y + lbThongBaoText3Height + 10, width: scrollView.frame.width - 30, height: 20))
        lbTB4.text = "Thông báo 4"
        lbTB4.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(lbTB4)
        
        //        lbThongBaoText4 = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbTB4.frame.origin.y + lbTB4.frame.height + Common.Size(s: 5), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 35)))
        lbThongBaoText4 = UILabel(frame: CGRect(x: 15, y: lbTB4.frame.origin.y + lbTB4.frame.height + 5, width: scrollView.frame.width - 30, height: 35))
        lbThongBaoText4.font = UIFont.systemFont(ofSize: 14)
        lbThongBaoText4.layer.cornerRadius = 5
        lbThongBaoText4.layer.borderColor = UIColor.lightGray.cgColor
        lbThongBaoText4.layer.borderWidth = 1
        contentView.addSubview(lbThongBaoText4)
        
        if rsNoiDung.count > 0 {
            lbThongBaoText4.text = " \(rsNoiDung[3].p_content)"
        } else {
            lbThongBaoText4.text = ""
        }
        
        let lbThongBaoText4Height: CGFloat = lbThongBaoText4.optimalHeight < 35 ? 35 : lbThongBaoText4.optimalHeight
        lbThongBaoText4.numberOfLines = 0
        lbThongBaoText4.frame = CGRect(x: lbThongBaoText4.frame.origin.x, y: lbThongBaoText4.frame.origin.y, width: lbThongBaoText4.frame.width, height: lbThongBaoText4Height)
        
        //----
        
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: contentView.frame.width, height: lbThongBaoText4.frame.origin.y + lbThongBaoText4Height + Common.Size(s: 5))
        
        //---
        
        self.SetUpCollectionViewDSTargetPK()
        self.SetUpCollectionViewDSTargetTyTrongTraGop()
        self.SetUpCollectionViewDSSPHotSale()
        
        
        //        btnSendThongBao = UIButton(frame: CGRect(x: Common.Size(s: 15), y: collectionViewDSSPHotSale.frame.origin.y + collectionViewDSSPHotSale.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 45)))
        
        btnSendThongBao = UIButton(frame: CGRect(x: 15, y: collectionViewDSSPHotSale.frame.origin.y + collectionViewDSSPHotSale.frame.height + 15, width: scrollView.frame.width - 30, height: 45))
        btnSendThongBao.setTitle("Đã họp đầu ca", for: .normal)
        btnSendThongBao.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnSendThongBao.layer.cornerRadius = 5
        scrollView.addSubview(btnSendThongBao)
        btnSendThongBao.addTarget(self, action: #selector(checkListASMConfirm), for: .touchUpInside)
        
        if Cache.user?.JobTitle == DetailCheckListShopASMViewController.JOB_TITLE_CODE_ASM {
            btnSendThongBao.isHidden = true
            
            scrollViewHeight = collectionViewDSSPHotSale.frame.origin.y + collectionViewDSSPHotSale.frame.height + 15 + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
                + Common.Size(s: 30)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
            
        } else {
            btnSendThongBao.isHidden = false
            
            scrollViewHeight = btnSendThongBao.frame.origin.y + btnSendThongBao.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
                + Common.Size(s: 30)
            scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
        }
        
        
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addNewShopASM() {
        let vc = AddNewCheckListShopASMViewController()
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    @objc func showListShop() {
        let vc = ChooseOneShopASMViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    @objc func checkListASMConfirm() {
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            let rs = mSMApiManager.Checklist_ASM_confirm().Data ?? []
            WaitingNetworkResponseAlert.DismissWaitingAlert {
                if rs.count > 0 {
                    if rs[0].p_status == 1 {
                        let alertVC = UIAlertController(title: "Thông báo", message: "\(rs[0].p_messagess ?? "Xác nhận thành công")", preferredStyle: .alert)
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            if DetailCheckListShopASMViewController.shop != nil {
                                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                                    mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(DetailCheckListShopASMViewController.shop?.MaShop ?? "\(Cache.user!.ShopCode)")", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                                        
                                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                                            
                                            self.generateDSTargetPK(data: rsDSTargetPK)
                                            self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                                            self.generateDSSPHotSale(data: rsDSSPHotSale)
                                            
                                            self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                                            self.lbChooseShop.text = "\(DetailCheckListShopASMViewController.shop?.TenShop ?? "")"
                                        }
                                    })
                                }
                            } else {
                                WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
                                    mSMApiManager.Checklistshop_ASM_get(p_Shopcode: "\(Cache.user!.ShopCode)", handler: { (rsNoiDung, rsDSTargetPK, rsDSTTTraGop, rsDSSPHotSale, err) in
                                        
                                        WaitingNetworkResponseAlert.DismissWaitingAlert {
                                            
                                            self.generateDSTargetPK(data: rsDSTargetPK)
                                            self.generateDSTargetTyTrongTraGop(data: rsDSTTTraGop)
                                            self.generateDSSPHotSale(data: rsDSSPHotSale)
                                            
                                            self.setUpViewNoiDung(rsNoiDung: rsNoiDung)
                                            self.lbChooseShop.text = "\(Cache.user!.ShopName)"
                                        }
                                    })
                                }
                            }
                        })
                        self.dismiss(animated: true, completion: nil)
                        alertVC.addAction(action)
                        self.present(alertVC, animated: true, completion: nil)
                        
                    } else{
                        self.showAlert(title: "Thông báo", message: "\(rs[0].p_messagess ?? "Xác nhận thất bại!")")
                    }
                } else {
                    debugPrint("load api err")
                }
                
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertVC.addAction(action)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func generateDSTargetPK(data: [Checklistshop_ASM_getDSTargetPK]) {
        cellDataDSTargetPK = [[String]]()
        for item in data {
            self.cellDataDSTargetPK.append([
                "\(item.Name)",
                "\(Common.convertCurrencyV2(value: item.DS_PK_ConLai))",
                "\(Common.convertCurrencyV2(value: item.DS_ConLai))"
                ]);
        }
    }
    
    func generateDSTargetTyTrongTraGop(data: [Checklistshop_ASM_getDSTargetTyTrongTraGop]) {
        cellDataDSTargetTyTrongTraGop = [[String]]()
        for item in data {
            self.cellDataDSTargetTyTrongTraGop.append([
                "\(item.Current_Index)",
                "\(item.p_Target_index)"
                ]);
        }
    }
    
    func generateDSSPHotSale(data: [Checklistshop_ASM_getDSSPHotSale]) {
        cellDataDSSPHotSale = [[String]]()
        for item in data {
            self.cellDataDSSPHotSale.append([
                "\(item.MaSP)",
                "\(item.TenSP)"
                ]);
        }
    }
    
    func SetUpCollectionViewDSTargetPK(){
        self.navigationController?.navigationBar.isTranslucent = true;
        
        //        lbDSTargetPK = UILabel(frame: CGRect(x: Common.Size(s: 15), y: contentView.frame.origin.y + contentView.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbDSTargetPK = UILabel(frame: CGRect(x: 15, y: contentView.frame.origin.y + contentView.frame.height + 10, width: scrollView.frame.width - 30, height: 20))
        lbDSTargetPK.text = "DS Target PK"
        lbDSTargetPK.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDSTargetPK)
        
        var tempHeaderForSize = self.headerDSTargetPK
        
        //Setup cell size
        for i in 0..<cellDataDSTargetPK.count{
            for j in 0..<tempHeaderForSize.count{
                if("\(tempHeaderForSize[j])".count < "\(cellDataDSTargetPK[i][j])".count){
                    tempHeaderForSize[j] = "\(cellDataDSTargetPK[i][j])";
                }
            }
        }
        
        let collectionViewLayout = DSTargetPKCheckListShopLayout();
        collectionViewLayout.numberOfColumns = headerDSTargetPK.count;
        collectionViewLayout.titleArray = tempHeaderForSize;
        
        let collectionViewDSTargetPKHeight:CGFloat = CGFloat((cellDataDSTargetPK.count + 1) * 25)
        self.collectionViewDSTargetPK = UICollectionView.init(frame: CGRect(x: 15, y: lbDSTargetPK.frame.origin.y + lbDSTargetPK.frame.height + Common.Size(s: 5), width: scrollView.frame.size.width - 30, height: collectionViewDSTargetPKHeight), collectionViewLayout: collectionViewLayout);
        
        self.collectionViewDSTargetPK.delegate = self;
        self.collectionViewDSTargetPK.dataSource = self;
        self.collectionViewDSTargetPK.showsHorizontalScrollIndicator = true;
        self.collectionViewDSTargetPK.backgroundColor = UIColor.white;
        
        scrollView.bringSubviewToFront(collectionViewDSTargetPK);
        self.collectionViewDSTargetPK.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        self.collectionViewDSTargetPK.backgroundColor = UIColor.white
        scrollView.addSubview(self.collectionViewDSTargetPK)
        
        if(cellDataDSTargetPK.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 15, y: lbDSTargetPK.frame.origin.y + lbDSTargetPK.frame.height + 5, width: scrollView.frame.size.width - 30, height: collectionViewDSTargetPKHeight);
            emptyView.layer.borderColor = UIColor.lightGray.cgColor
            emptyView.layer.borderWidth = 1
            scrollView.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        
    }
    
    func SetUpCollectionViewDSTargetTyTrongTraGop(){
        self.navigationController?.navigationBar.isTranslucent = true;
        
        //        lbDSTargetTyTrongTraGop = UILabel(frame: CGRect(x: Common.Size(s: 15), y: collectionViewDSTargetPK.frame.origin.y + collectionViewDSTargetPK.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbDSTargetTyTrongTraGop = UILabel(frame: CGRect(x: 15, y: collectionViewDSTargetPK.frame.origin.y + collectionViewDSTargetPK.frame.height + 10, width: scrollView.frame.width - 30, height: 20))
        lbDSTargetTyTrongTraGop.text = "DS Target Tỷ Trọng Trả Góp"
        lbDSTargetTyTrongTraGop.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDSTargetTyTrongTraGop)
        
        var tempHeaderForSize = self.headerDSTargetTyTrongTraGop
        
        //Setup cell size
        for i in 0..<cellDataDSTargetTyTrongTraGop.count{
            for j in 0..<tempHeaderForSize.count{
                if("\(tempHeaderForSize[j])".count < "\(cellDataDSTargetTyTrongTraGop[i][j])".count){
                    tempHeaderForSize[j] = "\(cellDataDSTargetTyTrongTraGop[i][j])";
                }
            }
        }
        
        let collectionViewLayout = CheckListShopASMCollectionViewLayout();
        collectionViewLayout.numberOfColumns = headerDSTargetTyTrongTraGop.count;
        collectionViewLayout.titleArray = tempHeaderForSize;
        
        let collectionViewDSTargetTyTrongTraGopHeight:CGFloat = CGFloat((cellDataDSTargetTyTrongTraGop.count + 1) * 25)
        
        self.collectionViewDSTargetTyTrongTraGop = UICollectionView.init(frame: CGRect(x: 15, y: lbDSTargetTyTrongTraGop.frame.origin.y + lbDSTargetTyTrongTraGop.frame.height + 5, width: scrollView.frame.size.width - 30, height: collectionViewDSTargetTyTrongTraGopHeight), collectionViewLayout: collectionViewLayout);
        
        self.collectionViewDSTargetTyTrongTraGop.delegate = self;
        self.collectionViewDSTargetTyTrongTraGop.dataSource = self;
        self.collectionViewDSTargetTyTrongTraGop.showsHorizontalScrollIndicator = true;
        self.collectionViewDSTargetTyTrongTraGop.backgroundColor = UIColor.white;
        
        scrollView.bringSubviewToFront(collectionViewDSTargetTyTrongTraGop);
        self.collectionViewDSTargetTyTrongTraGop.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        self.collectionViewDSTargetTyTrongTraGop.backgroundColor = UIColor.white
        scrollView.addSubview(self.collectionViewDSTargetTyTrongTraGop)
        
        if(cellDataDSTargetTyTrongTraGop.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 15, y: lbDSTargetTyTrongTraGop.frame.origin.y + lbDSTargetTyTrongTraGop.frame.height + 5, width: scrollView.frame.size.width - 30, height: collectionViewDSTargetTyTrongTraGopHeight);
            emptyView.layer.borderColor = UIColor.lightGray.cgColor
            emptyView.layer.borderWidth = 1
            scrollView.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        
    }
    
    func SetUpCollectionViewDSSPHotSale(){
        self.navigationController?.navigationBar.isTranslucent = true;
        
        //        lbDSSPHotSale = UILabel(frame: CGRect(x: Common.Size(s: 15), y: collectionViewDSTargetTyTrongTraGop.frame.origin.y + collectionViewDSTargetTyTrongTraGop.frame.height + Common.Size(s: 10), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 20)))
        lbDSSPHotSale = UILabel(frame: CGRect(x: 15, y: collectionViewDSTargetTyTrongTraGop.frame.origin.y + collectionViewDSTargetTyTrongTraGop.frame.height + 10, width: scrollView.frame.width - 30, height: 20))
        lbDSSPHotSale.text = "DS Sản Phẩm Hot Sale"
        lbDSSPHotSale.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbDSSPHotSale)
        
        var tempHeaderForSize = self.headerDSSPHotSale
        
        //Setup cell size
        for i in 0..<cellDataDSSPHotSale.count{
            for j in 0..<tempHeaderForSize.count{
                if("\(tempHeaderForSize[j])".count < "\(cellDataDSSPHotSale[i][j])".count){
                    tempHeaderForSize[j] = "\(cellDataDSSPHotSale[i][j])";
                }
            }
        }
        
        let collectionViewLayout = CheckListShopASMCollectionViewLayout();
        collectionViewLayout.numberOfColumns = headerDSSPHotSale.count;
        collectionViewLayout.titleArray = tempHeaderForSize;
        
        let collectionViewDSSPHotSaleHeight:CGFloat = CGFloat((cellDataDSSPHotSale.count + 1) * 25)
        
        self.collectionViewDSSPHotSale = UICollectionView.init(frame: CGRect(x: 15, y: lbDSSPHotSale.frame.origin.y + lbDSSPHotSale.frame.height + 5, width: scrollView.frame.size.width - 30, height: collectionViewDSSPHotSaleHeight), collectionViewLayout: collectionViewLayout);
        
        self.collectionViewDSSPHotSale.delegate = self;
        self.collectionViewDSSPHotSale.dataSource = self;
        self.collectionViewDSSPHotSale.showsHorizontalScrollIndicator = true;
        self.collectionViewDSSPHotSale.backgroundColor = UIColor.white;
        
        scrollView.bringSubviewToFront(collectionViewDSSPHotSale);
        self.collectionViewDSSPHotSale.register(ReportDataCollectionViewCell.self, forCellWithReuseIdentifier: "cell");
        
        
        self.collectionViewDSSPHotSale.backgroundColor = UIColor.white
        scrollView.addSubview(self.collectionViewDSSPHotSale)
        
        if(cellDataDSSPHotSale.count == 0){
            let emptyView = Bundle.main.loadNibNamed("EmptyDataView", owner: nil, options: nil)![0] as! UIView;
            emptyView.frame = CGRect(x: 15, y: lbDSSPHotSale.frame.origin.y + lbDSSPHotSale.frame.height + 5, width: scrollView.frame.size.width - 30, height: collectionViewDSSPHotSaleHeight);
            emptyView.layer.borderColor = UIColor.lightGray.cgColor
            emptyView.layer.borderWidth = 1
            scrollView.addSubview(emptyView);
        }
        self.navigationController?.navigationBar.isTranslucent = false;
        
    }
}

extension DetailCheckListShopASMViewController: ChooseOneShopASMViewControllerDelegate {
    func getShop(shop: ShopByASM) {
        DetailCheckListShopASMViewController.shop = shop
        self.lbChooseShop.text = shop.TenShop
        
        let lbChooseShopHeight: CGFloat = lbChooseShop.optimalHeight < 25 ? 25 : lbChooseShop.optimalHeight
        lbChooseShop.numberOfLines = 0
        lbChooseShop.frame = CGRect(x: lbChooseShop.frame.origin.x, y: lbChooseShop.frame.origin.y, width: lbChooseShop.frame.width, height: lbChooseShopHeight)
        
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: lbChooseShop.frame.origin.y + lbChooseShopHeight + 10, width: contentView.frame.width, height: contentView.frame.height)
        
        btnSendThongBao.frame = CGRect(x: btnSendThongBao.frame.origin.x, y: contentView.frame.origin.y + contentView.frame.height + 15, width: btnSendThongBao.frame.width, height: btnSendThongBao.frame.height)
        
        scrollViewHeight = btnSendThongBao.frame.origin.y + btnSendThongBao.frame.height + (navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height
            + 30
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
}

extension DetailCheckListShopASMViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == collectionViewDSTargetPK {
            return cellDataDSTargetPK.count + 1
        } else if collectionView == collectionViewDSTargetTyTrongTraGop {
            return cellDataDSTargetTyTrongTraGop.count + 1
        } else if collectionView == collectionViewDSSPHotSale {
            return cellDataDSSPHotSale.count + 1
        } else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewDSTargetPK {
            return headerDSTargetPK.count
        } else if collectionView == collectionViewDSTargetTyTrongTraGop {
            return headerDSTargetTyTrongTraGop.count
        } else if collectionView == collectionViewDSSPHotSale {
            return headerDSSPHotSale.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportDataCollectionViewCell;
        
        if indexPath.section % 2 == 0 {
            cell.backgroundColor = UIColor(white: 235/255.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor.white
        }
        
        if collectionView == collectionViewDSTargetPK {
            if(indexPath.section == 0){
                cell.setupHeader(item: headerDSTargetPK[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                if indexPath.row == 0 {
                    cell.setupNameLeft(item: cellDataDSTargetPK[indexPath.section - 1][indexPath.row]);
                } else {
                    cell.setupName(item: cellDataDSTargetPK[indexPath.section - 1][indexPath.row]);
                }
                
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
            
        } else if collectionView == collectionViewDSTargetTyTrongTraGop {
            if(indexPath.section == 0){
                cell.setupHeader(item: headerDSTargetTyTrongTraGop[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                
                cell.setupNameRed(item: cellDataDSTargetTyTrongTraGop[indexPath.section - 1][indexPath.row]);
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
            
        } else if collectionView == collectionViewDSSPHotSale {
            if(indexPath.section == 0){
                cell.setupHeader(item: headerDSSPHotSale[indexPath.row]);
                cell.backgroundColor = UIColor.lightGray;
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }else{
                
                cell.setupNameLeft(item: cellDataDSSPHotSale[indexPath.section - 1][indexPath.row]);
                cell.layer.borderWidth = 0.5;
                cell.layer.borderColor = UIColor.darkGray.cgColor;
            }
        }
        
        
        
        return cell
    }
}
