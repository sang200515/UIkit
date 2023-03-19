//
//  ShinhanModels.swift
//  fptshop
//
//  Created by Ngoc Bao on 11/02/2022.
//  Copyright © 2022 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
import ObjectMapper

//MARK: cmnd mat truoc
class ShinhanFontBase: Mappable {
    var success : Bool?
    var data : [ShinhanFontDetail] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        data <- map["Data"]
    }
    
}

class ShinhanFontDetail : Mappable {
    var cMND : String?
    var fullName : String?
    var birthday : String?
    var gender : Int?
    var address : String?
    var dateCreateCMND : String?
    var palaceCreateCMND : String?
    var provinceCode : String?
    var districtCode : String?
    var precinctCode : String?
    var street : String?
    var home : String?
    var firstName : String?
    var lastName : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        cMND <- map["CMND"]
        fullName <- map["FullName"]
        birthday <- map["Birthday"]
        gender <- map["Gender"]
        address <- map["Address"]
        dateCreateCMND <- map["DateCreateCMND"]
        palaceCreateCMND <- map["PalaceCreateCMND"]
        provinceCode <- map["ProvinceCode"]
        districtCode <- map["DistrictCode"]
        precinctCode <- map["PrecinctCode"]
        street <- map["Street"]
        home <- map["Home"]
        firstName <- map["FirstName"]
        lastName <- map["LastName"]
    }
    
}
//MARK: mat sau

class ShinhanBehindBase : Mappable {
    var success : Bool?
    var data : [ShinhanBehindDetail] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        data <- map["Data"]
    }
    
}


class ShinhanBehindDetail : Mappable {
    var ethnicity : String?
    var religion : String?
    var issue_date : String?
    var issue_loc : String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        ethnicity <- map["ethnicity"]
        religion <- map["religion"]
        issue_date <- map["issue_date"]
        issue_loc <- map["issue_loc"]
    }
    
}


//MARK: info before create

class ShinhanBeforeCreateBase : Mappable {
    var success : Bool = false
    var message : String = ""
    var data:ShinhanExistingApp?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
    
}

class ShinhanMasterData : Mappable {
    var city : [ShinhanCity] = []
    var paymentDate : [ShinhanPaymentDate] = []
    var relationship : [ShinhanRelationship] = []
    var document : [ShinhanDocument] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        city <- map["City"]
        paymentDate <- map["PaymentDate"]
        relationship <- map["Relationship"]
        document <- map["Document"]
    }
    
    var listCityStr: [String] {
        return city.map({$0.value ?? ""})
    }
    
    var listRelationShipStr: [String] {
        return relationship.map({$0.value ?? ""})
    }
    
    var listPaymentDate: [String] {
        return paymentDate.map({$0.paymentDate})
    }
    
}

class ShinhanCity : Mappable {
    var id : String?
    var value : String?
    
    init(id: String, value: String) {
        self.id = id
        self.value = value
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["Id"]
        value <- map["Value"]
    }
    
}

class ShinhanPaymentDate : Mappable {
    var paymentDate : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        paymentDate <- map["paymentDate"]
    }
    
}

class ShinhanRelationship : Mappable {
    var id : String?
    var value : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        id <- map["Id"]
        value <- map["Value"]
    }
    
}

class ShinhanDocument : Mappable {
    var fileType : String?
    var docType : String?
    var description : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        fileType <- map["FileType"]
        docType <- map["DocType"]
        description <- map["Description"]
    }
    
}


class ShinhanExistingApp : Mappable {
    var InternalCode : String?
    var personalLoan : ShinhanPersonalLoan?
    var permanentAddress : ShinhanPermanentAddress?
    var residenceAddress : ShinhanResidenceAddress?
    var refPerson1 : ShinhanRefPerson?
    var refPerson2 : ShinhanRefPerson?
    var workInfo : ShinhanWorkInfo?
    
    
    init(personal: ShinhanPersonalLoan,permanentAddress: ShinhanPermanentAddress,residenceAddress: ShinhanResidenceAddress,refPerson1:ShinhanRefPerson,refPerson2 : ShinhanRefPerson,workInfo : ShinhanWorkInfo) {
        self.personalLoan = personal
        self.permanentAddress = permanentAddress
        self.residenceAddress = residenceAddress
        self.refPerson1 = refPerson1
        self.refPerson2 = refPerson2
        self.workInfo = workInfo
    }
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        InternalCode <- map["InternalCode"]
        personalLoan <- map["personalLoan"]
        permanentAddress <- map["permanentAddress"]
        residenceAddress <- map["residenceAddress"]
        refPerson1 <- map["refPerson1"]
        refPerson2 <- map["refPerson2"]
        workInfo <- map["workInfo"]
    }
    
}

