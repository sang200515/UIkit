//
//  MenuTraGopViewController.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 21/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MenuTraGopViewController : BaseVC<MenuKhuiSealView> {
    
    let model = BehaviorSubject<[MenuCoreModel]>(value: [])
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Trả Góp"
        
        self.mainView.collectionView.delegate = self
        self.view.backgroundColor = Common.Colors.CamKet.background
        let content:[MenuCoreModel] = [
            MenuCoreModel(icon: UIImage(named: "TaoDonHangTG")!, title: "Tạo hồ sơ trả góp"),
            MenuCoreModel(icon: UIImage(named: "camKetICON")!, title: "Cam kết khui seal trả góp")
        ]
        
        self.model.onNext(content)
        
       self.model
            .bind(to: self.mainView.collectionView.rx.items(cellIdentifier: "MenuCoreICTCollectionViewCell",
                                              cellType: MenuCoreICTCollectionViewCell.self)) { row,item,cell in
                cell.model = item
        }.disposed(by: self.bag)
        
        self.mainView.collectionView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
              var vc = UIViewController()
              switch indexPath.row {
              case 0:
                  CoreInstallMentData.shared.resetParamEdit()
                  CoreInstallMentData.shared.resetParamCreate()
                  ShinhanData.resetShinhanData()
                  ShinhanData.IS_RUNNING = false 
                  vc = SearchCustomerController()
              default:
                  vc = MenuKhuiSealViewController()
              }
              self?.navigationController?.pushViewController(vc, animated: true)
          }).disposed(by: self.bag)
        
        AlertManager.shared.alertWithViewController(title: "Lưu ý", message: "Shop lưu ý tư vấn và hướng dẫn khách hàng ký biên bản cam kết khui seal khi làm trả góp sản phẩm iPhone nhé!!!", titleButton: "Đồng ý", viewController: self, completion: {
            
        })
    }
    
    
}

extension MenuTraGopViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - 30) / 2, height: 130)
    }
}
