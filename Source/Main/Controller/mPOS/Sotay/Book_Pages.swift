
//  Book_Pages.swift
//  fptshop
//
//  Created by Sang Truong on 2/17/22.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import Toaster
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
//
class SoTay_VC : UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate,NVActivityIndicatorViewable {
    var pageController: UIPageViewController!
    var controllers = [UIViewController]()
    var name = ""
    var bookID = 0
    var g_lst_book = [Books]()
    var g_lst_pages = [Book_Pages]()
    var g_lst_content = [Book_Contents]()
    var g_lst_chapter = [Book_Chapters]()
    var indexHeader = 0;
    let uiview = UIView()
    var imageview : UIImageView!
    let uiLable = UILabel()
    let uiContent = UILabel()
    let btn_Dong = UIButton()
    let g_Timer = Timer()
    var secondsRemaining = 5
    var listPage = ""
    var listChapter = ""
    var _listPage = [String]()
    var _listChapter = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = name
        let button1 = UIButton(type: .custom)
        button1.setImage(UIImage(named: "back"), for: .normal)
        button1.addTarget(self, action:#selector(backClick), for:.touchUpInside)
        let menuButtonLeft = UIBarButtonItem(customView: button1)
        navigationItem.leftBarButtonItem = menuButtonLeft
        
        let buttonRight3 = UIButton(type: .custom)
        buttonRight3.setImage(UIImage(named: "icon_list_menu"), for: .normal)
        buttonRight3.addTarget(self, action:#selector(gotoContent), for:.touchUpInside)
        buttonRight3.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menuButtonRefresh = UIBarButtonItem(customView: buttonRight3)
        
        navigationItem.rightBarButtonItems = [menuButtonRefresh]

        pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageController.dataSource = self
        pageController.delegate = self
        
        uiview.backgroundColor = UIColor.gray
        uiview.alpha = 0.5
        uiview.translatesAutoresizingMaskIntoConstraints = false
        
        imageview = UIImageView.init(image: UIImage.init(named: "swipe.png"))
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
        imageview.alpha = 1.0
        imageview.translatesAutoresizingMaskIntoConstraints = false
       // uiview.addSubview(imageview)
        
        uiLable.numberOfLines = 1
        uiLable.font = UIFont.boldSystemFont(ofSize: 40)
        uiLable.textAlignment = .left
        uiLable.textColor = UIColor.white
        uiLable.text = "Hướng dẫn"
        uiLable.translatesAutoresizingMaskIntoConstraints = false
        //uiview.addSubview(uiLable)
        
        uiContent.numberOfLines = 1
        uiContent.font = UIFont.boldSystemFont(ofSize: 20)
        uiContent.textAlignment = .left
        uiContent.textColor = UIColor.white
        uiContent.text = "Lướt trái phải để chuyển trang"
        uiContent.translatesAutoresizingMaskIntoConstraints = false
        //uiview.addSubview(uiContent)
        
        btn_Dong.backgroundColor = UIColor.blue
        btn_Dong.layer.cornerRadius = 10
        btn_Dong.titleLabel?.font =  UIFont.boldSystemFont(ofSize: 13)
        btn_Dong.setTitle("Kế tiếp", for: .normal)
        btn_Dong.addTarget(self, action:#selector(f_BtnCancel), for:.touchUpInside)
        btn_Dong.translatesAutoresizingMaskIntoConstraints = false
        
        
        addChild(pageController)
        view.addSubview(pageController.view)
        view.addSubview(uiview)
        view.addSubview(imageview)
        view.addSubview(uiLable)
        view.addSubview(uiContent)
        view.addSubview(btn_Dong)
        
        uiview.isHidden = true
        imageview.isHidden = true
        uiLable.isHidden = true
        uiContent.isHidden = true
        btn_Dong.isHidden = true
        
        view.addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 0
        ))
        
        view.addConstraint(NSLayoutConstraint(
            item: uiLable
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: (self.navigationController?.navigationBar.intrinsicContentSize.height)! + (UIApplication.shared.statusBarFrame.size.height) + 10
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiLable
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 40
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiLable
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiLable
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 30
        ))
        
        view.addConstraint(NSLayoutConstraint(
            item: uiContent
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: uiLable
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiContent
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 40
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiContent
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: uiContent
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 30
        ))
        
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: view.frame.size.height/3
        ))
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: view.frame.size.width/4
        ))
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.width
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.width
            , multiplier: 1
            , constant: view.frame.size.width/2
        ))
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: view.frame.size.height/3
        ))
        
        view.addConstraint(NSLayoutConstraint(
            item: btn_Dong
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: imageview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 90
        ))
        view.addConstraint(NSLayoutConstraint(
            item: btn_Dong
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: uiview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: -20
        ))
        view.addConstraint(NSLayoutConstraint(
            item: btn_Dong
            , attribute: NSLayoutConstraint.Attribute.width
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.width
            , multiplier: 1
            , constant: 80
        ))
        view.addConstraint(NSLayoutConstraint(
            item: btn_Dong
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 40
        ))


        let views = ["pageController": pageController.view] as [String: AnyObject]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))
        var image_background = ""
        for item in g_lst_book {
            if item.Book_ID == bookID {
                let vc = PagesBook()
                vc._link = item.Image
                controllers.append(vc)
                image_background = item.Background_Image
                break;
            }
        }
        let _vc = TableOfContent()
        _vc._background = image_background
        _vc.bookID = bookID
        _vc.g_lst_content = g_lst_content
        _vc.g_lst_chapter = g_lst_chapter
        _vc.g_lst_pages = g_lst_pages
        _vc.parrent_SoTay = self
        print("bookID2: " + String(_vc.bookID))
        controllers.append(_vc)
        for chapter in g_lst_content {
//            let vc = PagesBook()
//            vc._link = chapter.Image
//            controllers.append(vc)
            for item in g_lst_pages {
                if item.Book_ID == bookID && chapter.Table_of_Content_ID == item.Table_of_Content_ID{
                    let vc = PagesBook()
                    vc._link = item.Image
                    controllers.append(vc)
                }
            }
        }
        Toast(text: "Trang bìa").show()
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)

