import Cocoa


// Change approach as simplifies part 2, should have done part 1 like this, doh!
// Make 0,0 the centre then North is -ve on y-axis, South is +ve on y-axis, East is +ve on x-axis, y is -ve on x-axis
// refactor how I move the point and part 2 is simple and I don't need to track the direction pointing to separately...
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

func rotate(waypoint: coordinate, degrees: Int)-> coordinate {
    switch degrees {
    case 90:
        return coordinate(x: waypoint.y * -1, y: waypoint.x)
    case 180:
        return coordinate(x: waypoint.x * -1, y: waypoint.y * -1)
    case 270:
        return coordinate(x: waypoint.y, y: waypoint.x * -1)
    default:
        print("I'm sorry Dave, I'm afraid I can't do that!  Rotate(\(degrees))")
        return coordinate(x:0,y:0)
    }
}

func move(thingToMove: coordinate, change: coordinate)->coordinate {
    return coordinate(x: thingToMove.x + change.x, y: thingToMove.y + change.y)
}

func navigate(route: [String]) -> coordinate {
    var ship: coordinate = coordinate(x:0, y:0)
    var waypoint: coordinate = coordinate(x:10, y:-1)
    for step in route {
        let dir: String = String(step.prefix(1))
        let dist: Int = Int(step.suffix(step.count-1))!
        switch dir {
        case "R":
            waypoint = rotate(waypoint: waypoint, degrees: dist)
        case "L":
            waypoint = rotate(waypoint: waypoint, degrees: 360 - dist)
        case "E":
            waypoint = move(thingToMove: waypoint, change: coordinate(x: dist * +1, y: 0))
        case "W":
            waypoint = move(thingToMove: waypoint, change: coordinate(x: dist * -1, y: 0))
        case "N":
            waypoint = move(thingToMove: waypoint, change: coordinate(x: 0, y: dist * -1))
        case "S":
            waypoint = move(thingToMove: waypoint, change: coordinate(x: 0, y: dist * +1))
        case "F":
            ship = move(thingToMove: ship, change: coordinate(x: waypoint.x * dist, y: waypoint.y * dist))
        default:
            print("I'm sorry Dave, I'm afraid I can't do that! navigate(\(dir))")
        }
    }
    return ship
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

