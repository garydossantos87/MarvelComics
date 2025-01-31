//
//  ComicRepositoryTests.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 31/1/25.
//


import XCTest
import Combine
@testable import MarvelComics

final class ComicRepositoryTests: XCTestCase {
    private var mockClient: API.MockAPIClient!
    private var repository: Comic.Repository!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockClient = API.MockAPIClient()
        repository = Comic.Repository(client: mockClient)
    }

    override func tearDown() {
        cancellables.removeAll()
        mockClient = nil
        repository = nil
        super.tearDown()
    }

    func test_fetchComics_success() {
        // Given
        let mockResponse = Mocks.comicListResult(ids: [1,2,3])

        let mockData = try! JSONEncoder().encode(mockResponse)
        mockClient.result = .success(mockData)

        let expectation = XCTestExpectation(description: "Fetch comics success")

        // When
        repository.fetchComics()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { comics in
                XCTAssertEqual(comics.data.count, 3)
                XCTAssertEqual(comics.data.total, 20)
                XCTAssertEqual(comics.data.results.count, 3)
                XCTAssertEqual(comics.data.results.first?.id, 1)
                XCTAssertEqual(comics.data.results.first?.description, "Description #1")
                XCTAssertEqual(comics.data.results.first?.dates.first, Mocks.dateResult)
                XCTAssertEqual(comics.data.results.first?.prices.first, Mocks.priceResult)
                XCTAssertEqual(comics.data.results.first?.thumbnail, Mocks.thumbnailResult)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchComics_failure() {
        // Given
        mockClient.result = .failure(API.NetworkError.networkFailure)

        let expectation = XCTestExpectation(description: "Fetch comics failure")

        // When
        repository.fetchComics()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, API.NetworkError.networkFailure)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }
}
