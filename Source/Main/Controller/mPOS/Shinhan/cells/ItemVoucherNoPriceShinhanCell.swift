//
//  ItemVoucherNoPriceShinhanCell.swift
//  fptshop
//
//  Created by Sang Trương on 24/08/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ItemVoucherNoPriceShinhanCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate, ItemVoucherNoPriceTableViewCellDelegate {
    var isReadOnly = false

    var phoneNumber = ""
    var cellHeight:CGFloat = 0
    var heightTable:Int = 0
    var controller:UIViewController?
    var itemVoucher:[VoucherNoPrice] = []{
        didSet {
            if itemVoucher.count > 0 {
                tableViewVoucherNoPrice.dataSource = self
                tableViewVoucherNoPrice.delegate = self

                self.tableViewVoucherNoPrice.reloadData()
            }
        }
    }
    var tableViewVoucherNoPrice: TableViewAutoHeight = TableViewAutoHeight()
	override func awakeFromNib() {
		super.awakeFromNib()

        tableViewVoucherNoPrice.dataSource = self
        tableViewVoucherNoPrice.delegate = self
	}
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

    func bindCell(phone:String,mainController:UIViewController) {
        controller = mainController
//        tableViewVoucherNoPrice.frame = contentView.bounds
            //- (UIApplication.shared.statusBarFrame.height + Cache.heightNav)

        tableViewVoucherNoPrice.register(ItemVoucherNoPriceTableViewCell.self, forCellReuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        tableViewVoucherNoPrice.tableFooterView = UIView()
        tableViewVoucherNoPrice.backgroundColor = UIColor.white
//        self.tableViewVoucherNoPrice.isScrollEnabled = false
        self.addSubview(tableViewVoucherNoPrice)

        self.tableViewVoucherNoPrice.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(heightTable)
        }

//        getListVoucherNoPrice(phone:phone)
        phoneNumber = phone
        tableViewVoucherNoPrice.reloadData()
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cache.listVoucherNoPrice.count
	}

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ItemVoucherNoPriceTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "ItemVoucherNoPriceTableViewCell")
        let item:VoucherNoPrice = Cache.listVoucherNoPrice[indexPath.row]
        cell.setup(so: item,indexNum: indexPath.row,readOnly:false)
        cell.selectionStyle = .none
        if isReadOnly == false {
            cell.delegate = self
        }

//        self.cellHeight = cell.estimateCellHeight
        return cell
    }


	private func autoSizeView() {

		self.tableViewVoucherNoPrice.layoutIfNeeded()
		self.tableViewVoucherNoPrice.frame.size.height =
			self.tableViewVoucherNoPrice.contentSize.height + Common.Size(s: 10)

	}




    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }




}
extension ItemVoucherNoPriceShinhanCell:ItemVoucherCellDelegate{

    func tabReloadViewRemoveVoucher(indexNum: Int) {
        guard indexNum < Cache.listVoucherNoPrice.count else { return }
        Cache.listVoucherNoPrice.remove(at: indexNum)
        self.tableViewVoucherNoPrice.reloadData()
    }

    func tabClickView(voucher: VoucherNoPrice) {
        let docType:String = "02" // trả góp


        let newViewController = LoadingViewController()
        newViewController.content = "Đang kiểm tra thông tin..."
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        controller?.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default

        MPOSAPIManager.mpos_FRT_SP_check_VC_crm(voucher:"\(voucher.VC_Code)",sdt:phoneNumber,doctype:"\(docType)") { [weak self] (p_status,p_message,err) in
            guard let self = self else {return}
            let when = DispatchTime.now() + 0.5
            DispatchQueue.main.asyncAfter(deadline: when) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil)
                if(err.count <= 0){
                    if(p_status == 2){
                        self.controller?.showPopUp(p_message, "Thông báo", buttonTitle: "Đồng ý")
                        return
                    }
                    if(p_status == 1){//1
                        let alertController = UIAlertController(title: "Thông báo", message: "Bạn có muốn sử dụng voucher này ?", preferredStyle: .alert)

                        let confirmAction = UIAlertAction(title: "Có", style: .default) { (_) in
                            let newViewController = CheckVoucherOTPViewController()
                            newViewController.delegate = self.controller as? CheckVoucherOTPViewControllerDelegate
                            newViewController.phone = self.phoneNumber
                            newViewController.doctype = docType
                            newViewController.voucher = voucher.VC_Code

                            let navController = UINavigationController(rootViewController: newViewController)
                            self.controller?.navigationController?.present(navController, animated:false, completion: nil)
                        }
                        let rejectConfirm =  UIAlertAction(title: "Không", style: .cancel) { (_) in

                        }
                        alertController.addAction(rejectConfirm)
                        alertController.addAction(confirmAction)


                        self.controller?.present(alertController, animated: true, completion: nil)
                    }
                    if(p_status == 0){//0


//                        let voucherObject = VoucherNoPrice(VC_Code: voucher.VC_Code, VC_Name: "", Endate: "", U_OTPcheck: "", STT: 0, isSelected: true)
//                        Cache.listVoucherNoPrice.append(voucherObject)
//                        self.tableViewVoucherNoPrice.reloadData()
//                        self.autoSizeView()

                        for item in Cache.listVoucherNoPrice{
                            if(item.VC_Code == voucher.VC_Code){
                                item.isSelected = true
                                break
                            }
                        }
                        self.tableViewVoucherNoPrice.reloadData()
                        self.autoSizeView()
                    }

                }else{
                    let alert = UIAlertController(title: "Thông báo", message: err, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive) { _ in

                    })
                    self.controller?.present(alert, animated: true)
                }
            }

        }
    }

}
