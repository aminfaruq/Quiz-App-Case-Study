//
//  MultipleAnswerQuestion.swift
//  QuizApp
//
//  Created by Amin faruq on 13/03/24.
//

import SwiftUI

struct MultipleAnswerQuestion: View {
    let title: String
    let question: String
    @State var store: MutipleSelectionStore
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HeaderView(title: title, subtitle: question)
            
            ForEach(Array(store.options.indices), id: \.self) { index in
                MultipleTextSelectionCell(option: $store.options[index])
            }
            
            Spacer()
            
            Button(action: store.submit, label: {
                HStack {
                    Spacer()
                    Text("Submit")
                        .padding()
                        .foregroundStyle(.white)
                    Spacer()
                }
                .background(Color.blue)
                .clipShape(Capsule())
            })
            .buttonStyle(PlainButtonStyle())
            .padding()
            .disabled(!store.canSubmit)
        }
    }
}

#Preview {
    MultipleAnswerQuestionTestView()
}

#Preview {
    MultipleAnswerQuestionTestView()
        .preferredColorScheme(.dark)
        .environment(\.sizeCategory, .extraExtraExtraLarge)
}

struct MultipleAnswerQuestionTestView: View {
    @State var selection = ["none"]
    
    var body: some View {
        VStack {
            MultipleAnswerQuestion(
                title: "1 of 2",
                question: "What's Mike's nationality?",
                store: .init(
                    options: [
                    "Portuguese",
                    "American",
                    "Greek",
                    "Canadian"
                    ], handler: { selection = $0 }
                ))
            
            Text("Last submission " + selection.joined(separator: ", "))
        }
    }
}

