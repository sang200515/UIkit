//
//  UpdateHinhAnhMiraeViewController.swift
//
//  Created by Trần Văn Dũng 07/10/2021.
// VIPER Template
//

import UIKit

class UpdateHinhAnhMiraeViewController: BaseVC<UpdateHinhAnhMiraeView> {
   
    //MARK:- Properties
    var presenter: UpdateHinhAnhMiraePresenter?
    var row:Int = 0
    //MARK:- Create ComponentUI
    

    // MARK: - ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationBackItem(title: "CẬP NHẬT HÌNH ẢNH")
        self.mainView.hinhDinhKemButton.delegate = self
        self.presenter?.viewDidLoad()
        self.mainView.tableView.dataSource = self
        self.mainView.tableView.delegate = self
        self.mainView.updateButton.addTarget(self, action: #selector(self.updateHinhAnh), for: .touchUpInside)
    }
    
    
    
    deinit {
        print("Denit UpdateHinhAnhMiraeViewController is Success")
    }
    
    //MARK:- Configure
    
    
    //MARK:- Actions
    @objc private func updateHinhAnh(){
        self.presenter?.updateHinhConThieu()
    }
    
}

extension UpdateHinhAnhMiraeViewController : UpdateHinhAnhMiraePresenterToViewProtocol {
    
    func didResubmitToMiraeSuccess(message: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "OK", viewController: self) {
            let controllers : Array = self.navigationController!.viewControllers
            self.navigationController?.popToViewController(controllers[1], animated: true)
        }
    }
    
    func didUploadHinhSuccess(message: String, tag: Int, image: UIImage) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "OK", viewController: self) {
            self.presenter?.model[self.row].image = image
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    func didUpdateHinhConThieuSuccess(message: String) {
        self.showAlertMultiOption(title: "Thông Báo", message: message, options: "GỬI NHÀ TRẢ GÓP","TIẾP TỤC CẬP NHẬT", buttonAlignment: .horizontal) { index in
            if index == 0 {
                self.presenter?.resubmitToMirae()
            }else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func didUpdateHinhConThieuFailed(message: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: message, titleButton: "OK", viewController: self) {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    func didLoadAnhConThieuSuccess() {
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }

    
    func outPutFailed(error: String) {
        AlertManager.shared.alertWithViewController(title: "Thông báo", message: error, titleButton: "OK", viewController: self) {
            
        }
    }
    
    func showLoading(message: String) {
        self.startLoading(message: message)
    }
    
    func hideLoading() {
        self.stopLoading()
    }
}

extension UpdateHinhAnhMiraeViewController : HeaderInfoDelegate {
    func onClickHeader(headerView: UIView) {
        
    }
}

extension UpdateHinhAnhMiraeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter?.model.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Common.TraGopMirae.identifierTableViewCell.updateHinh, for: indexPath) as! UpdateHinhAnhTableViewCell
        cell.model = self.presenter?.model[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        self.row = indexPath.row
        ImagePickerManager().pickImage(isCamera: true, self) { [weak self] image in
            
            guard let self = self else { return }
            guard let imageData: Data = image.jpegData(compressionQuality: 0.8) else {
                self.outPutFailed(error: "Lỗi hình. Hãy thử chụp lại")
                return
            }
            let base64 = imageData.base64EncodedString(options: .endLineWithLineFeed)
            
            self.presenter?.uploadHinhHoSo(base64: base64, fileId: self.presenter?.model[indexPath.row].fieldID ?? 0, image: image)
        }
     }


}

extension UpdateHinhAnhMiraeViewController : UpdateHinhAnhTableViewCellDelegate {
    func didSelected(fileID:Int) {
        
    }
}
