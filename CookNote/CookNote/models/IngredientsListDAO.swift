//
//  IngredientsListDAO.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/28.
//

import Foundation

class IngredientsListDAO {
    private static var _inst = IngredientsListDAO()
    public static var shared: IngredientsListDAO {
        return _inst
    }
    //data
    var dbPath = ""
    
    private init() {
        dbPath = "\(NSHomeDirectory())/Documents/Cookbook.db"
        let fileMgr = FileManager.default
        if !fileMgr.fileExists(atPath: dbPath){
            if let source = Bundle.main.path(forResource: "Cookbook", ofType: "db"){
                try? fileMgr.copyItem(atPath: source, toPath: dbPath)
            }
        }
//        print(dbPath)
    }
    //Table Setting
    let TABLE_NAME = "IngredientsList"
    let COLUMN_RID = "rid"
    let COLUMN_IGROUP = "igroup"
    let COLUMN_INGREDIENTS = "ingredients"
    let COLUMN_QUANTITY = "quantity"
    let COLUMN_SELECTNUM = "selectNum"
    
    
    //從資料庫抓取所有資料(sql語法)
    func getAllIngredientsList() -> [IngredientsList] {
        var list = [IngredientsList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM \(TABLE_NAME)"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: []) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let ingredients = resultSet.string(forColumn: COLUMN_INGREDIENTS) ?? ""
                let quantity = resultSet.string(forColumn: COLUMN_QUANTITY) ?? ""
                let selectNum = Int(resultSet.int(forColumn: COLUMN_SELECTNUM))
                let data = IngredientsList(rid: rid, igroup: igroup, ingredients: ingredients, quantity: quantity,selectNum: selectNum)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    func getIngredientsListBySelectNum2(_ igroup: Int) -> [IngredientsList] {
        var list = [IngredientsList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM IngredientsList WHERE selectNum = 2 AND igroup = ?"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [igroup]) {
            while resultSet.next(){
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let ingredients = resultSet.string(forColumn: COLUMN_INGREDIENTS) ?? ""
                let quantity = resultSet.string(forColumn: COLUMN_QUANTITY) ?? ""
                let selectNum = Int(resultSet.int(forColumn: COLUMN_SELECTNUM))
                let data = IngredientsList(rid: rid, igroup: igroup, ingredients: ingredients, quantity: quantity,selectNum: selectNum)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    func getIngredientsListByGroup(_ igroup:Int) -> [IngredientsList] {
        var  list = [IngredientsList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        
        let sql = "SELECT * FROM  \(TABLE_NAME) WHERE igroup  = ?"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [igroup]) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let ingredients = resultSet.string(forColumn: COLUMN_INGREDIENTS) ?? ""
                let quantity = resultSet.string(forColumn: COLUMN_QUANTITY) ?? ""
                let selectNum = Int(resultSet.int(forColumn: COLUMN_SELECTNUM))
                let data = IngredientsList(rid: rid, igroup: igroup, ingredients: ingredients, quantity: quantity, selectNum: selectNum)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    
    func getIngredientsListBySelectNum() -> [IngredientsList] {
        var list = [IngredientsList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM IngredientsList WHERE selectNum = 2"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: []) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let ingredients = resultSet.string(forColumn: COLUMN_INGREDIENTS) ?? ""
                let quantity = resultSet.string(forColumn: COLUMN_QUANTITY) ?? ""
                let selectNum = Int(resultSet.int(forColumn: COLUMN_SELECTNUM))
                let data = IngredientsList(rid: rid, igroup: igroup, ingredients: ingredients, quantity: quantity,selectNum: selectNum)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    
    
    
    func getIngredientsListById(_ rid: Int) -> IngredientsList? {
        var ret: IngredientsList?
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM IngredientsList WHERE rid = ?"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [rid]) {
            if resultSet.next(){
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let ingredients = resultSet.string(forColumn: COLUMN_INGREDIENTS) ?? ""
                let quantity = resultSet.string(forColumn: COLUMN_QUANTITY) ?? ""
                let selectNum = Int(resultSet.int(forColumn: COLUMN_SELECTNUM))
                ret = IngredientsList(rid: rid, igroup: igroup, ingredients: ingredients, quantity: quantity,selectNum: selectNum)
            }
        }
        db?.close()
        return ret
    }
    fileprivate func updateDB(sql: String,dict: [String: Any]) {
        let db = FMDatabase(path: dbPath)
        db?.open()
        db?.executeUpdate(sql, withParameterDictionary: dict)
        db?.close()
    }
    
    func insert(_ data: IngredientsList) {
        var dict = [String: Any]()
        dict["g"] = data.igroup
        dict["i"] = data.ingredients
        dict["q"] = data.quantity
        dict["s"] = data.selectNum

        let sql = "INSERT INTO IngredientsList(\(COLUMN_IGROUP),\(COLUMN_INGREDIENTS),\(COLUMN_QUANTITY),\(COLUMN_SELECTNUM) VALUES (:g, :i, :q, :s)"
        updateDB(sql: sql, dict: dict)
    }
    
    func update(_ data: IngredientsList) {
        let dict: [String: Any] = ["s": data.selectNum, "rid": data.rid]
        let sql = "UPDATE IngredientsList SET \(COLUMN_SELECTNUM) = :s WHERE \(COLUMN_RID) = :rid"
        updateDB(sql: sql, dict: dict)
    }
    func update2(_ igroup: Int) {
        let dict: [String: Any] = ["g": igroup]
        let sql = "UPDATE IngredientsList SET \(COLUMN_SELECTNUM) = 1 WHERE \(COLUMN_IGROUP) = :g"
        updateDB(sql: sql, dict: dict)
    }
    func delete(_ rid: Int) {
        let dict: [String: Any] = ["rid": rid]
        let sql = "DELETE FROM IngredientsList WHERE \(COLUMN_RID) = :rid"
        updateDB(sql: sql, dict: dict)
    }
    
}