class ShinhanPersonalLoan : Mappable {
    
    var fullName : String = ""
    var gender : Bool = false
    var dateOfBirth : String = ""
    var idCard : String = ""
    var idCardCityCode : String = ""
    var idCardCityDesc : String = ""
    var idCardDateIssued : String = ""
    var idCardDateExpiration : String = ""
    var phone : String = ""
    var email : String = ""
    var idCardType : Int = 0
    
    init(fullName: String = "", gender: Bool = false, dateOfBirth: String = "", idCard: String = "", idCardCityCode: String = "", idCardCityDesc: String = "", idCardDateIssued: String = "", idCardDateExpiration: String = "", phone: String = "", email: String = "", idCardType: Int = 0) {
        self.fullName = fullName
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.idCard = idCard
        self.idCardCityCode = idCardCityCode
        self.idCardCityDesc = idCardCityDesc
        self.idCardDateIssued = idCardDateIssued
        self.idCardDateExpiration = idCardDateExpiration
        self.phone = phone
        self.email = email
        self.idCardType = idCardType
    }
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        fullName <- map["fullName"]
        gender <- map["gender"]
        dateOfBirth <- map["dateOfBirth"]
        idCard <- map["idCard"]
        idCardCityCode <- map["idCardCityCode"]
        idCardCityDesc <- map["idCardCityDesc"]
        idCardDateIssued <- map["idCardDateIssued"]
        idCardDateExpiration <- map["idCardDateExpiration"]
        phone <- map["phone"]
        email <- map["email"]
        idCardType <- map["idCardType"]
    }
    
}

class ShinhanPermanentAddress : Mappable {
    
    var houseNo : String = ""
    var street : String = ""
    var cityCode : String = ""
    var cityDesc : String = ""
    var districtCode : String = ""
    var districtName : String = ""
    var wardCode : String = ""
    var wardName : String = ""
    
    
    init(houseNo: String = "", street: String = "", cityCode: String = "", cityDesc: String = "", districtCode: String = "", districtName: String = "", wardCode: String = "", wardName: String = "") {
        self.houseNo = houseNo
        self.street = street
        self.cityCode = cityCode
        self.cityDesc = cityDesc
        self.districtCode = districtCode
        self.districtName = districtName
        self.wardCode = wardCode
        self.wardName = wardName
    }
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        houseNo <- map["houseNo"]
        street <- map["street"]
        cityCode <- map["cityCode"]
        cityDesc <- map["cityDesc"]
        districtCode <- map["districtCode"]
        districtName <- map["districtName"]
        wardCode <- map["wardCode"]
        wardName <- map["wardName"]
    }
    
}

class ShinhanResidenceAddress : Mappable {
    init(samePerResAddress: Bool = false, houseNo: String = "", street: String = "", cityCode: String = "", cityDesc: String = "", districtCode: String = "", districtName: String = "", wardCode: String = "", wardName: String = "") {
        self.samePerResAddress = samePerResAddress
        self.houseNo = houseNo
        self.street = street
        self.cityCode = cityCode
        self.cityDesc = cityDesc
        self.districtCode = districtCode
        self.districtName = districtName
        self.wardCode = wardCode
        self.wardName = wardName
    }
    
