//
//  Result.swift
//  QuizEngine
//
//  Created by Amin faruq on 20/02/24.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answers: [Question : Answer]
    let score: Int
}
