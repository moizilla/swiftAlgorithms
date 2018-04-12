//
//  ViewController.swift
//  Iterators
//
//  Created by Olmedo Pina, Moises on 3/28/18.
//  Copyright © 2018 Olmedo, Moises. All rights reserved.
//

import UIKit

class ListNode {
    var value: Any
    var next: ListNode?
    
    init(value: Any) {
        self.value = value
    }
}

class LinkedList: Sequence {
    var head: ListNode
    
    init(head: ListNode) {
        self.head = head
    }
    
    typealias Iterator = LinkedListIterator
    
    func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(storage: self)
    }
}

class LinkedListIterator: IteratorProtocol {
    typealias Element = Any
    var storage: LinkedList
    var currentNode: ListNode?
    
    init(storage: LinkedList) {
        self.storage = storage
        self.currentNode = storage.head
    }
    
    func next() -> Any? {
        let value = self.currentNode?.value
        self.currentNode = self.currentNode?.next
        return value
    }
}

class LinkedListSequence: Sequence {
    typealias Iterator = LinkedListIterator
    var linkedList: LinkedList

    init(storage: LinkedList) {
        self.linkedList = storage
    }

    func makeIterator() -> LinkedListIterator {
        return LinkedListIterator(storage: linkedList)
    }
}




//indirect enum BinaryTree<T>: Sequence {
//    case node(BinaryTree<T>, T, BinaryTree<T>)
//    case empty
//
//
//    typealias Element = BinaryTree
//
//    func makeIterator() -> BinaryTree<T>.Iterator {
//        return
//    }
//}

class TreeNode<T> {
    var value: T
    var leftNode: TreeNode?
    var rightNode: TreeNode?
    
    init(value: T) {
        self.value = value
    }
}

class BinaryTree<T>: Sequence {
    var root: TreeNode<T>?
    
    init(root: TreeNode<T>?) {
        self.root = root
    }
    
    func makeIterator() -> BinaryTreePreOrderEnumerator<T> {
        return BinaryTreePreOrderEnumerator(root: root!)
    }
}

class BinaryTreeInOrderEnumerator<T>: IteratorProtocol {
    
    typealias Element = TreeNode<T>
    
    var stack = MyStack<Element>()
    
    var current: Element?
    
    init(root: TreeNode<T>) {
        self.current = root
    }
    
    func next() -> Element? {
        var done = false
        while !done {

            if let node = current {

                stack.push(element: node)
                current = current?.leftNode

            } else {
                if stack.isEmpty() {
                    done = true
                } else {
                    if let node = stack.pop() {
                        current = node.rightNode
                        return node
                    }
                }
            }
        }
        
        return nil
    }
    
}

class BinaryTreePreOrderEnumerator<T>: IteratorProtocol {
    
    typealias Element = TreeNode<T>
    
    var stack = MyStack<Element>()
    
    var current: Element?
    
    init(root: TreeNode<T>) {
        self.current = root
        stack.push(element: root)

    }
    
    func next() -> Element? {
        while !stack.isEmpty() {
            let node = stack.pop()
            
            if let right = node?.rightNode {
                stack.push(element: right)
            }
            if let left = node?.leftNode {
                stack.push(element: left)
            }
            return node
        }
        
        return nil
    }
    
}

class MyStack<T> {
    var storage = [T]()
    
    func pop() -> T? {
        return storage.popLast()
    }
    
    func push(element: T) {
        storage.append(element)
    }
    
    func isEmpty() -> Bool {
        return storage.isEmpty
    }
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sequence = BetterCountToThree()
        
        for number in sequence {
            //print(number)
        }
        
        let node1 = ListNode(value: "hello")
        let node2 = ListNode(value: 3.14)
        let node3 = ListNode(value: 42)
        
        node1.next = node2
        node2.next = node3
        
        let list = LinkedList(head: node1)
        
        for element in list {
            //print(element)
        }
        
        let mm = [1,3,4,3,2,3,4,3,4,5,6,6,4,7,56]
        for element in mm.randomSubsequence() {
            //print(element)
        }
        //myBinaryTree()
        print(longestSubstringLengthWith2UniqueChars(input: "abcabcabc"))
        //ispiprint(findShortestPatternContainedInString(input: "this is a test string", pattern: "tist"))
        //print(isPermutation(t: "abbba", m: "bbbaa"))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
//    func findShortestPatternContainedInString(input: String, pattern: String) -> String {
//        var longestSubstring = ""
//        var uniquesPattern = [Character: Int]()
//        var uniquesInput = [Character: Int]()
//        for char in pattern {
//            if let times = uniquesPattern[char] {
//                uniquesPattern[char] = times + 1
//            } else {
//                uniquesPattern[char] = 1
//            }
//        }
//        var window = 0
//
//        var i = 0
//        for char in input {
//            // check if all pattern chars have been found
//            if let foundTimesInInput = uniquesInput[char] {
//                if foundTimes
//            }
//            // if true, you have a new window
//            // if you found a unique p char in input again, reduce charAtStart and window will be next unique char
//        }
//        return longestSubstring
//    }
    
