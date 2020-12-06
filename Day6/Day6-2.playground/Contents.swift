import Cocoa

func countAnswers(_ input: [[String]])  -> Int {
    input.reduce(0) {
        let answer = $1[0]
        return $1.reduce(into: Set<Character>(answer)) { $0.formIntersection($1.map { $0 }) }.count + $0
    }
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
