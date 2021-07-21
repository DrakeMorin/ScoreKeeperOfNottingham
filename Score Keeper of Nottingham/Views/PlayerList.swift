//
//  PlayerList.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI

struct PlayerList: View {
    @ObservedObject var listData: ListData

    var body: some View {
        NavigationView {
            List(listData.playerData.indices) { i in
                NavigationLink(destination: PlayerDetail(player: $listData.playerData[i])) {
                    PlayerRow(player: $listData.playerData[i])
                }
            }
            .navigationBarTitle("Players")
            .navigationBarItems(
                trailing: Button(action: { self.addNewPlayer() }, label: { Text("Add") })
            )
            
        }
    }

    func addNewPlayer() {
        let newPlayer = Player(name: "New player")
        listData.playerData.append(newPlayer)
    }

    func clearPlayers() {
        listData.playerData = []
    }
}

//struct PlayerList_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerList()
//            .environmentObject(ListData())
//    }
//}
