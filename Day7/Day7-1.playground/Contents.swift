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
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day7/Day7_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day7/Day7_input.txt", encoding: String.Encoding.utf8)
//    print(input)
    let inputRules = input.components(separatedBy: "\n")
    let rules = inputRules.map(Rule.init)
//    print(values.count)

    var contains = [String: [String]]()
    rules.forEach { rule in
        rule.bagContents.forEach { colour, count in
            let insideBag = contains[colour, default: []]
            contains[colour] = insideBag + [rule.colour]
        }
    }

    var outer = [String]()
    var done = Set<String>()
    var q = contains["shiny gold"]!
    while !q.isEmpty {
        let bag = q.removeFirst()
        if rules.contains(where: { $0.colour == bag }) {
            outer.append(bag)
        }
        for container in contains[bag, default: []] {
            if !done.contains(container) && !q.contains(container) {
                q.append(container)
            }
        }
        done.insert(bag)
    }

    print("Answer: ", outer.count)
    print(outer)
    
} catch {
    
    print("File not Found")

}
