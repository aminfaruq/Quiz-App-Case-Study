//
//  SingleTextSelectionCell.swift
//  QuizApp
//
//  Created by Amin faruq on 12/03/24.
//

import SwiftUI

struct SingleTextSelectionCell: View {
    let text: String
    let selection: () -> Void

    var body: some View {
        Button (action: selection, label: {
            HStack {
                Circle()
                    .stroke(Color.secondary, lineWidth: 2.5)
                    .frame(width: 40.0, height: 40.0)
                
                Text(text)
                    .font(.title)
                    .foregroundStyle(Color.secondary)
                
                Spacer()
            }.padding()
        })
    }
}

#Preview {
    SingleTextSelectionCell(text: "any text", selection: { })
}
