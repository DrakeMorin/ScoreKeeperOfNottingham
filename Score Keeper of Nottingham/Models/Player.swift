//
//  Player.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import Foundation

struct Player {
    let name: String
    let appleCount: Int
    let cheeseCount: Int
    let breadCount: Int
    let chickenCount: Int
    let pepperCount: Int
    let meadCount: Int
    let silkCount: Int
    let crossbowCount: Int
    let coinageValue: Int
    let greenApplesCount: Int
    let goldenApplesCount: Int
    let goudaCheeseCount: Int
    let blueCheseCount: Int
    let ryeBreadCount: Int
    let pumpernickelCount: Int
    let dualChickenCount: Int
    
    
    var totalApples: Int {
        return appleCount + greenApplesCount * APPLES_ON_GREEN_APPLES + goldenApplesCount * APPLES_ON_GOLDEN_APPLES
    }
    
    var totalCheese: Int {
        return cheeseCount + goudaCheeseCount * CHEESE_ON_GOUDA + blueCheseCount * CHEESE_ON_BLUE_CHEESE
    }
    
    var totalBread: Int {
        return breadCount + ryeBreadCount * BREAD_ON_RYE + pumpernickelCount * BREAD_ON_PUMPERNICKEL
    }
    
    var totalChickens: Int {
        return chickenCount + dualChickenCount * CHICKENS_ON_DUAL_CHICKEN
    }
    
    var totalLegalGoods: Int {
        return appleCount + cheeseCount + breadCount + chickenCount
    }
    
    var totalContrabandGoods: Int {
        return pepperCount + meadCount + silkCount + crossbowCount +
            greenApplesCount + goldenApplesCount + goudaCheeseCount + blueCheseCount +
            ryeBreadCount + pumpernickelCount + dualChickenCount
    }
}
