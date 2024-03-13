//
//  MutipleSelectionStore.swift
//  QuizApp
//
//  Created by Amin faruq on 13/03/24.
//

import Foundation

struct MutipleSelectionStore {
    var options: [MultipleSelectionOption]
    var canSubmit: Bool {
        !options.filter(\.isSelected).isEmpty
    }
    
    private let handler: ([String]) -> Void
    
    internal init(options: [String], handler: @escaping ([String]) -> Void = { _ in }) {
        self.options = options.map { MultipleSelectionOption(text: $0) }
        self.handler = handler
    }
    
    func submit() {
        guard canSubmit else { return }
        
        handler(options.filter(\.isSelected).map(\.text))
    }
}

struct MultipleSelectionOption {
    let text: String
    var isSelected = false
    
    mutating func select() {
        isSelected.toggle()
    }
}
