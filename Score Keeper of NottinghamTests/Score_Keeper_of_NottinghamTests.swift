//
//  Score_Keeper_of_NottinghamTests.swift
//  Score Keeper of NottinghamTests
//
//  Created by Drake Morin on 2020-09-03.
//  Copyright © 2020 Drake Morin. All rights reserved.
//

import XCTest
@testable import Score_Keeper_of_Nottingham

class Score_Keeper_of_NottinghamTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlayerWithNoItemsScore() throws {
        let player1 = Player(name: "Tess")
        let scoredPlayers = scoreGame(for: [player1])
        
        XCTAssertEqual(scoredPlayers.count, 1, "There should only be one returned player with a score")
        let scoredPlayer = scoredPlayers.first!
        
        XCTAssertEqual(scoredPlayer.id, player1.id, "Player should retain the same ID")
        XCTAssertEqual(scoredPlayer.name, player1.name, "Player should retain the same name")
        
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
        
        XCTAssertEqual(scoredPlayer.id, player1.id, "Player should retain the same ID")
        XCTAssertEqual(scoredPlayer.name, player1.name, "Player should retain the same name")
        
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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
