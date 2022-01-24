import Foundation

func solution(_ id_list:[String], _ report:[String], _ k:Int) -> [Int] {
    var result: [Int] = Array(repeating: 0, count: id_list.count)
    var resultdic: [String: Int] = [:]
    var reportlist: [String: [String]] = [:]
    for name in Set(report) {
        let names = name.components(separatedBy: " ")
        reportlist[names[1]] = (reportlist[names[1]] ?? []) + [names[0]]
//        resultdic[names[0]] = (resultdic[names[0]] ?? 0) + 1
//        if let key = reportlist[names[1]] {
//            if !key.contains(names[0]) {
//                reportlist[names[1]]!.append(names[0])
//            }
//        } else {
//            reportlist[names[1]] = [names[0]]
//        }
    }
    for (key, value) in reportlist {
        if value.count >= k {
            for i in value {
                resultdic[i] = (resultdic[i] ?? 0) + 1
//                if let id = resultdic[i] {
//                    resultdic[i]! += 1
//                } else {
//                    resultdic[i] = 1
//                }
            }
        }
    }
    for (key, value) in resultdic {
        let index = id_list.firstIndex(of: key)!
        result[index] = value
    }
    
    return result
}

var id_list = ["muzi", "frodo", "apeach", "neo"]
var report = ["muzi frodo","apeach frodo","frodo neo","muzi neo","apeach muzi"]

print(solution(id_list, report, 2))
