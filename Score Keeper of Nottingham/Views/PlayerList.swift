//
//  PlayerList.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI

struct PlayerList: View {
    @ObservedObject var game: Game

    var body: some View {
        NavigationView {
            List(game.players) { player in
                let playerBinding = binding(for: player)
                NavigationLink(destination:
                                PlayerDetail(
                                    player: playerBinding,
                                    isRoyalGoodsEnabled: $game.isRoyalGoodsEnabled
                                )) {
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
        game.players.append(newPlayer)
    }

    func clearPlayers() {
        game.players = []
    }
    
    private func binding(for player: Player) -> Binding<Player> {
        guard let idx = game.players.firstIndex(where: { $0.id == player.id }) else {
            fatalError("Could not find player index")
        }
        
        return $game.players[idx]
    }
}
