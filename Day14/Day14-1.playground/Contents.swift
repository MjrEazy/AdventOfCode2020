import Cocoa

func maskValue(mask: String, value: Int)->Int {
    var maskedValue = value
    for (bit, position) in zip(mask, (0..<36).reversed()) {
        if bit == "0" { maskedValue &= ~(1 << position) }
        else if bit == "1" { maskedValue |= (1 << position)}
    }
    return maskedValue
}

public func main() {
    //let instructions = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day14/Day14_input_test.txt")
    let instructions = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day14/Day14_input.txt")
    var mask:String = String(instructions[0].suffix(36))
    var memory = [Int: Int]()
    for iptr in 1..<instructions.count {
        if instructions[iptr].prefix(4) == "mask" {
            mask = String(instructions[iptr].suffix(36))
        } else {
            let addr: Int = Int(instructions[iptr].dropFirst(4).prefix(while: { $0.isWholeNumber }))!
            let value: Int = Int(instructions[iptr].components(separatedBy: " = ")[1])!
            let masked = maskValue(mask: mask, value: value)
            memory[addr] = masked
        }
    }
    
    let answer:Int = memory.values.reduce(0, +)
    print("Answer: \(answer)")
}

printTimeElapsedWhenRunningCode(title:"main()") {
    main()
}

