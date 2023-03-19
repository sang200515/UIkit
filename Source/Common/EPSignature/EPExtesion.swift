//
//  EPExtesion.swift
//  fptshop
//
//  Created by Sang Truong on 11/5/21.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import Foundation

//MARK: - UIViewController Extensions

extension UIViewController {
    
        func alert(message: String, title: String = "", textBtn: String = "OK") {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: textBtn, style: .default, handler: nil)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        
    }
    func showAlert(_ message: String) {
        showAlert(message, andTitle: "")
    }
    
    func showAlert(_ message: String, andTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

	func showAlertWithColorTitle(colorTitle:UIColor,titleAlert: String, with message: String, titleButton: String, handleOk: (() -> Void)? = nil) {
		let attributedString = NSAttributedString(string: titleAlert, attributes: [
			NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18,weight: .bold),
			NSAttributedString.Key.foregroundColor : colorTitle
		])

		let alert = UIAlertController(title: "", message: message,  preferredStyle: .alert)

		alert.setValue(attributedString, forKey: "attributedTitle")

		alert.addAction(UIAlertAction(title: titleButton, style: .cancel, handler: { (action) in
			if let act = handleOk {
				act()
			}
		}))

		present(alert, animated: true, completion: nil)
	}
}

//MARK: - UIColor Extensions

extension UIColor {
    class func defaultTintColor() -> UIColor {
        return UIColor(red: (233/255), green: (159/255), blue: (94/255), alpha: 1.0)
    }
}
//

open class EPSignatureView: UIView {

    // MARK: - Private Vars
    
    fileprivate var bezierPoints = [CGPoint](repeating: CGPoint(), count: 5)
    fileprivate var bezierPath = UIBezierPath()
    fileprivate var bezierCounter : Int = 0
    
    // MARK: - Public Vars
    
    open var strokeColor = UIColor.black
    open var strokeWidth: CGFloat = 2.0 {
        didSet { bezierPath.lineWidth = strokeWidth }
    }
    open var isSigned: Bool = false
    
    // MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clear
        bezierPath.lineWidth = strokeWidth
        addLongPressGesture()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        bezierPath.lineWidth = strokeWidth
        addLongPressGesture()
    }
    
    override open func draw(_ rect: CGRect) {
        bezierPath.stroke()
        strokeColor.setStroke()
        bezierPath.stroke()

    }
    
    
    // MARK: - Touch Functions
    
    func addLongPressGesture() {
        //Long press gesture is used to keep clear dots in the canvas
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(EPSignatureView.longPressed(_:)))
        longPressGesture.minimumPressDuration = 1.5
        self.addGestureRecognizer(longPressGesture)
    }
    
    @objc func longPressed(_ gesture: UILongPressGestureRecognizer) {
        let touchPoint = gesture.location(in: self)
        let endAngle: CGFloat = .pi * 2.0
        bezierPath.move(to: touchPoint)
        bezierPath.addArc(withCenter: touchPoint, radius: 2, startAngle: 0, endAngle: endAngle, clockwise: true)
        setNeedsDisplay()
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if let currentPoint = touchPoint(touches) {
            isSigned = true
            bezierPoints[0] = currentPoint
            bezierCounter = 0
        }
    }
    
    override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let currentPoint = touchPoint(touches) {
            bezierCounter += 1
            bezierPoints[bezierCounter] = currentPoint

            //Smoothing is done by Bezier Equations where curves are calculated based on four concurrent  points drawn
            if bezierCounter == 4 {
                bezierPoints[3] = CGPoint(x: (bezierPoints[2].x + bezierPoints[4].x) / 2 , y: (bezierPoints[2].y + bezierPoints[4].y) / 2)
                bezierPath.move(to: bezierPoints[0])
                bezierPath.addCurve(to: bezierPoints[3], controlPoint1: bezierPoints[1], controlPoint2: bezierPoints[2])
                setNeedsDisplay()
                bezierPoints[0] = bezierPoints[3]
                bezierPoints[1] = bezierPoints[4]
                bezierCounter = 1
            }
        }
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        bezierCounter = 0
    }
    
    func touchPoint(_ touches: Set<UITouch>) -> CGPoint? {
        if let touch = touches.first {
            return touch.location(in: self)
        }
        return nil
    }
    
    //MARK: Utility Methods
    
    /** Clears the drawn paths in the canvas
    */
    open func clear() {
        isSigned = false
        bezierPath.removeAllPoints()
        setNeedsDisplay()
    }
    
    /** scales and repositions the path
     */
    open func reposition() {
        var ratio =  min(self.bounds.width / bezierPath.bounds.width, 1)
        ratio =  min((self.bounds.height - 64) / bezierPath.bounds.height, ratio)
        bezierPath.apply(CGAffineTransform(scaleX: ratio, y: ratio))
        setNeedsDisplay()
    }
    
    /** Returns the drawn path as Image. Adding subview to this view will also get returned in this image.
     */
    open func getSignatureAsImage() -> UIImage? {
        if isSigned {
            UIGraphicsBeginImageContext(CGSize(width: self.bounds.size.width, height: self.bounds.size.height))
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let signature: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return signature
        }
        return nil
    }
    
    /** Returns the rect of signature image drawn in the canvas. This can very very useful in croping out the unwanted empty areas in the signature image returned.
     */

    open func getSignatureBoundsInCanvas() -> CGRect {
        return bezierPath.bounds
    }
    
    //MARK: Save load signature methods
    
    open func saveSignature(_ localPath: String) {
        if isSigned {
            NSKeyedArchiver.archiveRootObject(bezierPath, toFile: localPath)
        }
    }

    open func loadSignature(_ filePath: String) {
        if let path = getPath(filePath) {
            isSigned = true
            bezierPath = path
            setNeedsDisplay()
        }
    }
    
    fileprivate func getPath(_ filePath: String) -> UIBezierPath? {
        if FileManager.default.fileExists(atPath: filePath) {
            return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UIBezierPath
        }
        return nil
    }
    
    func removeSignature() {
        let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
        do {
            try FileManager.default.removeItem(atPath: filePath)
        }
        catch let error {
            print(error)
        }
    }
    
}
//
//  EPSignatureViewController.swift
//  Pods
//
//  Created by Prabaharan Elangovan on 13/01/16.
//
//

