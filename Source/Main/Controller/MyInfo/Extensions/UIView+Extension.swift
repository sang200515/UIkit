//
//  UIView+Extension.swift
//  fptshop
//
//  Created by KhanhNguyen on 7/16/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.white.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func makeColor(color: UIColor? = nil) {
        if let value = color {
            self.backgroundColor = value
        }
    }
    
    func setBorder(color : UIColor? = nil, borderWidth : CGFloat? = 0, corner : CGFloat? = 0) {
        if let value = corner{
            self.makeCorner(corner: value)
        }
        if let value = borderWidth{
            self.layer.borderWidth = value
        }
        if let value = color{
            self.layer.borderColor = value.cgColor
        }
    }
    
    
    func makeCircle()  {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.bounds.width / 2.0
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    
    func makeCorner(corner : CGFloat) {
        self.layer.cornerRadius = corner
        self.layer.masksToBounds = true
    }
    
    @available(iOS 11.0, *)
    func drawTwoCornerBottom(cornerValue: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerValue
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    @available(iOS 11.0, *)
    func drawTwoCornerTop(cornerValue: CGFloat) {
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerValue
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
    func myCustomAnchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, centerX: NSLayoutXAxisAnchor? = nil, centerY: NSLayoutYAxisAnchor? = nil, width: NSLayoutDimension? = nil, height: NSLayoutDimension? = nil, topConstant: CGFloat = 0, leadingConstant: CGFloat = 0, trailingConstant: CGFloat = 0, bottomConstant: CGFloat = 0, centerXConstant: CGFloat = 0, centerYConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        var anchors = [NSLayoutConstraint]()
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let leading = leading {
            anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
        }
        
        if let trailing = trailing {
            anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let centerX = centerX {
            anchors.append(centerXAnchor.constraint(equalTo: centerX, constant: centerXConstant))
        }
        
        if let centerY = centerY {
            anchors.append(centerYAnchor.constraint(equalTo: centerY, constant: centerYConstant))
        }
        
        if let width = width {
            anchors.append(widthAnchor.constraint(equalTo: width, constant: widthConstant))
        } else if widthConstant != 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if let height = height {
            anchors.append(heightAnchor.constraint(equalTo: height, constant: heightConstant))
        } else if heightConstant != 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
    }
    
    func fill(left: CGFloat? = 0, top: CGFloat? = 0, right: CGFloat? = 0, bottom: CGFloat? = 0) {
        guard let superview = superview else {
            return print("\(self.description): there is no superview")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        if let left = left {
            self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
        }
        if let top = top {
            self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
        }
        if let right = right {
            self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: right).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
        }
    }
    
    func myAnchorWithUIEdgeInsets(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer"
    }
    
    fileprivate typealias Action = (() -> Void)?
    
    
    fileprivate var tapGestureRecognizerAction: Action? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? Action
            return tapGestureRecognizerActionInstance
        }
    }
    
    
    public func addTapGestureRecognizer(action: (() -> Void)?) {
        self.isUserInteractionEnabled = true
        self.tapGestureRecognizerAction = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc fileprivate func handleTapGesture(sender: UITapGestureRecognizer) {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
    
    func myCustomDropShadow(scale: Bool = false, shadowColor:CGColor = UIColor.black.cgColor,shadowOpacity: Float = 0.1, shadowOffset: CGSize = .zero, radius: CGFloat = 4) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = radius
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadowV2() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor(red: 227/255, green: 227/255, blue: 227/255, alpha: 0.5).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 3
        
        layer.shouldRasterize = true
        layer.rasterizationScale = true ? UIScreen.main.scale : 1
    }
    
    func rotate(degrees: CGFloat) {
        
        let degreesToRadians: (CGFloat) -> CGFloat = { (degrees: CGFloat) in
            return degrees / 180.0 * CGFloat.pi
        }
        self.transform =  CGAffineTransform(rotationAngle: degreesToRadians(degrees))
        
        // If you like to use layer you can uncomment the following line
        layer.transform = CATransform3DMakeRotation(degreesToRadians(degrees), 0.0, 0.0, 1.0)
    }
    
    func addDashedBorder() {
        let color = UIColor.black.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
}

extension NSLayoutConstraint {
    
    /// Returns the constraint sender with the passed priority.
    ///
    /// - Parameter priority: The priority to be set.
    /// - Returns: The sended constraint adjusted with the new priority.
    func usingPriority(_ priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}

extension UILayoutPriority {
    
    /// Creates a priority which is almost required, but not 100%.
    static var almostRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 999)
    }
    
    /// Creates a priority which is not required at all.
    static var notRequired: UILayoutPriority {
        return UILayoutPriority(rawValue: 0)
    }
}

class RectangularDashedView: UIView {
    
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radius
            layer.masksToBounds = radius > 0
        }
    }
    @IBInspectable var dashWidth: CGFloat = 0
    @IBInspectable var dashColor: UIColor = .clear
    @IBInspectable var dashLength: CGFloat = 0
    @IBInspectable var betweenDashesSpace: CGFloat = 0
    
    var dashBorder: CAShapeLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dashBorder?.removeFromSuperlayer()
        let dashBorder = CAShapeLayer()
        dashBorder.lineWidth = dashWidth
        dashBorder.strokeColor = dashColor.cgColor
        dashBorder.lineDashPattern = [dashLength, betweenDashesSpace] as [NSNumber]
        dashBorder.frame = bounds
        dashBorder.fillColor = nil
        if radius > 0 {
            dashBorder.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        } else {
            dashBorder.path = UIBezierPath(rect: bounds).cgPath
        }
        layer.addSublayer(dashBorder)
        self.dashBorder = dashBorder
    }
}
