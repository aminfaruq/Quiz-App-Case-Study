//
//  Game.swift
//  QuizEngine
//
//  Created by Amin faruq on 20/02/24.
//

import Foundation

public func startGame<Question: Hashable, Answer, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) where R.Question == Question, R.Answer == Answer {

}
