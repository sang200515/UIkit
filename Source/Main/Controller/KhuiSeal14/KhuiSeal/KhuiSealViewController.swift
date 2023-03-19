//
//  KhuiSealViewController.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 20/10/2022.
//

import UIKit
import RxSwift
import RxCocoa

class KhuiSealViewController: BaseVC<KhuiSealView> {
    
    private var viewModel:KhuiSealViewModel!
    private let image = PublishSubject<String>()
    private let imei = BehaviorRelay<String>(value:"")
    
    init(id: Int) {
        self.viewModel = KhuiSealViewModel()
        self.viewModel.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let view = self.mainView
        view.imageView.delegate = self
        view.imeitextField.delegate = self
        self.title = "Khách hàng khui seal"
        
        self.bind()
    }
    
    private func bind(){
        let view = self.mainView
        let bag = self.viewModel.bag
        
        view.imeitextField.textField
            .rx
            .text
            .orEmpty
            .bind(to: self.imei)
            .disposed(by: bag)
        
        self.imei.bind(to: view.imeitextField.textField.rx.text).disposed(by: bag)
        
        let input = KhuiSealViewModel.Input(
            imei: imei.asDriver(),
            image: self.image.asDriver(onErrorJustReturn: ""),
            finish: view.finalButton.rx.tap.asDriver())
        
        let output = self.viewModel.transform(input)
        
        
        output.fetching
            .drive { [weak self] value in
            value ? self?.startLoading(message: "Đang tải dữ liệu") : self?.stopLoading()
        }.disposed(by: bag)
        
        output.error
            .drive { [weak self] error in
                self?.showAlert(message: error,colorTitle: .red)
            }.disposed(by: bag)
        
        output.enableButton
            .drive(view.finalButton.rx.isEnabled)
            .disposed(by: bag)
        
        output.responseFinal.drive(onNext: { model in
            let mess = model.mess ?? ""
            let isBack = model.status == 1
            self.showAlert(message: mess,
                           colorTitle: isBack ? Common.Colors.CamKet.green : .red,
                           isBack: isBack ? true : false)
        }).disposed(by: bag)
        
        output.urlImage
            .drive { urlString in
                if urlString != "" {
                    let url = URL(string: urlString)
                    view.imageView.kf.setImage(with: url)
                }
            }.disposed(by: bag)
        
        output.responseUpLoad.drive(onNext: { model in
            let mess = model.message ?? ""
            self.showAlert(message: mess,
                           colorTitle: model.success == true ? Common.Colors.CamKet.green : .red)
        }).disposed(by: bag)
        
    }
    
    private func showAlert(message:String,colorTitle:UIColor ,isBack:Bool = false){
        AlertManager
            .shared
            .alertCoreICT(
                title: "Thông báo",
                message: message,
                colorTitle: colorTitle,
                colorButtons: .darkGray,
                placeholder: "",
                buttons: "Đồng ý",
                isTextField: false,
                self: self) { _, index in
                    if isBack {
                        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
                    }
        }
    }
    
}

extension KhuiSealViewController : ImageViewCoreICTDelegate {
    func imagePicker(index: Int) {
        ImagePickerManager().pickImage(isCamera: true, self) { [weak self] image in
            guard let self = self else { return }
            guard let imageData: Data = image.jpegData(compressionQuality: 0.8) else {
                self.showAlert(message: "Lỗi hình. Hãy thử chụp lại", colorTitle: .red)
                return
            }
            let base64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            self.image.onNext(base64)
        }
    }
}

extension KhuiSealViewController : TextFieldCoreICTDelegate {
    func actionButton() {
        let vc = ScanCodeViewController()
        vc.scanSuccess = { code in
            self.imei.accept(code)
        }
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false, completion: nil)
    }
}
