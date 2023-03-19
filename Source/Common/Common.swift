//
//  Common.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 10/12/18.
//  Copyright © 2018 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration;
import SwiftyJSON;
import CoreImage
import CoreTelephony
import Moya
import WebKit
import SystemConfiguration
//this class check user activity
public class GlobalData{
    public static var shared = GlobalData()
    public var nameOfVC = ""
}
enum NetworkResponse:String {
    case success
    case authenticationError = "Bạn cần đăng nhập lại tài khoản, token hết hiệu lực"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum MyCustomResult<String>{
    case success
    case failure(String)
}

postfix operator &

postfix func & <T>(element: T?) -> String {
    return (element == nil) ? "" : "\(element!)"
}

postfix func & <T>(element: T) -> String {
    return "\(element)"
}

class Common {
    static let shared = Common()
    static let PrefixUploadImage = ""
    static let heightWidthCLV = (UIScreen.main.bounds.width / 2) - 8
    var screenGroup: String = ""
    //fix showing smaller content when converting from UIWebView to WKWebView
    let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
    

    
    class func getCurrentTime()->String{
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    class func gettimeWith(format: String) -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: currentDateTime)
    }
    
    class func toDate(str: String,fromDateFormat: String = "dd/MM/yyyy") -> Date? {
        let initalFormatter = DateFormatter()
        initalFormatter.dateFormat = fromDateFormat

