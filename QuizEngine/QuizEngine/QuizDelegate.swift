//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Amin faruq on 01/03/24.
//

import Foundation

public protocol QuizDelegate  {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func handle(question: Question, answerCallback: @escaping (Answer) -> Void)
    func handle(result: Result<Question, Answer>)
}
