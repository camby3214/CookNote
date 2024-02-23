//
//  StrpListDAO.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/28.
//

import Foundation

class StepListDAO {
    private static var _inst = StepListDAO()
    public static var shared: StepListDAO {
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
    let TABLE_NAME = "StepList"
    let COLUMN_RID = "rid"
    let COLUMN_IGROUP = "igroup"
    let COLUMN_STEP = "step"
    let COLUMN_IMAGE = "image"
    let COLUMN_INSTRUCTION = "instruction"
    
    
    //從資料庫抓取所有資料(sql語法)
    func getAllStepList() -> [StepList] {
        var list = [StepList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM \(TABLE_NAME)"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: []) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let step = Int(resultSet.int(forColumn: COLUMN_STEP))
                let image = resultSet.data(forColumn: COLUMN_IMAGE)
                let instruction = resultSet.string(forColumn: COLUMN_INSTRUCTION) ?? ""
                let data = StepList(rid: rid, igroup: igroup, step: step, image: image,instruction: instruction)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    
    func getStepListByGroup(_ igroup:Int) -> [StepList] {
        var  list = [StepList]()
        let db = FMDatabase(path: dbPath)
        db?.open()
        
        let sql = "SELECT * FROM  \(TABLE_NAME) WHERE igroup  = ?"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [igroup]) {
            while resultSet.next() {
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let step = Int(resultSet.int(forColumn: COLUMN_STEP))
                let image = resultSet.data(forColumn: COLUMN_IMAGE)
                let instruction = resultSet.string(forColumn: COLUMN_INSTRUCTION) ?? ""
                let data = StepList(rid: rid, igroup: igroup, step: step, image: image,instruction: instruction)
                list.append(data)
            }
            resultSet.close()
        }
        db?.close()
        return list
    }
    
    
    
    func getStepListListById(_ rid: Int) -> StepList? {
        var ret: StepList?
        let db = FMDatabase(path: dbPath)
        db?.open()
        let sql = "SELECT * FROM StepList WHERE rid = ?"
        if let resultSet = db?.executeQuery(sql, withArgumentsIn: [rid]) {
            if resultSet.next(){
                let rid = Int(resultSet.int(forColumn: COLUMN_RID))
                let igroup = Int(resultSet.int(forColumn: COLUMN_IGROUP))
                let step = Int(resultSet.int(forColumn: COLUMN_STEP))
                let image = resultSet.data(forColumn: COLUMN_IMAGE)
                let instruction = resultSet.string(forColumn: COLUMN_INSTRUCTION) ?? ""
                ret = StepList(rid: rid, igroup: igroup, step: step, image: image,instruction: instruction)
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
    
    func insert(_ data: StepList) {
        var dict = [String: Any]()
        dict["g"] = data.igroup
        dict["s"] = data.step
        dict["t"] = data.instruction
        let sql = "INSERT INTO StepList(\(COLUMN_IGROUP),\(COLUMN_STEP),\(COLUMN_INSTRUCTION)) VALUES (:g, :s, :t)"
        updateDB(sql: sql, dict: dict)
    }
    
    func update(_ data: StepList) {
        var dict: [String: Any] = ["g": data.igroup, "s": data.step, "t": data.instruction, "rid": data.rid]
        let sql = "UPDATE StepList SET \(COLUMN_IGROUP) = :g, \(COLUMN_STEP) = :s, \(COLUMN_INSTRUCTION) = :t) WHERE \(COLUMN_RID) = :rid"
        updateDB(sql: sql, dict: dict)
    }
    
    func delete(_ rid: Int) {
        let dict: [String: Any] = ["rid": rid]
        let sql = "DELETE FROM StepList WHERE \(COLUMN_RID) = :rid"
        updateDB(sql: sql, dict: dict)
    }
    
}
