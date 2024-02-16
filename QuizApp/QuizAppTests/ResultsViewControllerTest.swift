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
        
        sut = makeSUT(answers: [makeDummyAnswer()])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_viewDidLoad_withCorrectAnswer_renderCorrectAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: true)])
        
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    func test_viewDidLoad_withWrongAnswer_renderWrongAnswerCell() {
        let sut = makeSUT(answers: [PresentableAnswer(isCorrect: false)])
        
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
    }
    
    //MARK: - Helpers
    
    func makeSUT(summary: String = "", answers: [PresentableAnswer] = []) -> ResultsViewController {
        let sut = ResultsViewController(summary: summary, answers: answers)
        _ = sut.view
        return sut
    }
    
    func makeDummyAnswer() -> PresentableAnswer {
        return PresentableAnswer(isCorrect: false)
    }

}
