//
//  KiemTraThongTinKhuyenMaiMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class KiemTraThongTinKhuyenMaiMiraeViewController: BaseVC<KiemTraThongTinKhuyenMaiMiraeView> {
   
    //MARK:- Properties
    var presenter: KiemTraThongTinKhuyenMaiMiraePresenter?
    
    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.model.first?.isSelected = true
        self.configureNavigationBackItem(title: "THÔNG TIN KHUYẾN MÃI")
        self.configureTableView()
        self.configureButton()
    }
    
    deinit {
        print("Denit KiemTraThongTinKhuyenMaiMiraeViewController is Success")
    }
    
    //MARK:- Configure
    private func configureTableView(){
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.delegate = self
    }
    
    private func configureButton(){
        self.mainView.accectButton.addTarget(self, action: #selector(self.accectTapped), for: .touchUpInside)
    }
    
    //MARK:- Actions
    @objc private func accectTapped(){
        let vc = ThongTinDonHangMiraeCompleteRouter().configureVIPERThongTinDonHangComplete()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension KiemTraThongTinKhuyenMaiMiraeViewController : KiemTraThongTinKhuyenMaiMiraePresenterToViewProtocol {
    
    func outPutSuccess(data: String) {
        
    }
    
    func outPutFailed(error: String) {

    }
    
    func showLoading(message: String) {
        
    }
    
    func hideLoading() {
        
    }
}

extension KiemTraThongTinKhuyenMaiMiraeViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.presenter?.model[section].isExpanded == true {
            return self.presenter?.model[section].subTitle.count ?? 0
        }else{
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = KiemTraThongTinKhuyenMaiMiraeHeaderView()
        view.model = self.presenter?.model[section]
        view.delegate = self
        view.isExpanded = self.presenter?.model[section].isExpanded ?? false
        view.row = section
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.kiemTraThongTinKhuyenMai,
                                                 for: indexPath) as! KiemTraThongTinKhuyenMaiMiraeTableViewCell
        cell.model = self.presenter?.model[indexPath.section].subTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}

extension KiemTraThongTinKhuyenMaiMiraeViewController : KiemTraThongTinKhuyenMaiMiraeHeaderViewDelegate {
    func selectedRowHeader(row: Int) {
        self.presenter?.model.forEach({ item in
            item.isSelected = false
        })
        self.presenter?.model[row].isSelected = true
        self.mainView.tableView.reloadData()
    }
    func expandedRowHeader(row:Int, isExpanded:Bool) {
        if isExpanded {
            self.presenter?.model[row].isExpanded = false
        }else {
            self.presenter?.model[row].isExpanded = true
        }
        self.mainView.tableView.reloadData()
    }
}
