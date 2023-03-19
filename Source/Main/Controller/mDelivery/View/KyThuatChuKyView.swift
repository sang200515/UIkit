//
//  KyThuatChuKyView.swift
//  NewmDelivery
//
//  Created by sumi on 8/30/18.
//  Copyright © 2018 sumi. All rights reserved.
//

import UIKit

class KyThuatChuKyView: UIView {

    
    fileprivate let backgroudView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var mViewImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    var mImageSign: UIImageView = {
        let xImage = UIImageView()
        xImage.translatesAutoresizingMaskIntoConstraints = false
        //xImage.image = UIImage(named:"Add Image-51")
        xImage.contentMode = .center
        return xImage
    }()
    
    
    
    var mViewLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let lbTextAccept: UILabel = {
        let lb = UILabel()
        lb.text = "Tôi đã kiểm tra và nhận đầy đủ hàng hóa phụ kiện đi kèm"
        lb.textAlignment = .left
        lb.font = UIFont.systemFont(ofSize: Common.Size(s:11))
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.tintColor = .white
        lb.textColor = UIColor.black
        return lb
    }()
    
    let myButtonDone:UIButton =
    {
        let xButton = UIButton()
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.backgroundColor = UIColor(netHex:0x0055A4)
        xButton.layer.cornerRadius = 10
        xButton.setTitle("Hoàn tất",for: .normal)
        return xButton
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(backgroudView)
        backgroudView.addSubview(mViewImage)
        mViewImage.addSubview(mImageSign)
        backgroudView.addSubview(mViewLine)
        backgroudView.addSubview(lbTextAccept)
        backgroudView.addSubview(myButtonDone)
     
        
        backgroudView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroudView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        backgroudView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        backgroudView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        
       
        
        mViewImage.topAnchor.constraint(equalTo: self.backgroudView.topAnchor).isActive = true
        mViewImage.centerXAnchor.constraint(equalTo: self.backgroudView.centerXAnchor).isActive = true
        mViewImage.widthAnchor.constraint(equalTo: backgroudView.widthAnchor).isActive = true
        mViewImage.heightAnchor.constraint(equalTo: backgroudView.heightAnchor, multiplier: 0.5).isActive = true
        
        
        mImageSign.centerYAnchor.constraint(equalTo: self.mViewImage.centerYAnchor).isActive = true
        mImageSign.centerXAnchor.constraint(equalTo: self.mViewImage.centerXAnchor).isActive = true
        mImageSign.widthAnchor.constraint(equalTo: mViewImage.widthAnchor, multiplier: 0.9).isActive = true
        mImageSign.heightAnchor.constraint(equalTo: mViewImage.heightAnchor, multiplier: 0.8).isActive = true
        
        
        mViewLine.topAnchor.constraint(equalTo: self.mViewImage.bottomAnchor, constant: 10).isActive = true
        mViewLine.leftAnchor.constraint(equalTo: self.backgroudView.leftAnchor , constant: Common.Size(s: 10)).isActive = true
        mViewLine.widthAnchor.constraint(equalTo: backgroudView.widthAnchor, constant: backgroudView.frame.size.width - Common.Size(s: 20)).isActive = true
        mViewLine.heightAnchor.constraint(equalToConstant: Common.Size(s: 1)).isActive = true
        
        
        lbTextAccept.topAnchor.constraint(equalTo: self.mViewLine.bottomAnchor, constant: 5).isActive = true
        lbTextAccept.leftAnchor.constraint(equalTo: self.mViewLine.leftAnchor).isActive = true
        lbTextAccept.widthAnchor.constraint(equalTo: backgroudView.widthAnchor).isActive = true
        lbTextAccept.heightAnchor.constraint(equalToConstant: Common.Size(s: 30)).isActive = true
        
        
        myButtonDone.topAnchor.constraint(equalTo: lbTextAccept.bottomAnchor, constant: 20).isActive = true
        myButtonDone.centerXAnchor.constraint(equalTo: backgroudView.centerXAnchor).isActive = true
        myButtonDone.widthAnchor.constraint(equalTo: backgroudView.widthAnchor, multiplier: 0.8).isActive = true
        myButtonDone.heightAnchor.constraint(equalToConstant: Common.Size(s: 34)).isActive = true
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}
