//
//  PlayerScore.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import Foundation

struct PlayerScore {
    let name: String
    let playerHand: Player
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
