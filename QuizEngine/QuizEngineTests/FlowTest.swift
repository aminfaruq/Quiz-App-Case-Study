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
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(delegate.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q1","Q2"]).start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routeToCorrectQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswersFirstQuestionAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswersFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertEqual(delegate.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestions_routesToResult() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(delegate.routedResult?.answers, [:])
    }
    
    func test_start_withOneQuestions_doesNotRouteToResult() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertNil(delegate.routedResult)
    }
    
    func test_startAndAnswerFirstQuestion_withTwoQuestions_doesNotRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        
        XCTAssertNil(delegate.routedResult)
    }
    
    func test_startAndAnswersFirstAndSecondQuestion_withTwoQuestion_routesToResult() {
        let sut = makeSUT(questions: ["Q1" , "Q2"])
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.routedResult?.answers, ["Q1" : "A1", "Q2" : "A2"])
    }
    
    func test_startAndAnswersFirstAndSecondQuestion_withTwoQuestion_scores() {
        let sut = makeSUT(questions: ["Q1" , "Q2"], scoring: { _ in 10 })
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(delegate.routedResult?.score, 10)
    }
    
    func test_startAndAnswersFirstAndSecondQuestion_withTwoQuestion_scoresWithRightAnswers() {
        var receivedAnswers = [String: String]()
        let sut = makeSUT(questions: ["Q1" , "Q2"], scoring: { answers in
            receivedAnswers = answers
            return 20
        })
        sut.start()
        
        delegate.answerCallback("A1")
        delegate.answerCallback("A2")
        
        XCTAssertEqual(receivedAnswers, ["Q1" : "A1", "Q2" : "A2"])
    }
    
    //MARK: - Helpers -
    
    private weak var weakSUT: Flow<DelegateSpy>?
    
    override func tearDown() {
        super.tearDown()
        
        XCTAssertNil(weakSUT, "Memory leak detected. Weak reference to the SUT (Flow<DelegateSpy>) instance is not nil.")
    }
    
    private func makeSUT(questions: [String],
                         scoring: @escaping ([String: String]) -> Int = { _ in 0 }) -> Flow<DelegateSpy> {
        let sut = Flow(questions: questions, router: delegate, scoring: scoring)
        weakSUT = sut
        return sut
    }
    
    private class DelegateSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: Result<String, String>? = nil
        var answerCallback: (Answer) -> Void = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: Result<String, String>) {
            routedResult = result
        }
    }
}
