import Foundation
import SwiftyJSON
class AllDocumentsMirae:NSObject{
    var ProcessId:String
    var ContractNumber:String
    var IDCard:String
    var FullName:String
    var Status:String
    var StatusCode:String
    var Note:String
    var Highlight:Int
    var isSelect:Bool
    var DateComplete:String
    
    init(
        ProcessId:String,ContractNumber:String,IDCard:String,FullName:String,Status:String,StatusCode:String,Note:String,Highlight:Int,isSelect:Bool,DateComplete:String){
        self.ProcessId = ProcessId
        self.ContractNumber = ContractNumber
        self.IDCard = IDCard
        self.FullName = FullName
        self.Status = Status
        self.StatusCode = StatusCode
        self.Note = Note
        self.Highlight = Highlight
        self.isSelect = isSelect
        self.DateComplete = DateComplete
    }
    
    class func parseObjfromArray(array:[JSON])->[AllDocumentsMirae]{
        var list:[AllDocumentsMirae] = []
        for item in array {
            list.append(self.getObjFromDictionary(data: item))
        }
        return list
    }
    
    class func getObjFromDictionary(data:JSON) -> AllDocumentsMirae{
        var ProcessId = data["ProcessId"].string
        var ContractNumber = data["ContractNumber"].string
        var IDCard = data["IDCard"].string
        var FullName = data["FullName"].string
        var Status = data["Status"].string
        var StatusCode = data["StatusCode"].string
        var Note = data["Note"].string
        var Highlight = data["Highlight"].int
        var DateComplete = data["DateComplete"].string
        
        ProcessId = ProcessId == nil ? "" : ProcessId
        ContractNumber = ContractNumber == nil ? "" : ContractNumber
        IDCard = IDCard == nil ? "" : IDCard
        FullName = FullName == nil ? "" : FullName
        
        Status = Status == nil ? "" : Status
        StatusCode = StatusCode == nil ? "" : StatusCode
        Note = Note == nil ? "" : Note
        Highlight = Highlight == nil ? 0 : Highlight
        DateComplete = DateComplete == nil ? "" : DateComplete
        return AllDocumentsMirae(
            ProcessId:ProcessId!,
            ContractNumber:ContractNumber!,
            IDCard:IDCard!,
            FullName:FullName!,
         Status:Status!,
         StatusCode:StatusCode!,
         Note:Note!,
         Highlight:Highlight!,
         isSelect:false,
         DateComplete:DateComplete!
        )
    }
}
