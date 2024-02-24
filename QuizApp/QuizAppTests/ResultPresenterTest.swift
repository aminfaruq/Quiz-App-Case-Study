//
//  ResultPresenterTest.swift
//  QuizAppTests
//
//  Created by Amin faruq on 24/02/24.
//

import XCTest
import QuizEngine
@testable import QuizApp

final class ResultPresenterTest: XCTestCase {

    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers = [Question.singleAnswer("Q1"): ["A1"], Question.multipleAnswer("Q2") : ["A2", "A3"]]
        let result = Result(answers: answers, score: 1)
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers = Dictionary<Question<String>, [String]>()
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A2"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A2", "A3"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withRightSingleAnswer_mapsAnswer() {
        let answers = [Question.singleAnswer("Q1"): ["A1"]]
        let correctAnswers = [Question.singleAnswer("Q1"): ["A1"]]
        let result = Result(answers: answers, score: 1)
        
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A1")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
    func test_presentableAnswers_withRightMultipleAnswer_mapsAnswer() {
        let answers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let correctAnswers = [Question.multipleAnswer("Q1"): ["A1", "A4"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
}
