//
//  SingleAnswerQuestion.swift
//  QuizApp
//
//  Created by Amin faruq on 12/03/24.
//

import SwiftUI

struct SingleAnswerQuestion: View {
    let title: String
    let question: String
    let options: [String]
    let selection: (String) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            QuestionHeader(title: title, question: question)
            
            ForEach(options, id: \.self) { option in
                Button (action: {
                    
                }, label: {
                    HStack {
                        Circle()
                            .stroke(Color.secondary, lineWidth: 2.5)
                        .frame(width: 40.0, height: 40.0)
                        
                        Text(option)
                            .font(.title)
                            .foregroundStyle(Color.secondary)
                        
                        Spacer()
                    }.padding()
                })
            }
            Spacer()
        }
    }
}

#Preview {
    SingleAnswerQuestion(
        title: "1 of 2",
        question: "What's Mike's nationality?",
        options: [
            "Portuguese",
            "American",
            "Greek",
            "Canadian"
        ],
        selection: { _ in }
    )
}

#Preview {
    SingleAnswerQuestion(
        title: "1 of 2",
        question: "What's Mike's nationality?",
        options: [
            "Portuguese",
            "American",
            "Greek",
            "Canadian"
        ],
        selection: { _ in }
    )
    .preferredColorScheme(.dark)
    .environment(\.sizeCategory, .extraExtraExtraLarge)
}
