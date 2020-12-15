import Cocoa


let turns: Int = 30000000
//let input: [Int] = [0,3,6]  //30000000th, 175594
//let input: [Int] = [1,3,2]    //30000000th, 2578
//let input: [Int] = [2,1,3]    //30000000th, 3544142
//let input: [Int] = [1,2,3]    //30000000th, 261214
//let input: [Int] = [2,3,1]    //30000000th, 6895259
//let input: [Int] = [3,2,1]    //30000000th, 18
//let input: [Int] = [3,1,2]    //30000000th, 362
let input: [Int] = [2,0,1,7,4,14,18]    //30000000th , ??

printTimeElapsedWhenRunningCode(title:"main()") {
    main(input: input, turns: turns)
}

