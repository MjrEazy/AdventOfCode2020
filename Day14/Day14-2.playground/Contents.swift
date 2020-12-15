import Cocoa

extension String {
  public func replaceFirst(of pattern:String, with replacement:String) -> String {
    if let range = self.range(of: pattern){
      return self.replacingCharacters(in: range, with: replacement)
    }else{
      return self
    }
  }
}

var memory = [String: Int]()

public func maskAddress(mask: String, address: String)->String {
    var maskedAddress: String = ""
    for (m, a) in zip(mask, address) {
        if m == "0" {
            maskedAddress = maskedAddress + String(a)
        } else {
            maskedAddress = maskedAddress + String(m)
        }
    }
    return maskedAddress
}

public func storeValue(address: String, value: Int) {
    if !address.contains("X") {
      memory[address] = value
      return
    }
    storeValue(address: address.replaceFirst(of: "X", with: "0"), value: value)
    storeValue(address: address.replaceFirst(of: "X", with: "1"), value: value)
}


public func main() {
    //let instructions = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day14/Day14_input_test2.txt")
    let instructions = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day14/Day14_input.txt")
    var mask:String = String(instructions[0].suffix(36))
    for iptr in 1..<instructions.count {
        if instructions[iptr].prefix(4) == "mask" {
            mask = String(instructions[iptr].suffix(36))
        } else {
            let addr: Int = Int(instructions[iptr].dropFirst(4).prefix(while: { $0.isWholeNumber }))!
            var address:String = String(addr, radix: 2)
            address = String(repeating: "0", count: 36-address.count) + address
            let value: Int = Int(instructions[iptr].components(separatedBy: " = ")[1])!
            let maskedAddress = maskAddress(mask: mask, address: address)
            storeValue(address: maskedAddress, value: value)
        }
    }
    
    let answer:Int = memory.values.reduce(0, +)
    print("Answer: \(answer)")
}

printTimeElapsedWhenRunningCode(title:"main()") {
    main()
}

