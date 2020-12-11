import Cocoa

//var seatPlan = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day11/Day11_input_test.txt")
var seatPlan = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day11/Day11_input.txt")

var seatingMap = seatPlan.map { Array($0) }
printTimeElapsedWhenRunningCode(title:"main()") {
    main()
}

public func main() {

    var change: Int = 0
    repeat {
        change = iterate(seatingMap: &seatingMap)
    } while change > 0
    print (seatingMap.reduce(0) { res, row in res + row.filter { $0 == "#" }.count})
}


