import Cocoa

var departureTimes = [Int: Int]()

func calcDepartureTime(etd: Int, bus: Int)->Int {
    var depart: Int = 0
    repeat {
        depart = depart + bus
    } while depart < etd
    return depart
}

public func main() {
    //let data = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day13/Day13_input_test.txt")
    let data = getFileAsStrings(fileName: "/Users/David/Documents/AdventOfCode2020/AdventOfCode2020/Day13/Day13_input.txt")
    let etd: Int = Int(data[0])!
    let busses: [String] = data[1].components(separatedBy: ",").map{String($0)}
    var lowestTime: Int = 69
    var busToCatch: Int = 0
    for bus in 1..<busses.count {
        if busses[bus] != "x" {
            let busID: Int = Int(busses[bus])!
            departureTimes[busID] = calcDepartureTime(etd: etd, bus: busID) - etd
            if departureTimes[busID]! < lowestTime {
                busToCatch = busID
                lowestTime = departureTimes[busID]!
            }
        }
    }
    print("BusID: \(busToCatch), Answer:", busToCatch * lowestTime)
}

printTimeElapsedWhenRunningCode(title:"main()") {
    main()
}

