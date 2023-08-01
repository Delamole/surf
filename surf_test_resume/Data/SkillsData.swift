import Foundation
// класс для начальных значений
struct SKills {
    
    var name = ""
    var image = ""
    
    static func getnames() -> [SKills]{
        return [ SKills(name: "DataStore",image: "x"),
                 SKills(name: "Solid",image: "x"),
                 SKills(name: "ООП",image: "x"),
                 SKills(name: "MVC/MVVM",image: "x"),
                 SKills(name: "Kotlin",image: "x"),
                 SKills(name: "HTTP",image: "x"),
                 SKills(name: "CustomView",image: "x"),
                 SKills(name: "Room",image: "x")
        ]
        }
}

extension String {
    func take(_ n: Int) -> String {
        guard n >= 0 else {
            fatalError("n should never negative")
        }
        let index = self.index(self.startIndex, offsetBy: min(n, self.count))
        return String(self[..<index])
    }
}
