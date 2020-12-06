import Cocoa

func findTrees(input: [String], stepRight: Int, stepDown: Int) -> Int {
    let d:Int = input.count - 1
    let w:Int = input[0].count - 1
    var trees:Int = 0
    var c: Int = stepRight
    for r in stride(from: stepDown, through: d, by: stepDown) {
        let i = input[r].index(input[r].startIndex, offsetBy: c)
        if input[r][i...i] == "#" {
            trees = trees + 1
        }
        c = c + stepRight
        if c > w {
            c = c - w - 1
        }
    }
    print(trees)
    return trees
}

do {
    
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day3/Day3_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day3/Day3_input.txt", encoding: String.Encoding.utf8)
//    print(input)
    let values = input.components(separatedBy: "\n")
//    print(values.count)

    var answer: Int = findTrees(input: values, stepRight : 1, stepDown : 1)
    answer =  answer * findTrees(input: values, stepRight : 3, stepDown : 1)
    answer =  answer * findTrees(input: values, stepRight : 5, stepDown : 1)
    answer =  answer * findTrees(input: values, stepRight : 7, stepDown : 1)
    answer =  answer * findTrees(input: values, stepRight : 1, stepDown : 2)
    print(answer)
    
} catch {
    
    print("File not Found")

}
