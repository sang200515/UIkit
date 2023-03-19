import Foundation
import SwiftyJSON
class ThuMuaMayCuList{
    var Name:String
    var Itemcode:String
    var UrlPicture:String
    
    init(
        Name:String,Itemcode:String,UrlPicture:String){
        self.Name = Name
        self.Itemcode = Itemcode
        self.UrlPicture = UrlPicture
    }
    
    class func parseObjfromArray(array:[JSON])->[ThuMuaMayCuList]{
        var list:[ThuMuaMayCuList] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> ThuMuaMayCuList{
        var Name = data["Name"].string
        var Itemcode = data["Itemcode"].string
        var UrlPicture = data["UrlPicture"].string
        
        Name = Name == nil ? "" : Name
        Itemcode = Itemcode == nil ? "" : Itemcode
        UrlPicture = UrlPicture == nil ? "" : UrlPicture
        return ThuMuaMayCuList(
            Name:Name!,
            Itemcode:Itemcode!,
            UrlPicture:UrlPicture!
        )
    }
}
