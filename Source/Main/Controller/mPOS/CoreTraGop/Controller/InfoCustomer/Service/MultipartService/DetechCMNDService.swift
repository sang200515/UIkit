    //
    //  DetechCMNDService.swift
    //  QuickCode
    //
    //  Created by Sang Trương on 18/07/2022.
    //
import UIKit
import Foundation
import Alamofire
import SwiftyJSON
import MBProgressHUD

struct ErrorDetech2 : Codable {
    let error : Error2?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }
}
struct Error2 : Codable {
    let code : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
    }


}

struct ErrorDetech : Codable {
    let error : Error1?

    enum CodingKeys: String, CodingKey {

        case error = "error"
    }
}
struct Error1 : Codable {
    let code : String?
    let message : String?
    let details : String?
    let data : String?
    let validationErrors : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case details = "details"
        case data = "data"
        case validationErrors = "validationErrors"
    }


}
public class MultiPartService{

    class func detechCMND(media: UIImage,media2: UIImage, params: [String:Any], fileName: String,handler: @escaping (_ success:DetechCMNDModel?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("Starting detech ... ")
        let access_token = UserDefaults.standard.string(forKey: "access_token")
        let headers: HTTPHeaders = [ "Content-type": "multipart/form-data", "Authorization": "Bearer \(access_token!)"]
        var BASE_URL = ""
        let target = Bundle.main.infoDictionary?["TargetName"] as? String
        var prefix = ""
        switch target {
            case "fptshop", "Production":
                prefix = "/installment-service"
            default:
                prefix = "/dev-installment-service"
        }
        BASE_URL = Config.manager.URL_GATEWAY! + prefix
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(media.jpegData(
                    compressionQuality: 1)!,
                                         withName: "IdCardFront",
                                         fileName: "IdCardFront.jpeg", mimeType: "image/jpeg"
                )
                multipartFormData.append(media2.jpegData(
                    compressionQuality: 1)!,
                                         withName: "idCardBack",
                                         fileName: "idCardBack.jpeg", mimeType: "image/jpeg"
                )
                for (key, value) in params {
                    let memberData = "\(value)".data(using: String.Encoding.utf8) ?? Data()
                    multipartFormData.append(memberData, withName: "\(key)")
                }
            },
            to: BASE_URL + "/api/customer/detach-idcard",
            method: .post ,
            headers: headers
        )
        .response { response in
            switch response.result {
                case .success(let value):
                let numberRange = 200...299
                guard let data = value else {return}
                let status = response.response?.statusCode
                if numberRange.contains(status ?? 0) {
                    do {
                        let json = try JSONDecoder().decode(DetechCMNDModel.self, from: data)
                        handler(json,"")
                        print(json)
                    }catch {
                        handler(nil,"Không parse được dữ liệu!")
                    }
                } else {
                    do {
                        let error = try JSONDecoder().decode(ErrorDetech2.self, from: data)
                        handler(nil,error.error?.message ?? "")
                    } catch {
                        handler(nil,"Không thể bóc tách cmnd/cccd")
                    }
                }
                case .failure(let error):
                    print(error.localizedDescription)
                    handler(DetechCMNDModel(idCard: "", birthDate: "", proviceName: "", wardName: "", firstName: "", middleName: "", lastName: "", street: "", wardCode: "", idCardIssuedDate: "", districtName: "", proviceCode: "", idCardIssuedExpiration: "", idCardIssuedBy: "", districtCode: "", uploadFiles: []),error.localizedDescription)
            }
        }
    }

    class func uploadPhoto(media: UIImage, params: [String:Any], fileName: String,handler: @escaping (_ success:UploadFiles,_ error:String) ->Void){
//        ProgressView.shared.show()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("Starting upload ... ")
        let access_token = UserDefaults.standard.string(forKey: "access_token")
        let headers: HTTPHeaders = [ "Content-type": "multipart/form-data", "Authorization": "Bearer \(access_token!)"]
        var BASE_URL = ""
        let target = Bundle.main.infoDictionary?["TargetName"] as? String
        var prefix = ""
        switch target {
            case "fptshop", "Production":
                prefix = "/installment-service"
            default:
                prefix = "/dev-installment-service"
        }
        BASE_URL = Config.manager.URL_GATEWAY! + prefix
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(media.jpegData(
                    compressionQuality: 1)!,
                                         withName: "file",
                                         fileName: "file.jpeg", mimeType: "image/jpeg"
                )
                    //                multipartFormData.append(media2.jpegData(
                    //                    compressionQuality: 1)!,
                    //                                         withName: "idCardBack",
                    //                                         fileName: "idCardBack.jpeg", mimeType: "image/jpeg"
                    //                )
                for (key, value) in params {
                    let memberData = "\(value)".data(using: String.Encoding.utf8) ?? Data()
                    multipartFormData.append(memberData, withName: "\(key)")
                }
            },
            to: BASE_URL + "/api/customer/upload",
            method: .post ,
            headers: headers
        )
        .response { response in
//            ProgressView.shared.hide()
            switch response.result {
                case .success(let value):
                    guard let data = value else {return}
                    print(String(data: data, encoding: .utf8)!)

                    do {
//                        ProgressView.shared.hide()
                        let json = try JSONDecoder().decode(UploadFiles.self, from: data)
                        let error = try JSONDecoder().decode(ErrorDetech.self, from: data)
                        handler(json,error.error?.details ?? "")

                    }catch {
                        print(error.localizedDescription)
                        handler(UploadFiles(fileType: "", fileName: "", urlImage: ""),  "")
//                        ProgressView.shared.hide()
                    }
                case .failure(let error):
                        //                handler(nil,"")
//                    ProgressView.shared.hide()
                    print(error.localizedDescription)
                        //                    handler(ơư,error.localizedDescription)
                    handler(UploadFiles(fileType: "", fileName: "", urlImage: ""),  "")


            }
        }
    }
}
