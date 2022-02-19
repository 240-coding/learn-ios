import Foundation

let a = "abcdzABCDZ"
let b = Character("a").asciiValue!
let c = UnicodeScalar(b)
print(a.utf8)
