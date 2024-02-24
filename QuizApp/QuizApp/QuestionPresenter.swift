//
//  QuestionPresenter.swift
//  QuizApp
//
//  Created by Amin faruq on 24/02/24.
//

import Foundation

struct QuestionPresenter {
    let questions: [Question<String>]
    let question: Question<String>
    
    var title: String {
        guard let index = questions.firstIndex(of: question) else { return "" }
            
        return "Question #\(index + 1)"
    }
}
