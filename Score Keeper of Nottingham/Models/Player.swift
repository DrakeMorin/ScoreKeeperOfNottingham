//
//  Player.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import Foundation
import Combine

struct Player: Identifiable {
    internal init(id: UUID = UUID(), name: String = "", appleCount: Int = 0, cheeseCount: Int = 0, breadCount: Int = 0, chickenCount: Int = 0, pepperCount: Int = 0, meadCount: Int = 0, silkCount: Int = 0, crossbowCount: Int = 0, coinageValue: Int = 0, greenApplesCount: Int = 0, goldenApplesCount: Int = 0, goudaCheeseCount: Int = 0, blueCheseCount: Int = 0, ryeBreadCount: Int = 0, pumpernickelCount: Int = 0, dualChickenCount: Int = 0, scoreData: PlayerScore = PlayerScore()) {
        self.id = id
        self.name = name
        self.appleCount = appleCount
        self.cheeseCount = cheeseCount
        self.breadCount = breadCount
        self.chickenCount = chickenCount
        self.pepperCount = pepperCount
        self.meadCount = meadCount
        self.silkCount = silkCount
        self.crossbowCount = crossbowCount
        self.coinageValue = coinageValue
        self.greenApplesCount = greenApplesCount
        self.goldenApplesCount = goldenApplesCount
        self.goudaCheeseCount = goudaCheeseCount
        self.blueCheseCount = blueCheseCount
        self.ryeBreadCount = ryeBreadCount
        self.pumpernickelCount = pumpernickelCount
        self.dualChickenCount = dualChickenCount
        self.scoreData = scoreData
    }
    
    init(copy player: Player, scoreData: PlayerScore) {
        self.init(id: player.id, name: player.name, appleCount: player.appleCount, cheeseCount: player.cheeseCount, breadCount: player.breadCount, chickenCount: player.chickenCount, pepperCount: player.pepperCount, meadCount: player.meadCount, silkCount: player.silkCount, crossbowCount: player.crossbowCount, coinageValue: player.coinageValue, greenApplesCount: player.greenApplesCount, goldenApplesCount: player.goldenApplesCount, goudaCheeseCount: player.goudaCheeseCount, blueCheseCount: player.blueCheseCount, ryeBreadCount: player.ryeBreadCount, pumpernickelCount: player.pumpernickelCount, dualChickenCount: player.dualChickenCount, scoreData: scoreData)
    }
    
    
    let id: UUID
    var name: String = "New player"
    // Should these be private and / or constants (à la React and the UI when an edit is made creates a new object. I think that would be excessive?)
    var appleCount = 0
    var cheeseCount = 0
    var breadCount = 0
    var chickenCount = 0
    var pepperCount = 0
    var meadCount = 0
    var silkCount = 0
    var crossbowCount = 0
    var coinageValue = 0
    var greenApplesCount = 0
    var goldenApplesCount = 0
    var goudaCheeseCount = 0
    var blueCheseCount = 0
    var ryeBreadCount = 0
    var pumpernickelCount = 0
    var dualChickenCount = 0
    var scoreData = PlayerScore()
    
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
    
    var score: Int {
        return scoreData.score
    }
}

extension Player: Equatable {
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id && lhs.scoreData == rhs.scoreData
    }
}
