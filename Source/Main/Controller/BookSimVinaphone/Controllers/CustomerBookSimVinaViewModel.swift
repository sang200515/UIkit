	//
	//  CustomerBookSimVinaViewModel.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 30/12/2022.
	//
import RxSwift
import RxCocoa
import Foundation
import SwiftyJSON
class CustomerBookSimVinaViewModel:ViewModelType {
	let errorSubject = PublishRelay<String>()
	let responseSubject =  PublishRelay<AddBookSimVinaphoneModel>()
	struct Input{
		let subscriptionSubject:Driver<Int>
		let nameSubject:Driver<String>
		let idCardSubject:Driver<String>
		let phoneSubject:Driver<String>
		let searialSubject:Driver<String>
		let saveButtonClicked:Driver<Void>

	}
	struct Output {
		let errorMessage:Driver<String>
		let responseAddBookSim:Driver<AddBookSimVinaphoneModel>
		let isEnableButton:Driver<Bool>
	}
	func transform(_ input:Input) -> Output {
		let validateSubject = Driver.combineLatest(input.nameSubject,input.idCardSubject,input.phoneSubject,input.searialSubject).map { name ,idcard ,phone , serial in
			return (name != "" && idcard != "" && phone != "" && serial != "" )
		}.startWith(false).distinctUntilChanged().asDriver(onErrorJustReturn: true )

		let paramAddBookSim = Driver.combineLatest(input.subscriptionSubject,
												   input.nameSubject,
												   input.idCardSubject,
												   input.phoneSubject,
												   input.searialSubject).map { subscription, name , idCard, phone , serial  -> AddBookSimVinaphoneParam in
			let param = AddBookSimVinaphoneParam(Usercode: Cache.user!.UserName,
												 Shopcode: Cache.user!.ShopCode,
												 PhoneNumber: phone,
												 Serial: serial,
												 CMND: idCard,
												 FullName: name,
												 PackageCode: Cache.packageBookSim?.MaGoiCuoc ?? "",
												 PackageName: Cache.packageBookSim?.TenGoiCuoc ?? "",
												 PackagePrice: "\(subscription)" ,
												 PackageType: 1 )
				//FIXME: PackageType : loại sim (1 sim thường / 2 esim )
			return param
		}

		let  _responseAddBookSim = input.saveButtonClicked
			.withLatestFrom(paramAddBookSim)
			.flatMapLatest { param in
				return self.executeObservableAddBookSim(param:param)
					.asDriver(onErrorJustReturn: AddBookSimVinaphoneModel(JSON:[:])!)

			}

		return Output(errorMessage: errorSubject.asDriverOnErrorJustComplete(), responseAddBookSim: _responseAddBookSim, isEnableButton: validateSubject)
	}

}

extension CustomerBookSimVinaViewModel {

	func executeObservableAddBookSim(param:AddBookSimVinaphoneParam) -> Observable<AddBookSimVinaphoneModel> {
		Observable.create { (observer) -> Disposable in
			Provider.shared.bookSimVinaphone.addOrder(param: param,success: {
				result in
				guard let success = result?.success else { return }
				if success  {
					observer.onNext((result ?? AddBookSimVinaphoneModel(JSON:[:]))!)
				}else {
					self.errorSubject.accept(result?.mess ?? "Load API Error => /api/Sim/VinaAddOrder_SMCS" )
				}

				observer.onCompleted()
			},failure: { [weak self] (error) in
				guard let self = self else { return }
				self.errorSubject.accept(error.description + " => /api/Sim/VinaAddOrder_SMCS")
				observer.onCompleted()
			})
			return Disposables.create()
		}
	}

}
