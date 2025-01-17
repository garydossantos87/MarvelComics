//
//  SnapshotsHelper.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 17/1/25.
//

import XCTest
import SnapshotTesting
@testable import MarvelComics

extension XCTestCase {
    public func snapshotTest(
        with view: UIView,
        record: Bool = false,
        name: String = #function,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        for device in Devices.allCases {
            // Given
            let containerView = createContainerView(for: device.size, view: view)
            // Then
            assertSnapshot(
                of: containerView,
                as: .image,
                named: "\(device.name)",
                record: record,
                file: file,
                testName: name,
                line: line
            )
        }
    }

    // MARK: - Private func -

    private func createContainerView(for size: CGSize, view: UIView) -> UIView {
        let containerView = UIView(frame: CGRect(origin: .zero, size: size))
        containerView.backgroundColor = .white

        view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(view)

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: containerView.topAnchor),
            view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        // Force layout pass to render the view hierarchy
        containerView.layoutIfNeeded()

        return containerView
    }
}
