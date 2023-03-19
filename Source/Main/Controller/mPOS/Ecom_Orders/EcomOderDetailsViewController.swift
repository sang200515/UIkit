//
//  EcomOderDetailsViewController.swift
//  CustomAlert
//
//  Created by Trần Văn Dũng on 03/03/2022.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

class EcomOderDetailsViewController: UIViewController, NVActivityIndicatorViewable {

    let identifier:String = "EcomOderDetailsTableViewCell"
    var docNum:String = ""
    var model:[EcomOrderDetails] = []
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.keyboardDismissMode = .interactive
        sv.showsHorizontalScrollIndicator = false
        return sv
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.mainGreen
        label.text = "THÔNG TIN ĐƠN HÀNG"
        return label
    }()
    
    let thongTinThanhToanLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.mainGreen
        label.text = "THÔNG TIN THANH TOÁN"
        return label
    }()
    
    let sttLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = UIColor.mainGreen
        label.text = "STT"
        return label
    }()
    
    let tenSPLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = UIColor.mainGreen
        label.text = "Sản Phẩm"
        return label
    }()
    
    let tongDonHangLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "Tổng đơn hàng : "
        return label
    }()
    
    let tongDonHangResultLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .right
        label.text = "0 đ"
        return label
    }()
    
    let giamGiaLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "Giảm giá : "
        return label
    }()
    
    let giamGiaResultLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .right
        label.text = "0 đ"
        return label
    }()
    
    let tienOnlineLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .darkGray
        label.text = "Tiền Online : "
        return label
    }()
    
    let tienOnlineResultLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .red
        label.textAlignment = .right
        label.text = "0 đ"
        return label
    }()
    
    let tongThanhToanLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15,weight:.semibold)
        label.textColor = .darkGray
        label.text = "Tổng thanh toán : "
        return label
    }()
    
    let tongThanhToanResultLabel:UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17,weight:.semibold)
        label.textColor = .red
        label.text = "0 đ"
        label.textAlignment = .right
        return label
    }()
    
    lazy var tableView:TableViewAutoHeight = {
        let tbv = TableViewAutoHeight()
        tbv.register(EcomOderDetailsTableViewCell.self,
                     forCellReuseIdentifier: self.identifier)
        return tbv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addView()
        self.setLayout()
        self.configureTableView()
        self.addBorder()
        self.configureNavigationItem()
        self.getEcomOrderDetails()
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        var height:CGFloat = 0
        height += self.titleLabel.bounds.height + 10
        height += self.sttLabel.bounds.height + 10
        height += self.thongTinThanhToanLabel.bounds.height + 10
        height += self.tableView.bounds.height + 10
        height += self.tongDonHangResultLabel.bounds.height + 10
        height += self.giamGiaResultLabel.bounds.height + 10
        height += self.tienOnlineResultLabel.bounds.height + 10
        height += self.tongThanhToanResultLabel.bounds.height + 30
        self.scrollView.contentSize = .init(width: self.view.frame.width, height: height)
    }
    
    private func addView(){
        self.view.backgroundColor = .white
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.sttLabel)
        self.scrollView.addSubview(self.tenSPLabel)
        self.scrollView.addSubview(self.tableView)
        self.scrollView.addSubview(self.thongTinThanhToanLabel)
        self.scrollView.addSubview(self.tongDonHangLabel)
        self.scrollView.addSubview(self.tongDonHangResultLabel)
        self.scrollView.addSubview(self.giamGiaLabel)
        self.scrollView.addSubview(self.giamGiaResultLabel)
        self.scrollView.addSubview(self.tienOnlineLabel)
        self.scrollView.addSubview(self.tienOnlineResultLabel)
        self.scrollView.addSubview(self.tongThanhToanLabel)
        self.scrollView.addSubview(self.tongThanhToanResultLabel)
    }

    private func setLayout(){
        
        self.scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            make.center.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
        self.sttLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.titleLabel)
            make.width.equalTo(100)
            make.height.equalTo(40)
        }
        self.tenSPLabel.snp.makeConstraints { make in
            make.top.equalTo(self.sttLabel)
            make.leading.equalTo(self.sttLabel.snp.trailing)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(self.sttLabel)
        }
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.tenSPLabel.snp.bottom)
            make.trailing.equalTo(self.tenSPLabel)
            make.leading.equalTo(self.sttLabel)
        }
        self.thongTinThanhToanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tableView.snp.bottom).offset(10)
            make.leading.trailing.equalTo(self.tableView)
        }
        self.tongDonHangLabel.snp.makeConstraints { make in
            make.top.equalTo(self.thongTinThanhToanLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.tableView)
            make.width.equalTo(120)
        }
        self.tongDonHangResultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.tongDonHangLabel)
            make.leading.equalTo(self.tongDonHangLabel.snp.trailing)
            make.trailing.equalTo(self.tableView)
        }
        self.giamGiaLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tongDonHangLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.tableView)
            make.width.equalTo(120)
        }
        self.giamGiaResultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.giamGiaLabel)
            make.leading.equalTo(self.giamGiaLabel.snp.trailing)
            make.trailing.equalTo(self.tableView)
        }
        self.tienOnlineLabel.snp.makeConstraints { make in
            make.top.equalTo(self.giamGiaLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.tableView)
            make.width.equalTo(120)
        }
        self.tienOnlineResultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.tienOnlineLabel)
            make.leading.equalTo(self.tienOnlineLabel.snp.trailing)
            make.trailing.equalTo(self.tableView)
        }
        self.tongThanhToanLabel.snp.makeConstraints { make in
            make.top.equalTo(self.tienOnlineLabel.snp.bottom).offset(10)
            make.leading.equalTo(self.tableView)
            make.width.equalTo(140)
        }
        self.tongThanhToanResultLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.tongThanhToanLabel)
            make.leading.equalTo(self.tongThanhToanLabel.snp.trailing)
            make.trailing.equalTo(self.tableView)
        }
    }
    
    private func addBorder(){
        self.tenSPLabel.addLeftBorder(with: .white, andWidth: 1)
    }
    
    private func configureNavigationItem(){
        self.title = "CHI TIẾT ĐƠN HÀNG"
        
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    @objc private func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    
    private func configureTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.isScrollEnabled = false
    }
    
    private func bindingData(model:EcomOrderDetailsModel){
        self.model = model.dataItem
        
        let tongDonHang = Double(model.tongdonhang)
        let giamGia = Double(model.giamgia)
        let tienOnline = Double(model.tienonline)
        let tongThanhToan = Double(model.tongthanhtoan)
        
        DispatchQueue.main.async {
            self.tongDonHangResultLabel.text = Common.convertCurrencyDouble(value: tongDonHang ?? 0) + "đ"
            self.giamGiaResultLabel.text = Common.convertCurrencyDouble(value: giamGia ?? 0) + "đ"
            self.tienOnlineResultLabel.text = Common.convertCurrencyDouble(value: tienOnline ?? 0) + "đ"
            self.tongThanhToanResultLabel.text = Common.convertCurrencyDouble(value: tongThanhToan ?? 0) + "đ"
            self.tableView.reloadData()
        }
        self.stopLoading()
    }
    
    private func getEcomOrderDetails(){
        self.startLoading(message: "Đang lấy thông tin đơn hàng")
        Provider.shared.ecomOrders.getEcomOrderDetails(docNum: self.docNum) { [weak self] result in
            guard let self = self,
                  let model = result else { return }
            self.bindingData(model: model)
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.showPopUp(error.description, "Thông báo", buttonTitle: "OK") {
                self.handleBack()
            }
            self.stopLoading()
        }

    }
    
    private func startLoading(message:String) {
        self.startAnimating(CGSize(width: 30, height: 30), message: message, messageFont: .systemFont(ofSize: 15), type: .ballClipRotateMultiple, color: UIColor.mainGreen, backgroundColor: .black.withAlphaComponent(0.5), textColor: UIColor.mainGray)
    }
    
    private func stopLoading() {
        self.stopAnimating()
    }
}

extension EcomOderDetailsViewController : UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! EcomOderDetailsTableViewCell
        cell.selectionStyle = .none
        cell.model = self.model[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

