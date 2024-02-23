//
//  FoodDAO.swift
//  SqlTest
//
//  Created by 李韋辰 on 2021/7/26.
//

import Foundation

class FoodDAO {
    private static var _inst = FoodDAO()
    public static var share: FoodDAO {
        return _inst
    }
    //data
    var dbPath = ""
    
    //初始化邏輯
    private init(){
        //資料庫路徑
        dbPath = "\(NSHomeDirectory())/Documents/FoodList.db"
        let fileMgr = FileManager.default
        //找檔案(FoodList是否存在)
        if !fileMgr.fileExists(atPath: dbPath) {
            if let source = Bundle.main.path(forResource: "FoodList", ofType: "db"){
                try? fileMgr.copyItem(atPath: source, toPath: dbPath)
            }
        }
        print(dbPath)
    }
    
    //Table Setting
    let TABLE_NAME = "FoodList"
    let COLUMN_RID = "rid"
    let COLUMN_FOOD_NAME = "foodName"
    let COLUMN_AUTHOR_NAME = "authorName"
    let COLUMN_FOOD_IMG = "foodImg"
    let COLUMN_AUTHOR_IMG = "authorImg"
    
    //從資料庫抓取所有資料(sql語法)
    func getAllFoods() -> [Food] {
        var foodList = [Food]()
        //設定資料庫
        let db = FMDatabase(path: dbPath)
        db?.open()
        //sql語法 顯示所有資料
        let sql = "SELECT * FROM \(TABLE_NAME)"
        //執行查詢
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: []){
            while resultSet.next() {//還有下一個就執行
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let foodName = resultSet.string(forColumn: COLUMN_FOOD_NAME) ?? ""
                let authorName = resultSet.string(forColumn: COLUMN_AUTHOR_NAME) ?? ""
                let foodImg = resultSet.data(forColumn: COLUMN_FOOD_IMG)
                let authorImg = resultSet.data(forColumn: COLUMN_AUTHOR_IMG)
                let data = Food(rid: rid, foodName: foodName, authorName: authorName, foodImg: foodImg, authorImg: authorImg)
                foodList.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return foodList
    }
    
    func getFoodByName(_ foodName: String) -> [Food] {
        var foodList = [Food]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        
        let sql = "SELECT * FROM \(TABLE_NAME) WHERE foodName like ? "
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: ["%\(foodName)%"]) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let foodName = resultSet.string(forColumn: COLUMN_FOOD_NAME) ?? ""
                let authorName = resultSet.string(forColumn: COLUMN_AUTHOR_NAME) ?? ""
                let foodImg = resultSet.data(forColumn: COLUMN_FOOD_IMG)
                let authorImg = resultSet.data(forColumn: COLUMN_AUTHOR_IMG)
                let data = Food(rid: rid, foodName: foodName, authorName: authorName, foodImg: foodImg, authorImg: authorImg)
                foodList.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return foodList
    }
    
    func getFoodById(_ rid: Int) -> Food? {
        var ret: Food?
        let db = FMDatabase(path: dbPath)
        db?.open()
        
        let sql = "SELECT * FROM \(TABLE_NAME) WHERE rid = ? "
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [rid]) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let foodName = resultSet.string(forColumn: COLUMN_FOOD_NAME) ?? ""
                let authorName = resultSet.string(forColumn: COLUMN_AUTHOR_NAME) ?? ""
                let foodImg = resultSet.data(forColumn: COLUMN_FOOD_IMG)
                let authorImg = resultSet.data(forColumn: COLUMN_AUTHOR_IMG)
                ret = Food(rid: rid, foodName: foodName, authorName: authorName, foodImg: foodImg, authorImg: authorImg)
            }
            resultSet.close()
        }
        db?.close()
        return ret
    }
    
    func insert(_ data: Food) {
        var dict = [String: Any]()
        dict["fn"] = data.foodName
        dict["an"] = data.authorName
        dict["fi"] = data.foodImg
        dict["ai"] = data.authorImg
        
        let sql = "INSERT INTO FoodList(\(COLUMN_FOOD_NAME),\(COLUMN_AUTHOR_NAME),\(COLUMN_FOOD_IMG),\(COLUMN_AUTHOR_IMG))VALUES (:fn, :an, :fi, :ai)"
        updateDB(sql: sql, dict: dict)
    }
    
    func updateDB(sql: String,dict: [String: Any]) {
        let db = FMDatabase(path: dbPath)
        db?.open()
        db?.executeUpdate(sql, withParameterDictionary: dict)
        db?.close()
    }
    
}
