import Cocoa



public func main() {
    // let turns: Int = 10
    // let input: [Int] = [0,3,6]  //10th, 0

    let turns: Int = 2020
    //let input: [Int] = [1,3,2]    //2020th, 1
    //let input: [Int] = [2,1,3]    //2020th, 10
    //let input: [Int] = [1,2,3]    //2020th, 27
    //let input: [Int] = [2,3,1]    //202th, 78
    //let input: [Int] = [3,2,1]    //2020th, 438
    //let input: [Int] = [3,1,2]    //2020th, 1836
    let input: [Int] = [2,0,1,7,4,14,18]    //2020th, ??
    
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

printTimeElapsedWhenRunningCode(title:"main()") {
    main()
}

