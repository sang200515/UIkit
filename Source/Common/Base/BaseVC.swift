//
//  BaseVC.swift
//  BaseVC
//
//  Created by Trần Văn Dũng on 23/09/2021.
//

import UIKit

class BaseVC <T : UIView > : BaseViewController {
    override func loadView() {
        let t = T()
        t.backgroundColor = .white
        self.view = t
    }
    var mainView : T {
        if let view = self.view as? T {
            return view
        }else {
            let view = T()
            self.view = view
            return view
        }
    }
    
}

