//
//  BanHangOutsideViewController.swift
//  fptshop
//
//  Created by Apple on 4/1/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import PopupDialog

class BanHangOutsideViewController: UIViewController {
    
    var scrollView:UIScrollView!
    var lblInsideCode: UILabel!
    var lblName: UILabel!
    var lblPosition: UILabel!
    var lblStatus: UILabel!
    var lblCongNoValue: UILabel!
    var lblNgayD1: UILabel!
    var lblNgayD: UILabel!
    var indexSegment:CGFloat = 1
    var scrollViewHeight:CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Bán hàng Outside"
        self.view.backgroundColor = .white
        //---
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: #selector(BanHangOutsideViewController.actionBack), for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
        //---
        
        navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "LSCC"), style: .plain, target: self, action: #selector(showListHistory))
        
        let newViewController = LoadingViewController();
        newViewController.content = "Đang lấy dữ liệu, bạn đợi xíu nhé"
        newViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        newViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.navigationController?.present(newViewController, animated: true, completion: nil)
        let nc = NotificationCenter.default
        MPOSAPIManager.sp_mpos_FRT_SP_Load_OutSide_Info(userID: "\(Cache.user?.UserName ?? "")", MaShop: "\(Cache.user?.ShopCode ?? "")") { (arrayOutsideInfo, error) in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                nc.post(name: Notification.Name("dismissLoading"), object: nil);
                if error.isEmpty {
                    if arrayOutsideInfo.count > 0 {
                        self.setUpUI(item: arrayOutsideInfo[0])
                    } else {
                        let outsideInfo = OutsideInfo(MaNV: "", TenNV: "", TinhTrang: "", HanMuc: 0, HanMucConLai: 0, CongNo: 0, JobTitleName: "", NgayD: "", NgayD_money: 0, NgayD1: "", NgayD1_money: 0, NgayHetHan: "")
                        self.setUpUI(item: outsideInfo)
                    }
                } else {
                    let popup = PopupDialog(title: "Thông báo", message: "\(error)", buttonAlignment: .horizontal, transitionStyle: .zoomIn, tapGestureDismissal: false, panGestureDismissal: false, hideStatusBar: false) {
                    }
                    let buttonOne = CancelButton(title: "OK") {
                    }
                    popup.addButtons([buttonOne])
                    self.present(popup, animated: true, completion: nil)
                    
                }
            }
        }
    }
    @objc func actionBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpUI(item: OutsideInfo){
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height ))
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let emplInfoView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: Common.Size(s: 40)))
        emplInfoView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        scrollView.addSubview(emplInfoView)
        
        let lblEmplInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: emplInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lblEmplInfo.backgroundColor = UIColor.clear
        lblEmplInfo.text = "THÔNG TIN NHÂN VIÊN"
        emplInfoView.addSubview(lblEmplInfo)
        
        let lblInside = UILabel(frame: CGRect(x: Common.Size(s: 15), y: emplInfoView.frame.height + Common.Size(s: 15), width: self.view.frame.width/3 , height: Common.Size(s: 20)))
        lblInside.text = "Mã inside:"
        lblInside.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblInside.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblInside)
        
        lblInsideCode = UILabel(frame: CGRect(x: lblInside.frame.origin.x + lblInside.frame.width , y: lblInside.frame.origin.y, width: self.view.frame.width - lblInside.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
        lblInsideCode.text = "\(item.MaNV)"
        lblInsideCode.textColor = UIColor.black
        lblInsideCode.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblInsideCode)
        
        let lblHoten = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblInside.frame.origin.y + lblInside.frame.height + Common.Size(s: 5), width: self.view.frame.width/3 , height: Common.Size(s: 20)))
        lblHoten.text = "Họ tên:"
        lblHoten.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblHoten.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblHoten)
        
        lblName = UILabel(frame: CGRect(x: lblInsideCode.frame.origin.x, y: lblHoten.frame.origin.y, width: lblInsideCode.frame.width, height: Common.Size(s: 20)))
        lblName.text = "\(item.TenNV)"
        lblName.textColor = UIColor.black
        lblName.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblName)
        
        let lblChucDanh = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblHoten.frame.origin.y + lblHoten.frame.height + Common.Size(s: 5), width: self.view.frame.width/3 , height: Common.Size(s: 20)))
        lblChucDanh.text = "Chức danh:"
        lblChucDanh.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblChucDanh.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblChucDanh)
        
        lblPosition = UILabel(frame: CGRect(x: lblInsideCode.frame.origin.x, y: lblChucDanh.frame.origin.y, width: lblInsideCode.frame.width, height: Common.Size(s: 20)))
        lblPosition.text = "\(item.JobTitleName)"
        lblPosition.textColor = UIColor.black
        lblPosition.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblPosition)
        
        let lblPositionHeight = lblPosition.optimalHeight < Common.Size(s: 20) ? Common.Size(s: 20) : lblPosition.optimalHeight
        lblPosition.numberOfLines = 0
        lblPosition.frame = CGRect(x: lblPosition.frame.origin.x, y: lblPosition.frame.origin.y, width: lblPosition.frame.width, height: lblPositionHeight)
        
        ///thong tin ban hang
        let saleInfoView = UIView(frame: CGRect(x: 0, y: lblChucDanh.frame.origin.y + lblPositionHeight + Common.Size(s: 20), width: self.view.frame.width, height: Common.Size(s: 40)))
        saleInfoView.backgroundColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1)
        scrollView.addSubview(saleInfoView)
        
        let lblSaleInfo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: 0, width: saleInfoView.frame.width - Common.Size(s: 30), height: Common.Size(s: 40)))
        lblSaleInfo.backgroundColor = UIColor.clear
        lblSaleInfo.text = "THÔNG TIN BÁN HÀNG"
        saleInfoView.addSubview(lblSaleInfo)
        
        let lblTrangThai = UILabel(frame: CGRect(x: Common.Size(s: 15), y: saleInfoView.frame.origin.y + saleInfoView.frame.height + Common.Size(s: 10), width: self.view.frame.width/3 , height: Common.Size(s: 20)))
        lblTrangThai.text = "Trạng thái:"
        lblTrangThai.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblTrangThai.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblTrangThai)
        
        lblStatus = UILabel(frame: CGRect(x: lblInsideCode.frame.origin.x, y: lblTrangThai.frame.origin.y, width: lblInsideCode.frame.width, height: Common.Size(s: 20)))
        lblStatus.text = "\(item.TinhTrang)"
        lblStatus.textColor = UIColor.black
        lblStatus.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblStatus)
        
        let lblCongNo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblTrangThai.frame.origin.y + lblTrangThai.frame.height + Common.Size(s: 5), width: self.view.frame.width/3 , height: Common.Size(s: 20)))
        lblCongNo.text = "Công nợ:"
        lblCongNo.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblCongNo.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblCongNo)
        
        lblCongNoValue = UILabel(frame: CGRect(x: lblInsideCode.frame.origin.x, y: lblCongNo.frame.origin.y, width: lblInsideCode.frame.width, height: Common.Size(s: 20)))
        lblCongNoValue.text = "\(Common.convertCurrency(value: item.CongNo))"
        lblCongNoValue.textColor = UIColor.red
        lblCongNoValue.font = UIFont.boldSystemFont(ofSize: 13)
        scrollView.addSubview(lblCongNoValue)
        
        let lblChiTietCongNo = UILabel(frame: CGRect(x: Common.Size(s: 15), y: lblCongNo.frame.origin.y + lblCongNo.frame.height + Common.Size(s: 5), width: self.view.frame.width/3 , height: Common.Size(s: 20)))
        lblChiTietCongNo.text = "Chi tiết công nợ:"
        lblChiTietCongNo.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
        lblChiTietCongNo.font = UIFont.systemFont(ofSize: 13)
        scrollView.addSubview(lblChiTietCongNo)
        
        lblNgayD1 = UILabel(frame: CGRect(x: lblInsideCode.frame.origin.x, y: lblChiTietCongNo.frame.origin.y, width: lblInsideCode.frame.width, height: Common.Size(s: 20)))
        lblNgayD1.text = "\(item.NgayD1) - \(Common.convertCurrency(value: item.NgayD1_money))"
        lblNgayD1.textColor = UIColor.black
        lblNgayD1.font = UIFont.boldSystemFont(ofSize: 13)
        scrollView.addSubview(lblNgayD1)
        
        lblNgayD = UILabel(frame: CGRect(x: lblNgayD1.frame.origin.x, y: lblNgayD1.frame.origin.y + lblNgayD1.frame.height, width: lblNgayD1.frame.width, height: Common.Size(s: 20)))
        lblNgayD.text = "\(item.NgayD) - \(Common.convertCurrency(value: item.NgayD_money))"
        lblNgayD.textColor = UIColor.black
        lblNgayD.font = UIFont.boldSystemFont(ofSize: 13)
        scrollView.addSubview(lblNgayD)
        
        let pieView = PieChartView(frame: CGRect(x: Common.Size(s: 50), y: lblNgayD.frame.origin.y + lblNgayD.frame.height + Common.Size(s: 20), width: scrollView.frame.width - Common.Size(s: 100), height: scrollView.frame.width - Common.Size(s: 100)))
        scrollView.addSubview(pieView)
        let s1 = Segment.init(color: UIColor(netHex: 0x04AB6E), name: "Hạn mức còn lại \n \(Common.convertCurrency(value: item.HanMucConLai))", value: CGFloat(item.HanMucConLai))
        let s2 = Segment.init(color: UIColor(netHex: 0xF6313F), name: "Đã bán \n \(Common.convertCurrency(value: item.HanMuc))", value: CGFloat(item.HanMuc))
        pieView.segments.append(s1)
        pieView.segments.append(s2)

        for i in pieView.segments {

            let topSpace:CGFloat = Common.Size(s: 15)

            let rec = UIView(frame: CGRect(x: Common.Size(s: 15), y: pieView.frame.origin.y + pieView.frame.height + Common.Size(s: 20) + ((indexSegment - 1) * topSpace), width:Common.Size(s: 15) , height: Common.Size(s: 15)))
            rec.backgroundColor = i.color
            scrollView.addSubview(rec)

            let lblDiscription = UILabel(frame: CGRect(x: rec.frame.origin.x + rec.frame.width + Common.Size(s: 10), y: rec.frame.origin.y, width: self.view.frame.width - Common.Size(s: 30) , height: Common.Size(s: 20)))
            lblDiscription.text = "\(i.name.replace(target: "\n", withString: ":"))"
            lblDiscription.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1)
            lblDiscription.font = UIFont.systemFont(ofSize: 13)
            scrollView.addSubview(lblDiscription)
            indexSegment = indexSegment + 1
        }

        //----
        let attributedText = NSMutableAttributedString(string: "Bạn vui lòng nộp quỹ trước ngày ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: "\(item.NgayHetHan)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.red]))

        attributedText.append(NSAttributedString(string: "để gia hạn hạn mức!", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.black]))

        let lblNopQuy = UILabel(frame: CGRect(x: Common.Size(s: 15), y: pieView.frame.origin.y + pieView.frame.height +  Common.Size(s: 10) + (indexSegment * Common.Size(s: 30)), width: self.view.frame.width - Common.Size(s: 30) , height: Common.Size(s: 60)))
        lblNopQuy.font = UIFont.systemFont(ofSize: 13)
        lblNopQuy.textAlignment = .center
        scrollView.addSubview(lblNopQuy)
        lblNopQuy.numberOfLines = 0
        lblNopQuy.attributedText = attributedText

        scrollViewHeight = lblNopQuy.frame.origin.y + lblNopQuy.frame.height + Common.Size(s: 40)
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollViewHeight)
    }
    
    @objc func showListHistory() {
        debugPrint("showListHistory BHoutside")
        let historyBHOutsideVC = HistoryBanHangOutsideViewController()
        self.navigationController?.pushViewController(historyBHOutsideVC, animated: true)
    }
}


