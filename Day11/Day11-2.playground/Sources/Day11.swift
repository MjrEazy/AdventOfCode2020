import Foundation

var cache = [String: Int]()

func lookAround(seatingMap: inout [[String.Element]], row: Int, col: Int, y: Int, x: Int) -> Character? {
    if (0..<seatingMap.count).contains(row + y) && (0..<seatingMap.first!.count).contains(col + x) {
        return seatingMap[row+y][col+x]
    } else {
        return nil
    }
}

func keepLooking(seatingMap: inout [[String.Element]], row: Int, col: Int, y: Int, x: Int, taken: inout Int) {
    var multiplier: Int = 2
    while true {
        guard let location = lookAround(seatingMap: &seatingMap, row: row, col: col, y: y * multiplier,x: x * multiplier), location != "L" else { break }
        if location == "#" {
            taken = taken + 1
            break
        } else {
            multiplier += 1
        }
    }
}

func countTakenSeats(seatingMap: inout [[String.Element]], row: Int, col: Int) -> Int {
    var taken: Int = 0

    if cache.index(forKey: "\(row),\(col)") != nil {
        taken = cache["\(row),\(col)"]!
        return taken
    }

    for y in -1...1 {
        for x in -1...1 where !(y == 0 && x == 0) {
            guard let location = lookAround(seatingMap: &seatingMap, row: row, col: col, y: y, x: x) else { continue }
            if location == "#" {
                taken = taken + 1
            } else if location == "." {
                keepLooking(seatingMap: &seatingMap, row: row, col: col, y: y, x: x, taken: &taken)
            }
        }
    }
    cache["\(row),\(col)"] = taken
    return taken
}

public func iterate(seatingMap: inout [[String.Element]]) -> Int {
    var copy = seatingMap
    var numberChanged: Int = 0
    for r in 0..<seatingMap.count {
        for c in 0..<seatingMap.first!.count {
            let nTaken = countTakenSeats(seatingMap: &seatingMap, row: r, col: c)
            if copy[r][c] == "L" && nTaken == 0 {
                numberChanged = numberChanged + 1
                copy[r][c] = "#"
            } else if copy[r][c] == "#" && nTaken >= 5 {
                numberChanged = numberChanged + 1
                copy[r][c] = "L"
            }
        }
        cache.removeAll()
    }
    seatingMap = copy
    return numberChanged
}