        guard let initialDate = initalFormatter.date(from: str) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }
        return initialDate
    }
    
    class func handleNetworkResponse(_ response: Moya.Response) -> MyCustomResult<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401: return .failure(NetworkResponse.authenticationError.rawValue)
        case 402: return .failure("Cần hoàn thành thanh toán")
        case 403: return .failure("Bạn không có quyền truy cập vào mục này")
        case 404: return .failure("Không tìm thấy file")
        case 500: return .failure("Lỗi server")
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    static let skuKHTT:String = "00001891"
    class func FormatMoney(cost: Int) -> String?
    {
        let costt = NumberFormatter.localizedString(from: NSNumber(value: cost), number: NumberFormatter.Style.decimal)
        
        return costt
        
    }
    
    static  let resizeImageWith: CGFloat = 800
    static  let resizeImageValue: CGFloat = 0.2
    static  let resizeImageValueFF: CGFloat = 0.7
    static  let resizeImageScanCMND: CGFloat = 0.2
    static let standardFontSize:CGFloat = Common.Size(s: 15)
    static let standardWidth:CGFloat = UIScreen.main.bounds.width - Common.Size(s: 30)
    static let standardHeight: CGFloat = Common.Size(s: 40)
    static let standardHeightLabel: CGFloat = Common.Size(s: 14)
    static let standardPaddingLeft: CGFloat = Common.Size(s: 15)
    static let standardPaddingTop: CGFloat = Common.Size(s: 10)
    class func Size(s: CGFloat) -> CGFloat {
        let rs : CGFloat = UIScreen.main.bounds.size.width / ( 320 / s )
        return rs
    }
    
    class func myCustomVersionApp() -> String? {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return "\(version)"
        }
        return nil
    }
    class func versionApp() ->String{
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            //            let manager = Config.manager
            #if DEBUG
            //            return "\(version).\(buildVersionNumber()) \(manager.version!)"
            return "\(version)"
            #else
            return "\(version)"
            #endif
        }else{
            return "Version Error"
        }
    }
    class func encodeURLImg(urlString: String, imgView: UIImageView) {
        let allowedCharacterSet = (CharacterSet(charactersIn: "!*'();@&=+$,?%#[] `").inverted)
        if let escapedString = "\(urlString)".addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) {
            print("escapedString: \(escapedString)")
            if let url = URL(string: "\(escapedString)") {
                imgView.kf.setImage(with: url,
                                    placeholder: nil,
                                    options: [.transition(.fade(1))],
                                    progressBlock: nil,
                                    completionHandler: nil)
            } else {
                imgView.image = #imageLiteral(resourceName: "UploadImage")
            }
        } else {
            imgView.image = #imageLiteral(resourceName: "UploadImage")
        }
    }
    class func buildVersionNumber() ->String{
        if let version = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return "\(version)"
        }else{
            return "Version Error"
        }
    }
    class func convertCurrencyFloat(value:Float)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)đ"
    }
    class func convertCurrencyV2(value:Int)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)"
    }
    class func convertCurrencyFloatV2(value:Float)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)"
    }
    class func convertCurrencyDoubleV2(value:Double)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)"
    }
    class func convertCurrencyDouble(value: Double) -> String{
        let fmt = NumberFormatter();
        fmt.locale = Locale(identifier: "vi_VN");
        fmt.groupingSeparator = ",";
        fmt.groupingSize = 3;
        fmt.decimalSeparator = "."
        fmt.numberStyle = .decimal
        fmt.usesGroupingSeparator = true;
        fmt.minimumFractionDigits = 0;
        fmt.maximumFractionDigits = 2;
        fmt.numberStyle = NumberFormatter.Style.currencyAccounting;
        return "\(fmt.string(for: value)!.replace("₫", withString: ""))".replace(".", withString: ",");
    }
    class func convertCurrencyInteger(value: Int) -> String{
        let fmt = NumberFormatter()
        fmt.locale = Locale(identifier: "vi_VN");
        fmt.groupingSeparator = ",";
        fmt.groupingSize = 3;
        fmt.usesGroupingSeparator = true;
        fmt.numberStyle = NumberFormatter.Style.currencyAccounting;
        return "\(fmt.string(for: value)!.replace("₫", withString: ""))".replace(".", withString: ",");
    }
    class func convertCurrencyFloat(number: Float) -> String{
        let fmt = NumberFormatter()
        fmt.locale = Locale(identifier: "vi_VN");
        fmt.groupingSeparator = ",";
        fmt.groupingSize = 3;
        fmt.decimalSeparator = "."
        fmt.numberStyle = .decimal
        fmt.usesGroupingSeparator = true;
        fmt.minimumFractionDigits = 0;
        fmt.maximumFractionDigits = 2;
        fmt.numberStyle = NumberFormatter.Style.currencyAccounting;
        return "\(fmt.string(for: number)!.replace("₫", withString: ""))".replace(".", withString: ",");
    }
    class func convertCurrency(value:Int)->String{
        let fmt = NumberFormatter()
        fmt.numberStyle = NumberFormatter.Style.decimal
        return "\(fmt.string(for: value)!)đ"
    }
    
    public static func GetDateStringFrom(jsonStr: String) -> String{
        let dateTemp: Date = Date(jsonDate: jsonStr)!;
        let formatter = DateFormatter();
        formatter.locale = Locale(identifier: "en_US_POSIX");
        formatter.timeZone = TimeZone(identifier: "UTC");
        formatter.dateFormat = "dd/MM/yyyy - HH:mm";
        
        let formattedTimeString = formatter.string(from: dateTemp);
        
        return formattedTimeString;
    }
    
    public static func GetDateStringFromV3(jsonStr: String) -> String{
        let dateTemp: Date = Date(jsonDate: jsonStr) ?? Date()
        let formatter = DateFormatter();
        formatter.locale = Locale(identifier: "en_US_POSIX");
        formatter.timeZone = TimeZone(identifier: "UTC");
        formatter.dateFormat = "dd/MM/yyyy - HH:mm:ss";
        
        let formattedTimeString = formatter.string(from: dateTemp);
        
        return formattedTimeString;
    }
    
    public static func convertDateToStringWith(dateString: String, formatIn : String, formatOut : String) -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = formatIn
        guard let date = dateFormater.date(from: dateString) else {return ""}
        
        dateFormater.dateFormat = formatOut
        let timeStr = dateFormater.string(from: date)
        return timeStr
    }
    
    public static func GetDateStringFromV2(jsonStr: String) -> String{
        let dateTemp: Date = Date(jsonDate: jsonStr)!;
        let formatter = DateFormatter();
        formatter.locale = Locale(identifier: "en_US_POSIX");
        formatter.timeZone = TimeZone(identifier: "UTC");
        formatter.dateFormat = "dd/MM/yyyy";
        
        let formattedTimeString = formatter.string(from: dateTemp);
        
        return formattedTimeString;
    }
    
    public static func GetFormattedCallLogDescription(rawStr: String) -> String{
        let formatedDescription = rawStr.condenseWhitespace().replace("<p>", withString: "").replace("</p>", withString: "\n").replace("@@", withString:"\n");
        
        return formatedDescription
    }
    class func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
                                                         attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key : Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
    class func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    class func imageLayerForGradientBackground(searchBar:UISearchBar) -> UIImage {
        
        var updatedFrame = searchBar.bounds
        // take into account the status bar
        updatedFrame.size.height += 20
        let layer = CAGradientLayer.gradientLayerForBounds2(bounds: updatedFrame)
        layer.startPoint = CGPoint(x:0.0,y:0.5)
        layer.endPoint = CGPoint(x:1.0,y: 0.5)
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func getTelephoneName() -> String {
        let info = CTTelephonyNetworkInfo()
        if let carrier = info.serviceSubscriberCellularProviders?.first?.value {
            if let code = carrier.mobileNetworkCode {
                if !code.isEmpty {
                    let carrierName = carrier.carrierName
                    debugPrint("carrierName: \(carrierName ?? "")")
                    return carrierName ?? ""
                } else {
                    debugPrint("NO SIM")
                }
            }
        }
        return ""
    }
    
    class func isUrlImage(urlString: String) -> Bool {
        if (urlString.contains(find: ".jpg")) || (urlString.contains(find: ".png")) || (urlString.contains(find: ".jpeg")) {
            return true
        } else {
            return false
        }
    }
    class func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    class func rotateCameraImageToProperOrientation(imageSource : UIImage, maxResolution : CGFloat) -> UIImage? {
        guard let imgRef = imageSource.cgImage else {
            return nil
        }
        
        let width = CGFloat(imgRef.width)
        let height = CGFloat(imgRef.height)
        var bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        var scaleRatio : CGFloat = 1
        if (width > maxResolution || height > maxResolution) {
            scaleRatio = min(maxResolution / bounds.size.width, maxResolution / bounds.size.height)
            bounds.size.height = bounds.size.height * scaleRatio
            bounds.size.width = bounds.size.width * scaleRatio
        }
        
        var transform = CGAffineTransform.identity
        let orient = imageSource.imageOrientation
        let imageSize = CGSize(width: CGFloat(imgRef.width), height: CGFloat(imgRef.height))
        
        switch(imageSource.imageOrientation) {
        case .up:
            transform = .identity
        case .upMirrored:
            transform = CGAffineTransform
                .init(translationX: imageSize.width, y: 0)
                .scaledBy(x: -1.0, y: 1.0)
        case .down:
            transform = CGAffineTransform
                .init(translationX: imageSize.width, y: imageSize.height)
                .rotated(by: CGFloat.pi)
        case .downMirrored:
            transform = CGAffineTransform
                .init(translationX: 0, y: imageSize.height)
                .scaledBy(x: 1.0, y: -1.0)
        case .left:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(translationX: 0, y: imageSize.width)
                .rotated(by: 3.0 * CGFloat.pi / 2.0)
        case .leftMirrored:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(translationX: imageSize.height, y: imageSize.width)
                .scaledBy(x: -1.0, y: 1.0)
                .rotated(by: 3.0 * CGFloat.pi / 2.0)
        case .right :
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(translationX: imageSize.height, y: 0)
                .rotated(by: CGFloat.pi / 2.0)
        case .rightMirrored:
            let storedHeight = bounds.size.height
            bounds.size.height = bounds.size.width;
            bounds.size.width = storedHeight;
            transform = CGAffineTransform
                .init(scaleX: -1.0, y: 1.0)
                .rotated(by: CGFloat.pi / 2.0)
        @unknown default:
            fatalError("rotate")
        }
        
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            if orient == .right || orient == .left {
                context.scaleBy(x: -scaleRatio, y: scaleRatio)
                context.translateBy(x: -height, y: 0)
            } else {
                context.scaleBy(x: scaleRatio, y: -scaleRatio)
                context.translateBy(x: 0, y: -height)
            }
            
            context.concatenate(transform)
            context.draw(imgRef, in: CGRect(x: 0, y: 0, width: width, height: height))
        }
        
        let imageCopy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return imageCopy
    }
    // base container - Do not Edit
    class func tileLabel(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,title:String,fontSize:CGFloat = Common.Size(s: 12),isBoldStyle:Bool = false) -> UILabel{
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        label.textAlignment = .left
        label.textColor = UIColor.black
        if isBoldStyle{
            label.font = UIFont.boldSystemFont(ofSize: fontSize)
        }else{
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
        
        label.text = title
        
        return label
    }
    class func inputTextTextField(x:CGFloat,y:CGFloat,width:CGFloat,height:CGFloat,placeholder:String = "",fontSize:CGFloat,isNumber:Bool = false) -> UITextField {
        let textField = UITextField(frame: CGRect(x: x, y: y, width: width , height: height));
        textField.placeholder = placeholder
        textField.font = UIFont.systemFont(ofSize: fontSize)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        if isNumber{
            textField.keyboardType = UIKeyboardType.numberPad
        }else{
            textField.keyboardType = UIKeyboardType.default
        }
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        return textField
    }
    class func inputSearchTextField(x:CGFloat,y:CGFloat,width:CGFloat,height: CGFloat,isNumber:Bool = false) -> SearchTextField{
        
        let textField = SearchTextField(frame: CGRect(x: x, y: y, width: width , height: height ))
        
        textField.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        
        // Start visible - Default: false
        textField.startVisible = true
        textField.theme.bgColor = UIColor.white
        textField.theme.fontColor = UIColor.black
        textField.theme.font = UIFont.systemFont(ofSize: Common.Size(s:15))
        textField.theme.cellHeight = Common.Size(s:40)
        textField.highlightAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow, NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: Common.Size(s:15))]
        textField.leftViewMode = UITextField.ViewMode.always
        
        
        
        return textField
    }
    class func buttonAction(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat,title:String) -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: x, y: y, width: width,height: height)
        button.backgroundColor = UIColor(netHex:0x00955E)
        button.setTitle(title, for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 3
        
        button.clipsToBounds = true
        return button
    }
    class func initBackButton()->UIButton{
        let btLeftIcon = UIButton.init(type: .custom)
        btLeftIcon.setImage(#imageLiteral(resourceName: "back"),for: UIControl.State.normal)
        btLeftIcon.imageView?.contentMode = .scaleAspectFit
        btLeftIcon.frame = CGRect(x: 0, y: 0, width: 53/2, height: 51/2)
        return btLeftIcon
    }
    class func configurationWKWebView() -> WKWebViewConfiguration {
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width, initial-scale=1.0, shrink-to-fit=yes'); document.getElementsByTagName('head')[0].appendChild(meta);"
        
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        let wkUController = WKUserContentController()
        
        wkUController.addUserScript(userScript)
        
        let wkWebConfig = WKWebViewConfiguration()
        
        wkWebConfig.userContentController = wkUController
        return wkWebConfig
    }
    class func convertDateISO8601(dateString: String) -> String {
        debugPrint("date = \(dateString)")
        if !(dateString.isEmpty) {
            let dateStrOld = dateString
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
            let date2 = formatter.date(from: dateStrOld)
            
            let newFormatter = DateFormatter()
            newFormatter.locale = Locale(identifier: "vi_VN");
            //            newFormatter.timeZone = TimeZone(identifier: "UTC");
            newFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
            let str = newFormatter.string(from: date2 ?? Date())
            return str
        } else {
            return dateString
        }
    }
    class func btnWithImage(image: UIImage, title: String, color: UIColor,cgRect: CGRect) -> UIView
    {
        let btnCancel = UIView(frame: cgRect)
        btnCancel.backgroundColor = color
        btnCancel.layer.cornerRadius = 10
        let icBtn = UIImageView(frame: CGRect(x: btnCancel.frame.size.height/4, y: btnCancel.frame.size.height/4, width: btnCancel.frame.size.height/2, height: btnCancel.frame.size.height/2))
        icBtn.image = image
        icBtn.contentMode = .scaleAspectFit
        icBtn.tintColor = .white
        btnCancel.addSubview(icBtn)
        
        let lbBtn = UILabel(frame: CGRect(x: icBtn.frame.size.width
                                            + icBtn.frame.origin.x, y: 0, width: btnCancel.frame.size.width - (icBtn.frame.size.width + icBtn.frame.origin.x + btnCancel.frame.size.height/4), height: btnCancel.frame.size.height))
        lbBtn.textAlignment = .center
        lbBtn.textColor = UIColor.white
        lbBtn.font = UIFont.systemFont(ofSize: Common.Size(s:14))
        lbBtn.text = title
        btnCancel.addSubview(lbBtn)
        return btnCancel
    }
    static func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }

}
extension Date {
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            return "\(diff) giây"
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\(diff) phút"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\(diff) giờ"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff) ngày"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        //        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        return "\(dateFormatter.string(from: self))"
    }
    
    func getDayOfWeek() -> Int {
        
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: self)
        return weekDay
    }
}
extension String {
    func contains(_ string: String, caseSensitive: Bool = true) -> Bool {
        if !caseSensitive {
            return range(of: string, options: .caseInsensitive) != nil
        }
        return range(of: string) != nil
    }
    
