//
//  MutipleSelectionStoreTests.swift
//  QuizAppTests
//
//  Created by Amin faruq on 13/03/24.
//

import XCTest

struct MutipleSelectionStore {
    var options: [MultipleSelectionOption]
    
    internal init(options: [String]) {
        self.options = options.map { MultipleSelectionOption(text: $0) }
    }
}

struct MultipleSelectionOption {
    let text: String
    var isSelected = false
    
    mutating func select() {
        isSelected.toggle()
    }
}

final class MutipleSelectionStoreTests: XCTestCase {

    func test() {
        var sut = MutipleSelectionStore(options: ["o0", "o1"])
        XCTAssertFalse(sut.options[0].isSelected)

        sut.options[0].select()
        XCTAssertTrue(sut.options[0].isSelected)
        
        sut.options[0].select()
        XCTAssertFalse(sut.options[0].isSelected)
    }
}
