//
//  ViewModelTests.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 31/1/25.
//

import XCTest
import Combine
@testable import MarvelComics

class ComicViewModelTests: XCTestCase {
    var viewModel: Comic.List.ViewModel!
    var useCaseMock: MockComicUseCase!
    var coordinatorMock: MockComicListCoordinator!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        coordinatorMock = MockComicListCoordinator()
        useCaseMock = MockComicUseCase()
        viewModel = Comic.List.ViewModel(coordinator: coordinatorMock, useCases: UseCase.ComicUseCases(with: useCaseMock))
    }

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func test_viewDidLoad_success() {
        // Given
        let expectedComics = Mocks.comicListResult(ids: [1,2,3])

        useCaseMock.fetchComicsReturnValue = Just(expectedComics)
            .setFailureType(to: API.NetworkError.self)
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "Comics loaded")

        // When
        viewModel.$state
            .dropFirst()
            .sink { state in
                // Then
                switch state {
                case .loading:
                    break // This is expected initially
                case .success:
                    XCTAssertEqual(self.viewModel.numberOfRowsInSection(section: 0), expectedComics.data.count)
                    XCTAssertEqual(self.viewModel.comicModel(at: 0)?.title, "Comic #1")
                    XCTAssertEqual(self.viewModel.comicModel(at: 1)?.title, "Comic #2")
                    expectation.fulfill()
                default:
                    XCTFail("Unexpected state: \(String(describing: state))")
                }
            }
            .store(in: &cancellables)

        viewModel.viewDidLoad()

        wait(for: [expectation], timeout: 1.0)
    }

    func test_viewDidLoad_failure() {
        // Given
        useCaseMock.fetchComicsReturnValue = Fail(error: API.NetworkError.badServerResponse(statusCode: 500))
            .eraseToAnyPublisher()

        let expectation = XCTestExpectation(description: "Comics loading failure")

        // When
        viewModel.$state
            .dropFirst()
            .sink { state in
                // Then
                if case .failure(let error) = state {
                    XCTAssertEqual(error as? API.NetworkError, API.NetworkError.badServerResponse(statusCode: 500))
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.viewDidLoad()

        wait(for: [expectation], timeout: 1.0)
    }
}
