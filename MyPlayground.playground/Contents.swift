import Foundation

func solution(_ left:Int, _ right:Int) -> Int {
    let a = (left...right).map{ sqrt(Double($0)) == floor(sqrt(Double($0))) ? -$0 : $0 }
    print(a.reduce(0, +))
    var b = (left...right).map{ sqrt(Double($0)) == floor(sqrt(Double($0))) ? -$0 : $0 }.reduce(0, +)
    //    return (left...right).map{ sqrt(Double($0)) == floor(sqrt(Double($0))) ? -$0 : $0 }.reduce(0, +)
        return 1
}

solution(13, 17)
//print(solution(13, 17))
