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

    class func detechCMND(media: UIImage,media2: UIImage, params: [String:Any], fileName: String,handler: @escaping (_ success:DetechCMNDModel,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print("Starting detech ... ")
        let access_token = UserDefaults.standard.string(forKey: "access_token")
        let headers: HTTPHeaders = [ "Content-type": "multipart/form-data", "Authorization": "Bearer \(access_token!)"]
        let BASE_URL = Config.manager.URL_GATEWAY!
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
            to: BASE_URL + "/dev-installment-service/api/customer/detach-idcard",
            method: .post ,
            headers: headers
        )
        .response { response in
            switch response.result {
                case .success(let value):
                    print(value)

                    guard let data = value else {return}
                    do {
                        let json = try JSONDecoder().decode(DetechCMNDModel.self, from: data)
                        let error = try JSONDecoder().decode(ErrorDetech.self, from: data)
                        handler(json,error.error?.message ?? "Không thể bốc tách được CMND")
                        print(json)
                        print(error)

                        CoreInstallMentData.shared.uploadFiles = json.uploadFiles
                    }catch {
                        handler(DetechCMNDModel(idCard: "", birthDate: "", proviceName: "", wardName: "", firstName: "", middleName: "", lastName: "", street: "", wardCode: "", idCardIssuedDate: "", districtName: "", proviceCode: "", idCardIssuedExpiration: "", idCardIssuedBy: "", districtCode: "", uploadFiles: []),error.localizedDescription)
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
        var rs:UploadFiles?
        let BASE_URL = Config.manager.URL_GATEWAY!
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
            to: BASE_URL + "/dev-installment-service/api/customer/upload",
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
                        handler(json,error.error?.message ?? "")
                            //                        handler(json,"")
                            //                        print(json)
                            //                        CoreInstallMentData.shared.uploadFiles = json.uploadFiles
//                        ProgressView.shared.hide()


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
