import Foundation

public func main(input: [Int], turns: Int) {
    
    var lastTurns = input.enumerated().reduce(into: [Int:(Int,Int)]()) { $0[$1.1] = ($1.0+1,$1.0+1)}
    var lastSpoken = input.last!
    
    for turn in lastTurns.count+1...turns {
        let (first,second) = lastTurns[lastSpoken]!
        let new = second - first
        if let (_, lastTwo) = lastTurns[new] {
            lastTurns[new] = (lastTwo, turn)
        } else {
            lastTurns[new] = (turn,turn)
        }
        lastSpoken = new
    }

    print("Answer: \(lastSpoken)")
}

