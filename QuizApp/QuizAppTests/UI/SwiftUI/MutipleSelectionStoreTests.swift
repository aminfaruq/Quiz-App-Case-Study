//
//  MutipleSelectionStoreTests.swift
//  QuizAppTests
//
//  Created by Amin faruq on 13/03/24.
//

import XCTest
@testable import QuizApp

final class MutipleSelectionStoreTests: XCTestCase {

    func test_selectOption_togglesState() {
        var sut = MutipleSelectionStore(options: ["o0", "o1"])
        XCTAssertFalse(sut.options[0].isSelected)

        sut.options[0].select()
        XCTAssertTrue(sut.options[0].isSelected)
        
        sut.options[0].select()
        XCTAssertFalse(sut.options[0].isSelected)
    }
    
    func test_canSubmit_whenAtLeastOneOptionIsSelected() {
        var sut = MutipleSelectionStore(options: ["o0", "o1"])
        XCTAssertFalse(sut.canSubmit)

        sut.options[0].select()
        XCTAssertTrue(sut.canSubmit)
        
        sut.options[0].select()
        XCTAssertFalse(sut.canSubmit)
        
        sut.options[1].select()
        XCTAssertTrue(sut.canSubmit)
    }
    
    func test_submit_notofiesHandlerWithSelectedOptions() {
        var submittedOptions = [[String]]()
        var sut = MutipleSelectionStore(options: ["o0", "o1"], handler: {
            submittedOptions.append($0)
        })
        
        sut.submit()
        XCTAssertEqual(submittedOptions, [])
        
        sut.options[0].select()
        sut.submit()
        XCTAssertEqual(submittedOptions, [["o0"]])
        
        sut.options[1].select()
        sut.submit()
        XCTAssertEqual(submittedOptions, [["o0"], ["o0", "o1"]])
    }
}
