//
//  DetailImageVC.swift
//  IOSStoryborad
//
//  Created by Ngoc Bao on 06/12/2021.
//

import UIKit

class DetailImageVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    private let maximumZoomScale = 6.0
    private let minimumZoomScale = 1.0
    
    var detail: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.minimumZoomScale = CGFloat(minimumZoomScale)
        scrollView.maximumZoomScale = maximumZoomScale
        scrollView.delegate = self
        closeButton.setTitle("", for: .normal)
        imageDetail.image = detail
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown))
        gesture.direction = .down
        
        self.contentView.addGestureRecognizer(gesture)
        scrollView.isUserInteractionEnabled = true
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(onDoubleTap(touch:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    @objc func swipeDown() {
        close("")
    }
    
    @objc func onDoubleTap(touch: UITapGestureRecognizer) {
        if scrollView.zoomScale == maximumZoomScale {
            UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut) {
                self.scrollView.zoomScale = self.minimumZoomScale
            }
        } else {
            let touchPoint = touch.location(in: view)
            let scrollViewSize = scrollView.bounds.size
            
            let width = scrollViewSize.width / scrollView.maximumZoomScale
            let height = scrollViewSize.height / scrollView.maximumZoomScale
            let x = touchPoint.x - (width/2.0)
            let y = touchPoint.y - (height/2.0)
            
            let rect = CGRect(x: x, y: y, width: width, height: height)
            scrollView.zoom(to: rect, animated: true)
        }
    }
    
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageDetail
    }
    
}
