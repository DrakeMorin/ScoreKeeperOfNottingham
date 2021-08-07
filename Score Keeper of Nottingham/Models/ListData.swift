//
//  ListData.swift
//  Score Keeper of Nottingham
//
//  Created by Drake Morin on 2020-09-04.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import SwiftUI
import Combine

final class ListData: ObservableObject {
    @Published var playerData: [Player] = [dummyPlayer] {
        didSet {
            let scoredPlayers = scoreGame(for: playerData)
            guard playerData != scoredPlayers else { return }
            playerData = scoredPlayers
        }
    }
}
