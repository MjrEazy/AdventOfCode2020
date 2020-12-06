import Cocoa

func binaryMapping(range: String) -> Int {
    let binaryString = String(range.map {
        switch $0 {
            case "F", "L":
                return "0"
            default: // B, R
                return "1"
        }
    })
    return Int(binaryString, radix: 2)!
}

func checkBoardingPasses(input: [String]) {
    
    let seats = input.map(binaryMapping(range:))
    
    let max = seats.max()!
    let min = seats.min()!
    print("max ", max)
    
    var mySeats = [Int]()
    for i in min...max {
        if !seats.contains(i) && seats.contains(i + 1) && seats.contains(i - 1) {
            mySeats.append(i)
        }
    }

    print("Answer:", mySeats.first!)


}

do {
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day6/Day6_input_test.txt", encoding: String.Encoding.utf8)
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day6/Day6_input.txt", encoding: String.Encoding.utf8)
//    print(input)
    let values = input.components(separatedBy: "\n")
//    print(values.count)

    checkBoardingPasses(input: values)
    
} catch {
    
    print("File not Found")

}
