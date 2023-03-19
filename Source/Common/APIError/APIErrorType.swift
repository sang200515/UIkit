//
//  APIErrorType.swift
//  BaoCaoHinhAnhTrungBay
//
//  Created by Trần Văn Dũng on 13/07/2021.
//

import Foundation
import Alamofire

enum APIErrorType:Error {
    case vpnError
    case code400
    case code401
    case code403
    case code404
    case code405
    case code500
    case code501
    case code502
    case code503
    case code504
    case invalidURL
    case invalidNetWork
    case invalidData
    case invalidPaserData
    case requestTimeout
    case uploadImageFaild
    case defaultError(code:Int,message:String)
    
    var message:String {
        switch self {
        case .vpnError:
            return "Lỗi kết nối. Hãy kiểm tra lại mạng và thử lại"
        case .invalidURL:
            return "URL không hợp lệ"
        case .invalidData:
            return "Lỗi không có Data"
        case .requestTimeout:
            return "Hết thời gian yêu cầu"
        case .invalidPaserData:
            return "Không thể Decode Data"
        case .defaultError(let code,let message):
            return "HTTP Code: \(code) \n\(message)"
        case .invalidNetWork:
            return "Không có kết nối internet"
        case .uploadImageFaild:
            return "Upload hình thất bại"
        case .code400:
            return "400 Bad Request"
        case .code401:
            return "401 Unauthorized"
        case .code403:
            return "403 Forbidden\nKhông có quyền truy cập vào phần nội dung"
        case .code404:
            return "404 Not Found"
        case .code405:
            return "405 Method Not Allowed"
        case .code500:
            return "500 Internal Server Error"
        case .code501:
            return "501 Not Implemented"
        case .code502:
            return "502 Bad Gateway"
        case .code503:
            return "503\nMáy chủ hiện tại không có sẵn.Đang quá tải hoặc bảo trì."
        case .code504:
            return "504 Gateway Timeout"
        }
    }
}

