import Foundation

let input = "15\n1 2\n1 3\n2 4\n3 7\n6 2\n3 8\n4 9\n2 5\n5 11\n7 13\n10 4\n11 15\n12 5\n14 7\n6\n6 11\n10 9\n2 6\n7 6\n8 13\n8 15\n"

var path = [[Int]]()
var pairs = [[Int]]()
var result = -1

func initialize(_ input: String) {
    let row = input.components(separatedBy: .newlines)
    var n = Int(row[0])!
    path = [[Int]](repeating: [Int](), count: n)

    var i = 1
    var connects = [[Int]]()
    while true {
        var item = row[i]
        var pair = item.components(separatedBy: " ")
        if pair.count < 2 {
            break
        }
        var a = Int(pair[0])! - 1
        var b = Int(pair[1])! - 1
        connects.append([a, b])
        i += 1
    }

    makeTree(connects)

    var m = Int(row[n])!
    pairs = [[Int]]()
    for i in n + 1...n + m {
        var item = row[i]
        var pair = item.components(separatedBy: " ")
        var a = Int(pair[0])! - 1
        var b = Int(pair[1])! - 1
        pairs.append([ a, b ])
    }
}

func makeTree(_ connects: [[Int]], _ i: Int = 0, _ parent: Int = -1) {
    var children = searchChildren(connects, i, parent)
    path[i] = children
    for child in children {
        makeTree(connects, child, i)
    }
}

func searchChildren(_ connects: [[Int]], _ i: Int = 0, _ parent: Int = -1) -> [Int] {
    var a = connects.filter { $0[0] == i && $0[1] != parent }.map{ $0[1] }
    var b = connects.filter { $0[1] == i && $0[0] != parent }.map{ $0[0] }
    return a + b
}

func search(_ a: Int, _ b: Int,  _ i: Int = 0) -> Bool {
    var children = path[i]
    var found = a == i || b == i

    for child in children {
        var temp = search(a, b, child)
        if found && temp {
            result = i
            return true
        }
        found = found || temp
    }
    
    return found
}

initialize(input)

//print(path)
//print(pairs)

search(5, 10)

for pair in pairs {
    search(pair[0], pair[1])
    print(result + 1)
}



