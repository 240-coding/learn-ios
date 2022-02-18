import Foundation

let dartResult = "1S2D*3T"
let numberList = dartResult.split(whereSeparator: {$0.isLetter || $0 == "#" || $0 == "*"})
let letterList = dartResult.split(whereSeparator: {$0.isNumber})

print(zip(numberList, letterList))
