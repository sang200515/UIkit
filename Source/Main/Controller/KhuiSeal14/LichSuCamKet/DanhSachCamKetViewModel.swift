//
//  DanhSachCamKetViewModel.swift
//  KhuiSealiPhone14
//
//  Created by Trần Văn Dũng on 17/10/2022.
//

import RxSwift
import RxCocoa
import RxOptional


class DanhSachCamKetViewModel {
    
    let bag = DisposeBag()
    var arrayType:[String] = ["Tất cả","ID","CMND/CCCD","SĐT"]
    
    func transform(_ input: Input) -> Output {
        
        let activityIndicator = ActivityIndicator()
        let fetching = activityIndicator.asDriver()
        
        let parameters = Driver
            .combineLatest(input.typeFind, input.searchText)
        
        let type = input.typeFind
            .map { _ in
                return ()
            }
        
        let action = Driver.merge(input.viewDidLoad,input.searchTapped,type)
        
        let response = action
            .withLatestFrom(parameters)
            .flatMapLatest { type,text in
                return SealiPhone14RequestRx.request(
                    .getListHistory(typeFind: "\(type)", keySearch: text),
                    [DanhSachCamKetModel].self)
                    .trackActivity(activityIndicator)
                    .asDriverOnErrorJustComplete()
            }
        
        
        let responseSuccess = response
            .map { rsp -> [DanhSachCamKetModel]? in
                guard case .success(let value) = rsp else {
                    return nil
                }
                return value
            }
            .filterNil()
        
        let responseError = response
            .map { rsp -> String? in
            guard case .failure(let error) = rsp else {
                return nil
            }
            return error.message
        }.filterNil()
        
        
        let output = Output(listType: self.arrayType,
                            fetching: fetching,
                            error: responseError,
                            response: responseSuccess)
        
        return output
        
    }
    
}

extension DanhSachCamKetViewModel : ViewModelType {
    
    struct Input {
        let typeFind:Driver<Int>
        let searchText:Driver<String>
        let searchTapped:Driver<Void>
        let row:Driver<Int>
        let viewDidLoad:Driver<Void>
    }
    
    struct Output {
        let listType:[String]
        let fetching:Driver<Bool>
        let error: Driver<String>
        let response:Driver<[DanhSachCamKetModel]>
    }
    
    
}
