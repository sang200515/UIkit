//
//  ListInstallentViewController.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import UIKit

class ListInstallentViewController: BaseController {
    var itemDetail: CreateCustomerModel?
	@IBOutlet weak var tableView: UITableView!
	var listInstallMent: [InsHouses] = []
    var detailDataMapping:MasterDataInstallMent?
    var idCard:String = ""
    var flowSearch:Bool = false
	//MARK: - Variable

	//MARK: - Properties

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
        self.title = "Tham gia trả góp"
		tableView.dataSource = self
		tableView.delegate = self
		tableView.allowsSelection = true
		tableView.isUserInteractionEnabled = true
		getListInstallMentt()
		getMasterDataInstallMent()
		tableView.registerTableCell(NhaTraGhopCell.self)

	}

	private func getListInstallMentt() {
        var idcardPasing:String = ""
        if flowSearch {
            idcardPasing = idCard
        }else {
            idcardPasing =  CoreInstallMentData.shared.idCard
        }
		Provider.shared.coreInstallmentService.getListNhaTraGhop(
			idCard: idcardPasing,
			success: { [weak self] result in
				guard let self = self else { return }
                self.listInstallMent = result?.insHouses ?? []
                if result?.isReject ?? false ==  true {
                    self.showAlertOneButton(title: "Thông báo", with: result?.rejectMessage ?? "", titleButton: "OK",handleOk: {
                        if self.flowSearch {
                            self.navigationController?.popViewController(animated: true)
                        }else {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    })
                }else {
                    self.tableView.reloadData()
                }
			},
			failure: { [weak self] error in
				guard let self = self else { return }
				self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
			})
	}

    private func getMasterDataInstallMent() {
        var idcardPasing:String = ""
        if flowSearch {
            idcardPasing = idCard
        }else {
            idcardPasing =  CoreInstallMentData.shared.idCard
        }
        Provider.shared.coreInstallmentService.getMasterDataInstallMent(
            idCard: idcardPasing, success: { [weak self] result in
                guard let self = self else { return }
                print(result)
                self.detailDataMapping = result
            },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
    }
	// MARK: - API

	// MARK: - Selectors
}

extension ListInstallentViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listInstallMent.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(NhaTraGhopCell.self)

		switch listInstallMent[indexPath.row].name {
		case "Mirae":
                cell.bindCell(imageString: "ic_mirae", tenNhaTraGop: "Mirae", history: listInstallMent[indexPath.row].message ?? "",item:listInstallMent[indexPath.row])
			return cell
		case "COMP":
                cell.bindCell(imageString: "ic_comp", tenNhaTraGop: "Comp", history: listInstallMent[indexPath.row].message ?? "",item:listInstallMent[indexPath.row])
			return cell
		case "Shinhan":
			cell.bindCell(imageString: "Shinhan", tenNhaTraGop: "Shinhan", history: listInstallMent[indexPath.row].message ?? "",item:listInstallMent[indexPath.row])
			return cell
		default: return UITableViewCell()
		}
		//        return cell
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch listInstallMent[indexPath.row].name {
            case "Mirae":
                if listInstallMent[indexPath.row].isEnable ?? false == false {
                    self.showAlertOneButton(title: "Thông báo", with: listInstallMent[indexPath.row].alertMessage ?? "", titleButton: "OK")
                }else {
                    PARTNERID = "FPT"
                    let vc = ThongTinKhachHangMireaRouter().configureVIPERThongTinKhachHangMirea()
                    vc.presenter?.isCore = true
                    vc.presenter?.detailDataMapping = detailDataMapping
                        //                loadDataMirae()
                    self.navigationController?.navigationBar.tintColor = .white
                    self.navigationController?.pushViewController(vc, animated: true)
                }

            case "COMP":
                if listInstallMent[indexPath.row].isEnable ?? false == false {
                    self.showAlertOneButton(title: "Thông báo", with: listInstallMent[indexPath.row].alertMessage ?? "", titleButton: "OK")
                }else {
                    PARTNERID = "FPTC"
                    let vc = ThongTinKhachHangMireaRouter().configureVIPERThongTinKhachHangMirea()
                    vc.presenter?.isCore = true
                    vc.presenter?.detailDataMapping = detailDataMapping
                    self.navigationController?.navigationBar.tintColor = .white
                    self.navigationController?.pushViewController(vc, animated: true)
                }

            case "Shinhan":
                if listInstallMent[indexPath.row].isEnable ?? false == false {
                    self.showAlertOneButton(title: "Thông báo", with: listInstallMent[indexPath.row].alertMessage ?? "", titleButton: "OK")
                }else {
                    let vc = ShinhanInfoCustomerVC()
                    vc.isCore = true
                    vc.detailDataMapping = detailDataMapping
                    self.navigationController?.navigationBar.tintColor = .white
                    self.navigationController?.pushViewController(vc, animated: true)
                }

            default:
                return
        }

		print("ple")

	}
    private func loadDataMirae(){
        guard detailDataMapping?.addresses?.count == 2 else { return self.showAlertOneButton(title: "Thông báo", with: "Không đủ địa chỉ thường trú và địa chỉ tạm trú", titleButton: "OK")}
        guard detailDataMapping?.refPersons?.count == 2 else { return self.showAlertOneButton(title: "Thông báo", with: "Không đủ thông tin người tham chiếu", titleButton: "OK")}
        Cache.infoKHMirae = KhachHangMiraeModel(soDienThoai: detailDataMapping?.phone ?? "",
                                                thuNhap: "\(detailDataMapping?.company?.income ?? 0)",
                                                soCMND: detailDataMapping?.idCard ?? "",
                                                fullname: detailDataMapping?.fullName ?? "",
                                                ngayCapCMND: detailDataMapping?.idCardIssuedDate ?? "",
                                                ngaySinh: detailDataMapping?.birthDate ?? "",
                                                ho: detailDataMapping?.firstName ?? "",
                                                gioiTinh: detailDataMapping?.gender ?? 0 == 0 ? "M" : "FM",
                                                tenLot: detailDataMapping?.middleName ?? "",
                                                ten: detailDataMapping?.lastName ?? "",
                                                diaChi: "\(detailDataMapping?.addresses?[0].street ?? "") \(detailDataMapping?.addresses?[0].houseNo)" ,
                                                codeTinhThuongTru: detailDataMapping?.addresses?[0].provinceCode ?? "",
                                                tinhThuongTru: detailDataMapping?.addresses?[0].provinceName ?? "",
                                                tinhTamTru: detailDataMapping?.addresses?[1].provinceName  ?? "",
                                                huyenThuongTru: detailDataMapping?.addresses?[0].districtName  ?? "",
                                                huyenTamTru: detailDataMapping?.addresses?[1].districtName  ?? "",
                                                xaThuongTru: detailDataMapping?.addresses?[0].wardName  ?? "",
                                                xaTamTru: detailDataMapping?.addresses?[0].wardName  ?? "",
                                                codeTinhTamTru: detailDataMapping?.addresses?[0].provinceCode  ?? "",
                                                codeHuyenThuongTru: detailDataMapping?.addresses?[0].districtCode  ?? "",
                                                codeHuyenTamTru: detailDataMapping?.addresses?[0].districtCode  ?? "",
                                                codeXaThuongTru: detailDataMapping?.addresses?[0].wardCode  ?? "",
                                                codeXaTamTru: detailDataMapping?.addresses?[0].wardCode  ?? "",
                                                noiCapCMND: detailDataMapping?.idCardIssued?.idCardIssuedBy ?? "",
                                                tenNguoiThamChieu1: detailDataMapping?.refPersons?[0].fullName ?? "",
                                                moiQuanHeNguoiThamChieu1: detailDataMapping?.refPersons?[0].relationshipName ?? "",
                                                soDTNguoiThamChieu1: detailDataMapping?.refPersons?[0].phone ?? "",
                                                tenNguoiThamChieu2: detailDataMapping?.refPersons?[0].fullName ?? "",
                                                moiQuanHeNguoiThamChieu2: detailDataMapping?.refPersons?[0].relationshipName ?? "",
                                                soDTNguoiThamChieu2: detailDataMapping?.refPersons?[0].phone ?? "",
                                                appDocEntry: 0,
                                                tenGoiTraGop: "",
                                                kyHan:0,
                                                phiBaoHiem:0,
                                                soTienVay:0,
                                                giamGia: 0,
                                                tongTien:0,
                                                soTienTraTruoc:0,
                                                laiSuat:0,
                                                thanhTien:0,
                                                codeGoiTraGop:"0",
                                                fullAddress: detailDataMapping?.addresses?[0].fullAddress ?? "", soPOS: "", soMPOS: "")
    }
}

extension UIView {
	func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
		self.layer.cornerRadius = radius
		self.layer.maskedCorners = [CACornerMask]
	}

}
