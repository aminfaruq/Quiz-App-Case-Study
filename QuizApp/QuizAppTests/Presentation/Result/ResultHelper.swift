//
//  ResultHelper.swift
//  QuizAppTests
//
//  Created by Amin faruq on 24/02/24.
//

import QuizEngine

extension Result: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(1)
    }
    
    public static func ==(lhs: Result<Question, Answer>, rhs: Result<Question, Answer>) -> Bool {
        return lhs.score == rhs.score
    }
}
