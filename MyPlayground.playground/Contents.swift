let str = "z"
var dict = [Character: Int]()
for ch in str {
    if let value = dict[ch] {
        dict[ch] = value + 1
    } else {
        dict[ch] = 0
    }
}
var maxnum = dict.values.max()!
var maxch = dict.keys.filter({ dict[$0] == maxnum })
print(maxch.count > 1 ? "?" : maxch[0].uppercased())
