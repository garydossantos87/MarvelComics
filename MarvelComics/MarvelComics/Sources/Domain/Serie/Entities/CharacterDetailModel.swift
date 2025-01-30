import Foundation

extension Character.Detail {
    struct Model: Decodable {
        let character: Character.List.Model?
        let series: [Serie.List.Model]?

        // MARK: - Init -

        init(
            character: Character.List.Model?,
            series: [Serie.List.Model]? = nil
        ) {
            self.character = character
            self.series = series
        }
    }
}
