import Cocoa

func checkPasswords(input: [String]) {
    var validPwds: Int = 0
    for i in 0...input.count-1 {
        var parts: [String] = input[i].components(separatedBy: ":")
        parts[0] = parts[0].replacingOccurrences(of: " ", with: "-")
        let rules: [String] = parts[0].components(separatedBy: "-")
        let pwd: String = parts[1].trimmingCharacters(in: .whitespacesAndNewlines)
        let pwdMin = pwd.index(pwd.startIndex, offsetBy: Int(rules[0])!-1)
        let pwdMax = pwd.index(pwd.startIndex, offsetBy: Int(rules[1])!-1)
        let pwdChar: String = rules[2]
        print(pwd[pwdMin...pwdMin])
        print(pwd[pwdMax...pwdMax])
        if pwd[pwdMin...pwdMin] == pwdChar || pwd[pwdMax...pwdMax] == pwdChar {
            if pwd[pwdMin] != pwd[pwdMax] {
                validPwds = validPwds + 1
            }
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
