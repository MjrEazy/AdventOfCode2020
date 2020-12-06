import Cocoa

do {
    
    let input = try String(contentsOfFile: "/Users/David/Downloads/Day1_input.txt", encoding: String.Encoding.utf8)
    // print(input)
    let values = input.components(separatedBy: "\n")
    print(values.count)
    print(values)
   
    var found = false
    var i = 0
    while !found && i < values.count-2 {
        var j = 0
        while !found && j < values.count-1 {
            var k = 0
            while !found && k < values.count-1 {
                if i != j && j != k {
                    let v1:Int = Int(values[i]) ?? 0
                    let v2:Int = Int(values[j]) ?? 0
                    let v3:Int = Int(values[k]) ?? 0
                    let sum:Int = v1 + v2 + v3
                    if sum == 2020 {
                        print("Answer", v1 * v2 * v3)
                        found = true
                    }
                }
                k = k + 1
            }
            j = j + 1
        }
        i = i + 1
    }
    
} catch {
    
    print("File not Found")

}

