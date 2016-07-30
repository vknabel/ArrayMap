//
//  ArrayMap.swift
//  ArrayMap
//
//  Created by Valentin Knabel on 05.01.16.
//  Copyright © 2016 Conclurer GmbH. All rights reserved.
//


private func countArrayMapRawValue<Key: Hashable, Value>(rawValue: [Key: [Value]]) -> Int {
    return rawValue.reduce(0) { $0 + $1.1.count }
}
public struct ArrayMap<Key: Hashable, Value>: Sequence {
    internal var rawValue: [Key: [Value]]
    public private(set) var count: Int

    public init() {
        rawValue = [:]
        count = 0
    }
    public init(dict: [Key: [Value]]) {
        rawValue = dict
        count = countArrayMapRawValue(rawValue: dict)
    }

    public typealias Iterator = ArrayMapIterator<Key, Value>
    public typealias SubSequence = Array<Iterator.Element>.SubSequence
    
    /// - Complexity: O(1).
<<<<<<< HEAD
    
    public func generate() -> Generator {
        return Generator(arrayMap: self)
=======
    public func makeIterator() -> Iterator {
        return Iterator(arrayMap: self)
>>>>>>> 0.1.1
    }
    
    /// - Complexity: O(N).
<<<<<<< HEAD
    
=======
>>>>>>> 0.1.1
    public func underestimateCount() -> Int {
        return countArrayMapRawValue(rawValue: rawValue)
    }
    
    /// - Complexity: O(N).
<<<<<<< HEAD
    
    public func map<T>(@noescape transform: (Generator.Element) throws -> T) rethrows -> [T] {
=======
    public func map<T>(@noescape transform: (Iterator.Element) throws -> T) rethrows -> [T] {
>>>>>>> 0.1.1
        var maps = [T]()
        for e in self {
            maps.append(try transform(e))
        }
        return maps
    }
    
    /// - Complexity: O(N)
<<<<<<< HEAD
    
    public func filter(@noescape includeElement: (Generator.Element) throws -> Bool) rethrows -> [Generator.Element] {
        var maps: [Generator.Element] = []
=======
    public func filter(@noescape includeElement: (Iterator.Element) throws -> Bool) rethrows -> [Iterator.Element] {
        var maps: [Iterator.Element] = []
>>>>>>> 0.1.1
        for e in self {
            if try includeElement(e) {
                maps.append(e)
            }
        }
        return maps
    }
    
    /// - Complexity: O(N)
    public func forEach(@noescape body: (Iterator.Element) throws -> ()) rethrows {
        for e in self {
            try body(e)
        }
    }
    
    /// - Requires: `n >= 0`
    /// - Complexity: O(N)
<<<<<<< HEAD
    
    public func dropFirst(n: Int = 1) -> SubSequence {
        return Array(self).dropFirst(n)
=======
    public func dropFirst(_ n: Int = 1) -> SubSequence {
        return Array<Iterator.Element>(self).dropFirst(n)
>>>>>>> 0.1.1
    }
    
    /// - Requires: `n >= 0`
    /// - Complexity: O(`self.count`)
<<<<<<< HEAD
    
    public func dropLast(n: Int = 1) -> SubSequence {
        return Array(self).dropLast(n)
=======
    public func dropLast(_ n: Int = 1) -> SubSequence {
        return Array<Iterator.Element>(self).dropLast(n)
>>>>>>> 0.1.1
    }
    
    /// - Requires: `maxLength >= 0`
<<<<<<< HEAD
    
    public func prefix(maxLength: Int) -> SubSequence {
        return Array(self).prefix(maxLength)
=======
    public func prefix(_ maxLength: Int) -> SubSequence {
        return Array<Iterator.Element>(self).prefix(maxLength)
>>>>>>> 0.1.1
    }
    
    /// - Requires: `maxLength >= 0`
<<<<<<< HEAD
    
    public func suffix(maxLength: Int) -> SubSequence {
        return Array(self).suffix(maxLength)
=======
    public func suffix(_ maxLength: Int) -> SubSequence {
        return Array<Iterator.Element>(self).suffix(maxLength)
>>>>>>> 0.1.1
    }
    
    /// - Requires: `maxSplit >= 0`
<<<<<<< HEAD
    public func split(maxSplit: Int, allowEmptySlices: Bool, @noescape isSeparator: (Generator.Element) throws -> Bool) rethrows -> [SubSequence] {
        return try Array(self).split(maxSplit, allowEmptySlices: allowEmptySlices, isSeparator: isSeparator)
=======
    public func split(maxSplits: Int, omittingEmptySubsequences: Bool, @noescape isSeparator: (Iterator.Element) throws -> Bool) rethrows -> [SubSequence] {
        return try Array<Iterator.Element>(self).split(maxSplits: maxSplits, omittingEmptySubsequences: omittingEmptySubsequences, isSeparator: isSeparator)
>>>>>>> 0.1.1
    }
}
