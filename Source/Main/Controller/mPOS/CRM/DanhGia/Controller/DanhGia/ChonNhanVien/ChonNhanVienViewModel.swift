	//
	//  ChonNhanVienViewModel.swift
	//  QuickCode
	//
	//  Created by Sang Trương on 01/11/2022.
	//

import Foundation

enum SearchEmployeeResult {
	case message(String)
}
class ChonNhanVienViewModel {
	private var keySearch: String = ""
	private var loaiDanhGia: Int = 1
	private var typeSearch: String = ""
	 var listEmployee: [CustomerEveluateModel] = []
	var employeeSelected:CustomerEveluateModel?
	 typealias completionSearchEmployee = (SearchEmployeeResult) -> Void

	func searchEmployee(
		loaiDanhGia: Int, typeSearch: String, keySearch: String,shopCode:String, completion: @escaping completionSearchEmployee) {
			Provider.shared.eveluateAPIService.searchEmployee(
				loaiDanhGia: loaiDanhGia, typeSearch: typeSearch, keySearch: keySearch, shopCode: shopCode,
				success: { [unowned self] result in
					if result.count > 0 {
						self.listEmployee = result
						completion(.message(""))
					} else {
						self.listEmployee = []
						completion(.message( "Không tìm thấy thông tin user \(keySearch)"))
					}
				},
				failure: { error in
					completion(.message(error.description))
				})
		}
}
