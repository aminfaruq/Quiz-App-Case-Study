//
//  iOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Amin faruq on 23/02/24.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

class iOSViewControllerFactoryTest: XCTestCase {
    
    let singleAnswerQuestion = Question.singleAnswer("Q1")
    let multipleAnswerQuestion = Question.multipleAnswer("Q1")
    let options = ["A1" , "A2"]
    
    func test_questionViewController_singleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: singleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_singleAnswer_createsControllerWithSingleSelection() {
        XCTAssertFalse(makeQuestionController(question: singleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).title, presenter.title)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithQuestion() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).question, "Q1")
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithOptions() {
        XCTAssertEqual(makeQuestionController(question: multipleAnswerQuestion).options, options)
    }
    
    func test_questionViewController_multipleAnswer_createsControllerWithSingleSelection() {
        XCTAssertTrue(makeQuestionController(question: multipleAnswerQuestion).allowsMultipleSelection)
    }
    
    func test_resultsViewController_createsControllerWithTitle() {
        let results = makeResults()

        XCTAssertEqual(results.controller.title, results.presenter.title)
    }
    
    func test_resultsViewController_createsControllerWithSummary() {
        let results = makeResults()

        XCTAssertEqual(results.controller.summary, results.presenter.summary)
    }
    
    func test_resultsViewController_createsControllerWithPresentableAnswer() {
        let results = makeResults()
        
        XCTAssertEqual(results.controller.answers.count, results.presenter.presentableAnswer.count)
    }
    
    //MARK: - Helpers
    
    func makeSUT(options: [Question<String>: [String]] = [:], correctAnswers: [Question<String>: Set<String>] = [:]) -> iOSViewControllerFactory {
        iOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func makeResults() -> (controller: ResultsViewController, presenter: ResultsPresenter) {
        let userAnswers = [singleAnswerQuestion: Set(["A1"]), multipleAnswerQuestion: Set(["A1", "A2"])]
        let correctAnswers = [singleAnswerQuestion: Set(["A1"]), multipleAnswerQuestion: Set(["A1", "A2"])]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = Result(answers: userAnswers, score: 2)
        let orderedOptions = [singleAnswerQuestion: ["A1"], multipleAnswerQuestion: ["A1", "A2"]]
        
        let presenter = ResultsPresenter(result: result, questions: questions, options: orderedOptions, correctAnswers: correctAnswers)
        let sut = makeSUT(correctAnswers: correctAnswers)
        
        let controller = sut.resultsViewController(for: result) as! ResultsViewController
        
        return (controller, presenter)
    }
    
    func makeQuestionController(question: Question<String> = Question.singleAnswer("")) -> QuestionViewController {
        return makeSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}