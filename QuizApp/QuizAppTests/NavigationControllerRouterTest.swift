//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Amin faruq on 21/02/24.
//

import UIKit
import XCTest
import QuizEngine
@testable import QuizApp

final class NavigationControllerRouterTest: XCTestCase {
    
    func test_routeToQuestion_presentsQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController: navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
    
    func test_routeToQuestionTwice_presentsQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController: navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })

        XCTAssertEqual(navigationController.viewControllers.count, 2)
    }
}
