	//
	//  CallTuVanSanPhamViewModel.swift
	//  fptshop
	//
	//  Created by Sang Trương on 30/12/2022.
	//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
	//


import UIKit
import RxSwift
import RxCocoa

class CallTuVanSanPhamViewModel:ViewModelType{
	let errorSubject = BehaviorRelay(value: "")
	struct Input {
		let segmentIndexSubject: Observable<Int>
		let searchTextSubject:Driver<String>
	}
	struct Output {
		let responeSearchCustomerSubject:Driver<[CallTuVanSanPhamDataModel]>
		let errorRequest:Driver<String>
	}
	func transform(_ input: Input) -> Output{
		let respone = input.segmentIndexSubject.flatMapLatest { index in
			return self.executeObservableSearchHistory(type: "\(index + 1)")
		}

		let mapResponse = respone.map {  model ->  [CallTuVanSanPhamDataModel] in
			return model.data ?? []
		}

		let resultSearchLocalSubject = Driver.combineLatest(mapResponse.asDriver(onErrorJustReturn: []),input.searchTextSubject).map { dataSource, query -> [CallTuVanSanPhamDataModel] in
			if query == "" {
				return dataSource
			}else {
				return self.searchCustomer(query: query, source: dataSource)
			}
		}.asDriver(onErrorJustReturn: [])

		let _errorSubject:Driver<String> = errorSubject.asDriver(onErrorJustReturn: "")

		return Output(responeSearchCustomerSubject: resultSearchLocalSubject,errorRequest:_errorSubject)
	}
	private func searchCustomer(query:String,source:[CallTuVanSanPhamDataModel]) -> [CallTuVanSanPhamDataModel] {
		return source.filter {  ($0.customerName?.lowercased().contains(query.lowercased()))! ||
			($0.phone?.lowercased().contains(query.lowercased()))! }
	}

}

extension CallTuVanSanPhamViewModel {
	func executeObservableSearchHistory(type:String) -> Observable<CallTuVanSanPhamModel> {
		Observable.create { (observer) -> Disposable in
			Provider.shared.callTuVanSanPhamService.loadListCustomer(type: type, success: {
				result in
				observer.onNext((result ?? CallTuVanSanPhamModel(JSON:[:]))!)
				observer.onCompleted()
			},failure: { [weak self] (error) in
				guard let self = self else { return }
				self.errorSubject.accept(error.description)
				observer.onCompleted()
			})
			return Disposables.create()
		}
	}
}
enum RequestError: Error {
	case networkError(error:String)
}
