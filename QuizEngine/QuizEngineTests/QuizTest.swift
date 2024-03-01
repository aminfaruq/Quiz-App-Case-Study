//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Amin faruq on 01/03/24.
//

import Foundation
import XCTest
import QuizEngine

final class QuizTest: XCTestCase {
    
    private let delegate = DelegateSpy()
    private var quiz: Quiz!
    
    override func setUp() {
        super.setUp()
        
        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate, correctAnswers: ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_startQuiz_answerZeroOutOfTwoCorrectly_scoresZero() {
        delegate.answerCallback("wrong")
        delegate.answerCallback("wrong")

        XCTAssertEqual(delegate.handledResult?.score, 0)
    }

    func test_startQuiz_answerOneOutOfTwoCorrectly_scoresOne() {
        delegate.answerCallback("A1")
        delegate.answerCallback("wrong")

        XCTAssertEqual(delegate.handledResult?.score, 1)
    }
    
    func test_startQuiz_answerTwoOutOfTwoCorrectly_scoresTwo() {
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")

        XCTAssertEqual(delegate.handledResult?.score, 2)
    }
    
    private class DelegateSpy: QuizDelegate {
        var handledResult: Result<String, String>? = nil
        
        var answerCallback: (Answer) -> Void = { _ in }
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            self.answerCallback = completion
        }
        
        func handle(result: Result<String, String>) {
            handledResult = result
        }
    }
}
