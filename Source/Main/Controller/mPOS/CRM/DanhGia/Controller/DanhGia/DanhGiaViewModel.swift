	//
	//  DanhGiaViewModel.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 02/11/2022.
	//

import Foundation
import SwiftyJSON
final class DanhGiaViewModel{
	var masterDataObject:EvaluateMasterDataModel?


	func loadMasterData(completion:@escaping (String) -> Void){ //API 8
		Provider.shared.eveluateAPIService.loadMasterData(success: { [weak self] result in
			guard let self = self else { return }
			if let respone = result {
				self.masterDataObject = respone
//				self.masterDataObject?.hangMucGiaTri?.forEach({ item in
//					item.isSelected = false 
//				})
				completion("")
			}else {
				completion("Không load được data")
			}
		},failure: { error in
			completion(error.description)
		})
	}
	func doneEvaluate(loaiDanhGia: Int, nhanVien: String, cuaHangPhongBan: String, hangMucGiaTri: String, capDoDichVu: String,lyDo: String,completion: @escaping ((Bool,String) -> Void )){

		Provider.shared.eveluateAPIService.doneEvaluate(loaiDanhGia: loaiDanhGia, nhanVien: nhanVien, cuaHangPhongBan: cuaHangPhongBan, hangMucGiaTri: hangMucGiaTri, capDoDichVu: capDoDichVu, lyDo: lyDo, success: {  result in
			if result?.status == 1{
				completion(true,result?.mess ?? "")
			}else {
				completion(false,result?.mess ?? "")
			}
		}, failure: { error in
			completion(false, error.description)
		})

	}
	
	func loadDetailHistory(id:Int,type:Int,completion:@escaping ((DetailHistoryEveluateModel,String) -> Void)){
		Provider.shared.eveluateAPIService.loadDetailHistory(id: id,type:type, success: { result in

			if result == nil {
				completion(DetailHistoryEveluateModel(JSON: [:])!,"Không thể load chi tiết")
			}else {
				completion(result!,"")
			}
		}, failure: {error in
			completion(DetailHistoryEveluateModel(JSON: [:])!,error.description)
		})

	}
}
