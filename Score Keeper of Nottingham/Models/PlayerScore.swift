//
//  PlayerScore.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import Foundation

struct PlayerScore {
    init(score: Int = 0, isAppleKing: Bool = false, isAppleQueen: Bool = false, isCheeseKing: Bool = false, isCheeseQueen: Bool = false, isBreadKing: Bool = false, isBreadQueen: Bool = false, isChickenKing: Bool = false, isChickenQueen: Bool = false, isWinner: Bool = false) {
        self.score = score
        self.isAppleKing = isAppleKing
        self.isAppleQueen = isAppleQueen
        self.isCheeseKing = isCheeseKing
        self.isCheeseQueen = isCheeseQueen
        self.isBreadKing = isBreadKing
        self.isBreadQueen = isBreadQueen
        self.isChickenKing = isChickenKing
        self.isChickenQueen = isChickenQueen
        self.isWinner = isWinner
    }
    
    let score: Int
    let isAppleKing: Bool
    let isAppleQueen: Bool
    let isCheeseKing: Bool
    let isCheeseQueen: Bool
    let isBreadKing: Bool
    let isBreadQueen: Bool
    let isChickenKing: Bool
    let isChickenQueen: Bool
    var isWinner = false
}
