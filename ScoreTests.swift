//
//  ScoreTests.swift
//  Score Keeper of NottinghamTests
//
//  Created by Drake Morin on 2021-07-21.
//  Copyright © 2021 Drake Morin. All rights reserved.
//

import XCTest
@testable import Score_Keeper_of_Nottingham

class ScoreTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func assertPlayerNameAndIDUnchanged(player: Player, scoredplayer: Player) {
        XCTAssertEqual(scoredplayer.id, player.id, "Player should retain the same ID")
        XCTAssertEqual(scoredplayer.name, player.name, "Player should retain the same name")
    }

    func testPlayerWithNoItemsScore() throws {
        let player1 = Player(name: "Tess")
        let scoredPlayers = scoreGame(for: [player1])
        
        XCTAssertEqual(scoredPlayers.count, 1, "There should only be one returned player with a score")
        let scoredPlayer = scoredPlayers.first!
        
        assertPlayerNameAndIDUnchanged(player: player1, scoredplayer: scoredPlayer)
        
        XCTAssertFalse(scoredPlayer.scoreData.isAppleKing)
        XCTAssertFalse(scoredPlayer.scoreData.isCheeseKing)
        XCTAssertFalse(scoredPlayer.scoreData.isBreadKing)
        XCTAssertFalse(scoredPlayer.scoreData.isChickenKing)
        XCTAssertFalse(scoredPlayer.scoreData.isAppleQueen)
        XCTAssertFalse(scoredPlayer.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredPlayer.scoreData.isBreadQueen)
        XCTAssertFalse(scoredPlayer.scoreData.isChickenQueen)
        
        XCTAssertEqual(scoredPlayer.score, 0)
    }

    func testSinglePlayerScore() throws {
        // Test scoring a single player who has at least one of every good from the base game
        let player1 = Player(name: "Tess", appleCount: 13, cheeseCount: 8, breadCount: 6, chickenCount: 3, pepperCount: 2, meadCount: 4, silkCount: 2, crossbowCount: 5, coinageValue: 50)
        let scoredPlayers = scoreGame(for: [player1])
        
        XCTAssertEqual(scoredPlayers.count, 1, "There should only be one returned player with a score")
        let scoredPlayer = scoredPlayers.first!
        
        assertPlayerNameAndIDUnchanged(player: player1, scoredplayer: scoredPlayer)
        
        XCTAssertTrue(scoredPlayer.scoreData.isAppleKing)
        XCTAssertTrue(scoredPlayer.scoreData.isCheeseKing)
        XCTAssertTrue(scoredPlayer.scoreData.isBreadKing)
        XCTAssertTrue(scoredPlayer.scoreData.isChickenKing)
        
        XCTAssertFalse(scoredPlayer.scoreData.isAppleQueen, "There is only one player, there should not be an Apple Queen")
        XCTAssertFalse(scoredPlayer.scoreData.isCheeseQueen, "There is only one player, there should not be a Cheese Queen")
        XCTAssertFalse(scoredPlayer.scoreData.isBreadQueen, "There is only one player, there should not be a Bread Queen")
        XCTAssertFalse(scoredPlayer.scoreData.isChickenQueen, "There is only one player, there should not be a Chicken Queen")
        
        XCTAssertEqual(scoredPlayer.score, 291)
    }
    
    func testTwoPlayersOneWithAllKingsOneWithAllQueens() throws {
        // Test scoring a two player game where one player has all king bonuses, and the other gets all the queen bonuses
        let queenPlayer = Player(name: "Quinns", appleCount: 10, cheeseCount: 5, breadCount: 1, chickenCount: 2, pepperCount: 1, meadCount: 0, silkCount: 7, crossbowCount: 10, coinageValue: 25)
        let kingPlayer = Player(name: "Kevin", appleCount: 13, cheeseCount: 8, breadCount: 6, chickenCount: 3, pepperCount: 2, meadCount: 4, silkCount: 2, crossbowCount: 5, coinageValue: 0)
        let scoredPlayers = scoreGame(for: [queenPlayer, kingPlayer])
        
        XCTAssertEqual(scoredPlayers.count, 2)
        let scoredKingPlayer = scoredPlayers.first(where: { $0.id == kingPlayer.id })!
        let scoredQueenPlayer = scoredPlayers.first(where: { $0.id == queenPlayer.id })!
        
        XCTAssertEqual(scoredKingPlayer.id, kingPlayer.id, "Player should retain the same ID")
        XCTAssertEqual(scoredKingPlayer.name, kingPlayer.name, "Player should retain the same name")
        XCTAssertEqual(scoredQueenPlayer.id, queenPlayer.id, "Player should retain the same ID")
        XCTAssertEqual(scoredQueenPlayer.name, queenPlayer.name, "Player should retain the same name")

        // Assert King Player score attributes
        XCTAssertTrue(scoredKingPlayer.scoreData.isAppleKing)
        XCTAssertTrue(scoredKingPlayer.scoreData.isCheeseKing)
        XCTAssertTrue(scoredKingPlayer.scoreData.isBreadKing)
        XCTAssertTrue(scoredKingPlayer.scoreData.isChickenKing)
        XCTAssertFalse(scoredKingPlayer.scoreData.isAppleQueen)
        XCTAssertFalse(scoredKingPlayer.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredKingPlayer.scoreData.isBreadQueen)
        XCTAssertFalse(scoredKingPlayer.scoreData.isChickenQueen)
        XCTAssertEqual(scoredKingPlayer.score, 241)

        // Assert Queen Player score attributes
        XCTAssertFalse(scoredQueenPlayer.scoreData.isAppleKing)
        XCTAssertFalse(scoredQueenPlayer.scoreData.isCheeseKing)
        XCTAssertFalse(scoredQueenPlayer.scoreData.isBreadKing)
        XCTAssertFalse(scoredQueenPlayer.scoreData.isChickenKing)
        XCTAssertTrue(scoredQueenPlayer.scoreData.isAppleQueen)
        XCTAssertTrue(scoredQueenPlayer.scoreData.isCheeseQueen)
        XCTAssertTrue(scoredQueenPlayer.scoreData.isBreadQueen)
        XCTAssertTrue(scoredQueenPlayer.scoreData.isChickenQueen)
        XCTAssertEqual(scoredQueenPlayer.score, 258)
    }
    
    func testTwoPlayersTiedKingBonuses() throws {
        // Test scoring a three player game where two players have all the king bonuses and the third player gets none
        let player1 = Player(name: "Kevin", appleCount: 13, cheeseCount: 8, breadCount: 6, chickenCount: 3, pepperCount: 4, meadCount: 4, silkCount: 3, crossbowCount: 3, coinageValue: 10)
        let player2 = Player(name: "Karen", appleCount: 13, cheeseCount: 8, breadCount: 6, chickenCount: 3, pepperCount: 2, meadCount: 4, silkCount: 2, crossbowCount: 5, coinageValue: 20)
        let player3 = Player(name: "Lassie", appleCount: 3, cheeseCount: 4, breadCount: 2, chickenCount: 1, pepperCount: 4, meadCount: 1, silkCount: 3, crossbowCount: 0, coinageValue: 35)
        let scoredPlayers = scoreGame(for: [player1, player2, player3])
        
        XCTAssertEqual(scoredPlayers.count, 3)
        let scoredplayer1 = scoredPlayers.first(where: { $0.id == player1.id })!
        let scoredplayer2 = scoredPlayers.first(where: { $0.id == player2.id })!
        let scoredplayer3 = scoredPlayers.first(where: { $0.id == player3.id })!
        
        assertPlayerNameAndIDUnchanged(player: player1, scoredplayer: scoredplayer1)
        assertPlayerNameAndIDUnchanged(player: player2, scoredplayer: scoredplayer2)
        assertPlayerNameAndIDUnchanged(player: player3, scoredplayer: scoredplayer3)

        // Since there is a tie between the king bonuses, we expect the awarded bonus to be:
        // (king bonus + queen bonus) / 2 with the remainder dropped. No queen bonus should be awarded.
        XCTAssertTrue(scoredplayer1.scoreData.isAppleKing)
        XCTAssertTrue(scoredplayer1.scoreData.isCheeseKing)
        XCTAssertTrue(scoredplayer1.scoreData.isBreadKing)
        XCTAssertTrue(scoredplayer1.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer1.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer1.score, 239)

        XCTAssertTrue(scoredplayer2.scoreData.isAppleKing)
        XCTAssertTrue(scoredplayer2.scoreData.isCheeseKing)
        XCTAssertTrue(scoredplayer2.scoreData.isBreadKing)
        XCTAssertTrue(scoredplayer2.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer2.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer2.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer2.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer2.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer2.score, 247)
        
        // Player3 should not have any king or queen bonuses since all the king bonuses were tied
        XCTAssertFalse(scoredplayer3.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer3.scoreData.isCheeseKing)
        XCTAssertFalse(scoredplayer3.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer3.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer3.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer3.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer3.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer3.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer3.score, 118)
    }
    
    func testTwoPlayersTiedQueenBonuses() throws {
        // Test scoring a three player game where one player has all king bonuses, and the other two share all the queen bonuses
        let player1 = Player(name: "Kevin", appleCount: 13, cheeseCount: 8, breadCount: 6, chickenCount: 3, pepperCount: 4, meadCount: 4, silkCount: 3, crossbowCount: 3, coinageValue: 10)
        let player2 = Player(name: "Quinns", appleCount: 3, cheeseCount: 4, breadCount: 2, chickenCount: 1, pepperCount: 2, meadCount: 4, silkCount: 2, crossbowCount: 5, coinageValue: 20)
        let player3 = Player(name: "Quill", appleCount: 3, cheeseCount: 4, breadCount: 2, chickenCount: 1, pepperCount: 4, meadCount: 1, silkCount: 3, crossbowCount: 0, coinageValue: 35)
        let scoredPlayers = scoreGame(for: [player1, player2, player3])
        
        XCTAssertEqual(scoredPlayers.count, 3)
        let scoredplayer1 = scoredPlayers.first(where: { $0.id == player1.id })!
        let scoredplayer2 = scoredPlayers.first(where: { $0.id == player2.id })!
        let scoredplayer3 = scoredPlayers.first(where: { $0.id == player3.id })!
        
        assertPlayerNameAndIDUnchanged(player: player1, scoredplayer: scoredplayer1)
        assertPlayerNameAndIDUnchanged(player: player2, scoredplayer: scoredplayer2)
        assertPlayerNameAndIDUnchanged(player: player3, scoredplayer: scoredplayer3)

        // Player 1 wins the king bonuses
        XCTAssertTrue(scoredplayer1.scoreData.isAppleKing)
        XCTAssertTrue(scoredplayer1.scoreData.isCheeseKing)
        XCTAssertTrue(scoredplayer1.scoreData.isBreadKing)
        XCTAssertTrue(scoredplayer1.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer1.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer1.score, 253)

        // Since there is a tie between for the queen bonuses, we expect the awarded bonus to be:
        // queen bonus / 2 with the remainder dropped.
        XCTAssertFalse(scoredplayer2.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer2.scoreData.isCheeseKing)
        XCTAssertFalse(scoredplayer2.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer2.scoreData.isChickenKing)
        XCTAssertTrue(scoredplayer2.scoreData.isAppleQueen)
        XCTAssertTrue(scoredplayer2.scoreData.isCheeseQueen)
        XCTAssertTrue(scoredplayer2.scoreData.isBreadQueen)
        XCTAssertTrue(scoredplayer2.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer2.score, 166)
        
        
        XCTAssertFalse(scoredplayer3.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer3.scoreData.isCheeseKing)
        XCTAssertFalse(scoredplayer3.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer3.scoreData.isChickenKing)
        XCTAssertTrue(scoredplayer3.scoreData.isAppleQueen)
        XCTAssertTrue(scoredplayer3.scoreData.isCheeseQueen)
        XCTAssertTrue(scoredplayer3.scoreData.isBreadQueen)
        XCTAssertTrue(scoredplayer3.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer3.score, 135)
    }
    
    func testSixPlayerGame() throws {
        // Test scoring a 6 player game with a mix of bonuses distributed
        let player1 = Player(name: "Ava", appleCount: 13, cheeseCount: 8, breadCount: 4, chickenCount: 3, pepperCount: 3, meadCount: 8, silkCount: 4, crossbowCount: 3, coinageValue: 17)
        let player2 = Player(name: "Quinns", appleCount: 11, cheeseCount: 7, breadCount: 9, chickenCount: 11, pepperCount: 2, meadCount: 4, silkCount: 2, crossbowCount: 5, coinageValue: 12)
        let player3 = Player(name: "Matt", appleCount: 9, cheeseCount: 12, breadCount: 9, chickenCount: 5, pepperCount: 0, meadCount: 4, silkCount: 6, crossbowCount: 2, coinageValue: 58)
        let player4 = Player(name: "Tom B.", appleCount: 3, cheeseCount: 14, breadCount: 9, chickenCount: 13, pepperCount: 1, meadCount: 7, silkCount: 3, crossbowCount: 0, coinageValue: 91)
        let player5 = Player(name: "Tom V.", appleCount: 8, cheeseCount: 2, breadCount: 3, chickenCount: 7, pepperCount: 1, meadCount: 3, silkCount: 2, crossbowCount: 1, coinageValue: 32)
        let player6 = Player(name: "Paul", appleCount: 7, cheeseCount: 4, breadCount: 6, chickenCount: 11, pepperCount: 4, meadCount: 2, silkCount: 5, crossbowCount: 2, coinageValue: 35)
        let scoredPlayers = scoreGame(for: [player1, player2, player3, player4, player5, player6])
        
        XCTAssertEqual(scoredPlayers.count, 6)
        let scoredplayer1 = scoredPlayers.first(where: { $0.id == player1.id })!
        let scoredplayer2 = scoredPlayers.first(where: { $0.id == player2.id })!
        let scoredplayer3 = scoredPlayers.first(where: { $0.id == player3.id })!
        let scoredplayer4 = scoredPlayers.first(where: { $0.id == player4.id })!
        let scoredplayer5 = scoredPlayers.first(where: { $0.id == player5.id })!
        let scoredplayer6 = scoredPlayers.first(where: { $0.id == player6.id })!
        
        assertPlayerNameAndIDUnchanged(player: player1, scoredplayer: scoredplayer1)
        assertPlayerNameAndIDUnchanged(player: player2, scoredplayer: scoredplayer2)
        assertPlayerNameAndIDUnchanged(player: player3, scoredplayer: scoredplayer3)
        assertPlayerNameAndIDUnchanged(player: player4, scoredplayer: scoredplayer4)
        assertPlayerNameAndIDUnchanged(player: player5, scoredplayer: scoredplayer5)
        assertPlayerNameAndIDUnchanged(player: player6, scoredplayer: scoredplayer6)
        
        // Player1 is apple king
        XCTAssertTrue(scoredplayer1.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer1.scoreData.isCheeseKing)
        XCTAssertFalse(scoredplayer1.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer1.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer1.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer1.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer1.score, 244)
        
        // Player2 is apple queen, tied bread king, and tied chicken queen
        XCTAssertFalse(scoredplayer2.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer2.scoreData.isCheeseKing)
        XCTAssertTrue(scoredplayer2.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer2.scoreData.isChickenKing)
        XCTAssertTrue(scoredplayer2.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer2.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer2.scoreData.isBreadQueen)
        XCTAssertTrue(scoredplayer2.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer2.score, 247)
        
        // Player3 is cheese queen and tied bread king
        XCTAssertFalse(scoredplayer3.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer3.scoreData.isCheeseKing)
        XCTAssertTrue(scoredplayer3.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer3.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer3.scoreData.isAppleQueen)
        XCTAssertTrue(scoredplayer3.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer3.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer3.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer3.score, 271)
        
        // Player4 is cheese king, tied bread king, chicken king
        XCTAssertFalse(scoredplayer4.scoreData.isAppleKing)
        XCTAssertTrue(scoredplayer4.scoreData.isCheeseKing)
        XCTAssertTrue(scoredplayer4.scoreData.isBreadKing)
        XCTAssertTrue(scoredplayer4.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer4.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer4.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer4.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer4.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer4.score, 330)
        
        // Player5 holds no bonuses
        XCTAssertFalse(scoredplayer5.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer5.scoreData.isCheeseKing)
        XCTAssertFalse(scoredplayer5.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer5.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer5.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer5.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer5.scoreData.isBreadQueen)
        XCTAssertFalse(scoredplayer5.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer5.score, 143)
        
        // Player6 is tied chicken queen
        XCTAssertFalse(scoredplayer6.scoreData.isAppleKing)
        XCTAssertFalse(scoredplayer6.scoreData.isCheeseKing)
        XCTAssertFalse(scoredplayer6.scoreData.isBreadKing)
        XCTAssertFalse(scoredplayer6.scoreData.isChickenKing)
        XCTAssertFalse(scoredplayer6.scoreData.isAppleQueen)
        XCTAssertFalse(scoredplayer6.scoreData.isCheeseQueen)
        XCTAssertFalse(scoredplayer6.scoreData.isBreadQueen)
        XCTAssertTrue(scoredplayer6.scoreData.isChickenQueen)
        XCTAssertEqual(scoredplayer6.score, 221)
    }

    func testScoreSortsPlayers() throws {
        // Test that scoring a six player game returns the players in order for highest to lowest score.
        let player1 = Player(name: "Ava", appleCount: 13, cheeseCount: 8, breadCount: 4, chickenCount: 3, pepperCount: 3, meadCount: 8, silkCount: 4, crossbowCount: 3, coinageValue: 17)
        let player2 = Player(name: "Quinns", appleCount: 11, cheeseCount: 7, breadCount: 9, chickenCount: 11, pepperCount: 2, meadCount: 4, silkCount: 2, crossbowCount: 5, coinageValue: 12)
        let player3 = Player(name: "Matt", appleCount: 9, cheeseCount: 12, breadCount: 9, chickenCount: 5, pepperCount: 0, meadCount: 4, silkCount: 6, crossbowCount: 2, coinageValue: 58)
        let player4 = Player(name: "Tom B.", appleCount: 3, cheeseCount: 14, breadCount: 9, chickenCount: 13, pepperCount: 1, meadCount: 7, silkCount: 3, crossbowCount: 0, coinageValue: 91)
        let player5 = Player(name: "Tom V.", appleCount: 8, cheeseCount: 2, breadCount: 3, chickenCount: 7, pepperCount: 1, meadCount: 3, silkCount: 2, crossbowCount: 1, coinageValue: 32)
        let player6 = Player(name: "Paul", appleCount: 7, cheeseCount: 4, breadCount: 6, chickenCount: 11, pepperCount: 4, meadCount: 2, silkCount: 5, crossbowCount: 2, coinageValue: 35)
        let scoredPlayers = scoreGame(for: [player1, player2, player3, player4, player5, player6])
        
        XCTAssertEqual(scoredPlayers[0].id, player4.id)
        XCTAssertEqual(scoredPlayers[1].id, player3.id)
        XCTAssertEqual(scoredPlayers[2].id, player2.id)
        XCTAssertEqual(scoredPlayers[3].id, player1.id)
        XCTAssertEqual(scoredPlayers[4].id, player6.id)
        XCTAssertEqual(scoredPlayers[5].id, player5.id)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
