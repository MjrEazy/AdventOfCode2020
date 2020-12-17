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

func validateTickets(rules: [String:(ClosedRange<Int>,ClosedRange<Int>)], tickets: [[Int]]) -> Int {
    var errorRate: Int = 0
    for ticket in tickets {
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
                errorRate = errorRate + v
            }
        }
    }
    return errorRate
}

public func main(ticketsData: inout [String]) {
   
    let rules = getRules(ticketsData: &ticketsData)
    let _ = getTickets(ticketsData: &ticketsData)
    let nearbyTickets = getTickets(ticketsData: &ticketsData)
    let errorRate = validateTickets(rules: rules, tickets: nearbyTickets)
    print("Answer: \(errorRate)")
}


//var ticketsData = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day16/Day16_input_test.txt")
var ticketsData = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day16/Day16_input.txt")

printTimeElapsedWhenRunningCode(title:"main()") {
    main(ticketsData: &ticketsData)
}

