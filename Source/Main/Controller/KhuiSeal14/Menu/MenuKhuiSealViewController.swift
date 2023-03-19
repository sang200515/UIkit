//
//  MenuKhuiSealViewController.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 20/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MenuKhuiSealViewController : BaseVC<MenuKhuiSealView> {
    
    let model = BehaviorSubject<[MenuCoreModel]>(value: [])
    let bag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cam kết khách hàng"
        
        self.mainView.collectionView.delegate = self
        self.view.backgroundColor = Common.Colors.CamKet.background
        let content:[MenuCoreModel] = [
            MenuCoreModel(icon: UIImage(named: "camKetICON")!, title: "Biên bản cam kết"),
            MenuCoreModel(icon: UIImage(named: "lichSuICON")!, title: "Lịch sử cam kết")
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
                  vc = BanCamKetViewController()
              default:
                  vc = DanhSachCamKetViewController()
              }
              self?.navigationController?.pushViewController(vc, animated: true)
          }).disposed(by: self.bag)
    }
    
}

extension MenuKhuiSealViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - 30) / 2, height: 130)
    }
}

struct MenuCoreModel {
    let icon:UIImage
    let title:String
}
