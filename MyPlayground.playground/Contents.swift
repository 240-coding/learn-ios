import Foundation

var cache = [String: [String]]()

func combinations(_ array: [String]) -> Set<String> {
    if array.count == 0 { return [] }

    let answerArray = (0..<array.count).flatMap { i -> [String] in
        var removedArray = array
        let elem = removedArray.remove(at: i)
        return [elem] + combinations(removedArray).map { elem + $0 }
    }
//    print("answerArray: \(answerArray)")
    return Set(answerArray)
}

func isPrime(_ number: Int) -> Bool {
    guard number > 1 else {
        return false
    }

    for i in 2..<number {
        if number % i == 0 { return false }
    }
    return true
}

func solution(_ numbers: String) -> Int {
    let array = Array(numbers).map{ String($0) }
    print(Set(combinations(array)))
    let intSet = Set(combinations(array).compactMap { Int($0) })
    print(intSet)
    return intSet.filter{ isPrime($0) }.count
}

print(solution("011"))
