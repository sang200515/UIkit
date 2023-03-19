//
//  MenuItemViewModel.swift
//  fptshop
//
//  Created by Ngo Dang tan on 08/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
struct MenuItemViewModel {
    // MARK: - Properties
    let item: ItemApp
    var icon: UIImage {
        return item.icon
    }
    var label: String {
        return item.name
    }
    
    // MARK: - Lifecycle
    init(item: ItemApp){
        self.item = item
    }
}
