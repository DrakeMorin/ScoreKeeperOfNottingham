//
//  PlayerRow.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI

let dummyPlayer = Player(name: "John", appleCount: 6, cheeseCount: 3, breadCount: 3, chickenCount: 1, pepperCount: 3, meadCount: 2, silkCount: 2, crossbowCount: 1, coinageValue: 10, greenApplesCount: 0, goldenApplesCount: 0, goudaCheeseCount: 0, blueCheseCount: 0, ryeBreadCount: 0, pumpernickelCount: 0, dualChickenCount: 0,
                              scoreData: PlayerScore(score: 131,
                              isAppleKing: true, isAppleQueen: false,
                              isCheeseKing: false, isCheeseQueen: false,
                              isBreadKing: false, isBreadQueen: true,
                              isChickenKing: false, isChickenQueen: false,
                              isWinner: false)
)

struct PlayerRow: View {
    @State var player: Player
    
    var body: some View {
        HStack{
            Text(player.name)
            Spacer()
            Text(String(player.scoreData.score))
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRow(player: dummyPlayer)
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
