
//
//  Menu_Sotay.swift
//  fptshop
//
//  Created by Sang Truong on 2/17/22.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.

import Alamofire
import SwiftyJSON
import NVActivityIndicatorView

class Menu_SoTay : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,NVActivityIndicatorViewable {
    
    var collectionView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    var g_lst_book = [Books]()
    var g_lst_content = [Book_Contents]()
    var g_lst_chapter = [Book_Chapters]()
    var g_lst_pages = [Book_Pages]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Sổ tay"
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "back"), for: .normal)
        button1.addTarget(self, action:#selector(backClick), for:.touchUpInside)
        let menuButtonLeft = UIBarButtonItem(customView: button1)
        navigationItem.leftBarButtonItem = menuButtonLeft
        initController()
//        setupController()
        f_LoadData()
        let btLeftIcon = Common.initBackButton()
        btLeftIcon.addTarget(self, action: #selector(handleBack), for: UIControl.Event.touchUpInside)
        let barLeft = UIBarButtonItem(customView: btLeftIcon)
        self.navigationItem.leftBarButtonItem = barLeft
    }
    @objc func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    func initController(){
        collectionView = UICollectionView(frame: CGRect(x: 20, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.init(white: 1, alpha: 0)
        collectionView.register(MenuSoTay_Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    @objc func backClick(){
        dismiss(animated: true, completion: nil)
    }
    func setupController(){
        self.view.addConstraint(NSLayoutConstraint(
            item: collectionView
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: (self.navigationController?.navigationBar.intrinsicContentSize.height)! + (UIApplication.shared.statusBarFrame.size.height)
        ))
        self.view.addConstraint(NSLayoutConstraint(
            item: collectionView
            , attribute: NSLayoutConstraint.Attribute.bottom
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: -10
        ))
        self.view.addConstraint(NSLayoutConstraint(
            item: collectionView
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: self.view
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 0
        ))
        self.view.addConstraint(NSLayoutConstraint(
            item: collectionView
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: self.view
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MenuSoTay_Cell
        let row = indexPath.row
        cell.imageview.downloadedFrom(link: g_lst_book[row].Image)
        cell.imageview.contentMode = .scaleAspectFill
        cell.title.text = g_lst_book[row].Book_Name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return g_lst_book.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SoTay_VC()
        vc.name = g_lst_book[indexPath.row].Book_Name
        vc.bookID = g_lst_book[indexPath.row].Book_ID
        vc.g_lst_book = g_lst_book
        vc.g_lst_pages = g_lst_pages
        vc.g_lst_chapter = g_lst_chapter
        vc.g_lst_content = g_lst_content
        print("bookID: " + String(g_lst_book[indexPath.row].Book_ID))
        navigationController?.pushViewController(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: view.frame.size.width/2 - 10, height: view.frame.size.height/2)
    }
    func f_LoadData(){
        g_lst_book.removeAll()
        g_lst_pages.removeAll()
        g_lst_content.removeAll()
        g_lst_chapter.removeAll()
        startAnimating(CGSize(width:50,height:50), message: "Đang load data...!"
            , messageFont: UIFont.boldSystemFont(ofSize: 16), type: .ballClipRotateMultiple
            , color: UIColor(red: 75, green: 143, blue: 71), padding: 0, displayTimeThreshold: 0
            , minimumDisplayTime: 1, backgroundColor: UIColor.init(white: 0.8, alpha: 0.5), textColor: UIColor.black)
//        let url = "http://mpharmacyservicebeta.fptshop.com.vn:8082/mPharmacy/Service.svc/Get_Info_Books"
        let url = Config.manager.URL_GATEWAY + "/mpos-cloud-api" + "/api/Books/Get_Info_Books"

        
        let parameters = [
            "Book_ID" : 4,
            "UserID": Cache.user!.UserName,
            "System":"1" ] as [String : Any]
        print(parameters)
        var headers: HTTPHeaders? {
            return DefaultHeader().addAuthHeader()
        }
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers).validate(statusCode: 200..<500).responseJSON { response in
            
            switch response.result
            {
            case .failure(let error):
                self.alert(message: "Lỗi API!", title: "Lỗi", textBtn: "OK")
                self.stopAnimating()
                
            case .success(let value):
                self.stopAnimating()
                let json = JSON(value)
                let data_VC = json["Books"]
                let data_content = json["Book_Table_of_Contents"]
                let data_pages = json["Book_Pages"]
                let data_chapter = json["Book_Chapters"]
                if data_VC.count > 0 {
                    for i in 0..<data_VC.count {
                        let dto = Books()
                        dto.Book_ID = data_VC[i]["Book_ID"].intValue
                        dto.Image = data_VC[i]["Image"].stringValue
                        dto.Book_Name = data_VC[i]["Book_Name"].stringValue
                        dto.Background_Image = data_VC[i]["Background_Image"].stringValue
                        self.g_lst_book.append(dto)
                    }
                }
                if data_content.count > 0 {
                    for i in 0..<data_content.count {
                        let dto = Book_Contents()
                        dto.Book_ID = data_content[i]["Book_ID"].intValue
                        dto.Image = data_content[i]["Image"].stringValue
                        dto.Table_of_Content_ID = data_content[i]["Table_of_Content_ID"].intValue
                        dto.Table_of_Content_Name = data_content[i]["Table_of_Content_Name"].stringValue
                        self.g_lst_content.append(dto)
                    }
                }
                if data_pages.count > 0 {
                    for i in 0..<data_pages.count {
                        let dto = Book_Pages()
                        dto.Book_ID = data_pages[i]["Book_ID"].intValue
                        dto.Image = data_pages[i]["Image"].stringValue
                        dto.Table_of_Content_ID = data_pages[i]["Table_of_Content_ID"].intValue
                        dto.ChapterID = data_pages[i]["ChapterID"].intValue
                        dto.PageID = data_pages[i]["PageID"].intValue
                        dto.PageTitle = data_pages[i]["PageTitle"].stringValue
                        dto.ID = data_pages[i]["ID"].intValue
                        self.g_lst_pages.append(dto)
                    }
                }
                if data_chapter.count > 0 {
                    for i in 0..<data_chapter.count {
                        let dto = Book_Chapters()
                        dto.Book_ID = data_chapter[i]["Book_ID"].intValue
                        dto.Image = data_chapter[i]["Image"].stringValue
                        dto.Table_of_Content_ID = data_chapter[i]["Table_of_Content_ID"].intValue
                        dto.ChapterID = data_chapter[i]["ChapterID"].intValue
                        dto.ChapterName = data_chapter[i]["ChapterName"].stringValue
                        dto.Link_Document = data_chapter[i]["Link_Document"].stringValue
                        self.g_lst_chapter.append(dto)
                    }
                }
                
                guard self.g_lst_book.count > 0 else { return }
                let vc = SoTay_VC()
                vc.name = self.g_lst_book[0].Book_Name
                vc.bookID = self.g_lst_book[0].Book_ID
                vc.g_lst_book = self.g_lst_book
                vc.g_lst_pages = self.g_lst_pages
                vc.g_lst_chapter = self.g_lst_chapter
                vc.g_lst_content = self.g_lst_content
                print("bookID: " + String(self.g_lst_book[0].Book_ID))
                self.collectionView.reloadData()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

class MenuSoTay_Cell : UICollectionViewCell {
    let uiview = UIView()
    var imageview : UIImageView!
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initControl()
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initControl(){
        self.backgroundColor = UIColor.clear
        layer.masksToBounds = true
        
        uiview.layer.cornerRadius = 15
        uiview.backgroundColor = UIColor.white
        uiview.translatesAutoresizingMaskIntoConstraints = false
        uiview.layer.shadowColor = UIColor.gray.cgColor
        uiview.layer.shadowOpacity = 1
        uiview.layer.shadowOffset = CGSize.zero
        uiview.layer.shadowRadius = 5
        self.addSubview(uiview)
        
        imageview = UIImageView.init(image: UIImage.init(named: "picture.png"))
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageview)
        
        title.numberOfLines = 3
        title.font = UIFont.boldSystemFont(ofSize: 12)
        title.textAlignment = .center
        title.textColor = UIColor.gray
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
    }
    func initLayout(){
        addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: 10
        ))
        addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 10
        ))
        addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: -10
        ))
        addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , relatedBy: .equal
            , toItem: title
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 10
        ))
        
        addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: 15
        ))
        addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 150
        ))
        addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 10
        ))
        addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: -10
        ))
        
        addConstraint(NSLayoutConstraint(
            item: title
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: imageview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 5
        ))
        addConstraint(NSLayoutConstraint(
            item: title
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 10
        ))
        addConstraint(NSLayoutConstraint(
            item: title
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: -10
        ))
        addConstraint(NSLayoutConstraint(
            item: title
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 30
        ))
    }
}
class Books : NSObject {
    var Book_ID : Int! = 0
    var Book_Name : String! = ""
    var Image : String! = ""
    var Background_Image : String! = ""
}

class Book_Contents : NSObject {
    var Book_ID : Int! = 0
    var Image : String! = ""
    var Table_of_Content_ID : Int! = 0
    var Table_of_Content_Name : String! = ""
}

class Book_Pages : NSObject {
    var Book_ID : Int! = 0
    var ChapterID : Int! = 0
    var Image : String! = ""
    var PageID : Int! = 0
    var PageTitle : String! = ""
    var Table_of_Content_ID : Int! = 0
    var ID : Int! = 0
}

class Book_Chapters : NSObject {
    var Book_ID : Int! = 0
    var ChapterID : Int! = 0
    var ChapterName : String! = ""
    var Image : String! = ""
    var Table_of_Content_ID : Int! = 0
    var Link_Document : String! = ""
}
