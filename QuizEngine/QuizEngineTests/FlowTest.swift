//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Amin faruq on 11/02/24.
//

import XCTest
//@testable import QuizEngine

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
}

class Flow {
    private let router: Router
    private let questions: [String]
    
    init(questions: [String], router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestions = questions.first {
            router.routeTo(question: firstQuestions, answerCallback: routeNext(from: firstQuestions))
        }
    }
    
    private func routeNext(from question: String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let strongSelf = self else { return }
            
            if let currentQuestionIndex = strongSelf.questions.firstIndex(of: question) {
                if currentQuestionIndex+1 < strongSelf.questions.count {
                    let nextQuestion = strongSelf.questions[currentQuestionIndex + 1]
                    strongSelf.router.routeTo(question: nextQuestion, answerCallback: strongSelf.routeNext(from: nextQuestion))
                }
            }
        }
    }
}


final class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routeToCorrectQuestion_2() {
        makeSUT(questions: ["Q1","Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routeToCorrectQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        
        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswersFirstQuestionAndSecondQuestion_withThreeQuestions_routeToSecondAndThirdQuestion() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswersFirstQuestion_withOneQuestions_doesNotRouteToAnotherQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    
    
    //MARK: - Helpers -
    
    func makeSUT(questions: [String]) -> Flow {
        let sut = Flow(questions: questions, router: router)
        return sut
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: Router.AnswerCallback = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }

    }
}
