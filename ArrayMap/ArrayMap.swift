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
public struct ArrayMap<Key: Hashable, Value>: SequenceType {
    internal var rawValue: [Key: [Value]]
    public private(set) var count: Int

    public init() {
        rawValue = [:]
        count = 0
    }
    public init(dict: [Key: [Value]]) {
        rawValue = dict
        count = countArrayMapRawValue(dict)
    }

    public typealias Generator = ArrayMapIterator<Key, Value>
    public typealias Iterator = Generator
    public typealias SubSequence = Array<Iterator.Element>.SubSequence

    public func generate() -> Generator {
        return makeIterator()
    }

    /// - Complexity: O(1).
    public func makeIterator() -> Iterator {
        return Iterator(arrayMap: self)
    }
    
    /// - Complexity: O(N).
    public func underestimateCount() -> Int {
        return countArrayMapRawValue(rawValue)
    }
    
    /// - Complexity: O(N).
    public func map<T>(@noescape transform: (Iterator.Element) throws -> T) rethrows -> [T] {
        var maps = [T]()
        for e in self {
            maps.append(try transform(e))
        }
        return maps
    }
    
    /// - Complexity: O(N)
    public func filter(@noescape includeElement: (Iterator.Element) throws -> Bool) rethrows -> [Iterator.Element] {
        var maps: [Iterator.Element] = []
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
    public func dropFirst(n: Int = 1) -> SubSequence {
        return Array<Iterator.Element>(self).dropFirst(n)
    }
    
    /// - Requires: `n >= 0`
    /// - Complexity: O(`self.count`)
    public func dropLast(n: Int = 1) -> SubSequence {
        return Array<Iterator.Element>(self).dropLast(n)
    }
    
    /// - Requires: `maxLength >= 0`
    public func prefix(maxLength: Int) -> SubSequence {
        return Array<Iterator.Element>(self).prefix(maxLength)
    }
    
    /// - Requires: `maxLength >= 0`
    public func suffix(maxLength: Int) -> SubSequence {
        return Array<Iterator.Element>(self).suffix(maxLength)
    }

    /// - Requires: `maxSplit >= 0`
    public func split(maxSplit: Int, allowEmptySlices: Bool, @noescape isSeparator: (Generator.Element) throws -> Bool) rethrows -> [SubSequence] {
        return try Array<Iterator.Element>(self).split(maxSplit, allowEmptySlices: allowEmptySlices, isSeparator: isSeparator)
    }
}
