//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Amin faruq on 07/03/24.
//

import XCTest

final class ScoreTest: XCTestCase {

    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: []), 0)
    }
    
    private class BasicScore{
        static func score(for: [Any]) -> Int {
            return 0        }
    }
}
