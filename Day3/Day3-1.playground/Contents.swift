import Cocoa

func findTrees(input: [String]) {
    let d:Int = input.count - 1
    let w:Int = input[0].count - 1
    var trees:Int = 0
    var c: Int = 3
    for r in 1...d {
        let i = input[r].index(input[r].startIndex, offsetBy: c)
        if input[r][i...i] == "#" {
            trees = trees + 1
        }
        c = c + 3
        if c > w {
            c = c - w - 1
        }
    }
    print(trees)
}

do {
    
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day3/Day3_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day3/Day3_input.txt", encoding: String.Encoding.utf8)
//    print(input)
    let values = input.components(separatedBy: "\n")
//    print(values.count)

    findTrees(input: values)
    
} catch {
    
    print("File not Found")

}