//        var _secondsRemaining = 1
//        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
//            if self.secondsRemaining > 0 {
//                if self.secondsRemaining > 2 {
//                        self.pageController.setViewControllers([self.controllers[( 5 - self.secondsRemaining )]], direction: .forward, animated: true)
//                    }
//                    else {
//                        self.pageController.setViewControllers([self.controllers[( 5 - _secondsRemaining )]], direction: .forward, animated: true)
//                    }
//                self.secondsRemaining -= 1
//                    _secondsRemaining += 1
//                } else {
//                    Timer.invalidate()
//                    self.uiview.isHidden = true
//                    self.imageview.isHidden = true
//                    self.uiLable.isHidden = true
//                    self.uiContent.isHidden = true
//                    self.btn_Dong.isHidden = true
//                }
//            }
    }
    @objc func backClick(){
        self.f_WriteLog()
        navigationController?.popViewController(animated: true)
    }
    @objc func gotoContent(){
        pageController.setViewControllers([controllers[1]], direction: .forward, animated: false)
    }
    @objc func f_BtnCancel(){
        self.secondsRemaining = 0
        self.uiview.isHidden = true
        self.imageview.isHidden = true
        self.uiLable.isHidden = true
        self.uiContent.isHidden = true
        self.btn_Dong.isHidden = true
        pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            for item in g_lst_pages {
                if item.Book_ID == bookID && item.PageID == index-1 {
                    listPage += String(item.ID) + ","
                    listChapter += String(item.ChapterID) + ","
                    break
                }
            }
            if index > 0 {
                if index == 36 {
                    Toast(text: "35/" + String(controllers.count-2)).show()
                    return controllers[index - 1]
                } else {
                    Toast(text: String(index) + "/" + String(controllers.count-2)).show()
                    return controllers[index - 1]
                }
           
                
            } else {
                Toast(text: "Trang bìa").show()
                return nil
            }
        }

        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = controllers.firstIndex(of: viewController) {
            if index < controllers.count - 1 {
               
                if index == 0 {
                    Toast(text: "Mục lục").show()
                }
                else {
                    if index == 36 {
                        Toast(text: "35/" + String(controllers.count-2)).show()
                        for item in g_lst_pages {
                            if item.Book_ID == bookID && item.PageID == index-1 {
                                listPage += String(item.ID) + ","
                                listChapter += String(item.ChapterID) + ","
                                break
                            }
                        }
                    } else {
                        Toast(text: String(index) + "/" + String(controllers.count-2)).show()
                        for item in g_lst_pages {
                            if item.Book_ID == bookID && item.PageID == index-1 {
                                listPage += String(item.ID) + ","
                                listChapter += String(item.ChapterID) + ","
                                break
                            }
                        }
                    }
                    
                }
                return controllers[index + 1]
            } else {
                return nil
            }
        }

        return nil
    }
    func f_WriteLog(){
                let url = Config.manager.URL_GATEWAY + "/mpos-cloud-api" + "/api/Books/Get_Info_Books"

//        let url = "http://mpharmacyservicebeta.fptshop.com.vn:8082/mPharmacy/Service.svc/Insert_Book_LogView"
        for item in _listPage {
            listPage += item + ","
        }
        for item in _listChapter {
            listChapter += item + ","
        }
        let parameters = [
            "User": "15201",
            "List_Page": listPage,
            "List_Chapter" : listChapter
            ] as [String : Any]
        print(parameters)
        var headers: HTTPHeaders? {
            return DefaultHeader().addAuthHeader()
        }
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding(options: []),headers: headers).validate(statusCode: 200..<500).responseJSON { response in
            
            switch response.result
            {
            case .failure(let error):
                self.alert(message: "Lỗi API!", title: "Lỗi", textBtn: "OK")
                
            case .success(let value):
                let json = JSON(value)
                print(json)
            }
        }
    }
}

