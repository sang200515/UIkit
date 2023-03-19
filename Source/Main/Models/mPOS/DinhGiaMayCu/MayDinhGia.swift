import Foundation
import SwiftyJSON
class MayDinhGia{
    var Itemcode:String
    var Name:String
    var GiaHienTai:Float
    var GiaSauThuMua:Float
    var UrlPicture:String
    
    init(
        Itemcode:String,Name:String,GiaHienTai:Float,GiaSauThuMua:Float,UrlPicture:String){
        self.Itemcode = Itemcode
        self.Name = Name
        self.GiaHienTai = GiaHienTai
        self.GiaSauThuMua = GiaSauThuMua
        self.UrlPicture = UrlPicture
    }
    
    class func parseObjfromArray(array:[JSON])->[MayDinhGia]{
        var list:[MayDinhGia] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> MayDinhGia{
        var Itemcode = data["Itemcode"].string
        var Name = data["Name"].string
        var GiaHienTai = data["GiaHienTai"].float
        var GiaSauThuMua = data["GiaSauThuMua"].float
        var UrlPicture = data["UrlPicture"].string
        
        Itemcode = Itemcode == nil ? "" : Itemcode
        Name = Name == nil ? "" : Name
        GiaHienTai = GiaHienTai == nil ? 0 : GiaHienTai
        GiaSauThuMua = GiaSauThuMua == nil ? 0 : GiaSauThuMua
        UrlPicture = UrlPicture == nil ? "" : UrlPicture
        return MayDinhGia(
            Itemcode:Itemcode!,
            Name:Name!,
            GiaHienTai:GiaHienTai!,
            GiaSauThuMua:GiaSauThuMua!,
            UrlPicture:UrlPicture!
        )
    }
}
