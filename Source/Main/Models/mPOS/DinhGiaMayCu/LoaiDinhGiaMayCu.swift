import Foundation
import SwiftyJSON
class LoaiDinhGiaMayCu{
    var Code:String
    var Name:String
    
    init(
        Code:String,Name:String){
        self.Code = Code
        self.Name = Name
    }
    
    class func parseObjfromArray(array:[JSON])->[LoaiDinhGiaMayCu]{
        var list:[LoaiDinhGiaMayCu] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> LoaiDinhGiaMayCu{
        var Code = data["Code"].string
        var Name = data["Name"].string
        
        Code = Code == nil ? "" : Code
        Name = Name == nil ? "" : Name
        return LoaiDinhGiaMayCu(
            Code:Code!,
            Name:Name!
        )
    }
}
