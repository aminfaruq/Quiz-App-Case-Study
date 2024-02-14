//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Amin faruq on 13/02/24.
//

import XCTest
@testable import QuizApp

final class QuestionViewControllerTest: XCTestCase {
    
    func test_viewDidLoad_rendersQuestionHeaderText() {
        XCTAssertEqual(makeSUT(question: "Q1").headerLabel.text, "Q1")
    }
    
    func test_viewDidLoad_rendersOptions() {
        var sut = makeSUT()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        sut = makeSUT(options: ["A1"])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        
        sut = makeSUT(options: ["A1", "A2"])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_viewDidLoad_rendersOptionsText() {
        var sut = makeSUT(options: ["A1", "A2"])
        
        XCTAssertEqual(sut.tableView.title(at: 0), "A1")
        XCTAssertEqual(sut.tableView.title(at: 1), "A2")
    }
    
    //MARK: - Helpers
    
    func makeSUT(question: String = "", options: [String] = []) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options)
        //_ = sut.view
        
        sut.loadViewIfNeeded()
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        return cell(at: row)?.textLabel?.text
    }
}
