import Foundation

func solution(_ p:[Int]) -> [Int] {
    var result = Array(repeating: 0, count: p.count)
    var arr = p

    if p == p.sorted() { return result }

    for i in 0..<p.count {
        var min = 10000
        var minIndex = -1
        for j in i..<p.count {
            if arr[j] < min {
                min = arr[j]
                minIndex = j
            }
        }
        if arr[i] != arr[minIndex] {
            let temp = arr[i]
            arr[i] = arr[minIndex]
            arr[minIndex] = temp
            result[i] += 1
            result[minIndex] += 1
        }
    }

    return result
}

import Foundation

func solution(_ periods:[Int], _ payments:[[Int]], _ estimates:[Int]) -> [Int] {
    var vip = 0, notVip = 0

    for i in 0..<periods.count {
        // 가입 기간 2년 미만인 경우
        if periods[i] < 23 {
            continue
        }
        
        let currPay = payments[i].reduce(0, +)
        let estimatedPay = currPay - payments[i][0] + estimates[i]
        // 2년 이상 ~ 5년 미만
        if (24...59).contains(periods[i]+1) {
            if periods[i] == 23 || currPay < 900000 {
                if estimatedPay >= 900000 {
                    vip += 1
                }
            }
            if periods[i] > 23 && currPay >= 900000 {
                if estimatedPay < 900000 {
                    notVip += 1
                }
            }
        }
        // 5년 이상
        if periods[i]+1 >= 60 {
            if periods[i] == 59 {
                if currPay < 900000 && estimatedPay >= 600000 {
                    vip += 1
                } else if currPay >= 900000 && estimatedPay < 600000 {
                    notVip += 1
                }
            } else {
                if currPay < 600000 && estimatedPay >= 600000 {
                    vip += 1
                } else if currPay >= 600000 && estimatedPay < 600000 {
                    notVip += 1
                }
            }
        }
    }
    return [vip, notVip]
}

import Foundation

func solution(_ n:Int, _ plans:[String], _ clients:[String]) -> [Int] {
    var service = Array(repeating: -1, count: n+1) // 부가서비스 첫 등장 위치
    var datas = [Int]()
    var result = [Int]()

    // 부가서비스 첫 등장 위치 및 datas 배열 초기화
    for i in 0..<plans.count {
        let plan = plans[i].components(separatedBy: " ")
        datas.append(Int(plan[0])!)
        // 부가서비스
        for j in 1..<plan.count {
            service[Int(plan[j])!] = i
        }
    }

    // 각 고객별 요금제 찾기
    for i in 0..<clients.count {
        let client = clients[i].components(separatedBy: " ")
        var start = 0 // 요금제 탐색 최소 시작 위치
        var end = datas.count-1
        for j in 1..<client.count {
            let serviceStart = service[Int(client[j])!]
            if serviceStart == -1 {
                result.append(0)
                start = -1
                break
            }
            start = max(start, service[Int(client[j])!])
        }
        if start == -1 { continue }
        // 필요 데이터보다 더 큰 요금제 찾기
        let clientData = Int(client[0])!
        while start <= end {
            let mid = (start+end) / 2
            if datas[mid] < clientData {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        if start >= datas.count || datas[start] < clientData {
            result.append(0)
        } else {
            result.append(start+1)
        }

    }

    return result
}

import Foundation

func solution(_ grid:[String], _ k:Int) -> Int {
    var map: [[String]] = Array(repeating: Array(repeating: "", count: grid[0].count), count: grid.count)
    var visit = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)
    var routes = [String]()

    var result = 100000

    for (i, g) in grid.enumerated() {
        let str = Array(g)
        var temp = [String]()
        for ch in str {
            temp.append(String(ch))
        }
        map[i] = temp
    }

    // 모든 경로 탐색
    func dfs(_ r:Int, _ c:Int, _ currString:String) {
        if r == visit.count-1 && c == visit[0].count-1 {
            routes.append(currString + map[r][c])
            return
        }

        if r >= 0 && r < visit.count && c >= 0 && c < visit[0].count && map[r][c] != "#" {
            if !visit[r][c] {
                visit[r][c] = true
                let str = currString + map[r][c]

                dfs(r-1, c, str)
                dfs(r+1, c, str)
                dfs(r, c-1, str)
                dfs(r, c+1, str)

                visit[r][c] = false
            }
        }
    }

    dfs(0, 0, "")
    
    // 모든 경로 야영횟수 계산
    for r in routes {
        let route = Array(r)
        var i = k
        var sleepCount = 0
        while i < route.count-1 {
            if route[i] != "." {
                i -= 1
                if i < 0 { break }
            } else {
                sleepCount += 1
                i += k
            }
        }
        result = min(result, sleepCount)
    }

    return result
}
