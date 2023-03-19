//
//  DBManager.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import RealmSwift
class DBMangerComboPK {
    private var database:Realm
    static let sharedInstance = DBMangerComboPK()
    private init() {
        let config = Realm.Configuration(
            schemaVersion: 7,
            migrationBlock: { migration, oldSchemaVersion in
                // Any migration logic older Realm files may need
        })
        
        Realm.Configuration.defaultConfiguration = config
        database = try! Realm()
    }
    func getDataFromDB() -> Results<ComboPK_SearchSP> {
        let results: Results<ComboPK_SearchSP> = database.objects(ComboPK_SearchSP.self)
        return results
    }
    func getAllDataFromDB() -> [ComboPK_SearchSP] {
        let results: Results<ComboPK_SearchSP> = database.objects(ComboPK_SearchSP.self)
        
        var items: [ComboPK_SearchSP] = []
        //        if(results.count > 30){
        //            for i in 0..<30 {
        //                items.append(results[i])
        //            }
        //            return items
        //        }else{
        //            for i in 0..<results.count {
        //                items.append(results[i])
        //            }
        //            return items
        //        }
        for i in 0..<30 {
            items.append(results[i])
        }
        return items
    }
    func searchName(key:String) -> [ComboPK_SearchSP] {
        let results: Results<ComboPK_SearchSP> = database.objects(ComboPK_SearchSP.self).filter("Name LIKE '*\(key)*'")
        
        var items: [ComboPK_SearchSP] = []
        if(results.count > 30){
            for i in 0..<30 {
                items.append(results[i])
            }
            return items
        }else{
            for i in 0..<results.count {
                items.append(results[i])
            }
            return items
        }
    }
    
    func searchSku(key:String) -> [ComboPK_SearchSP] {
        let results: Results<ComboPK_SearchSP> = database.objects(ComboPK_SearchSP.self).filter("Sku LIKE '*\(key)*'")
        
        var items: [ComboPK_SearchSP] = []
        if(results.count > 30){
            for i in 0..<30 {
                items.append(results[i])
            }
            return items
        }else{
            for i in 0..<results.count {
                items.append(results[i])
            }
            return items
        }
    }
    
    
    func addListData(objects: [ComboPK_SearchSP]){
        database.beginWrite()
        database.add(objects)
        do {
            try database.commitWrite()
        }
        catch let writeError {
            debugPrint("Unable to commit write: \(writeError)")
        }
        database.refresh()
    }
    func addData(object: ComboPK_SearchSP)   {
        try! database.write {
            database.beginWrite()
            print("Added new object")
        }
    }
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    func deleteFromDb()   {
        let results: Results<ComboPK_SearchSP> = database.objects(ComboPK_SearchSP.self)
        try! database.write {
            database.delete(results)
        }
    }
}
