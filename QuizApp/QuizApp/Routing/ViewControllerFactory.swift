//
//  ViewControllerFactory.swift
//  QuizApp
//
//  Created by Amin faruq on 23/02/24.
//

import UIKit
import QuizEngine

protocol ViewControllerFactory {
    typealias Answers = [(question: Question<String>, answer: [String])]
    
    func questionViewController(for question: Question<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController
    
    func resultsViewController(for userAnswers: Answers) -> UIViewController    
}
