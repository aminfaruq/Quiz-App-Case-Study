//
//  ResultsViewControllerTest.swift
//  QuizAppTests
//
//  Created by Amin faruq on 16/02/24.
//

import XCTest
@testable import QuizApp

final class ResultsViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_renderSummary() {
        let sut = makeSUT(summary: "a summary")
        XCTAssertEqual(sut.headerLabel.text, "a summary")
    }
    
    func test_viewDidLoad_renderAnswers() {
        var sut = makeSUT(answers: [])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        sut = makeSUT(answers: [makeAnswer()])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_configuresCell() {
        let answers = makeAnswer(question: "Q1", answer: "A1")
        let sut = makeSUT(answers: [answers])
        
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.answerLabel.text, "A1")
    }
    
    func test_viewDidLoad_withWrongAnswer_configuresCell() {
        let answers = makeAnswer(question: "Q1", answer: "A1", wrongAnswer: "wrong")
        let sut = makeSUT(answers: [answers])
        
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    //MARK: - Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeAnswer(question: String = "", answer: String = "", wrongAnswer: String? = nil) -> PresentableAnswer {
        return PresentableAnswer(question: question, answer: answer, wrongAnswer: wrongAnswer)
    }

}
