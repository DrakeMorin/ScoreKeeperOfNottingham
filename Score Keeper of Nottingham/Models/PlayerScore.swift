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

    var hasBonuses: Bool {
        return isAppleKing || isAppleQueen ||
            isCheeseKing || isCheeseQueen ||
            isBreadKing || isBreadQueen ||
            isChickenKing || isChickenQueen
    }

    var earnedBonuses: [String] {
        let bonusMap = [
            "🍎 K" : isAppleKing,
            "🍎 Q" : isAppleQueen,
            "🧀 K" : isCheeseKing,
            "🧀 Q" : isCheeseQueen,
            "🍞 K" : isBreadKing,
            "🍞 Q" : isBreadQueen,
            "🐓 K" : isChickenKing,
            "🐓 Q" : isChickenQueen,
        ]

        return bonusMap.compactMap { bonus, bonusEarned in
            bonusEarned ? bonus : nil
        }.sorted()
    }
}

extension PlayerScore: Equatable {
    static func == (lhs: PlayerScore, rhs: PlayerScore) -> Bool {
        return lhs.score == rhs.score && lhs.isAppleKing == rhs.isAppleKing &&
            lhs.isAppleQueen == rhs.isAppleQueen && lhs.isCheeseKing == rhs.isCheeseKing &&
            lhs.isCheeseQueen == rhs.isCheeseQueen && lhs.isBreadKing == rhs.isBreadKing &&
            lhs.isBreadQueen == rhs.isBreadQueen && lhs.isChickenKing == rhs.isChickenKing &&
            lhs.isChickenQueen == rhs.isChickenQueen && lhs.isWinner == rhs.isWinner
    }
}
