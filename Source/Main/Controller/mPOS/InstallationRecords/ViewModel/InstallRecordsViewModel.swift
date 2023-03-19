//
//  InstallRecordsViewModel.swift
//  fptshop
//
//  Created by Ngo Dang tan on 15/03/2021.
//  Copyright © 2021 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import Foundation
enum DataInstallLaptopConfiguration: Int, CaseIterable  {
    case appearance
    case charge
    case battery
    case ram
    case storage
    case info
    case display
    case memory
    case memorycard
    case term
    case appearancemobile
    case keyboard
    case confirm
    case confirmMobile

    var groupCode:String {
        switch self {
        case .appearance:
            return "1"
        case .keyboard:
            return "3"
        case .charge:
            return "4"
            
        case .battery:
            return "5"
            
        case .ram:
            return "13"
            
        case .storage:
            return "6"
        case .appearancemobile:
            return "7"
        case .display:
            return "2"
        case .memory:
            return "9"
        case .memorycard:
            return "10"
        case .info:
            return "11"
        case .term:
            return "12"
        case .confirmMobile:
            return "14"
        case .confirm:
            return "15"
        }
    }
}
struct InstallRecordsViewModel {
    
    var lstAppearance = [ItemDataInstallLaptop]()
    var lstCharge = [ItemDataInstallLaptop]()
    var lstBattery = [ItemDataInstallLaptop]()
    var lstRam = [ItemDataInstallLaptop]()
    var lstStorage = [ItemDataInstallLaptop]()
    var lstInfo = [ItemDataInstallLaptop]()
    var lstTerm = [ItemDataInstallLaptop]()
    var lstMemory = [ItemDataInstallLaptop]()
    var lstMemoryCard = [ItemDataInstallLaptop]()
    var lstAppearanceMobile = [ItemDataInstallLaptop]()
    var lstKeyboard = [ItemDataInstallLaptop]()
    var lstDisplay = [ItemDataInstallLaptop]()
    var lstConfirm = [ItemDataInstallLaptop]()
    var lstConfirmMobile = [ItemDataInstallLaptop]()

    var lstParamChoose = [String]()

    
    private var masterData:MasterDataInstallLaptop
 
  
    // MARK: - Init
    init(masterData:MasterDataInstallLaptop){
        self.masterData = masterData
        self.lstAppearance = getItemGroupCode(config: .appearance)
        self.lstCharge = getItemGroupCode(config: .charge)
        self.lstBattery = getItemGroupCode(config: .battery)
        self.lstRam = getItemGroupCode(config: .ram)
        self.lstStorage = getItemGroupCode(config: .storage)
        self.lstInfo = getItemGroupCode(config: .info,isCheckAll: true)
        self.lstTerm = getItemGroupCode(config: .term,isCheckAll: true)
        self.lstConfirm = getItemGroupCode(config: .confirm,isCheckAll: true)
        self.lstConfirmMobile = getItemGroupCode(config: .confirmMobile,isCheckAll: true)

        self.lstAppearanceMobile = getItemGroupCode(config: .appearancemobile)
        self.lstMemory = getItemGroupCode(config: .memory)
        self.lstMemoryCard = getItemGroupCode(config: .memorycard)
        self.lstKeyboard = getItemGroupCode(config: .keyboard)
        self.lstDisplay = getItemGroupCode(config: .display)

    }
    
    
    // MARK: - Helpers
    
    
    
    mutating func getItemGroupCode(config:DataInstallLaptopConfiguration,isCheckAll: Bool = false) -> [ItemDataInstallLaptop] {
    
        switch config {
        case .appearance:
          
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .charge:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .battery:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .ram:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .storage:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .display:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .memory:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .memorycard:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .info:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .term:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .confirm:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .confirmMobile:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .appearancemobile:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        case .keyboard:
            return getListData(isCheckAll: isCheckAll, groupCode: config.groupCode)
        }
    }
    
