import Foundation

var cache = [String: Int]()

func countTakenSeats(seatingMap: inout [[String.Element]], row: Int, col: Int) -> Int {
    var taken: Int = 0

    if cache.index(forKey: "\(row),\(col)") != nil {
        taken = cache["\(row),\(col)"]!
        return taken
    }

    for y in -1...1 {
        for x in -1...1 where !(y == 0 && x == 0) {
            if (0..<seatingMap.count).contains(row+y) && (0..<seatingMap.first!.count).contains(col+x) && seatingMap[row+y][col+x] == "#" {
                taken = taken + 1
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
            } else if copy[r][c] == "#" && nTaken >= 4 {
                numberChanged = numberChanged + 1
                copy[r][c] = "L"
            }
        }
        cache.removeAll()
    }
    seatingMap = copy
    return numberChanged
}
