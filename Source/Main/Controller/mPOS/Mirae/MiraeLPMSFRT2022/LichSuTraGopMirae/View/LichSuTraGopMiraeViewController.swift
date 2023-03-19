//
//  LichSuTraGopMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit
import DropDown

class LichSuTraGopMiraeViewController: BaseVC<LichSuTraGopMiraeView> {
   
    //MARK:- Properties
    var presenter: LichSuTraGopMiraePresenter?
    
    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.typeLoad = 1
        self.presenter?.viewDidLoad(type:"\(self.mainView.hoSoCanXuLyButton.tag)")
        self.configureNavigationBackItem(title: "LỊCH SỬ \(PARTNERID == "FPT" ? "TRẢ GÓP" : "THUÊ MÁY")")
        self.configureButton()
        self.configureTableView()
        self.configureDropDown()
        self.configureTextField()
        self.configureSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter?.viewDidLoad(type: "\(self.presenter?.typeLoad ?? 0)")
    }
    
    deinit {
        print("Denit LichSuTraGopMiraeViewController is Success")
    }
    
    //MARK:- Configure
    private func configureDropDown(){
        self.mainView.dropDown = DropDown()
        self.mainView.dropDown?.direction = .bottom
        self.mainView.dropDown?.offsetFromWindowBottom = 20
        self.mainView.dropDown?.anchorView = self.mainView.optionTextField
        self.mainView.dropDown?.bottomOffset = CGPoint(x: 0, y:(self.mainView.dropDown?.anchorView?.plainView.bounds.height)! + 40)
        self.mainView.dropDown?.dataSource = self.presenter?.modelSearchType.map({ item in
            return item.value
        }) ?? []
        self.mainView.dropDown?.selectionAction = { [unowned self] (index: Int, item: String) in
            self.presenter?.typeSearch = self.presenter?.modelSearchType[index].id ?? 0
            self.mainView.optionTextField.text = item
        }
    }
    private func configureTableView(){
        self.mainView.lichSuTableView.baseUITableViewDelegate = self
        self.mainView.lichSuTableView.dataSource = self
        self.mainView.lichSuTableView.delegate = self
    }
    
    private func configureButton(){
        self.mainView.hoSoCanXuLyButton.addTarget(self, action: #selector(self.hoSoCanXuLyTapped), for: .touchUpInside)
        self.mainView.danhSachHoSoButton.addTarget(self, action: #selector(self.danhSachHoSoTapped), for: .touchUpInside)
    }
    private func configureTextField(){
        self.mainView.optionTextField.selectTextFieldDelegate = self
        self.mainView.optionTextField.text = self.presenter?.modelSearchType[0].value ?? ""
    }
    private func configureSearchBar(){
        self.mainView.searchBar.delegate = self
    }
    
    //MARK:- Actions
    @objc private func hoSoCanXuLyTapped(){
        self.mainView.hoSoCanXuLyButton.isSelect = true
        self.mainView.danhSachHoSoButton.isSelect = false
        self.presenter?.viewDidLoad(type:"\(self.mainView.hoSoCanXuLyButton.tag)")
        self.presenter?.typeLoad = self.mainView.hoSoCanXuLyButton.tag
    }
    @objc private func danhSachHoSoTapped(){
        self.mainView.hoSoCanXuLyButton.isSelect = false
        self.mainView.danhSachHoSoButton.isSelect = true
        self.presenter?.viewDidLoad(type:"\(self.mainView.danhSachHoSoButton.tag)")
        self.presenter?.typeLoad = self.mainView.danhSachHoSoButton.tag
    }
    
}

extension LichSuTraGopMiraeViewController : LichSuTraGopMiraePresenterToViewProtocol {
    func didSearchSuccess() {
        DispatchQueue.main.async {
            self.mainView.lichSuTableView.reloadData()
        }
    }
    func didLoadDanhSachLichSuSuccess(model: [LichSuTraGopMiraeEntity.DataLichSuTraGopMiraeModel]) {
        DispatchQueue.main.async {
            self.mainView.lichSuTableView.refreshControl?.endRefreshing()
            self.mainView.lichSuTableView.reloadData()
        }
    }

    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo",
                                                    message: error,
                                                    titleButton: "OK",
                                                    viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension LichSuTraGopMiraeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.presenter?.model.count ?? 0 > 0 {
            tableView.backgroundView?.isHidden = true
        }
        return self.presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.lichSuTraGop,
                                                 for: indexPath) as! LichSuTraGopMiraeTableViewCell
        cell.model = self.presenter?.model[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ThongTinDonHangMiraeCompleteRouter().configureVIPERThongTinDonHangComplete()
        vc.presenter?.isLichSu = true
        vc.presenter?.lichSuModel = self.presenter?.model[indexPath.row]
        CoreInstallMentData.shared.editIdCard = self.presenter?.model[indexPath.row].idCard ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension LichSuTraGopMiraeViewController : BaseUITableViewDelegate {
    func pullToRefreshTableView() {
        self.presenter?.viewDidLoad(type: "\(self.presenter?.typeLoad ?? 0)")
    }
}

extension LichSuTraGopMiraeViewController : SelectTextFieldDelegate {
    func selectTextField(index: Int) {
        self.mainView.dropDown?.show()
    }
}

extension LichSuTraGopMiraeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.presenter?.searchDonHang(text: searchText)
    }
}
