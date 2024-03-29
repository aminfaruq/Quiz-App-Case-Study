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
    
    private var quiz: Quiz!
    
    func test_startQuiz_answerZeroAllQuestions_completesWithAnswer() {
        let delegate = DelegateSpy()

        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)

        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")

        XCTAssertEqual(delegate.completedQuizzes.count, 1)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
    }
    
    func test_startQuiz_answerZeroAllQuestionsTwice_completesWithNewAnswer() {
        let delegate = DelegateSpy()

        quiz = Quiz.start(questions: ["Q1", "Q2"], delegate: delegate)

        delegate.answerCompletions[0]("A1")
        delegate.answerCompletions[1]("A2")

        delegate.answerCompletions[0]("A1-1")
        delegate.answerCompletions[1]("A2-2")

        XCTAssertEqual(delegate.completedQuizzes.count, 2)
        assertEqual(delegate.completedQuizzes[0], [("Q1", "A1"), ("Q2", "A2")])
        assertEqual(delegate.completedQuizzes[1], [("Q1", "A1-1"), ("Q2", "A2-2")])
    }
}
