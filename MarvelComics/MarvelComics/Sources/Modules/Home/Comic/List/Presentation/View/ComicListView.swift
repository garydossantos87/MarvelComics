import UIKit

extension Comic.List {
    final class View: UIView {
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        public func configure() {
        }
        
        private func setup() {
            backgroundColor = .red
            setupConstraints()
        }
        
        private func setupConstraints() {
        }
    }
}