struct Segment {
    
    var color : UIColor
    var name : String
    var value : CGFloat
}

class PieChartView: UIView {
    
    /// An array of structs representing the segments of the pie chart
    
    var segments = [Segment]() {
        didSet { setNeedsDisplay() } // re-draw view when the values get set
    }
    
    /// Defines whether the segment labels should be shown when drawing the pie chart
    var showSegmentLabels = true {
        didSet { setNeedsDisplay() }
    }
    
    /// Defines whether the segment labels will show the value of the segment in brackets
    var showSegmentValueInLabel = false {
        didSet { setNeedsDisplay() }
    }
    
    /// The font to be used on the segment labels
    var segmentLabelFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            textAttributes[NSAttributedString.Key.font] = segmentLabelFont
            setNeedsDisplay()
        }
    }
    
    private let paragraphStyle : NSParagraphStyle = {
        var p = NSMutableParagraphStyle()
        p.alignment = .center
        return p.copy() as! NSParagraphStyle
    }()
    
    private lazy var textAttributes : [NSAttributedString.Key : Any] = {
        return [NSAttributedString.Key.paragraphStyle : self.paragraphStyle, NSAttributedString.Key.font : self.segmentLabelFont]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false // when overriding drawRect, you must specify this to maintain transparency.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        // get current context
        let ctx = UIGraphicsGetCurrentContext()
        
        // radius is the half the frame's width or height (whichever is smallest)
        let radius = min(frame.width, frame.height) * 0.5
        
        // center of the view
        let viewCenter = CGPoint(x: bounds.size.width * 0.5, y: bounds.size.height * 0.5)
        
        // enumerate the total value of the segments by using reduce to sum them
        let valueCount = segments.reduce(0, {($0 + $1.value)})
        // the starting angle is -90 degrees (top of the circle, as the context is flipped). By default, 0 is the right hand side of the circle, with the positive angle being in an anti-clockwise direction (same as a unit circle in maths).
        var startAngle = -CGFloat.pi * 0.5
        
        // loop through the values array
        for segment in segments {
            
            // set fill color to the segment color
            ctx?.setFillColor(segment.color.cgColor)
            
            // update the end angle of the segment
            let endAngle = startAngle + .pi * 2 * (segment.value / valueCount)
            
            // move to the center of the pie chart
            ctx?.move(to: viewCenter)
            
            // add arc from the center for each segment (anticlockwise is specified for the arc, but as the view flips the context, it will produce a clockwise arc)
            ctx?.addArc(center: viewCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
            
            // fill segment
            ctx?.fillPath()
            
            // ctx?.setStrokeColor(UIColor.white.cgColor)
            
            // ctx?.strokePath()
            
            
            if showSegmentLabels { // do text rendering
                
                // get the angle midpoint
                let halfAngle = startAngle + (endAngle - startAngle) * 0.5;
                
                // the ratio of how far away from the center of the pie chart the text will appear
                let textPositionValue : CGFloat = 0.65
                
                // get the 'center' of the segment. It's slightly biased to the outer edge, as it's wider.
                let segmentCenter = CGPoint(x: viewCenter.x + radius * textPositionValue * cos(halfAngle), y: viewCenter.y + radius * textPositionValue * sin(halfAngle))
                
                // text to render – the segment value is formatted to 1dp if needed to be displayed.
                
                // Previous
                //let textToRender = showSegmentValueInLabel ? "\(segment.name) \(segment.value.formattedToOneDecimalPlace))" : segment.name
                
                // Change
                let textToRender = showSegmentValueInLabel ? "\(segment.value)" : segment.name
                
                // get the color components of the segement color
                guard let colorComponents = segment.color.cgColor.components else { return }
                
                // get the average brightness of the color
                let averageRGB = (colorComponents[0] + colorComponents[1] + colorComponents[2]) / 3
                
                // if too light, use black. If too dark, use white
                textAttributes[NSAttributedString.Key.foregroundColor] = (averageRGB > 0.7) ? UIColor.black : UIColor.white
                
                // the bounds that the text will occupy
                var renderRect = CGRect(origin: .zero, size: textToRender.size(withAttributes: textAttributes))
                
                // center the origin of the rect
                renderRect.origin = CGPoint(x: segmentCenter.x - renderRect.size.width * 0.5, y: segmentCenter.y - renderRect.size.height * 0.5)
                
                // draw text in the rect, with the given attributes
                textToRender.draw(in: renderRect, withAttributes: textAttributes)
            }
            
            // update starting angle of the next segment to the ending angle of this segment
            startAngle = endAngle
        }
    }
}

