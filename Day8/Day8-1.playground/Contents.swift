import Cocoa

final class Instruction: CustomStringConvertible {
    let instr: String
    let oper: Int
    var description: String {
        return "Instruction: \(instr)\tOperand: \(oper)\n"
    }
    init(string: String) {
        let parts = string.components(separatedBy: " ")
        self.instr = parts[0]
        self.oper = Int(parts[1])!
    }
    
}

func execute(code: Instruction, accumulator: inout Int) -> Int {
//    print(code.instr, code.oper)
    var instrOffset: Int
    switch code.instr {
    //nop stands for No OPeration - it does nothing. The instruction immediately below it is executed next.
    case "nop":
        instrOffset = 1
        
    //acc increases or decreases a single global value called the accumulator by the value given in the argument. For example, acc +7 would increase the accumulator by 7. The accumulator starts at 0. After an acc instruction, the instruction immediately below it is executed next.
    case "acc":
        accumulator = accumulator + code.oper
        instrOffset = 1
        
    //jmp jumps to a new instruction relative to itself. The next instruction to execute is found using the argument as an offset from the jmp instruction; for example, jmp +2 would skip the next instruction, jmp +1 would continue to the instruction immediately below it, and jmp -20 would cause the instruction 20 lines above to be executed next.
    case "jmp":
        instrOffset = code.oper
        
    default:
        print("I'm sorry Dave, I'm afraid I can't do that")
        instrOffset = code.oper
    }
    return instrOffset
}

do {
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day8/Day8_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day8/Day8_input.txt", encoding: String.Encoding.utf8)
    let inputCode = input.components(separatedBy: "\n")
    let code = inputCode.map(Instruction.init)
//    print(code)

    var iptr: Int = 0
    var abend: Bool = false
    var accumulator:Int = 0
    var processed = [Int: String]()
    repeat {
        if processed.keys.contains(iptr) {
            abend = true
        } else {
            processed[iptr] = code[iptr].instr + " " + String(code[iptr].oper)
            iptr = iptr + execute(code: code[iptr], accumulator: &accumulator)
        }
    } while iptr < code.count && !abend
    print(accumulator)
    
} catch {
    
    print("File not Found")

}
