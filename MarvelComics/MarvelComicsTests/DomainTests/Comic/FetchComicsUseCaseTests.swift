//
//  FetchComicsUseCaseTests.swift
//  MarvelComicsTests
//
//  Created by Gary Dos Santos de Andrade on 31/1/25.
//

import XCTest
import Combine
@testable import MarvelComics

final class FetchComicsUseCaseTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var mockRepository: MockComicRepository!
    private var useCase: UseCase.FetchComicsUseCase!

    override func setUp() {
        super.setUp()
        mockRepository = MockComicRepository()
        useCase = UseCase.FetchComicsUseCase(repository: mockRepository)
    }

    override func tearDown() {
        cancellables.removeAll()
        mockRepository = nil
        useCase = nil
        super.tearDown()
    }

    func test_fetchComicsSuccess() {
        // Given
        let comicIds = [1,2,3]
        let expectedComics = Mocks.comicsModel(ids: comicIds)
        mockRepository.comicsResult = .success(Mocks.comicListResult(ids: comicIds))

        // When
        let expectation = XCTestExpectation(description: "Fetch comics successfully")
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { comics in
                XCTAssertEqual(comics, expectedComics, "Fetched comics do not match expected values")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Then
        wait(for: [expectation], timeout: 1.0)
    }

    func test_fetchComicsFailure() {
        // Given
        mockRepository.comicsResult = .failure(API.NetworkError.invalidRequest)

        // When
        let expectation = XCTestExpectation(description: "Fetch comics failure")
        useCase.execute()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error, ErrorModel.decodingError, "Expected network failure error")
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

// MARK: - Mock Repository -

final class MockComicRepository: ComicRepositoryProtocol {
    var comicsResult: Result<Comic.ListResult, API.NetworkError> = .failure(API.NetworkError.invalidResponse)

    func fetchComics() -> AnyPublisher<Comic.ListResult, API.NetworkError> {
        return Future { promise in
            promise(self.comicsResult)
        }
        .eraseToAnyPublisher()
    }
}
