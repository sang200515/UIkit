//
//  CalendarView.swift
//  MultichooseCell
//
//  Created by Apple on 8/4/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FSCalendar

protocol CalendarViewControllerDelegate: AnyObject {
    func getDate(dateString: String)
}

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    //    @IBOutlet weak var calendarView: FSCalendar!
    
    var calendarView: FSCalendar!
    weak var delegate: CalendarViewControllerDelegate?
    
    //Setting up view to portrait when view disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        if (self.isMovingFromParent) {
            UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
        }
        self.view.subviews.forEach({$0.removeFromSuperview()});
    }
    
    @objc func canRotate() -> Void{}
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent;
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .allButUpsideDown;
    }
    override var shouldAutorotate: Bool{
        return true;
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            
            switch orient {
            case .portrait:
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                //                self.SetUpCollectionView();
                self.viewDidLoad()
            case .landscapeLeft,.landscapeRight :
                self.view.subviews.forEach({ $0.removeFromSuperview() });
                self.viewDidLoad()
            default:
                print("Upside down, and that is not supported");
            }
            
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in})
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.6)
//        self.view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        // In loadView or viewDidLoad
        calendarView = FSCalendar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.backgroundColor = UIColor.white
        calendarView.center = self.view.center
        view.addSubview(calendarView)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: date)
        debugPrint("strDate :\(strDate)")
        
        self.dismiss(animated: true) {
            self.delegate?.getDate(dateString: strDate)
        }
    }
    
}