    mutating func getListData(isCheckAll:Bool,groupCode:String) -> [ItemDataInstallLaptop]{
        var lst = [ItemDataInstallLaptop]()
        if let row = masterData.data.firstIndex(where: {$0.groupCode == groupCode}) {
            if isCheckAll{
                for index in 0...masterData.data[row].items.count - 1 {
                    masterData.data[row].items[index].isSelected = true
                    lstParamChoose.append("\(masterData.data[row].items[index].id)")
                }
            }
            lst = masterData.data[row].items
          
            
        }
        return lst
    }
    mutating func getParamListData(){
        DataInstallLaptopConfiguration.allCases.forEach { config in
            switch config {
            case .appearance:
                let itemsDataFilter = lstAppearance.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
                
            case .charge:

                let itemsDataFilter = lstCharge.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .battery:
                let itemsDataFilter = lstBattery.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .ram:
                let itemsDataFilter = lstRam.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .storage:
                let itemsDataFilter = lstStorage.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .display:
                let itemsDataFilter = lstDisplay.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .memory:
                let itemsDataFilter = lstMemory.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .memorycard:
                let itemsDataFilter = lstMemoryCard.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .term:
                break
            case .confirm:
                break
            case .confirmMobile:
                break
            case .info:
                break
            case .appearancemobile:
                let itemsDataFilter = lstAppearanceMobile.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            case .keyboard:
                let itemsDataFilter = lstKeyboard.filter {  item in
                    return item.isSelected == true
                }
                itemsDataFilter.forEach { item in
                    lstParamChoose.append("\(item.id)")
                }
            }
        }
    }

    
}

enum InstallRecordTypeConfiguration:Int, CaseIterable  {
    case mobile
    case laptop
    
    var deviceType:String {
        
        switch self{
        case .laptop:
            return "laptop"
        case .mobile:
            return "mobile"
        }
    }
    
}
struct InstallRecordsHistoryViewModel {
    var lstAppearance = [MasterDatum]()
    var lstCharge = [MasterDatum]()
    var lstBattery = [MasterDatum]()
    var lstRam = [MasterDatum]()
    var lstStorage = [MasterDatum]()
    var lstInfo = [MasterDatum]()
    var lstTerm = [MasterDatum]()
    var lstMemory = [MasterDatum]()
    var lstMemoryCard = [MasterDatum]()
    var lstAppearanceMobile = [MasterDatum]()
    var lstKeyboard = [MasterDatum]()
    var lstDisplay = [MasterDatum]()
    var lstConfirm = [MasterDatum]()
    var lstConfirmMobile = [MasterDatum]()

    private var mastersData = [MasterDatum]()
    
    
    // MARK: - Init
    init(mastersData:[MasterDatum]){
        self.mastersData = mastersData
        self.lstAppearance = getItemGroupCode(config: .appearance)
        self.lstCharge = getItemGroupCode(config: .charge)
        self.lstBattery = getItemGroupCode(config: .battery)
        self.lstRam = getItemGroupCode(config: .ram)
        self.lstStorage = getItemGroupCode(config: .storage)
        self.lstInfo = getItemGroupCode(config: .info,isCheckAll: true)
        self.lstTerm = getItemGroupCode(config: .term,isCheckAll: true)
        self.lstConfirm = getItemGroupCode(config: .term,isCheckAll: true)
        self.lstConfirmMobile = getItemGroupCode(config: .term,isCheckAll: true)

        self.lstAppearanceMobile = getItemGroupCode(config: .appearancemobile)
        self.lstMemory = getItemGroupCode(config: .memory)
        self.lstMemoryCard = getItemGroupCode(config: .memorycard)
        self.lstKeyboard = getItemGroupCode(config: .keyboard)
        self.lstDisplay = getItemGroupCode(config: .display)

    }
    
    
    // MARK: - Helpers
    
    
    
    mutating func getItemGroupCode(config:DataInstallLaptopConfiguration,isCheckAll: Bool = false) -> [MasterDatum] {
    
        switch config {
        case .appearance:
          
            return getListData(groupCode: config.groupCode)
        case .charge:
            return getListData( groupCode: config.groupCode)
        case .battery:
            return getListData(groupCode: config.groupCode)
        case .ram:
            return getListData(groupCode: config.groupCode)
        case .storage:
            return getListData(groupCode: config.groupCode)
        case .display:
            return getListData(groupCode: config.groupCode)
        case .memory:
            return getListData(groupCode: config.groupCode)
        case .memorycard:
            return getListData(groupCode: config.groupCode)
        case .info:
            return getListData(groupCode: config.groupCode)
        case .term:
            return getListData(groupCode: config.groupCode)
        case .confirm:
            return getListData(groupCode: config.groupCode)
        case .confirmMobile:
            return getListData(groupCode: config.groupCode)
        case .appearancemobile:
            return getListData( groupCode: config.groupCode)
        case .keyboard:
            return getListData(groupCode: config.groupCode)
        }
    }
    
    mutating func getListData(groupCode:String) -> [MasterDatum]{
        var lst = [MasterDatum]()
        mastersData.forEach { item in
            if item.groupCode == groupCode{
                lst.append(item)
            }
        }
        return lst
    }
    
    
    
}