    func myCustomContains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func convertDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        if let dateInLocal = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            return dateFormatter.string(from: dateInLocal)
        }
        return "NA"
    }
    func maxLength(length: Int) -> String {
        var str = self
        let nsString = str as NSString
        if nsString.length >= length {
            str = nsString.substring(with:
                                        NSRange(
                                            location: 0,
                                            length: nsString.length > length ? length : nsString.length)
            )
        }
        return  str
    }

	func chopPrefix(_ count: Int = 1) -> String {
		return substring(from: index(startIndex, offsetBy: count))
	}
}
extension String {
    func convertDate2() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        if let dateInLocal = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return dateFormatter.string(from: dateInLocal)
        }
        return "NA"
    }
    func convertDateEbay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

        if let dateInLocal = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: dateInLocal)
        }
        return "NA"
    }

}

extension Int {
    func getDayOfWeekString() -> String {
        switch self {
        case 1:
            return "Chủ Nhật"
        case 2:
            return "Thứ Hai"
        case 3:
            return "Thứ Ba"
        case 4:
            return "Thứ Tư"
        case 5:
            return "Thứ Năm"
        case 6:
            return "Thứ Sáu"
        case 7:
            return "Thứ Bảy"
        default:
            return ""
        }
    }
}

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: Common.Size(s:11))]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}
extension UIColor {
    static let mainGreen = UIColor(netHex:0x00955E)
    static let mainGray = UIColor(netHex: 0xEEEEEE)
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >>    8) & 0xff, blue:netHex & 0xff)
    }
}
extension UIButton{
    
