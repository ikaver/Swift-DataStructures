//
//  MinPQTest.swift
//  DataStructures
//
//  Created by Iosef Kaver on 8/20/14.
//  Copyright (c) 2014 Iosef Kaver. All rights reserved.
//

import XCTest

class MinPQTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func assertOrderedMinPQ(var pq: MinPQ<Int>) -> Bool {

        return true
    }

    func testInsertRandomAndRemoveAll() {
        let size = 10000
        var pq = MinPQ<Int>(<)
        for i in 0..<size {
            pq.insert(Int(arc4random()))
            XCTAssert(pq.count() == i+1, "Count doesn't match amount of elements")
        }
        var current = 0
        var prev = Int.min
        while(!pq.empty()) {
            current = pq.removeMin()
            XCTAssert(prev <= current, "Unordered priority queue")
        }
    }
    
    func testCreateMinPQFromArray() {
        let size = 10000
        var arr = [Int]()
        for i in 0..<size {
            arr.append(Int(arc4random()))
        }
        var pq = MinPQ<Int>(array: arr, <)
        XCTAssert(pq.count() == size, "Count doesn't match amount of elements")
        var prev = Int.min
        while(!pq.empty()) {
            let current = pq.removeMin()
            XCTAssert(prev <= current, "Unordered priority queue")
            prev = current
        }
    }
    
    func testExtend() {
        let size = 10000
        var pq = MinPQ<Int>(<)
        pq.extend(0..<size/2)
        var arr: [Int] = []
        arr.extend(size/2..<size)
        pq.extend(arr)
        for i in 0..<size {
            XCTAssert(i == pq.removeMin(), "Mismatch in extend")
        }
        XCTAssert(pq.empty(), "Priority queue should be empty")
    }
    
    func testToSortedArray() {
        var pq = MinPQ<String>(array: ["Hi", "Hello", "Shalom"]) {
            s1, s2 in countElements(s1) < countElements(s2)
        };
        XCTAssertEqual(pq.toSortedArray(), ["Hi", "Hello", "Shalom"],
            "Arrays don't match")
        XCTAssert(pq.count() == 3, "PQ should remain untouched")
        XCTAssertEqual(pq.toSortedArray(), ["Hi", "Hello", "Shalom"],
            "PQ should remain untouched")
    }
    
    func testSmallPQ() {
        var pq = MinPQ<Int>(<)
        XCTAssert(pq.empty(), "PQ should be empty")
        XCTAssert(pq.count() == 0, "PQ should have 0 elements")
        pq.insert(1)
        XCTAssert(!pq.empty(), "PQ should have one element")
        XCTAssert(pq.count() == 1, "PQ should have one element")
        XCTAssert(pq.min() == 1, "PQ should have 1 as its min element")
        pq.extend(2...10)
        XCTAssert(pq.count() == 10, "PQ should have 10 elements")
        for i in 1...9 {
            XCTAssert(pq.min() == i && pq.removeMin() == i, "Remove min mismatch")
        }
        XCTAssert(pq.count() == 1, "PQ should have one element")
        XCTAssert(!pq.empty(), "PQ shouldn't be empty")
        XCTAssert(pq.min() == 10 && pq.removeMin() == 10, "PQ min should be 10")
        XCTAssert(pq.empty(), "PQ should be empty")
    }

    func testInsertAndRemoveSeveralTimes() {
        let size = 501
        var array = Array<Int>(1..<size)
        var pq = MinPQ<Int>(<)
        for i in 0...5 {
            pq.extend(array)
            for j in 1..<size {
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
            }
        }
        for i in 0...5 {
            pq.extend(array)
            for j in 1..<size/2 {
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
            }
            for j in 1..<size/2 {
                pq.insert(j)
                pq.insert(j)
                pq.insert(j)
                pq.insert(j)
            }
            for j in 1..<size/2 {
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
            }
            for j in size/2..<size {
                XCTAssert(pq.removeMin() == j, "Mismatch in remove min")
            }
        }
    }
}
