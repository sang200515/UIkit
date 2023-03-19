import RxSwift
import RxCocoa
import RxOptional

class BanCamKetViewModel {

    lazy var bag = DisposeBag()
    private let idOTP = BehaviorRelay<Int>(value: 0)
    private let userCode = Cache.user?.UserName ?? ""
    private let shopCode = Cache.user?.ShopCode ?? ""
    var isHistory:Bool = false

}

extension BanCamKetViewModel : ViewModelType {
    
    func transform(_ input: Input) -> Output {
      
        let activityIndicator = ActivityIndicator()
        let fetching = activityIndicator.asDriver()
        
        let action = Driver.merge(input.getOTP,input.resent)
        
        let prGetOTP = Driver.combineLatest(input.paramester,input.sign).map { pr,sign -> BanCamKetKhuiSealModel? in
            if pr.nameCustomer != "" && pr.cmnd != "" && pr.ngayCap != "" && pr.noiCap != "" && pr.phone != "" && sign != ""{
                return pr
            }
            return nil
        }
        
        let responseGetOTP = action
            .withLatestFrom(prGetOTP)
            .flatMapLatest { pr in
                if pr != nil {
                    return SealiPhone14RequestRx.request(.getOTP(
                        userCode: self.userCode,
                        shopCode: self.shopCode,
                        phone: pr?.phone ?? ""), KhuiSealOTPModel.self)
                        .trackActivity(activityIndicator)
                        .asDriverOnErrorJustComplete()
                }
                return Driver.never()
            }
        
        let responseGetOTPValue = responseGetOTP
            .map { response -> KhuiSealOTPModel? in
            guard case .success(let value) = response else {
                return nil
            }
            return value
        }.filterNil()
        
        let errorGetOTP = responseGetOTP
            .map { response -> String? in
            guard case .failure(let error) = response else {
                return nil
            }
            return error.message
        }.filterNil()
        
        responseGetOTPValue.map { model in
            model.idOtp ?? 0
        }.drive(self.idOTP)
            .disposed(by: self.bag)
        
        let prContent = Driver
            .combineLatest(input.id,
                           self.idOTP.asDriver())
        
        let prVerify = Driver
            .combineLatest(input.paramester,
                           input.otp,
                           self.idOTP.asDriver())
            .map { model,otp,id in
                return (model.phone ?? "",otp,id)
            }
        
        let response = input.viewDidLoad
            .asDriver()
            .withLatestFrom(prContent)
            .flatMapLatest { id, idOTP in
            return SealiPhone14RequestRx.request(
                .getContent(
                    userCode: self.userCode,
                    shopCode: self.shopCode,
                    id_OTP: idOTP,
                    id: id), BanCamKetKhuiSealModel.self)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
        }
        
        let responseSuccess = response
            .map { response -> BanCamKetKhuiSealModel? in
            guard case .success(let value) = response else {
                return nil
            }
            return value
        }.filterNil()
        
        let responseError = response
            .map { response -> String? in
            guard case .failure(let error) = response else {
                return nil
            }
            return error.message
        }.filterNil()
        
        let prFinal = Driver
            .combineLatest(input.paramester,
                           input.sign,
                           self.idOTP.asDriver(),
                           responseSuccess)

        let responseFinal = input.finalCommit
            .withLatestFrom(prFinal)
            .flatMapLatest { pr,sign,idOTP, rsp in
                return SealiPhone14RequestRx.request(.finishPledge(
                    userCode: self.userCode,
                    shopCode: self.shopCode,
                    nameCustomer: pr.nameCustomer ?? "",
                    cmnd: pr.cmnd ?? "",
                    ngayCap: pr.ngayCap ?? "",
                    noiCap: pr.noiCap ?? "",
                    phone: pr.phone ?? "" ,
                    sanPham: rsp.sanPham ?? "",
                    base64ChuKy: sign,
                    ID_OTP: idOTP), KhuiSealOTPModel.self)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
            }
        
        let responseFinalSuccess = responseFinal
            .map { response -> KhuiSealOTPModel? in
            guard case .success(let value) = response else {
                return nil
            }
            return value
        }.filterNil()
        
        let responseFinalError = responseFinal
            .map { response -> String? in
            guard case .failure(let error) = response else {
                return nil
            }
            return error.message
        }.filterNil()
        
        let responseVerifyOTP = prVerify
            .flatMapLatest { phone,otp,id in
            SealiPhone14RequestRx.request(
                .verifyOTP(userCode: self.userCode,
                           shopCode: self.shopCode,
                           phone: phone,
                           OTP: otp,
                           ID_OTP: id), KhuiSealOTPModel.self)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }
        
        let responseVerifyOTPSuccess = responseVerifyOTP
            .map { response -> KhuiSealOTPModel? in
            guard case .success(let value) = response else {
                return nil
            }
            return value
        }.filterNil()
        
        let responseVerifyOTPError = responseVerifyOTP
            .map { response -> String? in
            guard case .failure(let error) = response else {
                return nil
            }
            return error.message
        }.filterNil()
        
        let enabelButton = Driver.combineLatest(input.paramester,responseSuccess,input.sign)
        
        let missFieldString = input.getOTP.withLatestFrom(enabelButton)
            .map { pr,rsp ,sign-> String? in
                if pr.nameCustomer == "" {
                    return "Vui lòng nhập họ tên khách hàng"
                }
                
                if pr.cmnd == "" {
                    return "Vui lòng nhập CMND/CCCD của khách hàng"
                }
                
                if pr.ngayCap == "" {
                    return "Vui lòng chọn ngày cấp CMND/CCCD"
                }
                
                if pr.noiCap == "" {
                    return "Vui lòng nhập nơi cấp CMND/CCCD"
                }
                
                if pr.phone == "" {
                    return "Vui lòng nhập số điện thoại của khách hàng."
                }
                
                if pr.phone?.count != 10 {
                    return "Vui lòng nhập đúng định dạng số điện thoại."
                }
                
                if rsp.sanPham == "" {
                    return "Không có thông tin sản phẩm cần ký cam kết."
                }
                
                if sign == "" {
                    return "Thiếu chữ ký khách hàng cần cam kết."
                }
                
                return nil
            }
            .filterNil()
        
        let errors = Driver
            .merge(
                missFieldString,
                errorGetOTP,
                responseError,
                responseFinalError,
                responseVerifyOTPError
            )
            .asDriver(onErrorJustReturn: "Lỗi không xác định")
        
        
        return Output(fetching: fetching,
                      error: errors,
                      response: responseSuccess,
                      responseFinal: responseFinalSuccess,
                      responseGetOTP: responseGetOTPValue,
                      responseVerifyOTP:responseVerifyOTPSuccess)
    }
    
}

extension BanCamKetViewModel  {
    struct Input {
        let paramester:Driver<BanCamKetKhuiSealModel>
        let getOTP:Driver<Void>
        let finalCommit:Driver<Void>
        let id:Driver<Int>
        let otp:Driver<String>
        let sign:Driver<String>
        let viewDidLoad:BehaviorRelay<Void>
        let resent:Driver<Void>
    }
    
    struct Output {
        let fetching:Driver<Bool>
        let error: Driver<String>
        let response:Driver<BanCamKetKhuiSealModel>
        let responseFinal:Driver<KhuiSealOTPModel>
        let responseGetOTP:Driver<KhuiSealOTPModel>
        let responseVerifyOTP:Driver<KhuiSealOTPModel>
    }
}

