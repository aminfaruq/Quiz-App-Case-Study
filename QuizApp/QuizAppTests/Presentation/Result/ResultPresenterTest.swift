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
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q2")
    
    func test_title_returnsFormattedTitle() {
        let result: Result<Question<String>, Set<String>> = Result(answers: [:], score: 1)
        
        let sut = ResultsPresenter(result: result, questions: [], options: [:], correctAnswers: [:])
        
        XCTAssertEqual(sut.title, "Result")
    }

    func test_summary_withTwoQuestionsAndScoreOne_returnsSummary() {
        let answers : Dictionary<Question<String>, Set<String>> = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion : ["A2", "A3"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let orderedOptions = [singleAnswerQuestion: ["A1"],multipleAnswerQuestion: ["A2", "A3"]]
        let result = Result(answers: answers, score: 1)
        
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, options: orderedOptions, correctAnswers: [:])
        
        XCTAssertEqual(sut.summary, "You got 1/2 correct")
    }
    
    func test_presentableAnswers_withoutQuestions_isEmpty() {
        let answers = Dictionary<Question<String>, Set<String>>()
        
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [], options: [:], correctAnswers: [:])
        
        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }
    
    func test_presentableAnswers_withWrongSingleAnswer_mapsAnswer() {
        let answers : Dictionary<Question<String>, Set<String>> = [singleAnswerQuestion: ["A1"]]
        let correctAnswers : Dictionary<Question<String>, Set<String>> = [singleAnswerQuestion: ["A2"]]
        let orderedOptions = [singleAnswerQuestion: ["A1", "A2"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [singleAnswerQuestion], options: orderedOptions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_presentableAnswers_withWrongMultipleAnswer_mapsAnswer() {
        let answers : Dictionary<Question<String>, Set<String>> = [multipleAnswerQuestion: ["A1", "A4"]]
        let orderedQuestions = [multipleAnswerQuestion: ["A1", "A2" ,"A3" ,"A4"]]
        let correctAnswers : Dictionary<Question<String>, Set<String>> = [multipleAnswerQuestion: ["A2", "A3"]]
        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: [multipleAnswerQuestion], options: orderedQuestions, correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
    func test_presentableAnswers_withTwoQuestions_mapsOrderedAnswer() {
        let answers : Dictionary<Question<String>, Set<String>> = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A2"]]
        let correctAnswers : Dictionary<Question<String>, Set<String>> = [multipleAnswerQuestion: ["A1", "A4"], singleAnswerQuestion: ["A2"]]
        let orderedQuestions = [singleAnswerQuestion, multipleAnswerQuestion]
        let orderedOptions = [singleAnswerQuestion: ["A1", "A2"], multipleAnswerQuestion: ["A1", "A2" ,"A3" ,"A4"]]

        let result = Result(answers: answers, score: 0)
        
        let sut = ResultsPresenter(result: result, questions: orderedQuestions, options: orderedOptions , correctAnswers: correctAnswers)
        
        XCTAssertEqual(sut.presentableAnswer.count, 2)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.last!.question, "Q2")
        XCTAssertEqual(sut.presentableAnswer.last!.answer, "A1, A4")
        XCTAssertNil(sut.presentableAnswer.last!.wrongAnswer)
    }
}