class PagesBook : UIViewController {
    var imageview : UIImageView!
    var _link = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageview = UIImageView.init(image: UIImage.init(named: "picture.png"))
        imageview.downloadedFrom(link: _link)
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        
        self.view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant:0
        ))
        self.view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 0
        ))
        self.view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: self.view
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 0
        ))
        self.view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: self.view
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
    }
}

class TableOfContent : UIViewController, UITableViewDelegate, UITableViewDataSource,UIGestureRecognizerDelegate {

    
    let lblTitle = UILabel()
    var tableview = UITableView()
    let cellID = "cellID"
    var imageview : UIImageView!
    var _background = ""
    var bookID = 0
    var g_lst_content = [Book_Contents]()
    var g_lst_chapter = [Book_Chapters]()
    var g_lst_pages = [Book_Pages]()
    var parrent_SoTay = SoTay_VC()
    var listPage = [String]()
    var listChapter = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initController()
        setupController()
        tableview = UITableView(frame: tableview.frame, style: UITableView.Style.grouped)
        tableview.reloadData()
    }
    func initController(){
        view.backgroundColor = UIColor.clear
        
        imageview = UIImageView.init(image: UIImage.init(named: "picture.png"))
        imageview.downloadedFrom(link: _background)
        imageview.contentMode = .scaleToFill
        imageview.clipsToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        
        lblTitle.numberOfLines = 1
        lblTitle.font = UIFont.boldSystemFont(ofSize: 24)
        lblTitle.textAlignment = .left
        lblTitle.textColor = UIColor.black
        lblTitle.text = "Mục lục"
        lblTitle.backgroundColor = UIColor.clear
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lblTitle)
        
        tableview.backgroundColor = UIColor.clear//UIColor.init(white: 1, alpha: 1)
        tableview.alwaysBounceVertical = true
        tableview.register(TableOfContent_Cell.self, forCellReuseIdentifier: cellID)
        tableview.register(Header_Cell.self,forHeaderFooterViewReuseIdentifier: "sectionHeader")
        tableview.dataSource = self
        tableview.delegate = self
        tableview.separatorStyle = .none
        tableview.showsVerticalScrollIndicator = false
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.allowsSelectionDuringEditing = true
        tableview.rowHeight = UITableView.automaticDimension
        view.addSubview(tableview)
    }
    
    func setupController(){
        
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: imageview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 0
        ))
        
        view.addConstraint(NSLayoutConstraint(
            item: lblTitle
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: view.frame.size.height/8
        ))
        view.addConstraint(NSLayoutConstraint(
            item: lblTitle
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 30
        ))
        view.addConstraint(NSLayoutConstraint(
            item: lblTitle
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
        view.addConstraint(NSLayoutConstraint(
            item: lblTitle
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 40
        ))
        
        //
        view.addConstraint(NSLayoutConstraint(
            item: tableview
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: lblTitle
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: 5
        ))
        view.addConstraint(NSLayoutConstraint(
            item: tableview
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 70
        ))
        view.addConstraint(NSLayoutConstraint(
            item: tableview
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: -70
        ))
        view.addConstraint(NSLayoutConstraint(
            item: tableview
            , attribute: NSLayoutConstraint.Attribute.bottom
            , relatedBy: .equal
            , toItem: view
            , attribute: NSLayoutConstraint.Attribute.bottom
            , multiplier: 1
            , constant: -40
        ))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let id_content = g_lst_content.filter({$0.Book_ID == bookID})[section].Table_of_Content_ID
        return g_lst_chapter.filter({$0.Book_ID == bookID && $0.Table_of_Content_ID == id_content}).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! TableOfContent_Cell
        let row = indexPath.row
        let section = indexPath.section
        let id_content = g_lst_content.filter({$0.Book_ID == bookID})[section].Table_of_Content_ID
        let _item = g_lst_chapter.filter({$0.Book_ID == bookID && $0.Table_of_Content_ID == id_content})[row]
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "\(row + 1). " + _item.ChapterName, attributes: underlineAttribute)
        cell.lblContent.attributedText = underlineAttributedString
        cell.backgroundColor = UIColor.clear
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return g_lst_content.filter({$0.Book_ID == bookID}).count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "sectionHeader") as! Header_Cell
        let item = g_lst_content.filter({$0.Book_ID == bookID})[section]
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: item.Table_of_Content_Name, attributes: underlineAttribute)
        header.lblContent.attributedText = underlineAttributedString
        header.backgroundColor = UIColor.clear
        UITableViewHeaderFooterView.appearance().tintColor = .white
        header.tag = section
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapRecognizer.delegate = self
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        header.addGestureRecognizer(tapRecognizer)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let section = indexPath.section
        let id_content = g_lst_content.filter({$0.Book_ID == bookID})[section].Table_of_Content_ID
        let _item = g_lst_chapter.filter({$0.Book_ID == bookID && $0.Table_of_Content_ID == id_content})[row]
        for item in g_lst_pages {
            if _item.ChapterID == item.ChapterID {
                let _index = item.PageID! + 1
                listPage.append(String(item.PageID))
                listChapter.append(String(item.ChapterID))
                parrent_SoTay._listPage.removeAll()
                parrent_SoTay._listPage = listPage
                parrent_SoTay._listChapter.removeAll()
                parrent_SoTay._listChapter = listChapter
                print("_index")
                print(_index)
                parrent_SoTay.pageController.setViewControllers([parrent_SoTay.controllers[_index]], direction: .forward, animated: true)
                break
            }
        }
        if _item.Link_Document == "" {
            
        }
        else{
            if let url = URL(string:  _item.Link_Document) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer?){
        let index = (sender?.view?.tag)!
        let chapter = g_lst_content.filter({$0.Book_ID == bookID})[index]
        let list_page = g_lst_pages.filter({$0.Book_ID == bookID })
        for item in list_page {
            if chapter.Table_of_Content_ID == item.Table_of_Content_ID {
                let _index = item.PageID! + 1
                parrent_SoTay._listPage.removeAll()
                parrent_SoTay._listPage = listPage
                parrent_SoTay._listChapter.removeAll()
                parrent_SoTay._listChapter = listChapter
                parrent_SoTay.pageController.setViewControllers([parrent_SoTay.controllers[_index]], direction: .forward, animated: true)
                break
            }
        }
        
    }
}

