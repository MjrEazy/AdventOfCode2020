import Cocoa

public func main(data: inout [Int]) {
    data.append(0)
    data.sort()
    data.append(data[data.count-1]+3)
    
    var combinations = [Int](repeating:0, count: data.max()!+1)
    combinations[0] = 1
    print(combinations,combinations.count)
    for i in data {
        print(i)
        if i >= 3 {
            combinations[i] = combinations[i - 1] + combinations[i - 2] + combinations[i - 3]
        } else if i >= 2 {
            combinations[i] = combinations[i - 1] + combinations[i - 2]
        } else if i >= 1 {
            combinations[i] = combinations[i - 1]
        }
    }
    print(combinations)
    print("Answer: ", combinations[data[data.count-1]])
}


//var numbers = getFileAsInts(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day10/Day10_input_test.txt")
//var numbers = getFileAsInts(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day10/Day10_input_test2.txt")
var numbers = getFileAsInts(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day10/Day10_input.txt")

printTimeElapsedWhenRunningCode(title:"v2") {
    main(data: &numbers)
}