import UIKit

    // MARK: - EPSignatureDelegate
@objc public protocol EPSignatureDelegate {
    @objc optional    func epSignature(_: EPSignatureViewController, didCancel error : NSError)
    @objc optional    func epSignature(_: EPSignatureViewController, didSign signatureImage : UIImage, boundingRect: CGRect)
}

open class EPSignatureViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var switchSaveSignature: UISwitch!
    @IBOutlet weak var lblSignatureSubtitle: UILabel!
    @IBOutlet weak var lblDefaultSignature: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewMargin: UIView!
    @IBOutlet weak var lblX: UILabel!
    @IBOutlet weak var signatureView: EPSignatureView!
    
    // MARK: - Public Vars
    
    open var showsDate: Bool = true
    open var showsSaveSignatureOption: Bool = true
    open weak var signatureDelegate: EPSignatureDelegate?
    open var subtitleText = "Sign Here"
    open var tintColor = UIColor.defaultTintColor()

    // MARK: - Life cycle methods
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(EPSignatureViewController.onTouchCancelButton))
        cancelButton.tintColor = tintColor
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(EPSignatureViewController.onTouchDoneButton))
        doneButton.tintColor = tintColor
        let clearButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(EPSignatureViewController.onTouchClearButton))
        clearButton.tintColor = tintColor
        
        if showsDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle  = DateFormatter.Style.short
            dateFormatter.timeStyle  = DateFormatter.Style.none
            lblDate.text = dateFormatter.string(from: Date())
        } else {
            lblDate.isHidden = true
        }
        
        if showsSaveSignatureOption {
            let actionButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target:   self, action: #selector(EPSignatureViewController.onTouchActionButton(_:)))
            actionButton.tintColor = tintColor
            self.navigationItem.rightBarButtonItems = [doneButton, clearButton, actionButton]
            switchSaveSignature.onTintColor = tintColor
        } else {
            self.navigationItem.rightBarButtonItems = [doneButton, clearButton]
            lblDefaultSignature.isHidden = true
            switchSaveSignature.isHidden = true
        }
        
        lblSignatureSubtitle.text = subtitleText
        switchSaveSignature.setOn(false, animated: true)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Initializers
    
    public convenience init(signatureDelegate: EPSignatureDelegate) {
        self.init(signatureDelegate: signatureDelegate, showsDate: true, showsSaveSignatureOption: true)
    }
    
    public convenience init(signatureDelegate: EPSignatureDelegate, showsDate: Bool) {
        self.init(signatureDelegate: signatureDelegate, showsDate: showsDate, showsSaveSignatureOption: true)
    }
    
    public init(signatureDelegate: EPSignatureDelegate, showsDate: Bool, showsSaveSignatureOption: Bool ) {
        self.showsDate = showsDate
        self.showsSaveSignatureOption = showsSaveSignatureOption
        self.signatureDelegate = signatureDelegate
        let bundle = Bundle(for: EPSignatureViewController.self)
        super.init(nibName: "EPSignatureViewController", bundle: bundle)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Button Actions
    
    @objc func onTouchCancelButton() {
        signatureDelegate?.epSignature!(self, didCancel: NSError(domain: "EPSignatureDomain", code: 1, userInfo: [NSLocalizedDescriptionKey:"User not signed"]))
        dismiss(animated: true, completion: nil)
    }

    @objc func onTouchDoneButton() {
        if let signature = signatureView.getSignatureAsImage() {
            if switchSaveSignature.isOn {
                let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
                let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
                signatureView.saveSignature(filePath)
            }
            signatureDelegate?.epSignature!(self, didSign: signature, boundingRect: signatureView.getSignatureBoundsInCanvas())
            if ThuHoSOMOrderSummaryViewController.isCheckCanPopViewSign == true {
                    //view thu hộ đang present nên phải set chổ này
            }else {
                dismiss(animated: true, completion: nil)
            }
        } else {
            showAlert("You did not sign", andTitle: "Please draw your signature")
        }
    }
    
    @objc func onTouchActionButton(_ barButton: UIBarButtonItem) {
        let action = UIAlertController(title: "Action", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        action.view.tintColor = tintColor
        
        action.addAction(UIAlertAction(title: "Load default signature", style: UIAlertAction.Style.default, handler: { action in
            let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let filePath = (docPath! as NSString).appendingPathComponent("sig.data")
            self.signatureView.loadSignature(filePath)
        }))
        
        action.addAction(UIAlertAction(title: "Delete default signature", style: UIAlertAction.Style.destructive, handler: { action in
            self.signatureView.removeSignature()
        }))
        
        action.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        
        if let popOver = action.popoverPresentationController {
            popOver.barButtonItem = barButton
        }
        present(action, animated: true, completion: nil)
    }

    @objc func onTouchClearButton() {
        signatureView.clear()
    }
    
    override open func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        signatureView.reposition()
    }
}
