//
//  CookbooksDAO.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/28.
//

import Foundation

class CookbooksDAO {
    private static var _inst = CookbooksDAO()
    public static var shared: CookbooksDAO {
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
    let TABLE_NAME = "Cookbooks"
    let COLUMN_RID = "rid"
    let COLUMN_FOOD = "food"
    let COLUMN_AUTHOR = "author"
    let COLUMN_FOODPHOTO = "foodPhoto"
    let COLUMN_AUTHORPHOTO = "authorPhoto"
    let COLUMN_FAVORITE = "favorite"
    
    //從資料庫抓取所有資料(sql語法)
    func getAllCookbooks() -> [Cookbooks] {
        var list = [Cookbooks]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM \(TABLE_NAME)"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: []) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let food = resultSet.string(forColumn: COLUMN_FOOD) ?? ""
                let author = resultSet.string(forColumn: COLUMN_AUTHOR) ?? ""
                let foodPhoto = resultSet.data(forColumn: COLUMN_FOODPHOTO)
                let authorPhoto = resultSet.data(forColumn: COLUMN_AUTHORPHOTO)
                let favorite = Int(resultSet.int(forColumn: COLUMN_FAVORITE))
                let data = Cookbooks(rid: rid, food: food, author: author, foodPhoto: foodPhoto, authorPhoto: authorPhoto, favorite: favorite)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    func getCookbooksByFavorite() -> [Cookbooks] {
        var list = [Cookbooks]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM Cookbooks WHERE favorite = 2 "
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: []) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let food = resultSet.string(forColumn: COLUMN_FOOD) ?? ""
                let author = resultSet.string(forColumn: COLUMN_AUTHOR) ?? ""
                let foodPhoto = resultSet.data(forColumn: COLUMN_FOODPHOTO)
                let authorPhoto = resultSet.data(forColumn: COLUMN_AUTHORPHOTO)
                let favorite = Int(resultSet.int(forColumn: COLUMN_FAVORITE))
                let data = Cookbooks(rid: rid, food: food, author: author, foodPhoto: foodPhoto, authorPhoto: authorPhoto, favorite: favorite)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    
    
    
    
    
    func getCookbooksByName(_ food:String) -> [Cookbooks] {
        var  list = [Cookbooks]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        
        let sql = "SELECT * FROM  \(TABLE_NAME) WHERE food  like ? "
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: ["%\(food)%"]) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let food = resultSet.string(forColumn: COLUMN_FOOD) ?? ""
                let author = resultSet.string(forColumn: COLUMN_AUTHOR) ?? ""
                let foodPhoto = resultSet.data(forColumn: COLUMN_FOODPHOTO)
                let authorPhoto = resultSet.data(forColumn: COLUMN_AUTHORPHOTO)
                let favorite = Int(resultSet.int(forColumn: COLUMN_FAVORITE))
                let data = Cookbooks(rid: rid, food: food, author: author, foodPhoto: foodPhoto, authorPhoto: authorPhoto, favorite: favorite)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    
    
    
    func getCookbooksById(_ rid: Int) -> Cookbooks? {
        var ret: Cookbooks?
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM Cookbooks WHERE rid = ?"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [rid]) {
            if resultSet.next(){
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let food = resultSet.string(forColumn: COLUMN_FOOD) ?? ""
                let author = resultSet.string(forColumn: COLUMN_AUTHOR) ?? ""
                let foodPhoto = resultSet.data(forColumn: COLUMN_FOODPHOTO)
                let authorPhoto = resultSet.data(forColumn: COLUMN_AUTHORPHOTO)
                let favorite = Int(resultSet.int(forColumn: COLUMN_FAVORITE))
                ret = Cookbooks(rid: rid, food: food, author: author, foodPhoto: foodPhoto, authorPhoto: authorPhoto, favorite: favorite)
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
    
    func insert(_ data: Cookbooks) {
        var dict = [String: Any]()
        dict["f"] = data.food
        dict["a"] = data.author
        dict["fp"] = data.foodPhoto
        dict["ap"] = data.authorPhoto
        dict["fa"] = data.favorite

        let sql = "INSERT INTO Cookbooks(\(COLUMN_FOOD),\(COLUMN_AUTHOR),\(COLUMN_FOODPHOTO),\(COLUMN_AUTHORPHOTO),\(COLUMN_FAVORITE) VALUES (:f, :a, :fp, ap:, fa:)"
        updateDB(sql: sql, dict: dict)
    }
    
    func update(_ data: Cookbooks) {
        var dict: [String: Any] = ["f": data.food, "a": data.author, "fp": data.foodPhoto, "ap": data.authorPhoto, "fa":data.favorite, "rid": data.rid]
        let sql = "UPDATE Cookbooks SET \(COLUMN_FOOD) = :f, \(COLUMN_AUTHOR) = :a, \(COLUMN_FOODPHOTO) = :fp, \(COLUMN_AUTHORPHOTO) = :ap, \(COLUMN_FAVORITE) = :fa WHERE \(COLUMN_RID) = :rid"
        updateDB(sql: sql, dict: dict)
    }
    
    func delete(_ rid: Int) {
        let dict: [String: Any] = ["rid": rid]
        let sql = "DELETE FROM Cookbooks WHERE \(COLUMN_RID) = :rid"
        updateDB(sql: sql, dict: dict)
    }
    
}
    

