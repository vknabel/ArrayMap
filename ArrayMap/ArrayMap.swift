//
//  ArrayMap.swift
//  ArrayMap
//
//  Created by Valentin Knabel on 05.01.16.
//  Copyright © 2016 Conclurer GmbH. All rights reserved.
//

@warn_unused_result
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

    public typealias Generator = ArrayMapGenerator<Key, Value>
    public typealias SubSequence = Array<Generator.Element>.SubSequence
    /// - Complexity: O(1).
    @warn_unused_result
    public func generate() -> Generator {
        return Generator(arrayMap: self)
    }
    /// - Complexity: O(N).
    @warn_unused_result
    public func underestimateCount() -> Int {
        return countArrayMapRawValue(rawValue)
    }
    /// - Complexity: O(N).
    @warn_unused_result
    public func map<T>(@noescape transform: (Generator.Element) throws -> T) rethrows -> [T] {
        var maps = [T]()
        for e in self {
            maps.append(try transform(e))
        }
        return maps
    }
    /// - Complexity: O(N)
    @warn_unused_result
    public func filter(@noescape includeElement: (Generator.Element) throws -> Bool) rethrows -> [Generator.Element] {
        var maps: [Generator.Element] = []
        for e in self {
            if try includeElement(e) {
                maps.append(e)
            }
        }
        return maps
    }
    /// - Complexity: O(N)
    public func forEach(@noescape body: (Generator.Element) throws -> ()) rethrows {
        for e in self {
            try body(e)
        }
    }
    /// - Requires: `n >= 0`
    /// - Complexity: O(N)
    @warn_unused_result
    public func dropFirst(n: Int = 1) -> SubSequence {
        return Array(self).dropFirst(n)
    }
    /// - Requires: `n >= 0`
    /// - Complexity: O(`self.count`)
    @warn_unused_result
    public func dropLast(n: Int = 1) -> SubSequence {
        return Array(self).dropLast(n)
    }
    /// - Requires: `maxLength >= 0`
    @warn_unused_result
    public func prefix(maxLength: Int) -> SubSequence {
        return Array(self).prefix(maxLength)
    }
    /// - Requires: `maxLength >= 0`
    @warn_unused_result
    public func suffix(maxLength: Int) -> SubSequence {
        return Array(self).suffix(maxLength)
    }
    /// - Requires: `maxSplit >= 0`
    @warn_unused_result
    public func split(maxSplit: Int, allowEmptySlices: Bool, @noescape isSeparator: (Generator.Element) throws -> Bool) rethrows -> [SubSequence] {
        return try Array(self).split(maxSplit, allowEmptySlices: allowEmptySlices, isSeparator: isSeparator)
    }
    
}
