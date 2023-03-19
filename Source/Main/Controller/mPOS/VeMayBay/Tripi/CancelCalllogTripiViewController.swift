//
//  CancelCalllogTripiViewController.swift
//  fptshop
//
//  Created by DiemMy Le on 1/10/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog
import DLRadioButton

class CancelCalllogTripiViewController: UIViewController {
    var scrollView: UIScrollView!
    var calllogTripiType = 1
    var serviceNum = ""
    var cancelCalllogTripiTitle = "Huỷ Calllog Tripi"
    var scrollViewHeight: CGFloat = 0
    var tvNote:UITextView!
    var detailTribi:DetailFlightTribi?
    
    var radioDoiten:DLRadioButton!
    var radioMuaThemHanhLy:DLRadioButton!
    var radioMuaSuatAn:DLRadioButton!
    var radioEmBe:DLRadioButton!
    
    var radioHuyToanBoVe:DLRadioButton!
    var radioHuy1Chieu:DLRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = cancelCalllogTripiTitle
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.navigationBar.isTranslucent = false
        
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: Common.Size(s:50), height: Common.Size(s:45))))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: Common.Size(s:50), height: Common.Size(s:45))
        viewLeftNav.addSubview(btBackIcon)
        //        MPOSAPIManager.Flight_Tripi_GetConversation_CreateCalllog(bookingId: "1763940", DocenTry: "54", Type: "\(self.calllogTripiType)")
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Flight_Tripi_GetConversation_CreateCalllog(bookingId: "\(self.detailTribi?.bookingId ?? 0)", DocenTry: "\(self.detailTribi?.DocEntry ?? 0)", Type: "\(self.calllogTripiType)") { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            let item = rs[0]
                            self.setUpView(item: item)
                        } else {
                            self.setUpView(item: Tripi_GetConversation(DocEntry: 0, bookingId: 0, outboundPnrCode: "", inboundPnrCode: "", gender: "", fullName: "", email: "", phone: "", Conversation: ""))
                        }
                    } else {
                        let popup = PopupDialog(title: "Thông báo", message: "\(err)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let button1 = CancelButton(title: "OK"){
                        }
                        popup.addButtons([button1])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func setUpView(item: Tripi_GetConversation) {
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        let customerView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
        customerView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        scrollView.addSubview(customerView)
        
        let lbCustomerInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: customerView.frame.width - Common.Size(s: 30), height: customerView.frame.height))
        lbCustomerInfo.text = "THÔNG TIN KHÁCH HÀNG"
        lbCustomerInfo.font = UIFont.boldSystemFont(ofSize: 15)
        customerView.addSubview(lbCustomerInfo)
        
        let lbBookingID = UILabel(frame: CGRect(x: Common.Size(s: 15), y: customerView.frame.origin.y + customerView.frame.height + Common.Size(s: 10), width: (scrollView.frame.width - Common.Size(s: 30))/3, height: Common.Size(s: 20)))
        lbBookingID.text = "BookingID: "
        lbBookingID.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbBookingID)
        
        let lbBookingIDText = UILabel(frame: CGRect(x: lbBookingID.frame.origin.x + lbBookingID.frame.width, y: lbBookingID.frame.origin.y, width: (scrollView.frame.width - Common.Size(s: 30)) * 2/3, height: Common.Size(s: 20)))
        lbBookingIDText.text = "\(item.bookingId)"
        lbBookingIDText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbBookingIDText)
        
        let lbMaChuyenDi = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbBookingIDText.frame.origin.y + lbBookingIDText.frame.height + Common.Size(s: 5), width: lbBookingID.frame.width, height: Common.Size(s: 20)))
        lbMaChuyenDi.text = "Mã chuyến đi: "
        lbMaChuyenDi.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbMaChuyenDi)
        
        let lbMaChuyenDiText = UILabel(frame: CGRect(x: lbMaChuyenDi.frame.origin.x + lbMaChuyenDi.frame.width, y: lbMaChuyenDi.frame.origin.y, width: lbBookingIDText.frame.width, height: Common.Size(s: 20)))
        lbMaChuyenDiText.text = "\(item.outboundPnrCode)"
        lbMaChuyenDiText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbMaChuyenDiText)
        
        let lbMaChuyenVe = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaChuyenDiText.frame.origin.y + lbMaChuyenDiText.frame.height + Common.Size(s: 5), width: lbBookingID.frame.width, height: Common.Size(s: 20)))
        lbMaChuyenVe.text = "Mã chuyến về: "
        lbMaChuyenVe.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbMaChuyenVe)
        
        let lbMaChuyenVeText = UILabel(frame: CGRect(x: lbMaChuyenVe.frame.origin.x + lbMaChuyenVe.frame.width, y: lbMaChuyenVe.frame.origin.y, width: lbBookingIDText.frame.width, height: Common.Size(s: 20)))
        lbMaChuyenVeText.text = "\(item.inboundPnrCode)"
        lbMaChuyenVeText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbMaChuyenVeText)
        
        let lbGender = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbMaChuyenVeText.frame.origin.y + lbMaChuyenVeText.frame.height + Common.Size(s: 5), width: lbBookingID.frame.width, height: Common.Size(s: 20)))
        lbGender.text = "Giới tính: "
        lbGender.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbGender)
        
        let lbGenderText = UILabel(frame: CGRect(x: lbGender.frame.origin.x + lbGender.frame.width, y: lbGender.frame.origin.y, width: lbBookingIDText.frame.width, height: Common.Size(s: 20)))
        lbGenderText.text = "\(item.gender)"
        lbGenderText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbGenderText)
        
        let lbName = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbGenderText.frame.origin.y + lbGenderText.frame.height + Common.Size(s: 5), width: lbBookingID.frame.width, height: Common.Size(s: 20)))
        lbName.text = "Họ tên: "
        lbName.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbName)
        
        let lbNameText = UILabel(frame: CGRect(x: lbName.frame.origin.x + lbName.frame.width, y:  lbName.frame.origin.y, width: lbBookingIDText.frame.width, height: Common.Size(s: 20)))
        lbNameText.text = "\(item.fullName)"
        lbNameText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbNameText)
        
        let lbNameTextHeight: CGFloat = lbNameText.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lbNameText.optimalHeight
        lbNameText.numberOfLines = 0
        lbNameText.frame = CGRect(x: lbNameText.frame.origin.x, y: lbNameText.frame.origin.y, width: lbNameText.frame.width, height: lbNameTextHeight)
        
        let lbEmail = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbNameText.frame.origin.y + lbNameTextHeight + Common.Size(s: 5), width: lbBookingID.frame.width, height: Common.Size(s: 20)))
        lbEmail.text = "Email: "
        lbEmail.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbEmail)
        
        let lbEmailText = UILabel(frame: CGRect(x: lbEmail.frame.origin.x + lbEmail.frame.width, y: lbEmail.frame.origin.y, width: lbBookingIDText.frame.width, height: Common.Size(s: 20)))
        lbEmailText.text = "\(item.email)"
        lbEmailText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbEmailText)
        
        let lbSDT = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lbEmailText.frame.origin.y + lbEmailText.frame.height + Common.Size(s: 5), width: lbBookingID.frame.width, height: Common.Size(s: 20)))
        lbSDT.text = "SĐT: "
        lbSDT.font = UIFont.boldSystemFont(ofSize: 14)
        scrollView.addSubview(lbSDT)
        
        let lbSDTText = UILabel(frame: CGRect(x: lbSDT.frame.origin.x + lbSDT.frame.width, y: lbSDT.frame.origin.y, width: lbBookingIDText.frame.width, height: Common.Size(s: 20)))
        lbSDTText.text = "\(item.phone)"
        lbSDTText.font = UIFont.systemFont(ofSize: 14)
        scrollView.addSubview(lbSDTText)
        
        let changeInfoView = UIView(frame: CGRect(x: 0, y: lbSDTText.frame.origin.y + lbSDTText.frame.height + Common.Size(s: 10), width: scrollView.frame.width, height: Common.Size(s: 40)))
        changeInfoView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
        scrollView.addSubview(changeInfoView)
        
        //CHON DICH VU THEM VIEW
        if calllogTripiType == 6 {
            let viewMoreService = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbSDTText.frame.origin.y + lbSDTText.frame.height + Common.Size(s: 10), width: customerView.frame.width - Common.Size(s: 30), height: Common.Size(s: 100)))
            viewMoreService.backgroundColor = UIColor.white
            scrollView.addSubview(viewMoreService)
            
            let headerMoreServiceView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
            headerMoreServiceView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            viewMoreService.addSubview(headerMoreServiceView)
            
            let lbChooseService = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: headerMoreServiceView.frame.width - Common.Size(s: 30), height: headerMoreServiceView.frame.height))
            lbChooseService.text = "CHỌN DỊCH VỤ"
            lbChooseService.font = UIFont.boldSystemFont(ofSize: 15)
            headerMoreServiceView.addSubview(lbChooseService)
            
            radioDoiten = createRadioButtonGender(CGRect(x: Common.Size(s: 15), y: headerMoreServiceView.frame.origin.y + headerMoreServiceView.frame.height + Common.Size(s: 15), width: (viewMoreService.frame.size.width - Common.Size(s: 30))/2, height: Common.Size(s: 15)), title: "Đổi tên", color: UIColor.black);
            radioDoiten.isSelected = true
            viewMoreService.addSubview(radioDoiten)
            
            radioMuaThemHanhLy = createRadioButtonGender(CGRect(x: radioDoiten.frame.origin.x + radioDoiten.frame.width, y: radioDoiten.frame.origin.y, width: radioDoiten.frame.size.width, height: Common.Size(s: 15)), title: "Mua thêm hành lý", color: UIColor.black);
            radioMuaThemHanhLy.isSelected = false
            viewMoreService.addSubview(radioMuaThemHanhLy)
            
            radioMuaSuatAn = createRadioButtonGender(CGRect(x: Common.Size(s: 15), y: radioDoiten.frame.origin.y + radioDoiten.frame.height + Common.Size(s: 10), width: radioDoiten.frame.size.width, height: Common.Size(s: 15)), title: "Mua suất ăn", color: UIColor.black);
            radioMuaSuatAn.isSelected = false
            viewMoreService.addSubview(radioMuaSuatAn)
            
            radioEmBe = createRadioButtonGender(CGRect(x: radioMuaSuatAn.frame.origin.x + radioMuaSuatAn.frame.width, y: radioMuaSuatAn.frame.origin.y, width: radioDoiten.frame.size.width, height: Common.Size(s: 15)), title: "Em bé", color: UIColor.black);
            radioEmBe.isSelected = false
            viewMoreService.addSubview(radioEmBe)
            
            viewMoreService.frame = CGRect(x: 0, y: viewMoreService.frame.origin.y, width: scrollView.frame.width, height: radioEmBe.frame.origin.y + radioEmBe.frame.height + Common.Size(s: 15))
            
            changeInfoView.frame = CGRect(x: changeInfoView.frame.origin.x, y: viewMoreService.frame.origin.y + viewMoreService.frame.height, width: changeInfoView.frame.width, height: changeInfoView.frame.height)
        }
         //-----------------
        
        //CHON HUY 1 CHIEU VE KHU HOI
        if self.calllogTripiType == 5 {
            let viewCancelOneWay = UIView(frame: CGRect(x: Common.Size(s: 15), y: lbSDTText.frame.origin.y + lbSDTText.frame.height + Common.Size(s: 10), width: customerView.frame.width - Common.Size(s: 30), height: Common.Size(s: 100)))
            viewCancelOneWay.backgroundColor = UIColor.white
            scrollView.addSubview(viewCancelOneWay)
            
            let headerCancelOneWayView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.frame.width, height: Common.Size(s: 40)))
            headerCancelOneWayView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            viewCancelOneWay.addSubview(headerCancelOneWayView)
            
            let lbChooseCancelOneWay = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: headerCancelOneWayView.frame.width - Common.Size(s: 30), height: headerCancelOneWayView.frame.height))
            lbChooseCancelOneWay.text = "CHỌN THÔNG TIN CẦN HUỶ"
            lbChooseCancelOneWay.font = UIFont.boldSystemFont(ofSize: 15)
            headerCancelOneWayView.addSubview(lbChooseCancelOneWay)
            
            radioHuyToanBoVe = createRadioButtonGender(CGRect(x: Common.Size(s: 15), y: headerCancelOneWayView.frame.origin.y + headerCancelOneWayView.frame.height + Common.Size(s: 15), width: (viewCancelOneWay.frame.size.width - Common.Size(s: 30))/2, height: Common.Size(s: 15)), title: "Huỷ toàn bộ vé", color: UIColor.black);
            radioHuyToanBoVe.isSelected = true
            viewCancelOneWay.addSubview(radioHuyToanBoVe)
            
            radioHuy1Chieu = createRadioButtonGender(CGRect(x: radioHuyToanBoVe.frame.origin.x + radioHuyToanBoVe.frame.width, y: radioHuyToanBoVe.frame.origin.y, width: radioHuyToanBoVe.frame.size.width, height: Common.Size(s: 15)), title: "Huỷ 1 chiều", color: UIColor.black);
            radioHuy1Chieu.isSelected = false
            viewCancelOneWay.addSubview(radioHuy1Chieu)
            
            viewCancelOneWay.frame = CGRect(x: 0, y: viewCancelOneWay.frame.origin.y, width: scrollView.frame.width, height: radioHuy1Chieu.frame.origin.y + radioHuy1Chieu.frame.height + Common.Size(s: 15))
            
            changeInfoView.frame = CGRect(x: changeInfoView.frame.origin.x, y: viewCancelOneWay.frame.origin.y + viewCancelOneWay.frame.height, width: changeInfoView.frame.width, height: changeInfoView.frame.height)
        }
        
        //------------
        
        let lbChangeInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: customerView.frame.width - Common.Size(s: 30), height: customerView.frame.height))
        lbChangeInfo.text = "THÔNG TIN THAY ĐỔI"
        lbChangeInfo.font = UIFont.boldSystemFont(ofSize: 15)
        changeInfoView.addSubview(lbChangeInfo)
        
        tvNote = UITextView(frame: CGRect(x: Common.Size(s: 15), y: changeInfoView.frame.origin.y + changeInfoView.frame.height + Common.Size(s: 15), width: scrollView.frame.width - Common.Size(s: 30), height: Common.Size(s: 100)))
        tvNote.text = "\(item.Conversation)".htmlToString
        tvNote.layer.cornerRadius = 5
        tvNote.layer.borderColor = UIColor.lightGray.cgColor
        tvNote.layer.borderWidth = 1
        scrollView.addSubview(tvNote)
        
        let btnConfirm = UIButton(frame: CGRect(x: Common.Size(s: 40), y: tvNote.frame.origin.y + tvNote.frame.height + Common.Size(s: 30), width: scrollView.frame.width - Common.Size(s: 80), height: Common.Size(s: 45)))
        btnConfirm.backgroundColor = UIColor(red: 40/255, green: 158/255, blue: 91/255, alpha: 1)
        btnConfirm.setTitle("XÁC NHẬN", for: .normal)
        btnConfirm.layer.cornerRadius = 5
        btnConfirm.addTarget(self, action: #selector(confirm), for: .touchUpInside)
        scrollView.addSubview(btnConfirm)
        
        scrollViewHeight = tvNote.frame.origin.y + tvNote.frame.height + ((navigationController?.navigationBar.frame.height)! + UIApplication.shared.statusBarFrame.height) + Common.Size(s: 30)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    fileprivate func createRadioButtonGender(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: 14);
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = UIColor(netHex:0x00955E)
        radioButton.indicatorColor = UIColor(netHex:0x00955E)
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGender), for: UIControl.Event.touchUpInside);
        self.view.addSubview(radioButton);
        return radioButton;
    }
    
    @objc fileprivate func logSelectedButtonGender(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            let temp = radioButton.selected()!.titleLabel!.text!
            if self.calllogTripiType == 6 {
                radioDoiten.isSelected = false
                radioMuaThemHanhLy.isSelected = false
                radioMuaSuatAn.isSelected = false
                radioEmBe.isSelected = false
            }
            
            if self.calllogTripiType == 5 {
                radioHuyToanBoVe.isSelected = false
                radioHuy1Chieu.isSelected = false
            }
            
            switch temp {
            case "Đổi tên":
                radioDoiten.isSelected = true
                self.serviceNum = "1"
                break
            case "Mua thêm hành lý":
                radioMuaThemHanhLy.isSelected = true
                break
            case "Mua suất ăn":
                radioMuaSuatAn.isSelected = true
                break
            case "Em bé":
                radioEmBe.isSelected = true
                break
            case "Huỷ toàn bộ vé":
                radioHuyToanBoVe.isSelected = true
                break
            case "Huỷ 1 chiều":
                radioHuy1Chieu.isSelected = true
                break
            default:
                break
            }
        }
    }
    
    func setUpServiceNumber() {
//        (1- Đổi tên, 2- Mua thêm hành lý, 3- Mua xuất ăn, 4- Em bé)
        if self.calllogTripiType != 6 {
            self.serviceNum = ""
        }
        
        if self.calllogTripiType == 6 {
            if radioDoiten.isSelected {
                self.serviceNum = "1"
            } else if radioMuaThemHanhLy.isSelected {
                self.serviceNum = "2"
            } else if radioMuaSuatAn.isSelected {
                self.serviceNum = "3"
            } else if radioEmBe.isSelected {
                self.serviceNum = "4"
            }
        }
        
        if self.calllogTripiType == 5 {
            if radioHuyToanBoVe.isSelected {
                self.calllogTripiType = 1
            } else if radioHuy1Chieu.isSelected {
                self.calllogTripiType = 5
            }
        }
    }
    
    @objc func confirm() {
        self.setUpServiceNumber()
        guard let note = self.tvNote.text, !note.isEmpty else {
            let popup = PopupDialog(title: "Thông báo", message: "Bạn chưa nhập lý do thay đổi!", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                print("Completed")
            }
            let button1 = CancelButton(title: "OK"){
            }
            popup.addButtons([button1])
            self.present(popup, animated: true, completion: nil)
            return
        }
        
        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            MPOSAPIManager.Flight_Tripi_CreateCalllog(bookingId: "\(self.detailTribi?.bookingId ?? 0)", DocenTry: "\(self.detailTribi?.DocEntry ?? 0)", Note: note, Type: "\(self.calllogTripiType)", Service: self.serviceNum) { (rs, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        if rs.count > 0 {
                            if rs[0].Result == 1 {
                                let popup = PopupDialog(title: "Thông báo", message: "\(rs[0].Message)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                                    print("Completed")
                                }
                                let button1 = CancelButton(title: "OK"){
                                    self.navigationController?.popViewController(animated: true)
                                    NotificationCenter.default.post(name: NSNotification.Name.init("didCancelCalllogTripi"), object: nil)
                                }
                                popup.addButtons([button1])
                                self.present(popup, animated: true, completion: nil)
                            } else {
                          
                                self.showDialog(message: "\(rs[0].Message)")
                            }
                        } else {
                         
                            
                            self.showDialog(message: "LOAD API ERR")
                        }
                    } else {
                   
                        self.showDialog(message: err)
                    }
                }
            }
        }
    }
    
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func showDialog(message:String) {
        let alert = UIAlertController(title: "Thông báo", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .cancel) { _ in
            
        })
        self.present(alert, animated: true)
    }
}
