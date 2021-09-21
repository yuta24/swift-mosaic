import Foundation

struct Sheet: Decodable {
    let widgets: [String: Widget]
}
