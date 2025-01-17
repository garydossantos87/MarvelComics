//
//  MarvelComicsTests.swift
//  MarvelComicsTests
//
//  Created by Gary Dos Santos de Andrade on 24/3/24.
//

import XCTest
import SnapshotTesting
@testable import MarvelComics

final class CharacterSnapshotTests: XCTestCase {
    func testCharacterCell() throws {
        let charactedModelMock = Mocks.characterModel()
        createSnapshots(with: charactedModelMock)
    }

    func testCharacterCell_WithoutDescription() throws {
        let charactedModelMock = Mocks.characterModel(description: nil)
        createSnapshots(with: charactedModelMock)
    }

    func testCharacterCell_WithoutDate() throws {
        let charactedModelMock = Mocks.characterModel(date: nil)
        createSnapshots(with: charactedModelMock)
    }

    func testCharacterCell_WithoutDescriptionAndDate() throws {
        let charactedModelMock = Mocks.characterModel(description: nil, date: nil)
        createSnapshots(with: charactedModelMock)
    }
}

// MARK: - Private methods -

extension CharacterSnapshotTests {
    private func createSnapshots(
        with model: Character.List.Model,
        name: String = #function,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let view = Character.List.ViewCell()
        view.configure(with: model)
        snapshotTest(
            with: view,
            record: false,
            name: name,
            file: file,
            line: line
        )
    }
}
