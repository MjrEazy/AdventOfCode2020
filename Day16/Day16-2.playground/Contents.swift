import Cocoa

func getTickets(ticketsData: inout [String]) -> [[Int]] {
    var line: String = ""
    var tickets: [[Int]] = [[]]
    repeat {
        line = String(ticketsData[0])
        if line != "" && line.contains(",") {
            let ticketData: [Int] = line.components(separatedBy: ",").map{Int($0)!}
            tickets.append(ticketData)
        }
        ticketsData.remove(at: 0)
    }  while line != ""
    tickets.remove(at: 0)
    return tickets
}

func getRuleRange(ruleValues: String) -> ClosedRange<Int> {
    let parts = ruleValues.components(separatedBy: "-")
    let low: Int = Int(parts[0])!
    let high: Int = Int(parts[1])!
    let ruleRange: ClosedRange = low...high
    return ruleRange
}

func getRules(ticketsData: inout [String]) -> [String: (ClosedRange<Int>, ClosedRange<Int>)] {
    var rules = [String: (ClosedRange<Int>, ClosedRange<Int>)]()
    var line: String = ""
    repeat {
        line = ticketsData[0]
        if line != "" {
            let elements = line.components(separatedBy: " ")
            rules[elements[0]] = (getRuleRange(ruleValues: elements[1]), getRuleRange(ruleValues: elements[3]))
        }
        ticketsData.remove(at: 0)
    } while line != ""
    return rules
}

func removeInvalidTickets(rules: [String:(ClosedRange<Int>,ClosedRange<Int>)], tickets: inout [[Int]]) -> (Int, [Int]) {
    var errorRate: Int = 0
    var invalidTickets: [Int] = []
    var i: Int = 0
    var t: Int = 1
    for ticket in tickets {
        var validTicket: Bool = true
        for f in 0..<ticket.count {
            var valid: Bool = false
            let v: Int = ticket[f]
            for (_, rule) in rules {
                if (rule.0 ~= v) || (rule.1 ~= v) {
                    valid = true
                    break
                }
            }
            if !valid {
                errorRate = errorRate + 1
                validTicket = false
                if !invalidTickets.contains(i) { invalidTickets.append(t) }
            }
        }
        if !validTicket {
            tickets.remove(at: i)
            i = i - 1
        }
        i = i + 1
        t = t + 1
    }
    return (errorRate, invalidTickets)
}

func findFieldNumbers(rules: [String:(ClosedRange<Int>,ClosedRange<Int>)], tickets: [[Int]]) -> [String: [Int]] {
    var fields = [String: [Int]]()
    for (field, rule) in rules {
        var candidates: [Int] = [Int](0..<tickets.first!.count)
        for c in 0..<candidates.count {
            for t in 0..<tickets.count {
                let v:Int = tickets[t][c]
                if !rule.0.contains(v) && !rule.1.contains(v)  {
                    candidates[c] = -1
                    break
                }
            }
        }
        fields[field] = candidates.filter { $0 != -1 }
    }
    var done: [String] = []
    while done.count < tickets.first!.count {
        for (field, candidates) in fields {
            if !done.contains(field) && candidates.count == 1 {
                for (f, c) in fields.filter({ $0.key != field }) {
                    fields[f] = c.filter({ $0 != candidates[0] })
                }
                if fields[field]!.count == 1 {
                    done.append(field)
                    break
                }
            }
        }
    }
    return fields
}

public func main(ticketsData: inout [String]) {
    let rules = getRules(ticketsData: &ticketsData)
    let myTicket = getTickets(ticketsData: &ticketsData)
    var nearbyTickets = getTickets(ticketsData: &ticketsData)
    let (_, _) = removeInvalidTickets(rules: rules, tickets: &nearbyTickets)
    var tickets = nearbyTickets
    tickets.append(myTicket.first!)
    let fields = findFieldNumbers(rules: rules, tickets: tickets)
    let departureFields = fields.filter { $0.key.prefix(9) == "departure" }
    print(departureFields)
    var answer: Int = 1
    for (_, f) in departureFields {
        answer = answer * myTicket.first![f[0]]
    }
    print("Answer:", answer)
}


//var ticketsData = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day16/Day16_input_test.txt")
//var ticketsData = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day16/Day16_input_test2.txt")
var ticketsData = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day16/Day16_input.txt")

printTimeElapsedWhenRunningCode(title:"main()") {
    main(ticketsData: &ticketsData)
}

