//
//  DBManager.swift
//  fptshop
//
//  Created by Duong Hoang Minh on 1/4/19.
//  Copyright © 2019 FPT DIGITAL RETAIL JOINT STOCK COMPANY. All rights reserved.
//

import UIKit
import RealmSwift
class DBManager {
    private var database:Realm
    static let sharedInstance = DBManager()
    private init() {
        let config = Realm.Configuration(
            schemaVersion: 7,
            migrationBlock: { migration, oldSchemaVersion in
                // Any migration logic older Realm files may need
        })
        
        Realm.Configuration.defaultConfiguration = config
        database = try! Realm()
    }
    func getDataFromDB() -> Results<ItemContact> {
        let results: Results<ItemContact> = database.objects(ItemContact.self)
        return results
    }
    func searchName(key:String) -> [ItemContact] {
        let results: Results<ItemContact> = database.objects(ItemContact.self).filter("EmployeeNameSearch LIKE '*\(key)*'")
    
        var items: [ItemContact] = []
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
    func searchShop(key:String) -> [ItemContact] {
        let results: Results<ItemContact> = database.objects(ItemContact.self).filter("OrganizationHierachyNameSearch LIKE '*\(key)*'")
        
        var items: [ItemContact] = []
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
    func searchPhone(key:String) -> [ItemContact] {
        let results: Results<ItemContact> = database.objects(ItemContact.self).filter("Phone LIKE '*\(key)*'")
        
        var items: [ItemContact] = []
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
    func searchEmail(key:String) -> [ItemContact] {
        let results: Results<ItemContact> = database.objects(ItemContact.self).filter("EmailSearch LIKE '*\(key)*'")
        
        var items: [ItemContact] = []
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

    func addListData(objects: [ItemContact]){
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
    func addData(object: ItemContact)   {
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
    func deleteFromDb(object: ItemContact)   {
        try! database.write {
            database.delete(object)
        }
    }
    func deleteFromDbObject()   {
        let results: Results<ItemContact> = database.objects(ItemContact.self)
        try! database.write {
            //database.delete(object)
            database.delete(results)
        }
    }
}
