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
            List(listData.playerData) { player in
                let playerBinding = binding(for: player)
                NavigationLink(destination: PlayerDetail(player: playerBinding)) {
                    PlayerRow(player: playerBinding)
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
    
    private func binding(for player: Player) -> Binding<Player> {
        guard let idx = listData.playerData.firstIndex(where: { $0.id == player.id }) else {
            fatalError("Could not find player index")
        }
        
        return $listData.playerData[idx]
    }
}

//struct PlayerList_Previews: PreviewProvider {
//    static var previews: some View {
//        PlayerList()
//            .environmentObject(ListData())
//    }
//}
