Swift-DataStructures
========

Implementing a small library of generic data structures in Swift.

##[Priority Queue] (https://github.com/ikaver/Swift-DataStructures/blob/master/Swift-DataStructures/MinPQ.swift)

A simple generic priority queue implementation with a binary heap.
Prioritizes its elements according to a given compare function.

Using the > operator, bigger elements will have the highest priority
```Swift
var pq = MinPQ<Int>(>)
pq.extend([1, 8, 2, 9, 11, 100, 3, 17, 21, 30])
let highestPriority = pq.removeMin() //returns 100
```

Using the < operator, smaller elements will have the highest priority
```Swift
var pq = MinPQ<Int>(<)
pq.extend(1...100)
let highestPriority = pq.removeMin() //returns 1
```

You can also pass in your own custom compare function
```Swift
var pq = MinPQ<String>(array: ["Hello", "Hola", "Hi", "Chao", "Bye", "Goodbye"]) {
  s1, s2 in countElements(s1) < countElements(s2)
}
let highestPriority = pq.removeMin() //returns "Hi"
```
