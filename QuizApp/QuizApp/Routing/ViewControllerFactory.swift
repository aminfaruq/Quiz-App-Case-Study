//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Amin faruq on 23/02/24.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    func resultsViewController(for result: Result<Question<String>, [String]>) -> UIViewController
}
