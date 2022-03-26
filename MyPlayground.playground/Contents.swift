func solution(_ str1:String, _ str2:String) -> Int {
    var s1 = Array(str1.lowercased())
    var s2 = Array(str2.lowercased())
    var set1 = Set<String>()
    var set2 = Set<String>()
    var dict1 = [String: Int]()
    var dict2 = [String: Int]()
    
    // 다중집합 만들기
    for i in 0..<s1.count-1 {
        if s1[i].isLetter && s1[i+1].isLetter {
            let curr = String(s1[i...i+1])
            set1.insert(curr)
            dict1[curr] = (dict1[curr] ?? 0) + 1
        }
        
    }
    for i in 0..<s2.count-1 {
        if s2[i].isLetter && s2[i+1].isLetter {
            let curr = String(s2[i...i+1])
            set2.insert(curr)
            dict2[curr] = (dict2[curr] ?? 0) + 1
        }
    }
    // 교집합 찾기
    var inter = Array(set1.intersection(set2))
    for str in inter {
        let count = min(dict1[str]!, dict2[str]!)
        for i in 1..<count {
            inter.append(str)
        }
    }
    // 합집합 찾기
    var union = Array(set1.union(set2))
    for str in union {
        let count = max(dict1[str] ?? 0, dict2[str] ?? 0)
        for i in 1..<count {
            union.append(str)
        }
    }
    
    print(inter.count)
    print(union.count)
    return Int((Double(inter.count) / Double(union.count)) * 65536)
}

print(solution("E=M*C^2", "e=m*c^2"))
