//
//  Score.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import Foundation

private typealias ID = UUID
private typealias Count = Int
private typealias Kings = [ID]
private typealias Score = Int
private typealias Queens = [ID]

func scoreGame(for players: [Player]) -> [PlayerScore] {
    var scores: [PlayerScore] = []
    let appleBonuses = computeBonusScoreForGood(for: players.map { ($0.id, $0.totalApples) }, kingBonus: KING_BONUS_APPLE, queenBonus: QUEEN_BONUS_APPLE)
    let cheeseBonuses = computeBonusScoreForGood(for: players.map { ($0.id, $0.totalCheese) }, kingBonus: KING_BONUS_CHEESE, queenBonus: QUEEN_BONUS_CHEESE)
    let breadBonuses = computeBonusScoreForGood(for: players.map { ($0.id, $0.totalBread) }, kingBonus: KING_BONUS_BREAD, queenBonus: QUEEN_BONUS_BREAD)
    let chickenBonuses = computeBonusScoreForGood(for: players.map { ($0.id, $0.totalChickens) }, kingBonus: KING_BONUS_CHICKEN, queenBonus: QUEEN_BONUS_CHICKEN)
    for player in players {
        scores.append(PlayerScore(
            player: player,
            score: computeRawMaterialScore(for: player) + computeBonusScore(for: player, appleBonuses: appleBonuses, cheeseBonuses: cheeseBonuses, breadBonuses: breadBonuses, chickenBonuses: chickenBonuses),
            isAppleKing: appleBonuses.0.contains(player.id), isAppleQueen: appleBonuses.2.contains(player.id),
            isCheeseKing: cheeseBonuses.0.contains(player.id), isCheeseQueen: cheeseBonuses.0.contains(player.id),
            isBreadKing: breadBonuses.0.contains(player.id), isBreadQueen: breadBonuses.2.contains(player.id),
            isChickenKing: chickenBonuses.0.contains(player.id), isChickenQueen: chickenBonuses.2.contains(player.id))
        )
    }
    
    return orderScores(scores)
}

private func computeBonusScore(for player: Player, appleBonuses: (Kings, Score, Queens, Score),
                               cheeseBonuses: (Kings, Score, Queens, Score), breadBonuses: (Kings, Score, Queens, Score),
                               chickenBonuses: (Kings, Score, Queens, Score)) -> Int {
    var score = 0
    
    // Apple bonuses
    if appleBonuses.0.contains(player.id) {
        score += appleBonuses.1
    } else if appleBonuses.2.contains(player.id) {
        score += appleBonuses.3
    }
    
    // Cheese bonuses
    if cheeseBonuses.0.contains(player.id) {
        score += cheeseBonuses.1
    } else if cheeseBonuses.2.contains(player.id) {
        score += cheeseBonuses.3
    }
    
    // Bread bonuses
    if breadBonuses.0.contains(player.id) {
        score += breadBonuses.1
    } else if breadBonuses.2.contains(player.id) {
        score += breadBonuses.3
    }
    
    // Chicken bonuses
    if chickenBonuses.0.contains(player.id) {
        score += chickenBonuses.1
    } else if chickenBonuses.2.contains(player.id) {
        score += chickenBonuses.3
    }
    
    return score
}


private func computeRawMaterialScore(for player: Player) -> Int {
    return player.totalApples * POINTS_PER_APPLE +
        player.totalCheese * POINTS_PER_CHEESE +
        player.totalBread * POINTS_PER_BREAD +
        player.totalChickens * POINTS_PER_CHICKEN +
        player.pepperCount * POINTS_PER_PEPPER +
        player.meadCount * POINTS_PER_MEAD +
        player.silkCount * POINTS_PER_SILK +
        player.crossbowCount * POINTS_PER_CROSSBOW +
        player.coinageValue
}

private func computeBonusScoreForGood(for players: [(ID, Count)], kingBonus: Int, queenBonus: Int) -> (Kings, Score, Queens, Score) {
    let sortedPlayers = players.sorted { $0.1 > $1.1 }
    
    guard let largestAmount = sortedPlayers.first?.1 else { return ([], 0, [], 0) }
    
    let kingPlayers = players.filter { $0.1 == largestAmount }
    
    if kingPlayers.count > 1 {
        // In the event of multiple players having the most of one good, the King and Queen bonuses are
        // split between the king players. No queen points are awarded
        let scorePerPlayer: Int = ((kingBonus + queenBonus) / kingPlayers.count)
        let kings = kingPlayers.map { $0.0 }
        return (kings, scorePerPlayer, [], 0)
    }
    
    guard let kingPlayer = sortedPlayers.first?.0 else { return ([], 0, [], 0) }
    
    // Award the queen bonus
    let remainingPlayers = sortedPlayers.filter { $0.1 != largestAmount }.sorted { $0.1 > $1.1 }
    guard let nextLargestAmount = remainingPlayers.first?.1 else { return ([kingPlayer], kingBonus, [], 0) }
    let queenPlayers = remainingPlayers.filter { $0.1 == nextLargestAmount }
    
    // In the event of multiple players having the second most of one good, the Queen bonus is
    // split between the queen players
    let queenScorePerPlayer: Int = (queenBonus / queenPlayers.count)
    let queens = queenPlayers.map { $0.0 }
    return ([kingPlayer], kingBonus, queens, queenScorePerPlayer)
}

// TODO: Order sort player scores by place, ie. first, second, third, etc
private func orderScores(_ scores: [PlayerScore]) -> [PlayerScore] {
    guard let bestScore = scores.map({ $0.score }).max() else { return scores }
    
    var finalScores = scores
    var winners: [ID] = []
    let bestScoringPlayers = scores.filter({ $0.score == bestScore })
    
    if bestScoringPlayers.count > 1 {
        // In the event of a tie, the player with the most legal goods wins
        let mostLegalGoods = bestScoringPlayers.map { $0.player.totalLegalGoods }.max()
        let mostLegalGoodsPlayers = bestScoringPlayers.filter { $0.player.totalLegalGoods == mostLegalGoods }
        
        if mostLegalGoodsPlayers.count > 1 {
            // In the event that multiple players have the most legal goods, the winner is decided by
            // the most contraband goods, if there is still a tie the players share the victory
            let mostContrabandGoods = mostLegalGoodsPlayers.map { $0.player.totalLegalGoods }.max()
            let mostContrabandGoodsPlayers = mostLegalGoodsPlayers.filter { $0.player.totalContrabandGoods == mostContrabandGoods }
            
            for player in mostContrabandGoodsPlayers {
                winners.append(player.player.id)
            }
        } else {
            // We have only one winner
            winners.append(mostLegalGoodsPlayers.first!.player.id)
        }
    }
    
    // Update scores to denote winners
    for i in 1..<finalScores.count {
        if winners.contains(finalScores[i].player.id) {
            finalScores[i].isWinner = true
        }
    }
    
    return finalScores
}
