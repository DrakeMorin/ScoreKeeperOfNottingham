//
//  PlayerList.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI

protocol PlayerListActionable: class {
    func playerListDidAdd()
    func playerListDidClear()
}

struct PlayerList: View {
    @EnvironmentObject var listData: ListData
    
    weak var actionable: PlayerListActionable?
    
    var body: some View {
        NavigationView {
            List(listData.playerData, id: \.player.id) { playerScore in
                NavigationLink(destination: PlayerDetail(player: playerScore.player)) {
                    PlayerRow(playerScore: playerScore)
                }
            }
            .navigationBarTitle("Players")
            .navigationBarItems(
                trailing: Button(action: { self.actionable?.playerListDidAdd() }, label: { Text("Add") })
            )
            
        }
    }
}

struct PlayerList_Previews: PreviewProvider {
    static var previews: some View {
        PlayerList()
            .environmentObject(ListData())
    }
}
