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
    let source: Source = {
        let handler: (String, inout [String: Any]) -> Void = { action, value in
            switch action {
            case "#increment":
                let count = value["#count"] as! Int
                value["#count"] = count + 1
            case "#decrement":
                let count = value["#count"] as! Int
                value["#count"] = count - 1
            default:
                break
            }
        }
        let value = ["#count": 0]
        return .json(json, value, handler)
    }()

    var body: some Scene {
        WindowGroup {
            MosaicView(source)
        }
    }
}
