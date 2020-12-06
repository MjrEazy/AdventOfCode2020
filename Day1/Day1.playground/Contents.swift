import Cocoa

do {
    
    let input = try String(contentsOfFile: "/Users/David/Downloads/Day1_input.txt", encoding: String.Encoding.utf8)
    // print(input)
    let values = input.components(separatedBy: "\n")
    print(values.count)
    print(values)
   
    var found = false
    for i in 0...values.count-1 {
        for j in 0...values.count-1 {
            if i != j {
                let v1:Int = Int(values[i]) ?? 0
                let v2:Int = Int(values[j]) ?? 0
                let sum:Int = v1 + v2
                if sum == 2020 {
                    print("Answer", v1 * v2)
                    found = true
                    break
                }
            }
        }
        if found {
            break
        }
    }
    
} catch {
    
    print("File not Found")

}
