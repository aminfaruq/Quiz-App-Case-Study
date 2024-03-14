//
//  MultipleTextSelectionCell.swift
//  QuizApp
//
//  Created by Amin faruq on 13/03/24.
//

import SwiftUI

struct MultipleTextSelectionCell: View {
    @Binding var option: MultipleSelectionOption

    var body: some View {
        Button (action: { option.select() }, label: {
            HStack {
                Rectangle()
                    .strokeBorder(option.isSelected ? Color.blue : Color.secondary, lineWidth: 2.5)
                    .overlay(
                        Rectangle()
                            .fill(option.isSelected ? Color.blue : Color.clear)
                            .frame(width: 26.0, height: 26.0)
                    )
                    .frame(width: 40.0, height: 40.0)
                
                Text(option.text)
                    .font(.title)
                    .foregroundStyle(option.isSelected ? Color.blue : Color.secondary)
                
                Spacer()
            }.padding()
        })
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MultipleTextSelectionCell(
        option: .constant(.init(
            text: "any text",
            isSelected: false))
    )
}

#Preview(traits: .sizeThatFitsLayout) {
    MultipleTextSelectionCell(
        option: .constant(.init(
            text: "any text",
            isSelected: true))
    )
}
