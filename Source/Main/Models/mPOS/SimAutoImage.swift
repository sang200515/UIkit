//
//  SimAutoImage.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 11/6/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class SimAutoImage: NSObject {
    var LinkHinh: String
    var ResultImage: String
    
    init(LinkHinh: String,ResultImage: String) {
        self.LinkHinh = LinkHinh
        self.ResultImage = ResultImage
    }
    class func parseObjfromArray(array:[JSON])->[SimAutoImage]{
        var list:[SimAutoImage] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> SimAutoImage{
        
        var linkHinh = data["LinkHinh"].string
        var resultImage = data["ResultImage"].string
        
        linkHinh = linkHinh == nil ? "" : linkHinh
        resultImage = resultImage == nil ? "" : resultImage
        
        return SimAutoImage(LinkHinh: linkHinh!,ResultImage: resultImage!)
    }
}

