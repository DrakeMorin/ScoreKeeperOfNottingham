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
    @EnvironmentObject var listData: ListData
    @State var isRoyalGoodsEnabled = false
    @State var player: Player
    
    var playerIndex: Int {
        listData.playerData.firstIndex(where: { $0.id == player.id })!
    }
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Player Name")
                Spacer()
                TextField("", text: $listData.playerData[playerIndex].name
                )
                    .frame(width: 160)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .onReceive(Just(player.$name)) { newValue in
//                        listData.playerData[playerIndex].name = newValue
//                    }
            }
            Group {
                NumericTextField(text: "Apples")
                NumericTextField(text: "Cheese")
                NumericTextField(text: "Bread")
                NumericTextField(text: "Chickens")
                NumericTextField(text: "Pepper")
                NumericTextField(text: "Mead")
                NumericTextField(text: "Silk")
                NumericTextField(text: "Crossbows")
            }
            
            Toggle(isOn: $isRoyalGoodsEnabled) {
                Text("Royal Goods")
            }
            
            if isRoyalGoodsEnabled {
                Group {
                    NumericTextField(text: "Green Apples")
                    NumericTextField(text: "Golden Apples")
                    NumericTextField(text: "Gouda")
                    NumericTextField(text: "Blue Cheese")
                    NumericTextField(text: "Rye")
                    NumericTextField(text: "Pumpernickel")
                    NumericTextField(text: "Dual Chickens")
                }
            }
        }
        .padding(.leading, 8)
        .padding(.trailing, 8)
    }
}

struct PlayerDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetail(player: dummyPlayer)
            .environmentObject(ListData())
    }
}
