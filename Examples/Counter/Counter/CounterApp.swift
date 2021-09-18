import SwiftUI
import Mosaic

let json = """
{
    "vertical": {
        "alignment": "center",
        "spacing": 24,
        "contents": [
            {
                "text": {
                    "text": {
                        "content": "counter is #count",
                        "font": "title"
                    }
                }
            },
            {
                "horizontal": {
                    "alignment": "top",
                    "spacing": 32,
                    "contents": [
                        {
                            "button": {
                                "button": {
                                    "label": {
                                        "text": {
                                            "text": {
                                                "content": "decrement"
                                            }
                                        }
                                    },
                                    "action": "#decrement",
                                }
                            }
                        },
                        {
                            "button": {
                                "button": {
                                    "label": {
                                        "text": {
                                            "text": {
                                                "content": "increment",
                                            }
                                        }
                                    },
                                    "action": "#increment",
                                }
                            }
                        }
                    ]
                }
            }
        ]
    }
}
"""

@main
struct CounterApp: App {
    let engine: Engine = {
//        let url = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: .none, create: true)
//        return Mosaic.build(.init(source: .file(url)))
        let handler: (String, inout [String: Any]) -> [String: Any] = { action, value in
            switch action {
            case "#increment":
                let count = value["#count"] as! Int
                value["#count"] = count + 1
                return value
            case "#decrement":
                let count = value["#count"] as! Int
                value["#count"] = count - 1
                return value
            default:
                return value
            }
        }
        let value = ["#count": 0]
        return Mosaic.build(.init(source: .json(json, value, handler)))
    }()

    var body: some Scene {
        WindowGroup {
            Root(engine)
        }
    }
}
