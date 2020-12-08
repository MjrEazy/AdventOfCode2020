import Cocoa

final class Instruction: CustomStringConvertible {
    var instr: String
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

func fixCode(code: [Instruction], iptr: Int) -> [Instruction] {
    let line: Instruction = code[iptr]
    var fixedCode: [Instruction] = code
    if line.instr == "nop" {
        fixedCode[iptr].instr = "jmp"
    } else if line.instr == "jmp" {
        fixedCode[iptr].instr = "nop"
    }
    return fixedCode
}

func runProgram(code: [Instruction], accumulator: inout Int) -> Bool {
    var iptr: Int = 0
    var abend: Bool = false
    var processed = [Int: String]()
    repeat {
        if processed.keys.contains(iptr) {
            abend = true
        } else {
            processed[iptr] = code[iptr].instr + " " + String(code[iptr].oper)
            iptr = iptr + execute(code: code[iptr], accumulator: &accumulator)
        }
    } while iptr < code.count && !abend
    return !abend
}

do {
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day8/Day8_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day8/Day8_input.txt", encoding: String.Encoding.utf8)
    let inputCode = input.components(separatedBy: "\n")

//    for i in 0...dodgyCode.count-1 {
    for i in stride(from:inputCode.count-1, through: 0, by: -1) {
        // urgh! brute force it by trying all combinations, taking a punt it's nearer the end than the beginning and even worse...
        // doh! I already have the original input and can just use a map...
        let dodgyCode = inputCode.map(Instruction.init)
        var attemptedFix = dodgyCode
        if attemptedFix[i].instr == "jmp" || attemptedFix[i].instr == "nop" {
            attemptedFix = fixCode(code: attemptedFix, iptr: i)
            var accumulator: Int = 0
            if runProgram(code: attemptedFix, accumulator: &accumulator) {
                print(accumulator)
                break
            }
        }
    }
    print("Done")
    
} catch {
    
    print("File not Found")

}