    func longestSubstringLengthWith2UniqueChars(input: String) -> Int {
        var max = 0
        var start = 0
        var occurrences = [Character: Int]()
        
        var c = 0
        for char in input {
            if let existingCharRepeatedTimes = occurrences[char] {
                occurrences[char] = existingCharRepeatedTimes + 1
            } else {
                occurrences[char] = 1
            }
            //aabcabmaabazbababc verga de monoooo
            if occurrences.count > 2 {
                let tempMax = c - start
                print("tempmax-\(String(describing: tempMax))")
                print("start-\(String(describing: start))")
                if tempMax > max {
                    max = tempMax
                }
                // this can be translated to: if there are 3 unique chars, "remove" all occurrences of the "1st" unique you found, then your new window will start from the 2nd character to the 3rd unique.. and so on.
                while(occurrences.count > 2) {
                    let charAtStart = charAt(i: start, string: input)
                    if let charAtStartTimes = occurrences[charAtStart] {
                        if charAtStartTimes > 1 {
                            occurrences[charAtStart] = charAtStartTimes - 1
                        } else {
                            occurrences.removeValue(forKey: charAtStart)
                        }
                    }
                    start = start + 1
                }
            }
            c = c+1
        }
        if input.count - start > max {
            max = input.count - start
        }
        print("start-\(String(describing: start))")
        return max
    }
    
    func charAt(i: Int, string: String) -> Character {
        var c = 0
        for shit in string {
            if c == i {
                return shit
            }
            c = c+1
        }
        return Character("")
    }
    
    func myBinaryTree() {
        //
        
        let ten = TreeNode(value: 10)
        
        let fortyNine = TreeNode(value: 49)
        
        let ninetyNine = TreeNode(value: 99)
        
        let seventyFive = TreeNode(value: 75)
        seventyFive.rightNode = ninetyNine
        
        let twentyFive = TreeNode(value: 25)
        twentyFive.leftNode = ten
        twentyFive.rightNode = fortyNine
        
        let fifety = TreeNode(value: 50)
        fifety.leftNode = twentyFive
        fifety.rightNode = seventyFive
        
        let binaryTree = BinaryTree(root: fifety)
        
//        for node in binaryTree {
//            print(node.value)
//        }
        //inOrderTraversal(for: binaryTree)
        printIntersections(arr1: [1,2,4,5,6], arr2: [6,7])
    }
    
    func inOrderTraversal<T>(for tree: BinaryTree<T>) {
        
        guard let _ = tree.root else {
            return
        }
        inOrderTraversal(for: BinaryTree(root: tree.root?.leftNode))
        
        print(tree.root?.value)
        
        inOrderTraversal(for: BinaryTree(root: tree.root?.rightNode))
    }
    // [1,2,4,5,6]
    // [2,3,5,7]
    func printIntersections(arr1: [Int], arr2: [Int]) {
        var i = 0 // 1 2 3 4 5
        var j = 0 // 1 2 3
        while i < arr1.count && j < arr2.count {
            if arr1[i] < arr2[j] {
                i = i+1
            } else if arr2[j] < arr1[i] {
                j = j+1
            } else {
                print(arr1[i])
                j = j+1
                i = i+1
            }
        }
    }
}



extension Sequence {
    func randomSubsequence(chance: UInt32 = 50) -> [Iterator.Element] {
        var subsequence: [Self.Iterator.Element] = []
        var iterator = makeIterator()
        while let element = iterator.next() {
            if arc4random_uniform(100) > chance {
                subsequence.append(element)
            }
        }
        return subsequence
    }
}

struct BetterCountToThree: Sequence {
    private let start = 1
    private let end = 3
    
    typealias Iterator = BetterCountToThreeIterator
    
    func makeIterator() -> BetterCountToThree.Iterator {
        return BetterCountToThreeIterator(start: start, end: end)
    }
}

struct BetterCountToThreeIterator: IteratorProtocol {
    private var start: Int
    private var end: Int
    private let increment: Int = 1
    private var currentElement: Int
    
    typealias Element = Int
    
    init(start: Int, end: Int) {
        self.start = start
        self.end = end
        self.currentElement = start - increment
    }
    
    mutating func next() -> Int? {
        if currentElement < end {
            currentElement = currentElement + increment
            return currentElement
        }
        return nil
    }
}
//retencioneslte@etb.com.co
func isPermutation(t: String, m: String) -> Bool{
    
    if t.count != m.count {
        return false
    }
    
    var letters = [Character: Int]()
    for char in t {
        if let oc = letters[char] {
            letters[char] = oc + 1
        } else {
            letters[char] = 1
        }
    }
    
    for char in m {
        if let oc = letters[char] {
            letters[char] = oc - 1
        } else {
            letters[char] = -1
            return false
        }
    }
    
    return true
}


