//
//  QuizDelegate.swift
//  QuizEngine
//
//  Created by Amin faruq on 01/03/24.
//

import Foundation

public protocol QuizDelegate  {
    associatedtype Question
    associatedtype Answer
    
    func answer(for question: Question, completion: @escaping (Answer) -> Void)
    
    func didCompleteQuiz(withAnswers: [(question: Question, answer: Answer)])
}
