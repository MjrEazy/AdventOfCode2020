import Cocoa

func findTuple(input: [String], sum:Int) {
     
    var temp:Int
    for i in 0...input.count-2 {
        var hash:Set = Set<Int>()
        temp = sum - Int(input[i])!
        for j in i+1...input.count-1 {
            if hash.contains(temp - Int(input[j])!) {
                var s:String
                let temp2:Int = temp - Int(input[j])!
                s = "Triplet with sum " + String(sum) + " is (" + input[i] + ", " + input[j] + "," + String(temp2) + ")"
                print(s)
                let answer = Int(input[i])! * Int(input[j])! * temp2
                print("Answer is " + String(answer))
            }
            hash.insert(Int(input[j])!)
        }
    }
}

do {
    
    let input = try String(contentsOfFile: "/Users/David/Downloads/Day1_input.txt", encoding: String.Encoding.utf8)
    // print(input)
    let values = input.components(separatedBy: "\n")
    print(values.count)
    print(values)
    findTuple(input: values, sum: Int(2020))

    
} catch {
    
    print("File not Found")

}
