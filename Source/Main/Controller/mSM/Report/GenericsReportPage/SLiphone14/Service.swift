//
//  Service.swift
//  fptshop
//
//  Created by Sang Trương on 12/10/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation;
import Moya;
import SwiftyJSON;

extension mSMApiManager{
    private static func GetServerResponse4(target: mSMApiService, keyPath: String?, mappingObj: Jsonable.Type, handler: @escaping(_ success: Any, _ error: String) -> Void){

        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }

        let apiProvider = MoyaProvider<mSMApiService>(plugins: [VerbosePlugin(verbose: true)]);

        apiProvider.request(target, callbackQueue: .global(qos: .background)){ result in
            var response: Any!;

            switch result {
                case let .success(moyaResponse):
                    let data = moyaResponse.data;
                    let json = try? JSON(data: data);

                    if(json != nil){
                        var object: Any?;
                        if(keyPath == nil){
                            object = json!.to(type: mappingObj)
                        }
                        else{
                            object = json![keyPath!].to(type: mappingObj);
                        }

                        if let obj = object {
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                            response = obj;
                            handler(response as Any,"")
                        }
                        else{
                            DispatchQueue.main.async {
                                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            }
                            handler(response as Any, "Load API ERRO")
                        }
                    }
                    else{
                        handler(response as Any, "Load API ERRO")
                    }
                case let .failure(error):
                    DispatchQueue.main.async {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    handler(response as Any, error.localizedDescription)
            }
        }
    }
    public static func getSL_iphone14_Vung(username: String, token: String) -> Response<[SLIPHONE14]>{
        let returnedData = Response<[SLIPHONE14]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);

        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse4(target:.getSL_iphone14_Vung(username: username, token: token), keyPath: "FRT_MSM_ComboIPhone14Series_Realtime_Vung_View_FinalResult", mappingObj: SLIPHONE14.self) { (data, err) in
                let result = data as? [SLIPHONE14];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });

        dispatchGroup.wait();

        return returnedData;
    }

    public static func getSL_iphone14_khuvuc(username: String, token: String) -> Response<[SLIPHONE14]>{
        let returnedData = Response<[SLIPHONE14]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);

        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse4(target:.getSL_iphone14_khuvuc(username: username, token: token), keyPath: "FRT_MSM_ComboIPhone14Series_Realtime_ASM_View_FinalResult", mappingObj: SLIPHONE14.self) { (data, err) in
                let result = data as? [SLIPHONE14];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });

        dispatchGroup.wait();

        return returnedData;
    }

    public static func getSL_iphone14_Shop(username: String, token: String) -> Response<[SLIPHONE14]>{
        let returnedData = Response<[SLIPHONE14]>();
        let dispatchGroup = DispatchGroup();
        let dispatchQueue = DispatchQueue(label: "Report", qos: .background);

        dispatchGroup.enter();
        dispatchQueue.async(group: dispatchGroup, execute: {
            self.GetServerResponse4(target:.getSL_iphone14_Shop(username: username, token: token), keyPath: "FRT_MSM_ComboIPhone14Series_Realtime_Shop_View_FinalResult", mappingObj: SLIPHONE14.self) { (data, err) in
                let result = data as? [SLIPHONE14];
                returnedData.Data = result;
                returnedData.Error = err;
                dispatchGroup.leave();
            }
        });

        dispatchGroup.wait();

        return returnedData;
    }
}
