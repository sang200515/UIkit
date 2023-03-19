//
//  ShowImgDHMKViewController.swift
//  fptshop
//
//  Created by Apple on 8/26/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

class ShowImgDHMKViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var scrollViewHeight: CGFloat = 0
    var myImageView: UIImageView!
    var img:UIImage = #imageLiteral(resourceName: "AddImage")

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.7)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        scrollView.backgroundColor = UIColor.white
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
        
        myImageView = UIImageView(frame: CGRect(x: 20, y: 20, width: scrollView.frame.width - 40, height: 500))
//        myImageView.image = #imageLiteral(resourceName: "img1")
        myImageView.image = self.img
        myImageView.clipsToBounds = false
        scrollView.addSubview(myImageView)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self
        
        scrollViewHeight = myImageView.frame.origin.y + myImageView.frame.height
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return myImageView
    }
    
}
