//
//  DetailFilterViewController.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 12/28/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import PopupDialog
import DLRadioButton
protocol HandleFilter: AnyObject {
    func pushViewFilter(_ sort: String,_ sortPriceFrom: Float,_ sortPriceTo: Float,_ sortGroupName:String, _ sortManafacture:String, _ u_ng_code:String,_ inventory:String)
}
class DetailFilterViewController: UIViewController,UITextFieldDelegate {
    // MARK: - Properties
    var scrollView:UIScrollView!
    var item: ItemApp?
    
    var sort = "0"
    var sortPriceFrom:Float = 0
    var sortPriceTo:Float = 0
    var sortGroupName = ""
    var sortManafacture = ""
    var inventory = "0"
 
    var listRadio1: [DLRadioButton] = []
    var listRadio2: [DLRadioButton] = []
    var listRadio3: [DLRadioButton] = []
 
    private var listRadioInventory:[DLRadioButton] = []
    var listChoose:[Int] = []
    var viewFilter:UIView!
    var filterNew:FilterNew?
    private var radioPayFrom:DLRadioButton!
    private var viewFromToPrice:UIView!
    private var tfFrom:UITextField!
    private var tfTo:UITextField!
    weak var handleFilterDelegate: HandleFilter?
    private var listFilterHang: [ValueFilter]? {
        didSet {
            collectionViewHang.reloadData()
        }
    }
    var selectedIndexPath: IndexPath?
    private var collectionViewHang : UICollectionView = {
         
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = UICollectionView.ScrollDirection.vertical
         layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
         layout.itemSize = CGSize(width:  UIScreen.main.bounds.width / 2 - 5, height: Common.Size(s:30))
         layout.minimumInteritemSpacing = 0
         layout.minimumLineSpacing = 0
       
         
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.backgroundColor = UIColor(netHex: 0xEEEEEE)
         collectionView.isScrollEnabled = true
         return collectionView
     }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "\(item!.name)"
        self.initNavigationBar()
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        self.view.backgroundColor = UIColor(netHex: 0xEEEEEE)
        scrollView = UIScrollView(frame: CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height - ((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)))
        scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: scrollView.frame.size.height)
        scrollView.backgroundColor = UIColor(netHex: 0xEEEEEE)
        self.view.addSubview(scrollView)

        viewFilter = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        
        let btFilterIcon = UIButton.init(type: .custom)
        btFilterIcon.setImage(#imageLiteral(resourceName: "Filter"), for: UIControl.State.normal)
        btFilterIcon.imageView?.contentMode = .scaleAspectFit
        btFilterIcon.addTarget(self, action: #selector(actionFilter), for: UIControl.Event.touchUpInside)
        btFilterIcon.frame = CGRect(x: 5, y: 0, width: 30, height: 50)
        viewFilter.addSubview(btFilterIcon)
        //---

        WaitingNetworkResponseAlert.PresentWaitingAlert(parentVC: self) {
            ProductAPIManager.get_parameter_filter(u_ng_code:"\(self.item?.type ?? "")",handler: { (result, err) in
                WaitingNetworkResponseAlert.DismissWaitingAlert {
                    if err.count <= 0 {
                        
                        self.filterNew = result
                        if let filter = self.filterNew {
                            self.initPhone(results:filter)
                        }
                        
                    } else {
                        let popup = PopupDialog(title: "THÔNG BÁO", message: err, buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                            print("Completed")
                        }
                        let buttonOne = CancelButton(title: "OK") {
                            _ = self.navigationController?.popViewController(animated: true)
                            self.dismiss(animated: true, completion: nil)
                        }
                        popup.addButtons([buttonOne])
                        self.present(popup, animated: true, completion: nil)
                    }
                }
            })
            
        }
    }
    @objc func actionFilter() {
        if radioPayFrom.isSelected == true {
         
            
            guard var fromMoney = tfFrom.text else {return}
            fromMoney = fromMoney.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            fromMoney = fromMoney.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            
            
            guard var toMoney = tfTo.text else {return}
            toMoney = toMoney.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
            toMoney = toMoney.replacingOccurrences(of: ",", with: "", options: .literal, range: nil)
            
            
            sortPriceFrom = Float("\(fromMoney)") ?? 0
            sortPriceTo = Float("\(toMoney)") ?? 0
           
        }
      
        let firms:[ValueFilter] = listFilterHang?.filter({$0.isSelectFilter}) ?? []
        let firmCodes = firms.map({
            $0.value
        })
        sortManafacture = firmCodes.joined(separator: ",")
        handleFilterDelegate?.pushViewFilter(sort,sortPriceFrom,sortPriceTo,sortGroupName,sortManafacture,item?.type ?? "",inventory)
        self.navigationController?.popViewController(animated: false)
    }
    
    func initPhone(results:FilterNew){
        self.navigationItem.rightBarButtonItems  = [UIBarButtonItem(customView: viewFilter)]
        
        self.listRadio1 = []
        self.listRadio2 = []
        self.listRadio3 = []
       
        self.listChoose = []
        
        self.scrollView.subviews.forEach { $0.removeFromSuperview() }
        
        let lbInfoName = UILabel(frame: CGRect(x: 0, y: 0, width: self.scrollView.frame.size.width, height: Common.Size(s:30)))
        lbInfoName.textAlignment = .left
        lbInfoName.textColor = UIColor.white
        lbInfoName.backgroundColor = UIColor(netHex:0x00955E)
        lbInfoName.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
        lbInfoName.text = " \(results.sort.name)"
        self.scrollView.addSubview(lbInfoName)
        
        var indexType  = lbInfoName.frame.size.height + lbInfoName.frame.origin.y + Common.Size(s:5)
        for item in results.sort.valueFilters {
            let radioPayNow = createRadioButtonPayBonus(CGRect(x: Common.Size(s:5),y: indexType , width: self.scrollView.frame.size.width - Common.Size(s:10), height: lbInfoName.frame.size.height), title: "\(item.label)", color: UIColor.black);
        
            print("AAA \(item.value)")
            indexType = radioPayNow.frame.size.height + radioPayNow.frame.origin.y + Common.Size(s:5)
            self.scrollView.addSubview(radioPayNow)
            listRadio1.append(radioPayNow)
        }
        var lbInfoName1:UILabel!
        var indexType1:CGFloat  = indexType + lbInfoName.frame.size.height
        lbInfoName1 = UILabel(frame: CGRect(x: 0, y: indexType , width: self.scrollView.frame.size.width, height: Common.Size(s:30)))
        viewFromToPrice = UIView(frame: CGRect(x: 0, y:indexType1 + lbInfoName1.frame.size.height, width: self.view.frame.size.width, height: 0))
        viewFromToPrice.clipsToBounds = true
        scrollView.addSubview(viewFromToPrice)
        radioPayFrom = createRadioButtonTypePriceFromTo(CGRect(x: Common.Size(s: 5),y: 0 , width: Common.Size(s:50), height: Common.Size(s:30)), title: "Từ", color: UIColor.black);
        viewFromToPrice.addSubview(radioPayFrom)
        if (results.price.name != "") {
            
            lbInfoName1.textAlignment = .left
            lbInfoName1.textColor = UIColor.white
            lbInfoName1.backgroundColor = UIColor(netHex:0x00955E)
            lbInfoName1.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoName1.text = " \(results.price.name)"
            self.scrollView.addSubview(lbInfoName1)
            
            indexType1 =  lbInfoName1.frame.size.height + lbInfoName1.frame.origin.y + Common.Size(s:5)
            
            var count:Int = 0
            for item in results.price.valueFilterPrices {
          
                if (count % 2 == 0){

                    let radioPayNow = createRadioButtonTypePrice(CGRect(x: Common.Size(s:5),y: indexType1 , width: self.scrollView.frame.size.width - Common.Size(s:10), height: lbInfoName.frame.size.height), title: "\(item.label)", color: UIColor.black);
                  
                 
          
                    self.scrollView.addSubview(radioPayNow)
                    listRadio2.append(radioPayNow)
                }else{
          
                    let radioPayNow = createRadioButtonTypePrice(CGRect(x: self.scrollView.frame.size.width/2 + Common.Size(s:5),y: indexType1 , width: self.scrollView.frame.size.width - Common.Size(s:10), height: lbInfoName.frame.size.height), title: "\(item.label)", color: UIColor.black);
                  
                 
                    indexType1 = radioPayNow.frame.size.height + radioPayNow.frame.origin.y + Common.Size(s:5)
                    self.scrollView.addSubview(radioPayNow)
                    listRadio2.append(radioPayNow)
                }
                count = count + 1
                
            }
            //
            viewFromToPrice.frame.origin.y = indexType1 + lbInfoName1.frame.size.height
         
            viewFromToPrice.frame.size.height = Common.Size(s: 30)
//            radioPayFrom = createRadioButtonTypePriceFromTo(CGRect(x: Common.Size(s: 5),y: 0 , width: Common.Size(s:50), height: Common.Size(s:30)), title: "Từ", color: UIColor.black);
//            viewFromToPrice.addSubview(radioPayFrom)
            
            tfFrom = UITextField(frame: CGRect(x: radioPayFrom.frame.size.width + radioPayFrom.frame.origin.x, y: 1, width: Common.Size(s:116) , height: Common.Size(s:30)));
            tfFrom.placeholder = "0"
            tfFrom.font = UIFont.systemFont(ofSize: Common.Size(s:15))
            //tfFrom.borderStyle = UITextField.BorderStyle.roundedRect
            tfFrom.autocorrectionType = UITextAutocorrectionType.no
            tfFrom.keyboardType = UIKeyboardType.numberPad
            tfFrom.returnKeyType = UIReturnKeyType.done
            tfFrom.clearButtonMode = UITextField.ViewMode.whileEditing
            tfFrom.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
            tfFrom.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            tfFrom.delegate = self
            viewFromToPrice.addSubview(tfFrom)
            
            let lblTo = UILabel(frame: CGRect(x: tfFrom.frame.size.width + tfFrom.frame.origin.x, y: 0, width: Common.Size(s:40), height: Common.Size(s:30)))
            lblTo.text = "Đến"
            viewFromToPrice.addSubview(lblTo)
            
            tfTo = UITextField(frame: CGRect(x: lblTo.frame.size.width + lblTo.frame.origin.x, y: 1, width: Common.Size(s:116) , height: Common.Size(s:30)));
            tfTo.placeholder = "0"
            tfTo.font = UIFont.systemFont(ofSize: Common.Size(s:15))
            //tfFrom.borderStyle = UITextField.BorderStyle.roundedRect
            tfTo.autocorrectionType = UITextAutocorrectionType.no
            tfTo.keyboardType = UIKeyboardType.numberPad
            tfTo.returnKeyType = UIReturnKeyType.done
            tfTo.clearButtonMode = UITextField.ViewMode.whileEditing
            tfTo.addTarget(self, action: #selector(textFieldDidChangeMoney(_:)), for: .editingChanged)
            tfTo.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
            tfTo.delegate = self
            viewFromToPrice.addSubview(tfTo)
          
        
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: viewFromToPrice.frame.origin.y + viewFromToPrice.frame.size.height + Common.Size(s:5))
        }
  
        var indexTypeInventory:CGFloat  = viewFromToPrice.frame.size.height + viewFromToPrice.frame.origin.y
        if (results.inventory.name != ""){
            let lbInfoNameInventory = UILabel(frame: CGRect(x: 0, y: indexTypeInventory , width: self.scrollView.frame.size.width, height: Common.Size(s:30)))
            lbInfoNameInventory.textAlignment = .left
            lbInfoNameInventory.textColor = UIColor.white
            lbInfoNameInventory.backgroundColor = UIColor(netHex:0x00955E)
            lbInfoNameInventory.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoNameInventory.text = " \(results.inventory.name)"
            self.scrollView.addSubview(lbInfoNameInventory)
            indexTypeInventory =  lbInfoNameInventory.frame.size.height + lbInfoNameInventory.frame.origin.y + Common.Size(s:5)
            for item in results.inventory.valueFilters {
                let radioPayNow = createRadioButtonInventory(CGRect(x: Common.Size(s:5),y: indexTypeInventory , width: self.scrollView.frame.size.width - Common.Size(s:10), height: lbInfoNameInventory.frame.size.height), title: "\(item.label)", color: UIColor.black);
            
     
                indexTypeInventory = radioPayNow.frame.size.height + radioPayNow.frame.origin.y + Common.Size(s:5)
                self.scrollView.addSubview(radioPayNow)
                listRadioInventory.append(radioPayNow)
            }
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: indexTypeInventory + lbInfoNameInventory.frame.size.height + Common.Size(s:5))
            
        }
        var indexType2:CGFloat = indexTypeInventory
        if (results.group_name.name != "") {
            let lbInfoName2 = UILabel(frame: CGRect(x: 0, y: indexTypeInventory , width: self.scrollView.frame.size.width, height: Common.Size(s:30)))
            lbInfoName2.textAlignment = .left
            lbInfoName2.textColor = UIColor.white
            lbInfoName2.backgroundColor = UIColor(netHex:0x00955E)
            lbInfoName2.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoName2.text = " \(results.group_name.name)"
            self.scrollView.addSubview(lbInfoName2)
            
            indexType2 =  lbInfoName2.frame.size.height + lbInfoName2.frame.origin.y + Common.Size(s:5)
            var count:Int = 0
            for item in results.group_name.valueFilters {
                if (count % 2 == 0){
                    let radioPayNow = createRadioButtonTypeGroupName(CGRect(x: Common.Size(s:5),y: indexType2 , width: self.scrollView.frame.size.width - Common.Size(s:10), height: lbInfoName2.frame.size.height), title: "\(item.label)", color: UIColor.black);
                 
                    self.scrollView.addSubview(radioPayNow)
                    listRadio3.append(radioPayNow)
                }else{
                    let radioPayNow = createRadioButtonTypeGroupName(CGRect(x:  self.scrollView.frame.size.width/2 + Common.Size(s:5),y: indexType2 , width:  self.scrollView.frame.size.width - Common.Size(s:15), height: lbInfoName2.frame.size.height), title: "\(item.label)", color: UIColor.black);
                    indexType2 = radioPayNow.frame.size.height + radioPayNow.frame.origin.y + Common.Size(s:5)
                
                    self.scrollView.addSubview(radioPayNow)
                    listRadio3.append(radioPayNow)
                }
                count = count + 1
            }
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: indexType2 + lbInfoName2.frame.size.height + Common.Size(s:5))
        }
        if (results.firm_name.name != "") {
            let lbInfoName3 = UILabel(frame: CGRect(x: 0, y: indexType2 , width: self.scrollView.frame.size.width, height: Common.Size(s:30)))
            lbInfoName3.textAlignment = .left
            lbInfoName3.textColor = UIColor.white
            lbInfoName3.backgroundColor = UIColor(netHex:0x00955E)
            lbInfoName3.font = UIFont.boldSystemFont(ofSize: Common.Size(s:16))
            lbInfoName3.text = " \(results.firm_name.name)"
            self.scrollView.addSubview(lbInfoName3)
            
            scrollView.addSubview(collectionViewHang)
            collectionViewHang.frame = CGRect(x: Common.Size(s: 5), y: lbInfoName3.frame.size.height + lbInfoName3.frame.origin.y, width: self.scrollView.frame.size.width, height: 600)
            collectionViewHang.delegate = self
            collectionViewHang.dataSource = self
            collectionViewHang.register(GroupFilterRadioCollectionViewCell.self, forCellWithReuseIdentifier: "GroupFilterRadioCollectionViewCell")
 
            listFilterHang = results.firm_name.valueFilters
            
            scrollView.contentSize = CGSize(width:UIScreen.main.bounds.size.width, height: collectionViewHang.frame.size.height + collectionViewHang.frame.origin.y + Common.Size(s:5))
        }
        
    }
    // MARK: - Selectors
    fileprivate func createRadioButtonInventory(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonInventory), for: UIControl.Event.touchUpInside);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonInventory(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            for item in listRadioInventory {
                item.isSelected = false
            }
            
            let obj =  self.filterNew?.inventory.valueFilters.filter{ $0.label == radioButton.titleLabel?.text }.first
            inventory = obj?.value ?? "0"
            
            radioButton.isSelected = true
            print(sort)
        }
    }
    
    
    fileprivate func createRadioButtonPayBonus(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonBonus), for: UIControl.Event.touchUpInside);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonBonus(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            for item in listRadio1 {
                item.isSelected = false
            }
            
            let obj =  self.filterNew?.sort.valueFilters.filter{ $0.label == radioButton.titleLabel?.text }.first
            sort = obj?.value ?? "0"
            
            radioButton.isSelected = true
            print(sort)
        }
    }
    fileprivate func createRadioButtonTypePrice(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonPrice), for: UIControl.Event.touchUpInside)
        
        return radioButton;
    }
    fileprivate func createRadioButtonTypePriceFromTo(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State());
        radioButton.setTitleColor(color, for: UIControl.State());
        radioButton.iconColor = color;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonPriceFromTo), for: UIControl.Event.touchUpInside)
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonPrice(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            for item in listRadio2 {
                item.isSelected = false
            }
            
            let obj =  self.filterNew?.price.valueFilterPrices.filter{ $0.label == radioButton.titleLabel?.text }.first
            sortPriceFrom = obj?.from ?? 0
            sortPriceTo = obj?.to ?? 0
            radioButton.isSelected = true
            radioPayFrom.isSelected = false
            print("\(sortPriceFrom) - \(sortPriceTo)")
            
        }
    }
    @objc @IBAction fileprivate func logSelectedButtonPriceFromTo(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            for item in listRadio2 {
                item.isSelected = false
            }
 
            radioButton.isSelected = true
     
            
        }
    }
    fileprivate func createRadioButtonManufacturer(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State())
        radioButton.setTitleColor(color, for: UIControl.State())
        radioButton.iconColor = color;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonManufacturer), for: UIControl.Event.touchUpInside);
        
        return radioButton;
    }

    @objc @IBAction fileprivate func logSelectedButtonManufacturer(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
                for item in listRadio3 {
                    item.isSelected = false
            }
            let obj =  self.filterNew?.firm_name.valueFilters.filter{ $0.label == radioButton.titleLabel?.text }.first
            sortManafacture = obj?.value ?? ""
                radioButton.isSelected = true
                print(sortManafacture)
            }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: false)
    }
    fileprivate func createRadioButtonTypeGroupName(_ frame : CGRect, title : String, color : UIColor) -> DLRadioButton {
        let radioButton = DLRadioButton(frame: frame);
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
        radioButton.setTitle(title, for: UIControl.State())
        radioButton.setTitleColor(color, for: UIControl.State())
        radioButton.iconColor = color;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = color;
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        radioButton.addTarget(self, action: #selector(logSelectedButtonGroupName), for: UIControl.Event.touchUpInside);
        
        return radioButton;
    }
    @objc @IBAction fileprivate func logSelectedButtonGroupName(_ radioButton : DLRadioButton) {
        if (!radioButton.isMultipleSelectionEnabled) {
            for item in listRadio3 {
                item.isSelected = false
            }
            let obj =  self.filterNew?.group_name.valueFilters.filter{ $0.label == radioButton.titleLabel?.text }.first
            sortGroupName = obj?.value ?? ""
            radioButton.isSelected = true
            print(sortGroupName)
        }
    }
    @objc func textFieldDidChangeMoney(_ textField: UITextField) {
        
        var moneyString:String = textField.text!
        moneyString = moneyString.replacingOccurrences(of: ".", with: "", options: .literal, range: nil)
        let characters = Array(moneyString)
        if(characters.count > 0){
            var str = ""
            var count:Int = 0
            for index in 0...(characters.count - 1) {
                let s = characters[(characters.count - 1) - index]
                if(count % 3 == 0 && count != 0){
                    str = "\(s).\(str)"
                }else{
                    str = "\(s)\(str)"
                }
                count = count + 1
            }
            textField.text = str
        
        }else{
            textField.text = ""
           
        }
        
    }
}
extension DetailFilterViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFilterHang?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let coCell: GroupFilterRadioCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupFilterRadioCollectionViewCell", for: indexPath) as! GroupFilterRadioCollectionViewCell
        guard let item = listFilterHang?[indexPath.row] else {return coCell}
        coCell.setUpCollectionViewCell(item: item)
        return coCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("DEBUG: \(indexPath)")
