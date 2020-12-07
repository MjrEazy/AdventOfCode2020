import Cocoa

final class Rule {
    let colour: String
    let bagContents: [(colour: String, count: Int)]

    init(string: String) {
        let ruleParts = string.components(separatedBy: " bags contain ")
        self.colour = ruleParts[0]
        let contents = ruleParts[1].components(separatedBy: ", ")
        if ruleParts[1] == "no other bags." {
            self.bagContents = []
            return
        }
        self.bagContents = contents.map { item in
            let text = item.components(separatedBy: " ")
            return ("\(text[1]) \(text[2])", Int(text[0])!)
        }
    }
}

do {
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day7/Day7_input_test2.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day7/Day7_input.txt", encoding: String.Encoding.utf8)
//    print(input)
    let inputRules = input.components(separatedBy: "\n")
    let rules = inputRules.map(Rule.init).reduce(into: [String: Rule](), { $0[$1.colour] = $1 })
//    print(values.count)

    var bags = 0
    var q = [(rule: rules["shiny gold"]!, multiplier: 1)]
    while !q.isEmpty {
        let (rule, multiplier) = q.removeFirst()
        rule.bagContents.forEach { colour, count in
            bags += count * multiplier
            q.append((rules[colour]!, count * multiplier))
        }
    }

    print("Answer: ", bags)
    
} catch {
    
    print("File not Found")

}
