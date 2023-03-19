//
//  MoMoViewModel.swift
//  fptshop
//
//  Created by Ngo Dang tan on 27/01/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation

enum MoMoInputOptions{
    case all
    case scan(String)
    
    var message: String {
        switch self {
        case .all: return ""
        case .scan(let message): return message

        }
    }
    

}

enum MoMoActionConfiguration{
    case create
    case recheck
}

struct MoMoViewModel {
    
    let actionButtonTitle: String


    init(configAction: MoMoActionConfiguration){
        switch configAction{
        case .create:
            actionButtonTitle = "Thanh Toán"
      
        case .recheck:
            actionButtonTitle = "Kiểm tra trạng thái giao dịch"
    
        }
     
    }
}
