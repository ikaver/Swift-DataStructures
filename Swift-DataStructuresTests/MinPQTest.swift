//
//  MinPQTest.swift
//  DataStructures
//
//  Created by Iosef Kaver on 8/20/14.
//  Copyright (c) 2014 Iosef Kaver. All rights reserved.
//

//import Cocoa
import XCTest

class MinPQTest: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func assertOrderedMinPQ(var pq: MinPQ<Int>) -> Bool {
        var prev = Int.min
        while(!pq.empty()) {
            let current = pq.removeMin()
            if(prev > current) {
                return false
            }
            prev = current
        }
        return true
    }

    func testInsertRandomAndRemoveAll() {
        let size = 10000
        var pq = MinPQ<Int>(<)
        for i in 0..<size {
            pq.insert(Int(arc4random()))
            XCTAssert(pq.count() == i+1, "Count doesn't match amount of elements")
        }
        XCTAssert(assertOrderedMinPQ(pq), "Unordered minpq")
    }
    
    func testCreateMinPQFromArray() {
        let size = 10000
        var arr = [Int]()
        for i in 0..<size {
            arr.append(Int(arc4random()))
        }
        var pq = MinPQ<Int>(array: arr, <)
        XCTAssert(pq.count() == size, "Count doesn't match amount of elements")
        XCTAssert(assertOrderedMinPQ(pq), "Unordered minpq")
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
    
    func testDescription() {
        let pq = MinPQ<Int>(array: [1,2,3], compareFunc: <)
        XCTAssert(pq.description == "[1, 2, 3]"
            || pq.description == "[1, 3, 2]", "Description is incorrect \(pq)")
    }

}
