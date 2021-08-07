//
//  PlayerDetail.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI
import Combine

struct PlayerDetail: View {
    @State var isRoyalGoodsEnabled = false
    @Binding var player: Player
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Player Name")
                Spacer()
                TextField("", text:$player.name)
                    .frame(width: 160)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            Group {
                NumericTextField(value: $player.coinageValue, text: "Coins")
                NumericTextField(value: $player.appleCount, text: "Apples")
                NumericTextField(value: $player.cheeseCount,text: "Cheese")
                NumericTextField(value: $player.breadCount,text: "Bread")
                NumericTextField(value: $player.chickenCount,text: "Chickens")
                NumericTextField(value: $player.pepperCount,text: "Pepper")
                NumericTextField(value: $player.meadCount,text: "Mead")
                NumericTextField(value: $player.silkCount,text: "Silk")
                NumericTextField(value: $player.crossbowCount,text: "Crossbows")
            }
            
            Toggle(isOn: $isRoyalGoodsEnabled) {
                Text("Royal Goods")
            }
            
            if isRoyalGoodsEnabled {
                Group {
                    NumericTextField(value: $player.greenApplesCount,text: "Green Apples")
                    NumericTextField(value: $player.goldenApplesCount,text: "Golden Apples")
                    NumericTextField(value: $player.goudaCheeseCount,text: "Gouda")
                    NumericTextField(value: $player.blueCheseCount,text: "Blue Cheese")
                    NumericTextField(value: $player.ryeBreadCount,text: "Rye")
                    NumericTextField(value: $player.pumpernickelCount,text: "Pumpernickel")
                    NumericTextField(value: $player.dualChickenCount,text: "Dual Chickens")
                }
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
    }
}

//struct PlayerDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerDetail(player: dummyPlayer)
//            .environmentObject(ListData())
//    }
//}
