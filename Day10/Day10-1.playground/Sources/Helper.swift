import Foundation

public func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    print("Time elapsed for \(title): \(timeElapsed) s.")
}

func timeElapsedInSecondsWhenRunningCode(operation: ()->()) -> Double {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}

public func getFileAsInts(fileName: String) -> [Int] {
    
    do {

        let input = try String(contentsOfFile: fileName, encoding: String.Encoding.utf8)
        let numbers = input.components(separatedBy: "\n").map{Int($0)!}
        return numbers
        
    } catch {
        
        print("File not Found")
        return []
        
    }
}
