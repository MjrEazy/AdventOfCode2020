import Cocoa

func checkPasswords(input: [String]) {
    var validPwds: Int = 0
    for i in 0...input.count-1 {
        var parts: [String] = input[i].components(separatedBy: ":")
        parts[0] = parts[0].replacingOccurrences(of: " ", with: "-")
        let rules: [String] = parts[0].components(separatedBy: "-")
        let pwd: String = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
        let pwdMin: Int = Int(rules[0])!
        let pwdMax: Int = Int(rules[1])!
        let pwdChar: String = rules[2]
        let set = CharacterSet(charactersIn: pwdChar)
        let pwdCount: Int  = pwd.components(separatedBy: set.inverted).joined().count
        //print(pwd, pwdMin, pwdMax, pwdChar, pwdCount)
        if pwdCount >= pwdMin && pwdCount <= pwdMax {
            validPwds = validPwds + 1
        }
    }
    print(validPwds)
}

do {
    
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day2/Day2_input.txt", encoding: String.Encoding.utf8)
    // print(input)
    let values = input.components(separatedBy: "\n")
    print(values.count)
    print(values)
    checkPasswords(input: values)
    
} catch {
    
    print("File not Found")

}
