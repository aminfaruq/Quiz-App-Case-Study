//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Amin faruq on 11/02/24.
//

import XCTest
@testable import QuizEngine

final class FlowTest: XCTestCase {
    
    private let delegate = DelegateSpy()
    
    func test_start_withNoQuestions_doesNotDelegateQuestionHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(delegate.handledQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_delegatesCorrectQuestionHandling() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_delegatesAnotherCorrectQuestionHandling() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_delegatesFirstQuestionHandling() {
        makeSUT(questions: ["Q1","Q2"]).start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_delegatesFirstQuestionHandlingTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswersFirstQuestionAndSecondQuestion_withThreeQuestions_delegatesSecondAndThirdQuestionHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswersFirstQuestion_withOneQuestions_doesNotDelegatesRouteToAnotherQuestionHandling() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        delegate.answerCompletion("A1")
        
        XCTAssertEqual(delegate.handledQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_doesNotCompleteQuiz() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertTrue(delegate.completedQuizzes.isEmpty)
    }
    
    func test_start_withNoQuestions_delegatesResultHandling() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(delegate.handledResult?.answers, [:])
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotDelegateResultHandling() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCompletion("A1")
        
        XCTAssertNil(delegate.handledResult)
    }
    
    func test_startAndAnswersFirstAndSecondQuestion_withTwoQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1" , "Q2"])
        sut.start()
        
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.handledResult?.answers, ["Q1" : "A1", "Q2" : "A2"])
    }
    
    func test_startAndAnswersFirstAndSecondQuestion_withTwoQuestion_scores() {
        let sut = makeSUT(questions: ["Q1" , "Q2"], scoring: { _ in 10 })
        sut.start()
        
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(delegate.handledResult?.score, 10)
    }
    
    func test_startAndAnswersFirstAndSecondQuestion_withTwoQuestion_scoresWithRightAnswers() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1" , "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        
        delegate.answerCompletion("A1")
        delegate.answerCompletion("A2")
        
        XCTAssertEqual(receivedAnswers, ["Q1" : "A1", "Q2" : "A2"])
    }
    
    //MARK: - Helpers -
    
    private weak var weakSUT: Flow<DelegateSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT instance is not nil.")
    }
    
    private func makeSUT(questions: [String],
                         scoring: @escaping ([String: String]) -> Int = { _ in 0 }) -> Flow<DelegateSpy> {
        let sut = Flow(questions: questions, delegate: delegate, scoring: scoring)
        weakSUT = sut
        return sut
    }
    
    private class DelegateSpy: QuizDelegate {
        var handledQuestions: [String] = []
        var handledResult: Result<String, String>? = nil
        var completedQuizzes: [[(String, String)]] = []
        
        var answerCompletion: (String) -> Void = { _ in }
        
        func answer(for question: String, completion: @escaping (String) -> Void) {
            handledQuestions.append(question)
            self.answerCompletion = completion
        }
        
        func handle(result: Result<String, String>) {
            handledResult = result
        }
    }
}
