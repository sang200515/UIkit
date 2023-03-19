//
//  ORCCMNDMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class ORCCMNDMiraeViewController: BaseVC<ORCCMNDMiraeView> {
   
    //MARK:- Properties
    var presenter: ORCCMNDMiraePresenter?
    
    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureImageView()
        self.configureButton()
        self.configureNavigationBackItem(title: PARTNERID == "FPT" ? "TRẢ GÓP MIRAE" : "THUÊ MÁY COMP")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.updateHeightScrollView()
    }
    
    deinit {
        print("Denit ORCCMNDMiraeViewController is Success")
    }
    
    //MARK:- Configure
    private func configureButton(){
        self.mainView.nextButton.addTarget(self, action: #selector(self.nextTapped), for: .touchUpInside)
    }
    
    private func configureImageView(){
        self.mainView.cmndMatTruocImageView.delegate = self
        self.mainView.cmndMatSauImageView.delegate = self
    }
    
    private func updateHeightScrollView(){
        let contentRect: CGRect = self.mainView.scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        self.mainView.scrollView.contentSize = contentRect.size
        self.mainView.layoutIfNeeded()
    }
    
    //MARK:- Actions
    @objc private func nextTapped(){
        self.presenter?.orcCMND()
    }
    
}

extension ORCCMNDMiraeViewController : ORCCMNDMiraePresenterToViewProtocol {
    
    func outPutSuccess(model: ORCCMNDMiraeEntity.ORCCMNDMiraeDataModel) {
        let vc = ThongTinKhachHangMireaRouter().configureVIPERThongTinKhachHangMirea()
        vc.presenter?.model = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func outPutSuccess(data: String) {
        
    }
    
    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "Đồng ý", viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension ORCCMNDMiraeViewController : UploadImageViewDelegate {
    func selectedTapped(tag: Int) {
        ImagePickerManager().pickImage(isCamera: true, self) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if tag == 0 {
                    if let imageData:NSData = image.jpegData(compressionQuality: 0.5) as NSData?{
                        self.presenter?.hinhMatTruoc = imageData.base64EncodedString(options: .endLineWithLineFeed)
                    }
                    self.mainView.cmndMatTruocImageView.imageSet = image
                }else {
                    if let imageData:NSData = image.jpegData(compressionQuality: 0.5) as NSData?{
                        self.presenter?.hinhMatSau = imageData.base64EncodedString(options: .endLineWithLineFeed)
                    }
                    self.mainView.cmndMatSauImageView.imageSet = image
                }
            }
        }
    }
}
