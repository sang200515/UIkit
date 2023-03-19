//
//  CustomAnnocation.swift
//  NewmDelivery
//
//  Created by sumi on 5/14/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnocation: NSObject , MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage!
    
    init(title: String , subtitle: String , coordinate: CLLocationCoordinate2D ,image: UIImage) {
        self.title = title;
        self.subtitle = subtitle;
        self.coordinate = coordinate;
        self.image = image
        
        super.init()
    }
}
