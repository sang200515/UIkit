//
//  PopUpPickColorView.swift
//  fptshop
//
//  Created by Ngo Dang tan on 9/3/20.
//  Copyright © 2020 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
protocol PopUpPickColorViewDelegate:AnyObject {
    func reloadbtCardIcon()
}
class PopUpPickColorView: UIViewController {
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.6
    }
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    weak var delegate:PopUpPickColorViewDelegate?
    private var myTargetView:UIView?
    private var myViewController:UIViewController?
    private var parameDetailImages:[ParameDetailImage]?
    private var tableView = UITableView()
    private var product:ProductBySku?
    private var mdmhSim:MDMHSim?
    private var isAccessories = false
    
    func showAlert(with title:String, on viewController: UIViewController,productView:ProductBySku,mdmhSimView:MDMHSim,isAccessoriesView:Bool){
        guard let targetView = viewController.view else{
            return
        }
        backgroundView.frame = targetView.bounds
        myTargetView = targetView
        myViewController = viewController
        self.product = productView
        self.mdmhSim = mdmhSimView
        self.isAccessories = isAccessoriesView
        
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        alertView.frame = CGRect(x: 40, y: -250, width: targetView.frame.size.width - 80, height: 250)
        
        let viewTitle = UIView(frame: CGRect(x: 0, y: 0, width: alertView.frame.size.width, height: 40))
        viewTitle.backgroundColor = UIColor(netHex:0x00955E)
        alertView.addSubview(viewTitle)
        
        
        let titleLabel = UILabel(frame: CGRect(x: 8, y: 10, width: alertView.frame.size.width, height: 20))
        titleLabel.text = title
        titleLabel.font = UIFont.boldFont(size: Common.Size(s: 15))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        viewTitle.addSubview(titleLabel)
        
        
        
        
        tableView = UITableView(frame: CGRect(x:10 , y: viewTitle.frame.size.height + viewTitle.frame.origin.y + 10, width: alertView.frame.size.width - 16, height: Common.Size(s:50) * 2 ))
        tableView.register(ColorVariantCell.self, forCellReuseIdentifier: "ColorVariantCell")
        tableView.dataSource = self
        tableView.delegate = self
        alertView.addSubview(tableView)
        
      
        
        
        let btComplete = UIButton()
        btComplete.frame = CGRect(x: alertView.frame.size.width/3.2, y: tableView.frame.origin.y + tableView.frame.size.height + Common.Size(s:20) , width: 120, height: 40 )
        btComplete.backgroundColor = UIColor(netHex:0xFF6600)
        btComplete.setTitle("Huỷ bỏ", for: .normal)
        btComplete.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        btComplete.layer.borderWidth = 0.5
        btComplete.layer.borderColor = UIColor.white.cgColor
        btComplete.layer.cornerRadius = 5.0
        alertView.addSubview(btComplete)
        
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        },completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    //self.alertView.center = targetView.center
                    self.alertView.frame.origin.y = targetView.frame.size.width/1.8
                })
            }
        })
        
        
    }
    
    @objc func dismissAlert(){
        guard let targetView = myTargetView else{return}
        UIView.animate(withDuration: 0.25, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 300)
        },completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                },completion: {done in
                    if done{
                        
                        self.alertView.removeFromSuperview()
                        self.backgroundView.removeFromSuperview()
                    }
                    
                } )
            }
        })
    }
  
}
extension PopUpPickColorView: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product!.variant.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ColorVariantCell = tableView.dequeueReusableCell(withIdentifier: "ColorVariantCell", for: indexPath) as! ColorVariantCell
        //let cell: PosmImageItemCell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "PosmImageItemCell") as! PosmImageItemCell
        let item = product!.variant[indexPath.row]
        cell.setUpCell(item: item)
      
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let item:Variant =  product!.variant[indexPath.row]
        if isAccessories {
            let sku = item.sku
            let colorProduct = item.colorValue
            let priceBeforeTax = item.priceBeforeTax
            let price = item.price
            let product = self.product!.product.copy() as! Product
            product.brandName = mdmhSim?.Brandname ?? ""
            product.labelName = mdmhSim?.p_sim ?? ""
            
            var check:Bool = false
            for item in Cache.carts {
                if (item.sku == sku){
                    item.quantity = item.quantity + 1
                    check = true
                }
            }
            if (check == false){
                let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
                Cache.carts.append(cart)
            }
            delegate?.reloadbtCardIcon()
        }else{
            
            
            
            let sku = item.sku
            let colorProduct = item.colorValue
            let priceBeforeTax = item.priceBeforeTax
            let price = item.price
            let product = self.product!.product.copy() as! Product
            
            product.sku = sku
            product.price = price
            product.priceBeforeTax = priceBeforeTax
            product.brandName = mdmhSim?.Brandname ?? ""
            product.labelName = mdmhSim?.p_sim ?? ""
            
            let cart = Cart(sku: sku, product: product,quantity: 1,color:colorProduct,inStock:-1, imei: "N/A",price: price, priceBT: priceBeforeTax, whsCode: "", discount: 0,reason:"",note:"", userapprove: "", listURLImg: [], Warr_imei: "", replacementAccessoriesLabel: "")
            Cache.carts.append(cart)
            Cache.itemsPromotion.removeAll()
            let newViewController = CartViewController()
            myViewController?.navigationController?.pushViewController(newViewController, animated: true)
        }
        

        
    }
    
    
    

 
    
}


class ColorVariantCell: UITableViewCell {
    
    var lbTitle:UILabel!
    var lbColor:UILabel!

    func setUpCell(item: Variant) {
        
        self.subviews.forEach({$0.removeFromSuperview()})
        
        
        let shadowView = UIView(frame: CGRect(x: Common.Size(s:10), y: Common.Size(s:10), width: Common.Size(s: 15), height: Common.Size(s: 15)))
        shadowView.layer.shadowColor = UIColor.red.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 5
        
        
        let view = UIView(frame: shadowView.bounds)
        view.backgroundColor = item.colorValue.hexColor
        view.layer.cornerRadius = 10.0
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = view.frame.size.width/2
        view.clipsToBounds = true
        shadowView.addSubview(view)
        
        
        self.addSubview(shadowView)
     
        

        
        lbTitle = UILabel(frame: CGRect(x:shadowView.frame.size.width + shadowView.frame.origin.x + Common.Size(s:10), y: Common.Size(s:8), width: self.frame.width, height: Common.Size(s: 20)))
        lbTitle.text = "\(item.colorName) - \(item.sku)"
        lbTitle.textAlignment = .left
        lbTitle.font = UIFont.boldSystemFont(ofSize: Common.Size(s:14))
        lbTitle.textColor = UIColor(netHex: 0xAAAAAA)
        
        self.addSubview(lbTitle)
        
        
        
    }
    
    
}