    func setImage(image: UIImage?, inFrame frame: CGRect?, forState state: UIControl.State){
        self.setImage(image, for: state)
        self.imageEdgeInsets = UIEdgeInsets(top: self.frame.size.height/2 - (frame?.size
                                                                                .height)!/2, left: -Common.Size(s: 5), bottom: self.frame.size.height/2 - (frame?.size.height)!/2,right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -Common.Size(s: 2), bottom: 0,right: 0)
    }
    
}
extension String {
    
    var length: Int {
        return self.count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func convertStringToDictionary() -> [String:Any]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
}
extension UIButton {
    func backgroundGradient() {
        let updatedFrame = self.bounds
        let layer = CAGradientLayer.gradientLayerForBounds(bounds: updatedFrame)
        layer.startPoint = CGPoint(x:0.25,y:0.25)
        layer.endPoint = CGPoint(x:1,y: 1)
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(image, for: .normal)
    }
}

extension String{
    func replace(_ target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}

extension UIImageView {
    func getImg(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    func getImg(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        getImg(from: url, contentMode: mode)
    }
}
extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    func removeSubviews() {
        subviews.forEach({ $0.removeFromSuperview() })
    }
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(inView view: UIView, yConstant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant!).isActive = true
    }
    
    func centerX(inView view: UIView, topAnchor: NSLayoutYAxisAnchor? = nil, paddingTop: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if let topAnchor = topAnchor {
            self.topAnchor.constraint(equalTo: topAnchor, constant: paddingTop!).isActive = true
        }
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil, paddingLeft: CGFloat? = nil, constant: CGFloat? = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant!).isActive = true
        
