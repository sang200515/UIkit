//
//  PlayBackCamera.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/2/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import SwiftyJSON
class PlayBackCamera:NSObject{
    
    var playbackPath:String
    var livePath:String
    var livesPath:String
    
    init(playbackPath:String, livePath:String,livesPath:String){
        self.playbackPath = playbackPath
        self.livePath = livePath
        self.livesPath = livesPath
    }
    
    class func parseObjfromArray(array:[JSON])->[PlayBackCamera]{
        var list:[PlayBackCamera] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PlayBackCamera{
        var playbackPath = data["playbackPath"].string
        var livePath = data["livePath"].string
        var livesPath = data["livesPath"].string
        
        playbackPath = playbackPath == nil ? "" : playbackPath
        livePath = livePath == nil ? "" : livePath
        livesPath = livesPath == nil ? "" : livesPath
        
        return PlayBackCamera(playbackPath:playbackPath!, livePath:livePath!,livesPath:livesPath!)
    }
    
    
}

