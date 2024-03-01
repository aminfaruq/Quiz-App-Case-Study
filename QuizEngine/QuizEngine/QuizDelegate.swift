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
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])
    
    @available(*, deprecated, message: "use didCompleteQuiz(withAnswers: ) instead")
    func handle(result: Result<Question, Answer>)
}

#warning("Delete this at some point!")
public extension QuizDelegate {
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)]) {}
}
