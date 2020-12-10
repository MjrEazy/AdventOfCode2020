import Cocoa

public func main(data: inout [Int]) {
    data.append(0)
    data.sort()
    data.append(data[data.count-1]+3)
    var previous: Int = 0
    var ones: Int = 0
    var threes: Int = 0
    for adapter in data {
        switch adapter - previous {
        case 1:
            ones = ones + 1
            previous = adapter
        case 3:
            threes = threes + 1
            previous = adapter
        default:
            if adapter - previous > 4 { break }
        }
    }
    print("Ones:\(ones) Threes:\(threes), Answer:\(ones * threes)")
}


//var numbers = getFileAsInts(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day10/Day10_input_test.txt")
//var numbers = getFileAsInts(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day10/Day10_input_test2.txt")
var numbers = getFileAsInts(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day10/Day10_input.txt")

printTimeElapsedWhenRunningCode(title:"v2") {
    main(data: &numbers)
}


