//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Amin faruq on 20/02/24.
//

import XCTest
import XCTest
import QuizEngine

final class GameTest: XCTestCase {

    func test_startGame_answerOneOutOfTwoCorrectly_scores1() {
        let router = RouterSpy()
        startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])

        router.answerCallback("A1")
        router.answerCallback("wrong")

        XCTAssertEqual(router.routedResult?.score, 1)
    }

}
