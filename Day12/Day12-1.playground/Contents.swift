import Cocoa

class coordinate: CustomStringConvertible {
    var x: Int
    var y: Int
    var position: (Int, Int)
    var description: String { return "(\(x), \(y))" }
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        self.position = (x,y)
    }
}

func manhattanDistance(xA: Int, xB: Int, yA: Int, yB: Int) -> Int {
    let distance = abs(xA-xB) + abs(yA-yB)
    return distance
}

func move(position: coordinate, facing: Int, dir: String, dist: Int)-> coordinate {
    var newPosition: coordinate = coordinate(x: position.x, y: position.y)
    switch dir {
    case "E":
        newPosition.x = position.x + dist
    case "W":
        newPosition.x = position.x - dist
    case "N":
        newPosition.y = position.y + dist
    case "S":
        newPosition.y = position.y - dist
    default:
        print("I'm sorry Dave, I'm afraid I can't do that")
    }
    return newPosition
}

func navigate(route: [String]) -> coordinate {
    var current: coordinate = coordinate(x:0, y:0)
    var facing: Int = 90
    for step in route {
        let dir: String = String(step.prefix(1))
        let dist: Int = Int(step.suffix(step.count-1))!
        switch dir {
        case "R":
            if dist + facing < 360 {
                facing = facing + dist
            } else {
                facing = facing + dist - 360
            }
        case "L":
            if facing - dist >= 0 {
                facing = facing - dist
            } else {
                facing = facing - dist + 360
            }
        case "E", "W", "N", "S":
            current = move(position: current, facing: facing, dir: dir, dist: dist)
        case "F":
            switch facing {
            case 0:
                current = move(position: current, facing: facing, dir: "N", dist: dist)
            case 90:
                current = move(position: current, facing: facing, dir: "E", dist: dist)
            case 180:
                current = move(position: current, facing: facing, dir: "S", dist: dist)
            case 270:
                current = move(position: current, facing: facing, dir: "W", dist: dist)
            default:
                print("I'm sorry Dave, I'm afraid I can't do that")
            }
        default:
            print("I'm sorry Dave, I'm afraid I can't do that")
        }
    }
    return current
}

public func main() {
    //let route = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day12/Day12_input_test.txt")
    let route = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day12/Day12_input.txt")
    let endPoint = navigate(route: route)
    let startPoint: coordinate = coordinate (x: 0, y: 0)
    print("Answer:", manhattanDistance(xA: startPoint.x, xB: endPoint.x, yA: startPoint.y, yB: endPoint.y))
}

printTimeElapsedWhenRunningCode(title:"main()") {
    main()
}

