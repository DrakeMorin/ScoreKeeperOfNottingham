//
//  Game.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-04.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI
import Combine

final class Game: ObservableObject {
    @Published var isRoyalGoodsEnabled: Bool = false
    @Published var players: [Player] = [dummyPlayer] {
        didSet {
            let scoredPlayers = scoreGame(for: players)
            guard players != scoredPlayers else { return }
            players = scoredPlayers
        }
    }
}
