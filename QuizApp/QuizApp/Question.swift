//
//  Question.swift
//  QuizApp
//
//  Created by Amin faruq on 21/02/24.
//

import Foundation

enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .singleAnswer(let t):
            hasher.combine(t)
        case .multipleAnswer(let t):
            hasher.combine(t)
        }
    }
    
    static func ==(lhs: Question<T>, rhs: Question<T>) -> Bool {
        switch (lhs, rhs) {
        case (.singleAnswer(let a), .singleAnswer(let b)):
            return a == b
        case (.multipleAnswer(let a), .multipleAnswer(let b)):
            return a == b
        default:
            return false
        }
    }
}