    var samePerResAddress : Bool = false
    var houseNo : String = ""
    var street : String = ""
    var cityCode : String = ""
    var cityDesc : String = ""
    var districtCode : String = ""
    var districtName : String = ""
    var wardCode : String = ""
    var wardName : String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        samePerResAddress <- map["samePerResAddress"]
        houseNo <- map["houseNo"]
        street <- map["street"]
        cityCode <- map["cityCode"]
        cityDesc <- map["cityDesc"]
        districtCode <- map["districtCode"]
        districtName <- map["districtName"]
        wardCode <- map["wardCode"]
        wardName <- map["wardName"]
    }
    
}

class ShinhanRefPerson : Mappable {
    init(fullName: String = "", relationshipCode: String = "", relationshipDes: String = "", phone: String = "") {
        self.fullName = fullName
        self.relationshipCode = relationshipCode
        self.relationshipDes = relationshipDes
        self.phone = phone
    }
    
    var fullName : String = ""
    var relationshipCode : String = ""
    var relationshipDes: String = ""
    var phone : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        fullName <- map["fullName"]
        relationshipCode <- map["relationshipCode"]
        relationshipDes <- map["relationshipDes"]
        phone <- map["phone"]
    }
    
}

class ShinhanWorkInfo : Mappable {
    init(income: String = "", companyName: String = "", firstPaymentDate: String = "") {
        self.income = income
        self.companyName = companyName
        self.firstPaymentDate = firstPaymentDate
    }
    
    var income : String = ""
    var companyName : String = ""
    var firstPaymentDate : String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        income <- map["income"]
        companyName <- map["companyName"]
        firstPaymentDate <- map["firstPaymentDate"]
    }
    
}
//MARK: district/ward model
class ShinhanDistrictBase : Mappable {
    var success : Bool = false
    var message : String = ""
    var data : [ShinhanCity] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }
    
    var lisString: [String] {
        return data.map({$0.value ?? ""})
    }
    
}

//MARK: save application
class ShinhanSaveAppBase : Mappable {
    var success : Bool = false
    var message : String = ""
    var docEntry : Int  = 0
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        message <- map["Message"]
        docEntry <- map["docEntry"]
    }
    
}

class ShinhanPaymentDateBase : Mappable {
    var success : Bool = false
    var message : String = ""
    var data : [ShinhanPaymentDate] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }
    
    var lisString: [String] {
        return data.map({$0.paymentDate })
    }
    
}


//MARK: load goi tra gop

class ShinhanGoitragopBase : Mappable {
    var success : Bool =  false
    var message : String = ""
    var data : [ShinhanTragopData] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }
    
}

class ShinhanTragopData : Mappable {
    var schemeCode : String = ""
    var schemeName : String = ""
    var interestRate : Double = 0.0
    var schemeDetails : String = ""
    var insuranceFeeRate : Double = 0.0
    var loanTenure : [ShinhanLoanTenure]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        schemeCode <- map["SchemeCode"]
        schemeName <- map["SchemeName"]
        interestRate <- map["interestRate"]
        schemeDetails <- map["SchemeDetails"]
        insuranceFeeRate <- map["insuranceFeeRate"]
        loanTenure <- map["loanTenure"]
    }
    
    init(schemeCode: String,interestRate: Double,schemeName: String,schemeDetail: String) {
        self.schemeCode = schemeCode
        self.interestRate = interestRate
        self.schemeName = schemeName
        self.schemeDetails = schemeDetail
    }
    
}


class ShinhanLoanTenure : Mappable {
    var schemeCode : String = ""
    var number : Int = 0
    var text : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        schemeCode <- map["SchemeCode"]
        number <- map["number"]
        text <- map["text"]
    }
    
    init(number: Int) {
        self.number = number
        self.text = "\(number) tháng"
    }
}

//MARK: shinhan upload image

class ShinhanUploadBase : Mappable {
    var success : Bool =  false
    var message : String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
    
}

//MARK: save and submit application



class ShinhanSubmitBase : Mappable {
    var success : Bool =  false
    var message : String = ""
    var mposSoNum: Int = 0
    var status: Int = 0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        mposSoNum <- map["mposSoNum"]
        status <- map["status"]
    }
    
}

//MARK: detail order

class ShinhanDetailBase : Mappable {
    var success : Bool = false
    var message : String = ""
    var data : ShinhanOrderDetail?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
    
}

