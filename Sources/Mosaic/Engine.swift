import Foundation

public typealias TokenProvider = () async throws -> String?

public enum Engine {
    static var provider: TokenProvider = { return nil }

    public static func configure(_ provider: @escaping TokenProvider) {
        self.provider = provider
    }
}
