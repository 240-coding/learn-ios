import Foundation

import Foundation

func solution(_ n:Int) -> Int {
    func isPrime(_ num: Int) -> Bool {
        if num == 1 { return false }
        if num == 2 || num == 3 { return true }
        print(Int(sqrt(Double(num))))
        for i in 2..<Int(sqrt(Double(num))) {
            if num % i == 0 {
                print("\(num) % \(i) OOPS")
                return false
            }
        }
        return true
    }
    print((1...n).filter{ isPrime($0) })
    return (1...n).filter{ isPrime($0) }.count
}

print(solution(4))
