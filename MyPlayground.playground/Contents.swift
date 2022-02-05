import Foundation

func solution(_ N:Int, _ stages:[Int]) -> [Int] {
    var arr = stages.sorted()
    var stagesInfo = Array(repeating: (0, 0), count: N+1) // 0: 실패수, 1: 전체수
    var currentValue = arr[0]
    var startIndex = 0
    
    // 클리어 못 한 사용자 수 구하기
    for i in 1..<arr.count {
        if arr[i] != N+1 {
            if arr[i] != currentValue {
                stagesInfo[arr[i]].0 = i - startIndex
                currentValue = arr[i]
                startIndex = i
            }
        } else {
            stagesInfo[N].1 += 1
        }
    }
    // 도전한 사용자 수 구하기
    var sum = 0
    for i in (1..<stagesInfo.count).reversed() {
        stagesInfo[i].1 += stagesInfo[i].0 + sum
        sum += stagesInfo[i].1
    }
    var fails = stagesInfo.map{Double($0.0) / Double($0.1)} // 실패율 구하기
    
    return (1...N).sorted(by: {fails[$0] > fails[$1]})
}

var N = 5
var stages = [2, 1, 2, 6, 2, 4, 3, 3]
print(solution(N, stages))
print(stages.sorted())
for i in (1..<stages.count).reversed() {
    print(i)
}
