import Cocoa

//byr (Birth Year)
//iyr (Issue Year)
//eyr (Expiration Year)
//hgt (Height)
//hcl (Hair Color)
//ecl (Eye Color)
//pid (Passport ID)
//cid (Country ID) Optional
extension NSRegularExpression {
    convenience init(_ pattern: String) {
        do {
            try self.init(pattern: pattern)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}

func validateData(passportData: String, tag: String, dataLen:Int, regex: String) -> Bool {
    var isValid: Bool = false
    let part = passportData.range(of: tag)
    let index: Int = passportData.distance(from: passportData.startIndex, to: part!.upperBound)
    //print(index, dataLen, index+dataLen, passportData.count)
    if index + dataLen >= passportData.count {
        isValid = false
    } else {
        if index + dataLen  < passportData.count {
            //print(passportData[passportData.index(passportData.startIndex, offsetBy: index+dataLen)] == " ")
            if passportData[passportData.index(passportData.startIndex, offsetBy: index+dataLen)] != " " {
                isValid = false
            } else {
                //print(passportData, passportData[part!.upperBound...passportData.index(part!.upperBound, offsetBy: dataLen-1)])
                let values = passportData[part!.upperBound...passportData.index(part!.upperBound, offsetBy: dataLen-1)]
                //print("|" + values + "|")
                let regex = NSRegularExpression(regex)
                if regex.matches(String(values)) {
                    isValid = true
                }
            }
        } else {
            isValid = false
        }
    }
    return isValid
}

func checkPassport(passport: String) -> Bool {
    var isValid: Bool = false
    
//    isValid = validateData(passportData:passport, tag: "iyr:", dataLen: 4, regex: "^(201[0-9]|2020)$")
//    return isValid
    
    //print(passport.range(of: "byr:"))

    //byr (Birth Year) - four digits; at least 1920 and at most 2002.
    if passport.range(of:"byr:") != nil {
        isValid = validateData(passportData:passport, tag: "byr:", dataLen: 4, regex: "^(192[0-9]|19[3-9][0-9]|200[0-2])$")
    }

    //iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    if isValid && passport.range(of: "iyr:") != nil {
        isValid = validateData(passportData:passport, tag: "iyr:", dataLen: 4, regex: "^(201[0-9]|2020)$")
    } else { isValid = false }

    //eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    if isValid && passport.range(of: "eyr:") != nil {
        isValid = validateData(passportData:passport, tag: "eyr:", dataLen: 4, regex: "^(202[0-9]|2030)$")
    } else { isValid = false }

    //hgt (Height) - a number followed by either cm or in:
    //If cm, the number must be at least 150 and at most 193.
    //If in, the number must be at least 59 and at most 76.
    if isValid && passport.range(of: "hgt:") != nil {
        if passport.range(of: "cm") != nil {
            isValid = validateData(passportData:passport, tag: "hgt:", dataLen: 5, regex: "^(15[0-9]|1[6-8][0-9]|19[0-3])cm$")
        } else {
            if passport.range(of: "in") != nil {
                isValid = validateData(passportData:passport, tag: "hgt:", dataLen: 4, regex: "^(59|6[0-9]|7[0-6])in$")
            } else {
                isValid = false
            }
        }
    } else { isValid = false }

    // hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    if isValid && passport.range(of: "hcl:") != nil {
        isValid = validateData(passportData:passport, tag: "hcl:", dataLen: 7, regex: "^#([0-9]|[a-f]){6}$")
    } else { isValid = false }

    // ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    if isValid && passport.range(of: "ecl:") != nil {
        isValid = validateData(passportData:passport, tag: "ecl:", dataLen: 3, regex: "^(amb|blu|brn|gry|grn|hzl|oth)$")
    } else { isValid = false }

    // pid (Passport ID) - a nine-digit number, including leading zeroes.
    if isValid && passport.range(of: "pid:") != nil {
        isValid = validateData(passportData:passport, tag: "pid:", dataLen: 9, regex: "^[0-9]{9}$")
    } else { isValid = false }

    // cid (Country ID) - ignored, missing or not.

    // we're done, I'm outta here...
    return isValid
}

func checkPassports(input: [String]) -> Int {
    //Hey! Ho! Hey! Ho! Lets go...
    var validCount: Int = 0
    var passport: String = ""
    //print(input)
    for r in 0...input.count - 1 {
        print("|" + input[r] + "|")
        if input[r].count == 0 {
            let isValid = checkPassport(passport: passport)
            print(isValid, passport)
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
    
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day4/Day4_input_testInvalid.txt", encoding: String.Encoding.utf8)
//    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day4/Day4_input_testValid.txt", encoding: String.Encoding.utf8)
    let input = try String(contentsOfFile: "/Users/David/Documents/AdventOfCode2020/Day4/Day4_input.txt", encoding: String.Encoding.utf8)
//    print(input)
//    let values = ["iyr:2012","", "iyr:2014", "", "iyr:2014", "", "iyr:2010 ", ""]
    let values = input.components(separatedBy: "\n")
    print(values.count)
    let valid:Int  = checkPassports(input: values)
    print("# valid is " + String(valid))
    
} catch {
    
    print("File not Found")

}
