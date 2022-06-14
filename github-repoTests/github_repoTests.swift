//
//  github_repoTests.swift
//  github-repoTests
//
//  Created by Michael Michael on 13.06.22.
//

import XCTest
import Combine

@testable import github_repo

class github_repoTests: XCTestCase {

    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        
        cancellables = []
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyKeyword() {
        let viewModel = RepositorySearchViewModel()
        
        viewModel.searchRepository()
        
        XCTAssertEqual(viewModel.cellViewModels.count, 0)
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
