//
//  QuestionHeader.swift
//  QuizApp
//
//  Created by Amin faruq on 12/03/24.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(title)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
                .padding(.top)
            
            Text(subtitle)
                .font(.largeTitle)
                .fontWeight(.medium)
        }
        .padding()
    }
}


#Preview {
    HeaderView(title: "A title", subtitle: "A subtitle")
        .previewLayout(.sizeThatFits)
}
