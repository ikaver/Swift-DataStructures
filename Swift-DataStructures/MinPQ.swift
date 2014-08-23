//
//  MinPQ.swift
//  DataStructures
//
//  A simple generic priority queue implementation with a binary heap.
//  Prioritizes its elements according to a given compare function. For example,
//
//  Using the > operator, bigger elements will have the highest priority
//  var pq = MinPQ<Int>(>)
//  pq.extend([1, 2, 100, 3])
//  let highestPriority = pq.removeMin() //returns 100
//  Using the < operator, smaller elements will have the highest priority
//  var pq = MinPQ<Int>(<)
//  pq.extend(1...100)
//  let highestPriority = pq.removeMin() //returns 1
//  var pq = MinPQ<String>(array: ["Hi", "Hello", "Goodbye"]) {
//      s1, s2 in countElements(s1) < countElements(s2)
//  }
//  let highestPriority = pq.removeMin() //returns "Hi"
//  Copyright (c) 2014 Iosef Kaver. All rights reserved.
//

import Foundation

struct MinPQ<T>{
    private var heap: [T] = []
    private var size: Int = 0
    private let compareFunc: (T, T) -> Bool
    private let minimumCapacity = 50
    
    /* Creates a heap that compares its elements with the given compareFunc. */
    init(compareFunc: (T, T) -> Bool) {
        self.compareFunc = compareFunc
        self.heap.reserveCapacity(self.minimumCapacity)
    }
    
    /* Indicates true iff the heap has no elements */
    func empty() -> Bool {
        return self.size == 0
    }
    
    /* Returns the amount of elements currently in the heap */
    func count() -> Int {
        return self.size
    }
    
    /* Returns the element with highest priority in the heap. 
       The user is responsible of checking that there is at least one element in
       the heap before calling this function
    */
    func min() -> T {
        return self.heap[0]
    }
    
    /* Inserts the given element in the heap */
    mutating func insert(elem: T){
        self.heap.append(elem)
        self.swim(self.size++)
    }
    
    /* Removes the node with highest priority from the heap.  
       The user is responsible of checking that there is at least one element in
       the heap before calling this function
    */
    mutating func removeMin() -> T {
        let first = self.heap[0]
        self.heap[0] = self.heap[self.size-1]
        self.heap.removeLast()
        --self.size
        self.sink(0)
        return first
    }

    /* PRIVATE API (functions to mantain heap invariant) */
    
    /* The node with the given index "sinks" (i.e moves closer to the leafs of
       the heap) until it is on correct heap order */
    mutating private func sink(index: Int) {
        var currentIndex = index
        var child = minChild(currentIndex)
        while(child != -1 && self.greater(child, currentIndex)){
            swap(&self.heap[currentIndex], &self.heap[child])
            currentIndex = child
            child = minChild(currentIndex)
        }
    }
    
    /* The node with the given index "swims" (i.e moves closer to the root of the
       heap) until it is on correct heap order */
    mutating private func swim(index: Int) {
        var currentIndex = index
        var parentIndex = self.parent(currentIndex)
        while(currentIndex > 0 && self.greater(currentIndex, parentIndex)) {
            swap(&self.heap[currentIndex], &self.heap[parentIndex])
            currentIndex = parentIndex
            parentIndex = self.parent(currentIndex)
        }
    }
    
    /* Returns the index of the node with the given index */
    private func parent(index: Int) -> Int {
        return (index-1) / 2
    }
    
    /* Returns the index of the smallest child of (parentIndex) in the heap */
    private func minChild(parentIndex: Int) -> Int {
        let leftChildIndex  = parentIndex * 2 + 1
        let rightChildIndex = leftChildIndex + 1
        if(leftChildIndex >= self.size){
            return -1
        }
        if(rightChildIndex >= self.size){
            return leftChildIndex
        }
        
        if(self.greater(leftChildIndex, rightChildIndex)){
            return leftChildIndex
        }
        else{
            return rightChildIndex
        }
    }
    
    /* Evaluates compareFunc on heap[a] and heap[b] */
    private func greater(a: Int, _ b:Int) -> Bool{
        return self.compareFunc(self.heap[a], self.heap[b])
    }
}

extension MinPQ {
    
    /* Creates a priority queue with the contents of the given array and the 
    given compare function */
    init(array: [T], compareFunc: (T, T) -> Bool) {
        self.compareFunc = compareFunc
        self.size = array.count
        /* copy and heapify array */
        self.heap.extend(array)
        for var i = size/2; i >= 0; --i {
            self.sink(i)
        }
    }
    
    /* Creates a copy of the given priority queue */
    init(otherPQ: MinPQ<T>) {
        self.compareFunc = otherPQ.compareFunc
        self.size = otherPQ.size
        /* Other heap should be already in heap order, no need to heapify */
        self.heap.extend(otherPQ.heap)
    }
}

extension MinPQ : SequenceType {
    /* Clients should NOT expect elements to be ordered with this implementation */
    func generate() -> GeneratorOf<T> {
        var generator = self.heap.generate()
        return GeneratorOf {
            return generator.next()
        }
    }
}

extension MinPQ {
    /* Creates a sorted array from the MinPQ. Takes O(N) space and O(N * log(N))
       time complexity */
    func toSortedArray() -> [T] {
        var pqCopy = MinPQ<T>(otherPQ: self)
        var array: [T] = []
        array.reserveCapacity(pqCopy.count())
        while(!pqCopy.empty()) {
            array.append(pqCopy.removeMin())
        }
        return array
    }
}

extension MinPQ {
    /* Inserts all the elements in the sequence in the priority queue */
    mutating func extend<S : SequenceType where S.Generator.Element == T>(sequence: S) {
        for elem in [T](sequence) {
            self.insert(elem)
        }
    }
}

extension MinPQ : Printable {
    var description : String {
        return self.heap.description
    }
}