class TableOfContent_Cell : UITableViewCell {
    let lblContent = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initControllcell()

        self.contentView.isUserInteractionEnabled = false
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initControllcell(){
        self.backgroundColor = UIColor.clear
        lblContent.numberOfLines = 2
        lblContent.font = UIFont.systemFont(ofSize: 12)
        lblContent.textAlignment = .left
        lblContent.textColor = UIColor.gray
        lblContent.translatesAutoresizingMaskIntoConstraints = false
        lblContent.backgroundColor = UIColor.clear
        addSubview(lblContent)
        
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: 0
        ))
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 25
        ))
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: 25
        ))
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
    }
}

class Header_Cell : UITableViewHeaderFooterView {
    let lblContent = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
           initControllcell()
       }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initControllcell(){
        
        lblContent.numberOfLines = 1
        lblContent.font = UIFont.systemFont(ofSize: 16)
        lblContent.textAlignment = .left
        lblContent.textColor = UIColor.gray
        lblContent.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lblContent)
        
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.top
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.top
            , multiplier: 1
            , constant: 0
        ))
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.height
            , relatedBy: .equal
            , toItem: nil
            , attribute: NSLayoutConstraint.Attribute.height
            , multiplier: 1
            , constant: 25
        ))
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.leading
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.leading
            , multiplier: 1
            , constant: self.frame.size.width/7
        ))
        addConstraint(NSLayoutConstraint(
            item: lblContent
            , attribute: NSLayoutConstraint.Attribute.trailing
            , relatedBy: .equal
            , toItem: self
            , attribute: NSLayoutConstraint.Attribute.trailing
            , multiplier: 1
            , constant: 0
        ))
    }
}