        if let leftAnchor = leftAnchor, let padding = paddingLeft {
            self.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        }
    }
    
    func setDimensions(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func addConstraintsToFillView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: view.topAnchor, left: view.leftAnchor,
               bottom: view.bottomAnchor, right: view.rightAnchor)
    }
    
    public class var nibName: String {
        let name = "\(self)".components(separatedBy: ".").first ?? ""
        return name
    }
    
    public class var nib: UINib? {
        if let _ = Bundle.main.path(forResource: nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
    
    static var className: String {
        return String(describing: self)
    }
    
    static var identifier: String {
        return self.className
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }

}

extension CAGradientLayer {
    class func gradientLayerForBounds(bounds: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = [UIColor(netHex:0x069C90).cgColor, UIColor(netHex:0x28F698).cgColor]
        layer.cornerRadius = 20
        return layer
    }
    class func gradientLayerForBounds2(bounds: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = [UIColor(netHex:0x00955E).cgColor, UIColor(netHex:0x00955E).cgColor]
        return layer
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func initNavigationBar(){
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor =  UIColor(netHex:0x00955E)
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.standardAppearance = appearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        }else{
            self.navigationController?.navigationBar.setBackgroundImage(imageLayerForGradientBackground(navigationBar: (self.navigationController?.navigationBar)!), for: UIBarMetrics.default)
        }
    }
    
    func imageLayerForGradientBackground(navigationBar:UINavigationBar) -> UIImage {
        var updatedFrame = navigationBar.bounds
        // take into account the status bar
        updatedFrame.size.height += 20
        let layer = CAGradientLayer.gradientLayerForBounds2(bounds: updatedFrame)
        layer.startPoint = CGPoint(x:0.0,y:0.5)
        layer.endPoint = CGPoint(x:1.0,y: 0.5)
        UIGraphicsBeginImageContext(layer.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func addBackButton(_ selector: Selector? = nil) {
        let viewLeftNav = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 30, height: 50)))
        self.navigationItem.leftBarButtonItem  = UIBarButtonItem(customView: viewLeftNav)
        let btBackIcon = UIButton.init(type: .custom)
        btBackIcon.setImage(#imageLiteral(resourceName: "back"), for: UIControl.State.normal)
        btBackIcon.imageView?.contentMode = .scaleAspectFit
        btBackIcon.addTarget(self, action: selector == nil ? #selector(backButtonPressed) : selector!, for: UIControl.Event.touchUpInside)
        btBackIcon.frame = CGRect(x: -15, y: 0, width: 50, height: 45)
        viewLeftNav.addSubview(btBackIcon)
    }
    
    @objc func backButtonPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension UITableView {
    func registerTableCell<T: UITableViewCell>(_: T.Type, fromNib: Bool = true) {
        if fromNib {
            self.register( T.nib, forCellReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.identifier)
        }
    }
    
    func dequeueTableCell<T: UITableViewCell>(_: T.Type) -> T {
        let cell = self.dequeueReusableCell(withIdentifier: T.identifier)
        
        return cell as! T
    }
}

extension String {
    func floatValue() -> Float? {
        if let floatval = Float(self) {
            return floatval
        }
        return nil
    }
}
extension String
{
    func trim() -> String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
}
let     htmlReplaceString   :   String  =   "<[^>]+>"
extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.height
    }
    var hexColor: UIColor {
        let hex = trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return .clear
        }
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    func stripHTML() -> String {
        return self.replacingOccurrences(of: htmlReplaceString, with: "", options: NSString.CompareOptions.regularExpression, range: nil)
    }
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    /// Encode a String to Base64
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    /// Decode a String from Base64. Returns nil if unsuccessful.
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
extension Float
{
    var cleanValue: String
    {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
extension Date {
    init?(jsonDate: String) {
        
        let pattern = "\\\\?/Date\\((\\d+)(([+-]\\d{2})(\\d{2}))?\\)\\\\?/"
        let regex = try! NSRegularExpression(pattern: pattern)
        guard let match = regex.firstMatch(in: jsonDate, range: NSRange(location: 0, length: jsonDate.utf16.count)) else {
            return nil
        }
        
        // Extract milliseconds:
        let dateString = (jsonDate as NSString).substring(with: match.range(at: 1))
        // Convert to UNIX timestamp in seconds:
        let timeStamp = Double(dateString)! / 1000.0
        // Create Date from timestamp:
        self.init(timeIntervalSince1970: timeStamp)
    }
}
// extension check internet connection
protocol Utilities {
}
extension NSObject:Utilities{
    
    
    enum ReachabilityStatus {
        case notReachable
        case reachableViaWWAN
        case reachableViaWiFi
    }
    
    var isConntectStatus: ReachabilityStatus {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return .notReachable
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return .notReachable
        }
        
        if flags.contains(.reachable) == false {
            // The target host is not reachable.
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            // WWAN connections are OK if the calling application is using the CFNetwork APIs.
            return .reachableViaWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
            return .reachableViaWiFi
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
            return .reachableViaWiFi
        }
        else {
            return .notReachable
        }
    }
    
}
extension String {
    var htmlToAttributedString: NSAttributedString? {
        let style = "<style>body { font-size:\(15)px; }</style>"
        guard let data = (self + style).data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
}
extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

//JSON model mapping
extension JSON{
    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? Jsonable.Type {
            if self.type == .array {
                var arrObject: [Any] = []
                for obj in self.arrayValue {
                    let object = baseObj.init(json: obj)
                    arrObject.append(object!)
                }
                return arrObject
            } else {
                let object = baseObj.init(json: self)
                return object!
            }
        }
        return nil
        
    }
    
}
extension String {
    //    func dropLast(_ n: Int = 1) -> String {
    //        return String(characters.dropLast(n))
    //    }
    var dropLast: String {
        return String(dropLast())
    }
    func toDate(withFormat format: String = "dd/MM/yyyy") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSZ"
            if let date = dateFormatter.date(from: self) {
                return date
            } else {
                return Date()
            }
        }
    }
}

extension Float {
    
    func round() -> Int {
        let divisor = pow(10, Float(0))
        return Int(Darwin.round(self * divisor) / divisor)
    }
}

extension Notification.Name{
    static let dataRetrivedSuccessfully = Notification.Name(rawValue: "dataRetrivedSuccessfully");
}

extension UIAlertController{
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.allButUpsideDown
    }
    open override var shouldAutorotate: Bool {
        return false;
    }
    @objc func canRotate(){}
}

