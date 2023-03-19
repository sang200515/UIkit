//
//  FeeEx.swift
//  fptshop
//
//  Created by tan on 6/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class FeeEx: NSObject {
    var order_id:String
    var username:String
    var service_code:String
    
    var name:String
    var msisdn:String
    var id_number:String
    
    var province_code:String
    var district_code:String
    var precinct_code:String
    var address_detail:String
    
    
    var transfer_type:String
    var transfer_form:String
    var amount:String
    
    
    var channel_type:String
    var source:String
    var other_info:String
    var shop_name:String
    var shop_address:String
    var staff_id:String
    
    
    var error_code:String
    var trans_date:String
    var error_msg:String
    var cust_fee:String
    
    
    init(  order_id:String
    , username:String
    , service_code:String
    
    , name:String
    , msisdn:String
    , id_number:String
    
    , province_code:String
    , district_code:String
    , precinct_code:String
    , address_detail:String
    
    
    , transfer_type:String
    , transfer_form:String
    , amount:String
    
    
    , channel_type:String
    , source:String
    , other_info:String
    , shop_name:String
    , shop_address:String
    , staff_id:String
    
    
    , error_code:String
    , trans_date:String
    , error_msg:String
        ,cust_fee:String){
        
        self.order_id = order_id
        self.username = username
        self.service_code = service_code
        
        self.name = name
        self.msisdn = msisdn
        self.id_number = id_number
        
        self.province_code = province_code
        self.district_code = district_code
        self.precinct_code = precinct_code
        self.address_detail = address_detail
        
        
        self.transfer_type = transfer_type
        self.transfer_form = transfer_form
        self.amount = amount
        
        
        self.channel_type = channel_type
        self.source = source
        self.other_info = other_info
        self.shop_name = shop_name
        self.shop_address = shop_address
        self.staff_id = staff_id
        
        
        self.error_code = error_code
        self.trans_date = trans_date
        self.error_msg = error_msg
        self.cust_fee = cust_fee
        
    }
    
    class func parseObjfromArray(array:[JSON])->[FeeEx]{
        var list:[FeeEx] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> FeeEx{
        
        var order_id = data["order_id"].string
        var username = data["username"].string
        var service_code = data["service_code"].string
        
        var transfer_type = data["transfer_type"].string
        var transfer_form = data["transfer_form"].string
        var amount = data["amount"].string
        
        var error_code = data["error_code"].string
        var trans_date = data["trans_date"].string
        var error_msg = data["error_msg"].string
        var cust_fee = data["cust_fee"].string
        
        
        
        
        
        
        order_id = order_id == nil ? "" : order_id
        username = username == nil ? "" : username
        service_code = service_code == nil ? "" : service_code
        
        transfer_type = transfer_type == nil ? "" : transfer_type
        transfer_form = transfer_form == nil ? "" : transfer_form
        amount = amount == nil ? "" : amount
        
        error_code = error_code == nil ? "" : error_code
        trans_date = trans_date == nil ? "" : trans_date
        error_msg = error_msg == nil ? "" : error_msg
        cust_fee = cust_fee == nil ? "" : cust_fee
        
        return FeeEx(  order_id:order_id!
            , username:username!
            , service_code:service_code!
            
            , name: ""
            , msisdn: ""
            , id_number: ""
            
            , province_code:""
            , district_code:""
            , precinct_code:""
            , address_detail:""
            
            
            , transfer_type:transfer_type!
            , transfer_form:transfer_form!
            , amount:amount!
            
            
            , channel_type:""
            , source:""
            , other_info:""
            , shop_name:""
            , shop_address:""
            , staff_id:""
            
            
            , error_code:error_code!
            , trans_date:trans_date!
            , error_msg:error_msg!
            ,cust_fee:cust_fee!)
    }
    
    
}
