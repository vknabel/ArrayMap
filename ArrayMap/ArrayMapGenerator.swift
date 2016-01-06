//
//  ArrayMapGenerator.swift
//  ArrayMap
//
//  Created by Valentin Knabel on 05.01.16.
//  Copyright © 2016 Conclurer GmbH. All rights reserved.
//

public struct ArrayMapGenerator<Key: Hashable, Value>: GeneratorType {

    public typealias Element = (Key, Value)

    private var primaryGenerator: DictionaryGenerator<Key, [Value]>
    private var secondaryGenerator: Array<Value>.Generator? = nil
    private var currentKey: Key? = nil

    public init(arrayMap: ArrayMap<Key, Value>) {
        primaryGenerator = arrayMap.rawValue.generate()
    }

    @warn_unused_result
    public mutating func next() -> Element? {
        if let currentKey = currentKey,
            let nextResult = secondaryGenerator?.next()
        {
            return (currentKey, nextResult)
        } else if let newValue = primaryGenerator.next() {
            currentKey = newValue.0
            secondaryGenerator = newValue.1.generate()
            return next()
        } else {
            return nil
        }
    }
}
