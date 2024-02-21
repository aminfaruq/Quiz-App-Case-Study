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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
    
    func routeTo(result: Result<String, String>) {
        
    }
}
