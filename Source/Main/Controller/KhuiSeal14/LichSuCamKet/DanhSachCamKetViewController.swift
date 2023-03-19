//
//  DanhSachCamKetViewController.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import UIKit
import DropDown
import RxCocoa
import RxSwift

class DanhSachCamKetViewController : BaseVC<DanhSachCamKetView> {
    
    private var viewModel:DanhSachCamKetViewModel!
    lazy var dropDown:DropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lịch sử cam kết"
        self.view.backgroundColor = Common.Colors.CamKet.background
        self.bind()
    }
    
    private func bind(){
        self.viewModel = DanhSachCamKetViewModel()
        let bag = self.viewModel.bag
        let view = self.mainView
        let viewDidLoad = self.rx.viewWillAppear
            .mapToVoid()
            .asDriverOnErrorJustComplete()
        let tap = view.searchButton.rx.tap.asDriver()
        let type = BehaviorSubject<Int>(value: 0)
        let row = BehaviorRelay<Int>(value: 0)
        let textSearch = view.searchTextField.rx.text.orEmpty.asDriver()
        
        let input = DanhSachCamKetViewModel.Input(
            typeFind: type.asDriver(onErrorJustReturn: 0),
            searchText: textSearch.asDriver(),
            searchTapped: tap.asDriver(),
            row: row.asDriver(),
            viewDidLoad: viewDidLoad.asDriver())
        
        let output = self.viewModel.transform(input)
        
        self.configureDropDown(type: type, response: output.listType)
        
        output.response
            .drive(view.tableView.rx.items(
                cellIdentifier: view.identifier,
                cellType: DanhSachCamKetTableViewCell.self))
        { row,item,cell in
            cell.model = item
            cell.selectionStyle = .none
        }.disposed(by: bag)
        
        output.response
            .map { model -> Bool in
                model.count > 0
            }.drive(view.tableView.backgroundView!.rx.isHidden)
            .disposed(by: bag)

        view.tableView.rx.itemSelected
            .map { indexPath in
            return indexPath.row
        }
        .bind(to: row)
        .disposed(by: bag)
        
        view.tableView.rx
            .modelSelected(DanhSachCamKetModel.self)
            .subscribe { [weak self] model in
                let vc = BanCamKetViewController(
                    id: model.id ?? 0,
                    isHistory: true
                )
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: bag)
        
        output.fetching
            .drive { loading in
                loading ? self.startLoading(message: "Đang lấy dữ liệu") : self.stopLoading()
            }
            .disposed(by: bag)
        
        output.error
            .drive(errorBinding)
            .disposed(by: bag)
        
    }
    
    var errorBinding: Binder<String> {
        return Binder(self, binding: { [weak self] (vc, error) in
            self?.showAlert(message: error)
        })
    }
    
    private func showAlert(
        message:String,
        color:UIColor = Common.Colors.CamKet.green
    ) {
        AlertManager
            .shared
            .alertCoreICT(
                title: "Thông báo",
                message:message,
                colorTitle: color,
                colorButtons: .darkGray,
                placeholder: "",
                buttons: "Đồng ý",
                self: self) { text, index in
                   
        }

    }
    
    private func configureDropDown(type:BehaviorSubject<Int>,response:[String]) {
        let view = self.mainView
        self.dropDown.direction = .bottom
        self.dropDown.offsetFromWindowBottom = 20
        self.dropDown.anchorView = view.dropView
        self.dropDown.bottomOffset = CGPoint(x: 0, y:(self.dropDown.anchorView?.plainView.bounds.height)! + 45)
        self.dropDown.dataSource = response.map({ item in
            return item
        })
        self.dropDown.selectionAction = { (index: Int, item: String) in
            type.onNext(index)
            DispatchQueue.main.async {
                view.dropView.titleLabel.text = item
            }
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showDropDown))
        view.dropView.addGestureRecognizer(tap)
    }
    
    @objc private func showDropDown(){
        self.dropDown.show()
    }
    
}

