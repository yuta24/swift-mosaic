import Foundation
import UIKit

public protocol Sourceable {
    func toString() -> String
}

extension Int: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension UInt: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension Float: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension Double: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension CGFloat: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension String: Sourceable {
    public func toString() -> String {
        return self
    }
}