//        if collectionView == collectionViewHang {
//            guard let listGroup = listFilterHang else {
//                return
//            }
//            let item = listGroup[indexPath.row]
//            for i in 0...listGroup.count-1 {
//                if listGroup[i].value == item.value {
//                    listFilterHang?[i].isSelectFilter.toggle()
//                    break
//
//                }
//
//            }
//            collectionViewHang.reloadData()
//
//        }
        let cell = collectionView.cellForItem(at: indexPath) as! GroupFilterRadioCollectionViewCell
        guard let item = listFilterHang?[indexPath.row] else {return}
        guard let listGroup = listFilterHang else {return}
        for i in 0...listGroup.count-1 {
            if listGroup[i].value == item.value {
                if item.isSelectFilter {
                    listFilterHang?[i].isSelectFilter = false
                }else{
                    listFilterHang?[i].isSelectFilter = true
                }
               
            }
            
        }
        cell.toggelCell(item: item)
   
    }
    
    
    
}

    // MARK: - GroupFilterRadioCollectionViewCell
class GroupFilterRadioCollectionViewCell: UICollectionViewCell {
    
    var icon: UIImageView!
    private var radio:DLRadioButton = {
        let radioButton = DLRadioButton()
        radioButton.titleLabel!.font = UIFont.systemFont(ofSize: Common.Size(s:16));
     
        radioButton.setTitleColor(.black, for: UIControl.State())
        radioButton.iconColor = .black;
        radioButton.isIconSquare = true;
        radioButton.indicatorColor = .black
        radioButton.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left;
        return radioButton
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setUpCollectionViewCell(item: ValueFilter) {
        self.subviews.forEach({ $0.removeFromSuperview() })
    
        addSubview(radio)
        radio.frame = CGRect(x: 0, y: 0, width: contentView.frame.size.width - 10, height: Common.Size(s: 30))
        radio.setTitle(item.label, for: UIControl.State())
        if item.isSelectFilter{
            radio.isSelected = true
        }
   
    }
    
    func toggelCell(item: ValueFilter){
        if item.isSelectFilter {
            radio.isSelected = true
        }else{
            radio.isSelected = false
        }
    }
}