class ShinhanOrderDetail : Mappable {
    var customer : ShinhanCustomer?
    var order : [ShinhanOrder] = []
    var promotion : [ShinhanPromotion] = []
    var payment : ShinhanPayment?
    var button : ShinhanButton?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        customer <- map["customer"]
        order <- map["order"]
        promotion <- map["promotion"]
        payment <- map["payment"]
        button <- map["button"]
    }
    
}

class ShinhanCustomer : Mappable {
    var afn : Int =  0
    var trackingId : String =  ""
    var fullName : String = ""
    var idCard : String = ""
    var phone : String = ""
    var NgaySinh : String = ""
    var Address : String = ""
    var Mail : String = ""
    var gioitinh: Bool = false
	var mposSoNum : Int = 0

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        afn <- map["afn"]
        trackingId <- map["trackingId"]
        fullName <- map["fullName"]
        idCard <- map["idCard"]
        phone <- map["phone"]
        NgaySinh <- map["dateOfBirth"]
        NgaySinh = NgaySinh.toNewStrDate(withFormat: "yyyy-MM-dd'T'HH:mm:ss", newFormat: "dd/MM/yyyy")
        Address <- map["address"]
        Mail <- map["email"]
        gioitinh <- map["gender"]
		mposSoNum <- map["mposSoNum"]
    }
    
}

class ShinhanOrder : Mappable {
    var itemName : String = ""
    var imei : String = ""
    var price : Float = 0
    var itemCode: String = ""
    var quantity: Int = 0
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        itemCode <- map["itemCode"]
        itemName <- map["itemName"]
        imei <- map["imei"]
        price <- map["price"]
        quantity <- map["quantity"]
    }
    
}

class ShinhanPromotion : Mappable {
    var itemName : String?
    var quantity : Int?
    var itemCode: String = ""
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        itemName <- map["itemName"]
        quantity <- map["quantity"]
        itemCode <- map["itemCode"]
    }
    
}

class ShinhanPayment : Mappable {
    var schemeCode: String = ""
    var schemeName : String = ""
    
    var interestRate : Float = 0
    var loanTenor : Float = 0
    var totalPrice : Float = 0
    var downPayment : Float = 0
    var loanAmount : Float = 0
    var insuranceFee : Float = 0
    var discount : Float = 0
    var finalPrice : Float = 0
    var SchemeDetails: String = ""
    var U_DownPay : Float = 0
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        schemeCode <- map["schemeCode"]
        schemeName <- map["schemeName"]
        interestRate <- map["interestRate"]
        loanTenor <- map["loanTenor"]
        totalPrice <- map["totalPrice"]
        downPayment <- map["downPayment"]
        loanAmount <- map["loanAmount"]
        insuranceFee <- map["insuranceFee"]
        discount <- map["discount"]
        finalPrice <- map["finalPrice"]
        SchemeDetails <- map["SchemeDetails"]
        U_DownPay <- map["U_DownPay"]
    }
    
}

class ShinhanButton : Mappable {
    var updateLoanInfoBtn : Bool = false
    var updateImageBtn : Bool = false
    var viewCustomerInfoBtn : Bool = false
    var cancelBtn : Bool = false
    var incomeProofRequired: Bool = false
    var updateLoanInfo: String = ""
    var updateImages: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        updateLoanInfoBtn <- map["updateLoanInfoBtn"]
        updateImageBtn <- map["updateImageBtn"]
        viewCustomerInfoBtn <- map["viewCustomerInfoBtn"]
        cancelBtn <- map["cancelBtn"]
        incomeProofRequired <- map["incomeProofRequired"]
        updateLoanInfo <- map["updateLoanInfo"]
        updateImages <- map["updateImages"]
    }
    
    var numberButton: Int {
        var number = 0
        number = updateLoanInfoBtn || updateImageBtn ? number + 1 : number
        number = viewCustomerInfoBtn ? number + 1 : number
        number = cancelBtn ? number + 1 : number
        return number
    }
    
}

//MARK: list order history
class ShinhanOrderHistory : Mappable {
    var success : Bool = false
    var message : String = ""
    var data : [ShinhanOrderItem] = []
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
    
}

