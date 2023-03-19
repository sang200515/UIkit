//
//  ProductAPIManager.swift
//  fptshop
//
//  Created by Ngo Dang tan on 8/29/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire
public class ProductAPIManager{
    
    class func searchProduct(keyword:String,inventory:Int = 0,handler: @escaping (_ success:[Product],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Product] = []
        let parameters = [
            "keyword" : keyword,
            "shopcode": Cache.user?.ShopCode ?? "",
            "inventory":inventory
         
        ] as [String : Any]
        provider.request(.searchProduct(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let list = json?["data"].array {
                    rs = Product.parseObjfromArray(array: list)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Lỗi load api search prduct ! ")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func product_detais_by_model_id(model_id:String,sku:String,handler: @escaping (_ results:[ProductBySku],_ error:String) ->Void){
           UIApplication.shared.isNetworkActivityIndicatorVisible = true
           let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
 
        let parameters = [
            "sku" : sku,
            "shopcode": Cache.user?.ShopCode ?? ""
            
        ]
        
           var rs = [ProductBySku]()
        provider.request(.product_detais_by_model_id(model_id: model_id,params:parameters)){ result in
               switch result {
               case let .success(moyaResponse):
                   let data = moyaResponse.data
                   let json = try? JSON(data: data)
                   print("DEBUG: \(json as Any)")
                   if let success = json?["success"].bool {
                       if(success){
                           if let data = json?["data"].array {
                               rs = ProductBySku.parseObjfromArray(array: data)
                               UIApplication.shared.isNetworkActivityIndicatorVisible = false
                               handler(rs,"")
                           }else{
                               UIApplication.shared.isNetworkActivityIndicatorVisible = false
                               handler(rs,"Load API ERRO")
                           }
                           
                       }else{
                           UIApplication.shared.isNetworkActivityIndicatorVisible = false
                           handler(rs,"Load API ERRO")
                       }
                   }else{
                       let message = json?["messages"].stringValue
                       UIApplication.shared.isNetworkActivityIndicatorVisible = false
                       handler(rs,message ?? "Load API ERROR")
                   }
               case let .failure(error):
                   UIApplication.shared.isNetworkActivityIndicatorVisible = false
                   handler(rs, error.localizedDescription)
                   
               }
           }
       }
    class func product_detais_by_sku(sku:String,handler: @escaping (_ results:[ProductBySku],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters = [
            
            "shopcode": Cache.user?.ShopCode ?? ""
            
        ]
        
        
        var rs = [ProductBySku]()
        provider.request(.product_details_by_sku(sku: sku,params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let success = json?["success"].bool {
                    if(success){
                        if let data = json?["data"].array {
                            rs = ProductBySku.parseObjfromArray(array: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERRO")
                    }
                }else{
                    var message = json?["messages"].stringValue
                    let detail = json?["details"].stringValue
                    if detail != "" && message != ""{
                        message = "\(message ?? ""), \(detail ?? "")"
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,message ?? "Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
                
            }
        }
    }
    
    class func product_filter(u_ng_code:String,item_group_code:String,sort_point:String,price:Any,firm_code:String,pagination:Any,inventory:String = "0",handler: @escaping (_ results:[Product],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Product] = []
        let parameters: [String: Any] = [
            "u_ng_code":"\(u_ng_code)",
            "item_group_code":"\(item_group_code)",
            "sort_point":"\(sort_point)",
            "price":price,
            "firm_code":"\(firm_code)",
            "pagination":pagination,
            "shopcode": Cache.user?.ShopCode ?? "",
            "inventory": inventory
        ]
        print(parameters)
        
        provider.request(.product_filter(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["success"].bool {
                    if(success){
                        if let list = json?["data"].array {
                            rs = Product.parseObjfromArray(array: list)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERROR")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERROR")
                    }
                }else{
                    let message = json?["messages"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,message ?? "Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
                
            }
        }
    }
    class func get_parameter_filter(u_ng_code:String,handler: @escaping (_ results:FilterNew?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: String] = [
            "u_ng_code":"\(u_ng_code)",
            "shopcode": Cache.user?.ShopCode ?? ""
        ]
        
        
        provider.request(.get_parameter_filter(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["success"].bool {
                    if(success){
                        let data = json!["data"]
                        if(!data.isEmpty){
                            let rs = FilterNew.getObjFromDictionary(data: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let messages = json!["messages"].string
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(nil,messages ?? "Không tìm thấy sản phẩm")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    let message = json?["messages"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,message ?? "Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
                
            }
        }
    }
    class func get_list_nganh_hang(handler: @escaping (_ results:[NghanhHang],_ error:String) ->Void){
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
         let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
     
         let parameters: [String: String] = [
             :
         ]
    
         var rs = [NghanhHang]()
         provider.request(.get_list_nganh_hang(params: parameters)){ result in
             switch result {
             case let .success(moyaResponse):
                 let data = moyaResponse.data
                 let json = try? JSON(data: data)
                 print(json as Any)
                 if let success = json?["success"].bool {
                     if(success){
                         if let data = json?["data"].array {
                             rs = NghanhHang.parseObjfromArray(array: data)
                             UIApplication.shared.isNetworkActivityIndicatorVisible = false
                             handler(rs,"")
                         }else{
                             UIApplication.shared.isNetworkActivityIndicatorVisible = false
                             handler(rs,"Load API ERRO")
                         }
                         
                     }else{
                         let messages = json!["messages"].string
                         UIApplication.shared.isNetworkActivityIndicatorVisible = false
                         handler(rs,messages ?? "Load API ERROR")
                     }
                 }else{
              
                     UIApplication.shared.isNetworkActivityIndicatorVisible = false
                     handler(rs,"Load API ERROR")
                 }
             case let .failure(error):
                 UIApplication.shared.isNetworkActivityIndicatorVisible = false
                 handler(rs, error.localizedDescription)
                 
             }
         }
     }
    class func mpos_FRT_SP_innovation_MDMH_Sim(itemcode:String,handler: @escaping (_ results:[MDMHSim],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[MDMHSim] = []
        let parameters: [String: String] = [
            "userid":"\(Cache.user?.UserName ?? "")",
            "shopcode":"\(Cache.user?.ShopCode ?? "")",
            "itemcode":"\(itemcode)"
        ]
        print(parameters)
        
        provider.request(.mpos_FRT_SP_innovation_MDMH_Sim(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["Success"].bool {
                    if(success){
                        if let list = json?["Data"].array {
                            print(json?["Data"].array)
                            rs = MDMHSim.parseObjfromArray(array: list)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"Load API ERROR")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(rs,"Load API ERROR")
                    }
                }else{
                    let message = json?["messages"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,message ?? "Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs, error.localizedDescription)
                
            }
        }
    }
    class func get_promotions_detais(sku:String,handler: @escaping (_ results:String,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "sku":sku,
            "shopcode":Cache.user?.ShopCode ?? ""
        ]
        
        provider.request(.get_promotions_detais(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                
                if let success = json?["success"].bool {
                    if(success){
                        if let data = json?["data"].string {
                            
                            handler(data,"")
                        }else{
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler("","Load API ERRO")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler("","Load API ERRO")
                    }
                }else{
                    let message = json?["messages"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler("",message ?? "Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler("", error.localizedDescription)
                
            }
        }
    }
    //bao hanh
    class func get_listSpBH_detais(sku:String,handler: @escaping (_ results:[GoiBHModel],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[GoiBHModel] = []
        let parameters: [String: String] = [
            "itemCode":"\(sku)"
        ]
        print(parameters)
        provider.request(.get_list_SP_BH_detais(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)

                if let list = json?.array?.first, let data = list["get_List_Warranties"].array {
                    rs = GoiBHModel.parseObjfromArray(array: data)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Load API ERROR")
                }
            
    
                        case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
           
            }
        }
    }
    //tracoc
    class func CustomerTraCocAPI(phone: String,numEcom:String, typereturnSO: String, handler: @escaping (_ results:[CustomerTraCoc],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
   
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        let parameters: [String: String] = [
            "phone": "\(phone)",
            "shopcode": "\(Cache.user!.ShopCode)",
            "numEcom": "\(numEcom)",
            "typereturnSO": "\(typereturnSO)"
        ]
        print(parameters)
        var results:[CustomerTraCoc] = []
        provider.request(.CustomerTraCoc(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let data = json?[0]["data"].array {
                    for item in data{
                        let dictionary = item.rawValue as? [String:AnyObject]
                        let result = CustomerTraCoc(dictionary: dictionary ?? [:])
                        results.append(result)
                    }
                    handler(results,"")
                }else{
                    handler([],"LOAD API ERROR!")
                    
                }
   
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler([], error.localizedDescription)
            }
        }
    }
    class func DetailTraCocAPI(numSO: String, handler: @escaping (_ result:TraCoc?,_ error:String) ->Void){
         UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
         let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
         let parameters: [String: String] = [
             "numSO": "\(numSO)"
         ]
        print(parameters)
        var tracoc = TraCoc(headers: [], details: [])
        var lstHeaders:[HeaderDetailTraCoc] = []
        var lstDetails:[DetailTraCoc] = []
       
        provider.request(.DetailTraCoc(params:parameters)){ result in
            switch result {
             case let .success(moyaResponse):
                 let data = moyaResponse.data
                 let json = try? JSON(data: data)
                 print(json as Any)
                if json?.arrayValue.count ?? 0 > 0 {
                    if let messages = json?.arrayValue[0]["messages"].array {
                       let codeResult = messages[0]["result"].string
                       let message = messages[0]["message"].string
                       if codeResult == "200"{
                           if let headers = json?.arrayValue[0]["header"].array {
                               for item in headers{
                                   let dictionary = item.rawValue as? [String:AnyObject]
                                   let result = HeaderDetailTraCoc(dictionary: dictionary ?? [:])
                                   lstHeaders.append(result)
                               }
                               tracoc.headers = lstHeaders
                               if let details = json?.arrayValue[0]["detail"].array {
                                   for item in details{
                                       let dictionary = item.rawValue as? [String:AnyObject]
                                       let result = DetailTraCoc(dictionary: dictionary ?? [:])
                                       lstDetails.append(result)
                                   }
                                   tracoc.details = lstDetails
                                   handler(tracoc,"")
                               }else{
                                   handler(nil,"LOAD API ERROR!")
                               }
                               
                           }else{
                               handler(nil,"LOAD API ERROR!")
                               
                           }
                       }else{
                           handler(nil,message ?? "LOAD API ERROR!")
                       }
                       
                 
                    }else{
                       handler(nil,"LOAD API ERROR!")
                    }
                }else{
                    handler(nil,"LOAD API ERROR!")
                }
            
             
    
             case let .failure(error):
                 UIApplication.shared.isNetworkActivityIndicatorVisible = false
                 handler(nil, error.localizedDescription)
             }
         }
     }
    class func get_stock(itemCode:String,handler: @escaping (_ tonKho:Int,_ error:String) ->Void){
          UIApplication.shared.isNetworkActivityIndicatorVisible = true
          let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
          let parameters: [String: String] = [
              "shopcode": Cache.user?.ShopCode ?? "",
              "itemCodes": itemCode
          ]
          provider.request(.get_stock(params: parameters)){ result in
              switch result {
              case let .success(moyaResponse):
                  let data = moyaResponse.data
                  let json = try? JSON(data: data)
                  print("DEBUG: \(json as Any)")
                  var sl = 0
                  if let data = json?.array {
                      for item in data{
                  
                          let whsCode = item["whsCode"].string
                          let code_whs = String(whsCode?.suffix(3) ?? "")
                          print(code_whs)
                          if code_whs == "010" {
                              UIApplication.shared.isNetworkActivityIndicatorVisible = false
                              sl = item["qtyAvailable"].int ?? 0
                              break
                          }
                      }
                      handler(sl,"")
   
                  }else{
                      UIApplication.shared.isNetworkActivityIndicatorVisible = false
                      handler(0,"Load API ERRO")
                  }
                  
              case let .failure(error):
                  UIApplication.shared.isNetworkActivityIndicatorVisible = false
                  handler(0,error.localizedDescription)
              }
          }
      }
    

    class func searchProductPOSTAPI(keyword:String,item_group_code:String,pagination:Any,inventory:Int = 0,u_ng_code:String = "",firm_code:String = "",sort_point:Int = 0,price:Any = [
        "from": 0,
        "to": 0
      ],handler: @escaping (_ success:[Product],_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        var rs:[Product] = []
        let parameters = [
            "keyword" : keyword,
            "item_group_code":item_group_code,
            "pagination":pagination,
            "inventory":inventory,
            "shopcode": Cache.user?.ShopCode ?? "",
            "u_ng_code": u_ng_code,
            "firm_code": firm_code,
            "sort_point":sort_point,
            "price":price
            
         
        ]

        print("DEBUG: \(parameters)")
        provider.request(.searchProductPOST(params:parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let list = json?["data"].array {
                    rs = Product.parseObjfromArray(array: list)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"")
                }else{
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(rs,"Lỗi load api search prduct ! ")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(rs,error.localizedDescription)
            }
        }
    }
    class func get_parameter_after_search(keyword:String,inventory:Int,handler: @escaping (_ results:FilterNew?,_ error:String) ->Void){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let provider = MoyaProvider<ProductAPIService>(plugins: [NetworkLoggerPlugin()])
        
        let parameters: [String: Any] = [
            "keyword": keyword,
            "shopcode": "\(Cache.user?.ShopCode ?? "")",
            "inventory": inventory
        ]
        
        
        provider.request(.get_parameter_after_search(params: parameters)){ result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let json = try? JSON(data: data)
                print(json as Any)
                if let success = json?["success"].bool {
                    if(success){
                        let data = json!["data"]
                        if(!data.isEmpty){
                            let rs = FilterNew.getObjFromDictionary(data: data)
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(rs,"")
                        }else{
                            let messages = json!["messages"].string
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            handler(nil,messages ?? "Không tìm thấy sản phẩm")
                        }
                        
                    }else{
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        handler(nil,"Load API ERRO")
                    }
                }else{
                    let message = json?["messages"].stringValue
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    handler(nil,message ?? "Load API ERROR")
                }
            case let .failure(error):
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                handler(nil, error.localizedDescription)
                
            }
        }
    }
}

