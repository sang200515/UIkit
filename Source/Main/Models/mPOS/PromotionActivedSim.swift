import Foundation
import SwiftyJSON
class PromotionActivedSim:NSObject{
    var Result:Int
    var Message:String
    var ValuePromotion:Int
    var CardValue:Int
    var Price:Int
    
    
    init(Result:Int, Message:String, ValuePromotion:Int, CardValue:Int, Price:Int){
        self.Result = Result
        self.Message = Message
        self.ValuePromotion = ValuePromotion
        self.CardValue = CardValue
        self.Price = Price
    }
    
    class func parseObjfromArray(array:[JSON])->[PromotionActivedSim]{
        var list:[PromotionActivedSim] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item ))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> PromotionActivedSim{
        var Result = data["Result"].int
        var Message = data["Message"].string
        var ValuePromotion = data["ValuePromotion"].int
        var CardValue = data["CardValue"].int
        var Price = data["Price"].int
        
        Result = Result == nil ? 0 : Result
        Message = Message == nil ? "" : Message
        ValuePromotion = ValuePromotion == nil ? 0 : ValuePromotion
        CardValue = CardValue == nil ? 0 : CardValue
        Price = Price == nil ? 0 : Price
        
        return PromotionActivedSim(Result:Result!
            , Message:Message!
            , ValuePromotion:ValuePromotion!
            , CardValue:CardValue!
            , Price:Price!)
    }
    
    
    
}