extension UILabel {
    var optimalHeight: CGFloat {
        get {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.font = self.font
            label.text = self.text
            label.sizeToFit()
            return label.frame.height
        }
    }
}

extension String {
    
    func contains(find: String) -> Bool{
        return (self.range(of: "\(find)", options: .caseInsensitive) != nil)
    }
}

extension UIImageView {
    func loadAndResize(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.image?.resized(withPercentage: 0.7)
                    }
                }
            }
        }
    }
}
extension UIImage {
    
    func resized(withPercentage percentage: CGFloat) {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        //        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        
        switch padding {
        
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }

    // add image to textfield
    func withImage(direction: Direction, image: UIImage, padding: CGFloat = 5) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 15))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: imageView.frame.width + padding, height: imageView.frame.height))
        paddingView.addSubview(imageView)

        if(Direction.left == direction) { // image left
            self.leftViewMode = .always
            self.leftView = paddingView
        } else { // image right
            self.rightViewMode = .always
            self.rightView = paddingView
        }
    }
}

class Barcode {
    class func fromString(string : String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    class func fromStringV2(string : String) -> UIImage? {
        let data = string.data(using: String.Encoding.utf8)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
}

extension String {
    func encodeString() -> String {
        return self.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
extension UISearchBar {
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction(){
        self.resignFirstResponder()
    }
    public var textField: UITextField? {
        if #available(iOS 13, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap { $0.subviews }
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    func setRightImage(normalImage: UIImage,
                       highLightedImage: UIImage) {
        showsBookmarkButton = true
        if let btn = textField?.rightView as? UIButton {
            btn.setImage(normalImage,
                         for: .normal)
            btn.setImage(highLightedImage,
                         for: .highlighted)
        }
    }
}

extension UIButton {
    
    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        
        self.layer.addSublayer(border)
    }
}

public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

extension String {
    func isNumber() -> Bool{
        let numberCharacters = NSCharacterSet.decimalDigits.inverted
        if !self.isEmpty && self.rangeOfCharacter(from: numberCharacters) == nil {
            return true
        } else {
            return false
        }
    }
}
extension UITextField {
    func addLeftIconTextfield(img: UIImage) {
        self.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: Common.Size(s: 5), y: self.frame.height/2 - Common.Size(s:10), width: Common.Size(s:20), height: Common.Size(s:20)))
        imageView.image = img
        imageView.contentMode = .scaleAspectFill
        self.leftView = imageView
    }
}

extension UICollectionView {
    func registerCollectionCell<T: UICollectionViewCell>(_: T.Type, fromNib: Bool = true) {
        if fromNib {
            self.register(T.nib, forCellWithReuseIdentifier: T.identifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.identifier)
        }
    }

    func dequeueCollectionCell<T: UICollectionViewCell>(_: T.Type, indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else { return T.init()}

        return cell
    }
}

extension Common {
    struct TraGopMirae {
        struct Padding {
            static let padding:CGFloat = 20
            static let heightButton:CGFloat = 45
            static let heightTextField:CGFloat = 60
        }
        
        struct identifierTableViewCell {
            static let thongTinDonHang:String = "ThongTinDonHangTableViewCell"
            static let kiemTraThongTinKhuyenMai:String = "KiemTraThongTinKhuyenMaiMiraeTableViewCell"
            static let thongTinKhuyenMai:String = "ThongTinKhuyenMaiMiraeTableViewCell"
            static let lichSuTraGop:String = "LichSuTraGopMiraeTableViewCell"
            static let thongSoSanPham:String = "ThongSoSanPhamMiraeTableViewCell"
            static let timKiemDonHang:String = "TimKiemDonHangMireaTableViewCell"
            static let updateHinh:String = "UpdateHinhAnhTableViewCell"
            
        }
        struct identifierCollectionViewCell {
            static let chiTietSanPham:String = "ChiTietSanPhamTraGopMiraeCollectionViewCell"
            static let timKiemSanPham:String = "TimKiemSanPhamMireaCollectionViewCell"
            static let menu:String = ""
        }
        struct Color {
            static let blue:UIColor = UIColor(hexString: "#034EA1")
            static let orange:UIColor = UIColor(hexString: "#F36F20")
            static let green:UIColor = .mainGreen
            static let red:UIColor = UIColor(hexString: "#CD1818")
        }
        
    }
    struct Colors {
        struct CamKet {
            static let green = UIColor(hexString: "#04AB6E")
            static let background = UIColor(hexString: "#F5F5F5")
            static let blue = UIColor(hexString: "#4263EC")
        }
    }
}
