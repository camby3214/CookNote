//
//  Cookbooks.swift
//  CookNote
//
//  Created by 李韋辰 on 2021/7/28.
//

import Foundation

struct Cookbooks {
    var rid = 0
    var food = ""
    var author = ""
    var foodPhoto: Data?
    var authorPhoto: Data?
    var favorite = 1
    var btn = 0
}

struct IngredientsList {
    var rid = 0
    var igroup = 0
    var ingredients = ""
    var quantity = ""
    var selectNum = 1
}

struct StepList {
    var rid = 0
    var igroup = 0
    var step = 0
    var image: Data?
    var instruction = ""
    
}
