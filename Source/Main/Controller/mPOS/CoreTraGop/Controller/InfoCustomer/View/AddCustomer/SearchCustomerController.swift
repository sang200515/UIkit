//
//  Add&SearchCustomer.swift
//  QuickCode
//
//  Created by Sang Trương on 14/07/2022.
//

import UIKit

class DetailSearchUser {
	var name: String = ""
	var phone: String = ""
	var date: String = ""
	var email: String = ""
	var address: String = ""
	var gplx: String = ""
	var shk: String = ""
	internal init(
		name: String, phone: String, date: String, email: String, address: String, gplx: String, shk: String
	) {
		self.name = name
		self.phone = phone
		self.date = date
		self.email = email
		self.address = address
		self.gplx = gplx
		self.shk = shk
	}
}

class SearchCustomerController: UIViewController , UISearchDisplayDelegate{
        //MARK: - Variable
    var isFromShinhan:Bool = false 
   private var isShowTableView = false
    var filterList: [CreateCustomerModel] = []
    var resultFilterList: [ItemsSearchCustomer] = []

        //MARK: - Properties UI
    let searchBar = UISearchBar()
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var errMesssageLbl: UITextField!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var viewParentTable: UIView!
    @IBOutlet weak var stackViewSearch: UIStackView!


        // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        self.view.backgroundColor = tableView.backgroundColor
//        searchTextField.text = ""
        searchTextField.clearButtonMode = .whileEditing

//        search(shouldShow: false)

//        searchTextField.text = "301569993"


