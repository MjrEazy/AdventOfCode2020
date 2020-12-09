import Cocoa

func findAnswer(numbers: [Int], preAmble: Int) -> Int {
    let pieces = (preAmble..<numbers.count-1).map {
        Array(numbers[$0-preAmble...$0])
    }
    nextpiece: for piece in pieces {
        for i in 0..<preAmble-1 {
            for j in i+1..<preAmble {
                if piece[i]+piece[j] == piece.last! { continue nextpiece }
            }
        }
        return piece.last!
    }
    return 0
}

do {
    
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day9/Day9_input_test.txt", encoding: String.Encoding.utf8)
//    let preAmble = 5
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day9/Day9_input.txt", encoding: String.Encoding.utf8)
    let preAmble = 25

    let numbers = input.components(separatedBy: "\n").map{Int($0)!}
    let target = findAnswer(numbers: numbers, preAmble: preAmble)
    var answer: Int = 0
    nextloop: for i in 0..<numbers.count-1 {
        for j in i+1..<numbers.count {
            let window = numbers[i...j]
            let attempt = window.reduce(0,+)
            if  attempt == target {
                answer = window.max()! + window.min()!
                print("Answer: ", answer)
                break
            }
            if attempt > target { continue nextloop}
        }
        if answer == target { break }
    }
    
} catch {
    
    print("File not Found")

}

