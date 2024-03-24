import UIKit

extension Home {
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
            backgroundColor = .white
            setupConstraints()
        }
        
        private func setupConstraints() {
        }
    }
}