class ShinhanOrderItem : Mappable {
    var afn : Int = 0
    var trackingId : String = ""
    var createdDate : String = ""
    var fullName : String = ""
    var idCard : String = ""
    var contractNumber : String = ""
    var cancelReason : String = ""
    var status : String = ""
    var statusColor : String = ""
    var docEntry: Int = 0
    var mposSoNum: String = ""
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        afn <- map["afn"]
        mposSoNum <- map["mposSoNum"]
        trackingId <- map["trackingId"]
        createdDate <- map["CreatedDate"]
        fullName <- map["fullName"]
        idCard <- map["idCard"]
        contractNumber <- map["contractNumber"]
        cancelReason <- map["cancelReason"]
        status <- map["status"]
        statusColor <- map["statusColor"]
        docEntry <- map["docEntry"]
    }
    
}


//MARK: listCheme models
class ShinhanSchemeBase : Mappable {
    var success : Bool = false
    var message : String = ""
    var data : ShinhanChemeData?

   required init?(map: Map) {

    }

    func mapping(map: Map) {

        success <- map["Success"]
        message <- map["Message"]
        data <- map["Data"]
    }

}

class ShinhanChemeData : Mappable {
    var status : [ShinhanSchemeStatus] = []
    var header : [ShinhanSchemeHeader] = []
    var details : [ShinhanSchemeDetails] = []

   required init?(map: Map) {

    }

     func mapping(map: Map) {

        status <- map["Status"]
        header <- map["Header"]
        details <- map["Details"]
    }

}

class ShinhanSchemeStatus : Mappable {
    var p_status : Int = 0
    var p_messagess : String = ""

    required init?(map: Map) {

    }

    func mapping(map: Map) {

        p_status <- map["p_status"]
        p_messagess <- map["p_messagess"]
    }

}

class ShinhanSchemeHeader : Mappable {
    var sOPOS : Int = 0
    var sOMPOS : Int = 0
    var ecomNum : Int = 0
    var sDT : String = ""
    var cardname : String = ""
    var createDate : String = ""
    var doctotal : Double = 0.0
    var soTienCoc : Double = 0.0

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        sOPOS <- map["SOPOS"]
        sOMPOS <- map["SOMPOS"]
        ecomNum <- map["EcomNum"]
        sDT <- map["SDT"]
        cardname <- map["Cardname"]
        createDate <- map["CreateDate"]
        doctotal <- map["Doctotal"]
        soTienCoc <- map["SoTienCoc"]
    }

}

class ShinhanSchemeDetails : Mappable {
    var itemCode : String = ""
    var itemName : String = ""
    var price : Double = 0.0
    var bonusScopeBoom : String = ""
    var linkAnh : String = ""
    var iD : Int = 0
    var brandID : Int = 0
    var productTypeID : Int = 0
    var priceMarket : Int = 0
    var priceBeforeTax : Int = 0
    var iconUrl : String = ""
    var manSerNum : String = ""
    var inventory : Int = 0
    var includeInfo : String = ""
    var labelName : String = ""
    var hightlightsDes : String = ""
    var qlSerial : String = ""
    var lableProduct : String = ""

    required init?(map: Map) {

    }

     func mapping(map: Map) {

        itemCode <- map["ItemCode"]
        itemName <- map["ItemName"]
        price <- map["Price"]
        bonusScopeBoom <- map["BonusScopeBoom"]
        linkAnh <- map["linkAnh"]
        iD <- map["ID"]
        brandID <- map["BrandID"]
        productTypeID <- map["ProductTypeID"]
        priceMarket <- map["PriceMarket"]
        priceBeforeTax <- map["PriceBeforeTax"]
        iconUrl <- map["iconUrl"]
        manSerNum <- map["ManSerNum"]
        inventory <- map["inventory"]
        includeInfo <- map["IncludeInfo"]
        labelName <- map["LabelName"]
        hightlightsDes <- map["HightlightsDes"]
        qlSerial <- map["qlSerial"]
        lableProduct <- map["LableProduct"]
    }

}
