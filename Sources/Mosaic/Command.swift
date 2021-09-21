import Foundation

public enum Command {
    case save(data: [String: Any], collection: String)
    case update(document: String, data: [String: Any], collection: String)
    case delete(document: String, collection: String)
}

extension Command: Decodable {
    enum CodingKeys: String, CodingKey {
        case save
        case update
        case delete
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first

        switch key {
        case .save:
            var nested = try container.nestedUnkeyedContainer(forKey: .save)
            let data = try nested.decode([String: Any].self)
            let collection = try nested.decode(String.self)
            self = .save(data: data, collection: collection)
        case .update:
            var nested = try container.nestedUnkeyedContainer(forKey: .save)
            let document = try nested.decode(String.self)
            let data = try nested.decode([String: Any].self)
            let collection = try nested.decode(String.self)
            self = .update(document: document, data: data, collection: collection)
        case .delete:
            var nested = try container.nestedUnkeyedContainer(forKey: .delete)
            let document = try nested.decode(String.self)
            let collection = try nested.decode(String.self)
            self = .delete(document: document, collection: collection)
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unabled to decode enum."
                )
            )
        }
    }
}
