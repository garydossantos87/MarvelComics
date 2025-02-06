import Foundation

extension Comic.Detail {
    struct Model: Decodable {
        let comic: Comic.List.Model?
        let creators: [Creator.List.Model]?
        let stories: [Story.List.Model]?
        let characters: [Character.List.Model]?

        // MARK: - Init -

        init(
            comic: Comic.List.Model?,
            creators: [Creator.List.Model]? = nil,
            stories: [Story.List.Model]? = nil,
            characters: [Character.List.Model]? = nil
        ) {
            self.comic = comic
            self.creators = creators
            self.stories = stories
            self.characters = characters
        }
    }
}
