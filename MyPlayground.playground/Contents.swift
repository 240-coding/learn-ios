import Foundation

func solution(_ places:[[String]]) -> [Int] {
    var result = [Int]()
    var arr = [[Character]]()
    var shouldExit = false
    
    
    func testOutside(_ curr: [Int], _ target: [Int]) -> Bool {
        if target[0] < 0 || target[0] > 4 || target[1] < 0 || target[1] > 4 {
            return true
        }
        if arr[target[0]][target[1]] == "P" {
            let row = (curr[0] + target[0]) / 2
            let col = (curr[1] + target[1]) / 2
            return arr[row][col] != "X" ? false : true
        } else {
            return true
        }
        
    }
    
    func testDiagonalOutside(_ curr: [Int], _ target: [Int]) -> Bool {
        if target[0] < 0 || target[0] > 4 || target[1] < 0 || target[1] > 4 {
            return true
        }
        if arr[target[0]][target[1]] == "P" {
            return arr[curr[0]][target[1]] != "X" || arr[target[0]][curr[1]] != "X" ? false : true
        } else {
            return true
        }
        
    }
    
    for place in places {
        arr = place.map{ Array($0) }
        print(place)
        for i in 0..<5 {
            shouldExit = false
            for j in 0..<5 {
                print("\(i), \(j)")
                if arr[i][j] == "P" {
                    // 안쪽 부분 검사
                    if i > 0 {
                        if arr[i-1][j] == "P" {
                            print("안쪽1")
                            result.append(0)
                            shouldExit = true
                            break
                        }
                    }
                    if i < 4 {
                        if arr[i+1][j] == "P" {
                            print("안쪽2")
                            result.append(0)
                            shouldExit = true
                            break
                        }
                    }
                    if j > 0 {
                        if arr[i][j-1] == "P" {
                            print("안쪽3")
                            result.append(0)
                            shouldExit = true
                            break
                        }
                    }
                    if j < 4 {
                        if arr[i][j+1] == "P" {
                            print("안쪽4")
                            result.append(0)
                            shouldExit = true
                            break
                        }
                    }
                    // 바깥쪽 부분 검사 - 1
                    if !testOutside([i, j], [i-2, j]) || !testOutside([i, j], [i+2, j]) || !testOutside([i, j], [i, j-2]) || !testOutside([i, j], [i, j+2]) {
                        print("바깥1")
                        result.append(0)
                        shouldExit = true
                        break
                    }
                    // 바깥쪽 부분 검사 - 2 (대각선)
                    if !testDiagonalOutside([i, j], [i-1, j-1]) || !testDiagonalOutside([i, j], [i+1, j+1]) || !testDiagonalOutside([i, j], [i-1, j+1]) || !testDiagonalOutside([i, j], [i+1, j-1]) {
                        print("바깥2")
                        result.append(0)
                        shouldExit = true
                        break
                    }
                }
                
            }
            if shouldExit { break }
        }
        // 위 검사에서 거리두기 지키지 않은 응시자가 발견되지 않은 경우
        if !shouldExit { result.append(1) }
    }
    
    return result
}
let places = [["POOOP", "OXXOX", "OPXPX", "OOXOX", "POXXP"], ["POOPX", "OXPXP", "PXXXO", "OXXXO", "OOOPP"], ["PXOPX", "OXOXP", "OXPOX", "OXXOP", "PXPOX"], ["OOOXX", "XOOOX", "OOOXX", "OXOOX", "OOOOO"], ["PXPXP", "XPXPX", "PXPXP", "XPXPX", "PXPXP"]]
//print(places[0].map{ Array($0)})

print(solution(places))
