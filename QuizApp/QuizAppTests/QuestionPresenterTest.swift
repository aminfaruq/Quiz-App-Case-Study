//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by Amin faruq on 24/02/24.
//

import Foundation
import XCTest
import QuizEngine
@testable import QuizApp

class QuestionPresenterTest: XCTestCase {
    
    let question1 = Question.singleAnswer("A1")
    let question2 = Question.singleAnswer("A2")
    
    func test_title_forFirstQuestion() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question1)

        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_title_forSecondQuestion_formatsTitleForIndex() {
        let sut = QuestionPresenter(questions: [question1, question2], question: question2)
        
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_title_forUnexistentQuestion_isEmpty() {
        let sut = QuestionPresenter(questions: [], question: Question.singleAnswer("A1"))
        
        XCTAssertEqual(sut.title, "")
    }
}
