//
//  ScoreTest.swift
//  QuizEngineTests
//
//  Created by Amin faruq on 07/03/24.
//

import XCTest

final class ScoreTest: XCTestCase {

    func test_noAnswers_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: [], comparingTo: []), 0)
    }
    
    func test_oneWrongAnswer_scoresZero() {
        XCTAssertEqual(BasicScore.score(for: ["wrong"], comparingTo: ["correct"]), 0)
    }
    
    private class BasicScore{
        static func score(for: [Any], comparingTo: [Any]) -> Int {
            return 0
        }
    }
}