        configureUI()
        print(filterList.count)
        if isFromShinhan {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
            self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            addBackButton()
        }
    }
    override  func backButtonPressed(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        CoreInstallMentData.shared.resetParamEdit()
        CoreInstallMentData.shared.resetParamCreate()
       
        if searchTextField.text != "" {
            searchInfoByIDCard(keyword: searchTextField.text!)

        }

    }
        // MARK: - API
    private func deleteInfoCustomer(id: String) {
//        self.loading(isShow: true)
        Provider.shared.createCustomerAPIService.deleteInfoCustomer(id: id,
            success: { [weak self] (result) in
                guard let self = self, let response = result else { return }
            self.showAlertOneButton(title: "Thông báo", with: "Xóa thành công số phiếu \(id)", titleButton: "OK")
 },
            failure: { [weak self] error in
                guard let self = self else { return }
                self.loading(isShow: false)
                self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
            })
    }
    private func searchInfoByIDCard(keyword: String) {
        Provider.shared.createCustomerAPIService.searchCustomerByIDCard(id: keyword, success: { [weak self] result in
            guard let self = self, let response = result else { return }
            self.filterList = [response]
            if self.filterList.count > 0 {
                self.search(shouldShow: true)
                self.searchBar.becomeFirstResponder()
                self.stackViewSearch.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }


        },failure: { [weak self] error in
            guard let self = self else { return }
            self.showAlertOneButton(title: "Thông báo", with: error.description, titleButton: "OK")
        })
    }
    private func searchInfoByIDCard2(keyword: String) {
        Provider.shared.createCustomerAPIService.searchCustomerByIDCard(id: keyword, success: { [weak self] result in
            guard let self = self, let response = result else { return }
            self.filterList = [response]
            if self.filterList.count > 0 {

                self.search(shouldShow: true)
                self.searchBar.becomeFirstResponder()
                self.stackViewSearch.isHidden = true
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }else{
                self.filterList = []
                self.tableView.reloadData()
            }
        },failure: { [weak self] error in
            print("fail")
            self?.filterList = []
            self?.tableView.reloadData()
        })
    }
    private func loading(isShow: Bool) {
        let nc = NotificationCenter.default
        if isShow {
            let newViewController = LoadingViewController()
            newViewController.content = "Đang cập nhật thông tin..."
            newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.navigationController?.present(newViewController, animated: true, completion: nil)
        } else {
            nc.post(name: Notification.Name("dismissLoading"), object: nil)
        }
    }
        // MARK: - Selectors
    private func validateSearchTxt() -> Bool {
        guard let input = searchTextField.text, !input.isEmpty else {
            showAlertOneButton(title: "Thông báo", with: "Vui lòng nhập thông tin tìm kiếm", titleButton: "OK")
            return false
        }
        return true
    }
    @IBAction func createNewCustomer(_ sender: Any) {
        let vc = CreateCustomerProfile()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSearchOnClick(_ sender: Any) {
        guard validateSearchTxt() else { return }
        searchInfoByIDCard(keyword: searchTextField.text!)
//        searchInfoCustomer(keyword: searchTextField.text!,skipCount: 0, maxResultCount: 10)
        //start searching

        if filterList.count > 0 {
            searchBar.text = searchTextField.text
            searchBar.becomeFirstResponder()
            stackViewSearch.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()
            search(shouldShow: true)
        }else {
//            showAlertOneButton(title: "Thông báo", with: "Không tìm thấy thông tin khách hàng!", titleButton: "OK")
        }


    }

  // MARK: - Helpers



    func configureUI() {
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255,
                                                                   blue: 250/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isTranslucent = false
        searchBar.sizeToFit()
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.delegate = self
            //        navigationController?.navigationBar.barTintColor = UIColor(
            //            red: 55 / 255, green: 120 / 255,
            //            blue: 250 / 255, alpha: 1)
        navigationController?.navigationBar.tintColor = UIColor(named: "primary_green")
            //        navigationController?.navigationBar.prefersLargeTitles = false
            //        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Thông tin khách hàng"
        showSearchBarButton(shouldShow: false)

            //tableView

        self.tableView.registerTableCell(ItemSearchTraGhopCell.self)

    }





	//

}
//MARK: -Search Bar Delegate
extension SearchCustomerController: UISearchBarDelegate {
    func showSearchBarButton(shouldShow: Bool) {
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        space.width = 0
        if shouldShow {
            navigationItem.rightBarButtonItems = [
                UIBarButtonItem(
                    barButtonSystemItem: .search,
                    target: self,
                    action: #selector(handleShowSearchBar))
            ]
        } else {
            navigationItem.rightBarButtonItems = []
        }
    }
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		self.searchBar.endEditing(true)
	}
	func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
		print("Search bar editing did begin..")
        tableView.reloadData()
	}

	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		print("Search bar editing did end..")
        print(filterList.count)

	}

	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//		filterList = resultFilterList
		self.tableView.reloadData()
		search(shouldShow: false)
        
	}

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText != "" {
//            searchInfoCustomer(keyword: searchBar.text ?? "",skipCount: 0, maxResultCount: 10)
            searchInfoByIDCard2(keyword: searchBar.text ?? "")
		}
		tableView.reloadData()

	}
    @objc func handleShowSearchBar() {
        searchBar.becomeFirstResponder()
//        search(shouldShow: true)
    }
}
//MARK: - Tableview
extension SearchCustomerController: UITableViewDelegate, UITableViewDataSource {

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filterList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueTableCell(ItemSearchTraGhopCell.self)
		cell.bindCell(item: filterList[indexPath.row])
		return cell
	}

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfoCustomer()
        CoreInstallMentData.shared.editID = filterList[indexPath.row].id ?? 0
//        vc.idCard = filterList[indexPath.row].idCard ?? ""
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {




            // delete
        let delete = UIContextualAction(style: .destructive, title: "Xóa") { (action, view, completionHandler) in

            completionHandler(true)

            let refreshAlert = UIAlertController(title: "Thông báo", message: "Bạn có đồng xóa thông tin khách hàng với số CMND: \(self.filterList[indexPath.row].idCard ?? "" ) ?", preferredStyle: .alert)

            refreshAlert.addAction(UIAlertAction(title: "Đồng ý", style: .destructive, handler: { (action: UIAlertAction!) in
                print("Handle Ok logic here")
                CoreInstallMentData.shared.editID = self.filterList[indexPath.row].id ?? 0
                self.deleteInfoCustomer(id: "\(CoreInstallMentData.shared.editID)" )
                self.filterList.remove(at: indexPath.row)
                self.tableView.reloadData()
//MARK: - APII handle here


                tableView.reloadData()
            }))

            refreshAlert.addAction(UIAlertAction(title: "Không đồng ý", style: .cancel, handler: { (action: UIAlertAction!) in
            }))

            self.present(refreshAlert, animated: true, completion: nil)
        }
            // swipe
        let swipe = UISwipeActionsConfiguration(actions: [delete])


        swipe.performsFirstActionWithFullSwipe = false
        return swipe


        return nil
    }
}


