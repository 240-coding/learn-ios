import Foundation

func solution(_ s:String) -> Int {
    if s.count % 2 == 1 { return 0 }
    
    var str = Array(s)
    let dict = ["(": 0, ")": 1, "[": 2, "]": 3, "{": 4, "}": 5]
    var stk = [Int]()
    var start = 0, end = s.count-1
    var rotationCount = 0
    var x = 0
    
    // 올바른 괄호 문자열인지 확인
    while start <= end {
        let curr = dict[String(str[start])]!
        if curr % 2 == 0 { // 여는 괄호인 경우
            stk.append(curr)
        } else { // 닫는 괄호인 경우
            if stk.isEmpty {
                let lst = dict[String(str[end])]!
                if curr - lst == 1 { // 짝이 맞는 경우
                    end -= 1
                    rotationCount = start+1
                } else { // 짝이 맞지 않음 - 올바른 괄호 문자열 X
                    return 0
                }
            } else {
                if curr - stk.last! == 1 {
                    stk.removeLast()
                } else {
                    return 0
                }
            }
        }
        start += 1
    }
    
    print(stk)
    if !stk.isEmpty { return 0 }
    
    // 올바른 문자열 얻기 위한 문자열 회전
    str = rotationCount > 0 ? Array(str[rotationCount..<str.count] + str[0..<rotationCount]) : str
    
    // x 개수 계산
    stk = []
    for ch in str {
        let curr = dict[String(ch)]!
        if curr % 2 == 0 {
            if stk.isEmpty {
                x += 1
            }
            stk.append(curr)
        } else {
            stk.removeLast()
        }
    }
    
    
    return x
}

print(solution("))())((("))
