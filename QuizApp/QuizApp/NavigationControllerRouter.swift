//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Amin faruq on 21/02/24.
//

import UIKit
import QuizEngine

class NavigationControllerRouter: Router {
    private let navigationController: UINavigationController
    private let factory: ViewControllerFactory
    
    init(navigationController: UINavigationController, factory: ViewControllerFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func routeTo(question: Question<String>, answerCallback: @escaping ([String]) -> Void) {
        show(factory.questionViewController(for: question, answerCallback: answerCallback))
    }
    
    func routeTo(result: Result<Question<String>, [String]>) {
        show(factory.resultsViewController(for: result))
    }
    
    func show(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
}
