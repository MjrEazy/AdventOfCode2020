import Cocoa

//byr (Birth Year)
//iyr (Issue Year)
//eyr (Expiration Year)
//hgt (Height)
//hcl (Hair Color)
//ecl (Eye Color)
//pid (Passport ID)
//cid (Country ID) Optional

func checkPassport(passport: String) -> Bool {
    var isValid: Bool = false
    if passport.range(of:"byr") != nil && passport.range(of:"iyr") != nil && passport.range(of:"eyr") != nil  {
        isValid = true
    }
    if isValid && passport.range(of:"hgt") != nil && passport.range(of:"hcl") != nil && passport.range(of:"ecl") != nil {
        isValid = true
    }
    else {
        isValid = false
    }
    if isValid && passport.range(of:"pid") != nil {
        isValid = true
    }
    else {
        isValid = false
    }
    return isValid
}

func checkPassports(input: [String]) -> Int {
    var validCount: Int = 0
    var passport: String = ""
    for r in 0...input.count - 1 {
        if input[r].count == 0 {
            let isValid = checkPassport(passport: passport)
            // print(isValid, passport)
            if isValid {
                validCount = validCount + 1
            }
            passport = ""
        }
        passport = passport + input[r] + " "
    }
    return validCount
}

do {
    
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day4/Day4_input_test.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day4/Day4_input.txt", encoding: String.Encoding.utf8)
//    print(input)
    let values = input.components(separatedBy: "\n")
//    print(values.count)

    let valid:Int  = checkPassports(input: values)
    print("# valid is " + String(valid))
    
} catch {
    
    print("File not Found")

}

