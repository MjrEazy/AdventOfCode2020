import Cocoa

func countAnswers(_ input: [[String]])  -> Int {
    return input.reduce(0) { $1.reduce(Set<Character>()) { $0.union($1) }.count + $0 }
}

do {
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day6/Day6_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day6/Day6_input.txt", encoding: String.Encoding.utf8)
        .components(separatedBy: "\n\n")
        .map {
          $0.split(separator: "\n")
            .compactMap(String.init)
        }
//    print(input)
    print(countAnswers(input))
    
} catch {
    
    print("File not Found")

}
