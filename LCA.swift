import Foundation

let input = "100\n19 86\n14 63\n25 84\n86 99\n2 92\n27 24\n34 40\n12 68\n35 81\n77 86\n94 8\n79 29\n95 8\n16 44\n71 88\n55 62\n93 66\n84 67\n93 62\n64 5\n6 38\n67 87\n17 7\n83 98\n25 47\n5 86\n22 85\n99 51\n3 13\n3 57\n95 82\n14 67\n28 25\n96 26\n10 40\n88 4\n79 60\n83 60\n12 89\n53 49\n93 52\n99 79\n100 93\n29 89\n3 47\n36 37\n16 70\n54 82\n6 47\n74 80\n66 88\n12 56\n23 81\n49 38\n43 75\n28 41\n57 81\n75 52\n50 73\n58 19\n17 64\n85 83\n95 12\n42 39\n93 81\n91 51\n4 68\n82 74\n76 55\n34 89\n65 4\n96 5\n78 70\n37 65\n69 80\n89 21\n27 22\n27 90\n69 44\n50 96\n53 20\n32 54\n48 75\n82 39\n72 81\n9 12\n30 88\n45 63\n67 11\n78 59\n46 7\n18 92\n68 15\n17 97\n2 37\n31 63\n46 61\n1 10\n33 97\n10\n2 8\n37 78\n31 61\n1 2\n81 82\n43 77\n23 1\n42 89\n88 65\n32 75\n"

var path = [[Int]]()
var pairs = [[Int]]()
var result = -1

func read() {
    var n = Int(readLine(strippingNewline: true)!)!
    path = [[Int]](repeating: [Int](), count: n)

    var connects = [[Int]]()
    for i in 0..<n - 1 {
        var str = readLine(strippingNewline: true)!
        var pair = str.components(separatedBy: " ")
        var a = Int(pair[0])! - 1
        var b = Int(pair[1])! - 1
        connects.append([a, b])
    }

    makeTree(connects)

    var m = Int(readLine(strippingNewline: true)!)!
    pairs = [[Int]]()
    for i in n + 1...n + m {
        var str = readLine(strippingNewline: true)!
        var pair = str.components(separatedBy: " ")
        var a = Int(pair[0])! - 1
        var b = Int(pair[1])! - 1
        pairs.append([ a, b ])
    }
}

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

//initialize(input)

//print(path)
//print(pairs)
//search(5, 10)

read()

for pair in pairs {
    search(pair[0], pair[1])
    print(result + 1)
}
