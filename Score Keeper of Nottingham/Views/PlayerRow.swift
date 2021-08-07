//
//  PlayerRow.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI

private let SILVER_COLOR = Color(red: 128 / 255, green: 128 / 255, blue: 128 / 255)
private let GOLD_COLOR = Color(red: 212 / 255, green: 175 / 255, blue: 55 / 255)

let dummyPlayer = Player(name: "John", appleCount: 6, cheeseCount: 3, breadCount: 3, chickenCount: 1, pepperCount: 3, meadCount: 2, silkCount: 2, crossbowCount: 1, coinageValue: 10, greenApplesCount: 0, goldenApplesCount: 0, goudaCheeseCount: 0, blueCheseCount: 0, ryeBreadCount: 0, pumpernickelCount: 0, dualChickenCount: 0,
                         scoreData: PlayerScore(score: 131,
                                                isAppleKing: true, isAppleQueen: false,
                                                isCheeseKing: false, isCheeseQueen: false,
                                                isBreadKing: false, isBreadQueen: true,
                                                isChickenKing: false, isChickenQueen: false,
                                                isWinner: false)
)

struct PlayerRow: View {
    @Binding var player: Player
    
    var body: some View {
        VStack {
            HStack{
                Text(player.name)
                Spacer()
                Text(String(player.scoreData.score))
            }.padding(.bottom, 4)
            if player.hasBonuses {
                BonusesView(bonuses: player.earnedBonuses)
            }
        }
    }
}

struct BonusesView: View {
    let bonuses: [String]
    
    var body: some View {
        VStack() {
//            ScrollView(.horizontal, showsIndicators: false) {
                HStack() {
                    ForEach(bonuses, id: \.self) { bonus in
                        let color = bonus.contains("K") ? GOLD_COLOR : SILVER_COLOR
                        BonusCell(text: bonus, color: color)
                    }
                    Spacer()
                }
//            }
        }
    }
}

struct BonusCell: View {
    let text: String
    let color: Color
    
    var body: some View {
        Text(text)
            .fontWeight(.bold)
            .foregroundColor(color)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .font(.system(size: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(color, lineWidth: 2)
            )
    }
}
