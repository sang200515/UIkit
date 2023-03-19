//
//  KhuiSealViewModel.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 20/10/2022.
//

import RxSwift
import RxCocoa
import RxOptional

class KhuiSealViewModel {
    
    let userCode = Cache.user?.UserName ?? ""
    let shopCode = Cache.user?.ShopCode ?? ""
    let bag = DisposeBag()
    var id:Int = 0
    
    func transform(_ input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let fetching = activityIndicator.asDriver()
        
        let rspUpload = input.image
            .flatMapLatest { image in
                return SealiPhone14RequestRx
                    .request(.uploadIMGSeal(
                        base64: image,
                        folder: "IphoneOpenSeal",
                        filename: "\(self.id)_OpenSealKhachHangKhuiSeal.jpg"),
                             UploadImageSealModel.self)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
        }
        
        let rspUploadSuccess = rspUpload
            .map { response -> UploadImageSealModel? in
            guard case .success(let value) = response else {
                return nil
            }
            return value
        }.filterNil()
        
        let rspUploadError = rspUpload
            .map { response -> String? in
            guard case .failure(let error) = response else {
                return nil
            }
            return error.message
        }.filterNil()
        
        let paramFN = Driver.combineLatest(rspUploadSuccess,input.imei)
        
        let rspFinal = input.finish
            .withLatestFrom(paramFN)
            .flatMapLatest { response,imei in
                return SealiPhone14RequestRx
                    .request(.finishSeal(
                        UserCode: self.userCode,
                        ShopCode: self.shopCode,
                        id: self.id,
                        Imei: imei,
                        urlImageOpenSeal: response.url ?? ""), KhuiSealOTPModel.self)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        let rspFinalSuccess = rspFinal
            .map { response -> KhuiSealOTPModel? in
            guard case .success(let value) = response else {
                return nil
            }
            return value
        }.filterNil()
        
        let rspFinalError = rspFinal
            .map { response -> String? in
            guard case .failure(let error) = response else {
                return nil
            }
            return error.message
        }.filterNil()
        
        let errors = Driver.merge(rspUploadError,rspFinalError)
        
        let enabel = Driver.combineLatest(input.imei,input.image).map { imei,image -> Bool in
            return imei != "" && image != ""
        }
        
        let urlImage = rspUploadSuccess.map { model in
            return model.url ?? ""
        }
        
        return Output(fetching: fetching,
                      error: errors,
                      responseUpLoad: rspUploadSuccess,
                      responseFinal: rspFinalSuccess,
                      enableButton: enabel,
                      urlImage: urlImage)
    }
    
}

extension KhuiSealViewModel : ViewModelType {
    
    struct Input {
        let imei:Driver<String>
        let image:Driver<String>
        let finish:Driver<Void>
    }
    
    struct Output {
        let fetching:Driver<Bool>
        let error: Driver<String>
        let responseUpLoad:Driver<UploadImageSealModel>
        let responseFinal:Driver<KhuiSealOTPModel>
        let enableButton:Driver<Bool>
        let urlImage:Driver<String>
    }
}
