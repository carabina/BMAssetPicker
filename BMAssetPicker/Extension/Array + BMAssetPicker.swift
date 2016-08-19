//
//  Array + BMAssetPicker.swift
//  Pods
//
//  Created by BrikerMan on 16/8/19.
//
//

import Foundation


extension Array where Element: Equatable {
    public func bm_indexesOf(object: Element) -> [Int] {
        var indexes = [Int]()
        for index in 0..<self.count {
            if self[index] == object {
                indexes.append(index)
            }
        }
        return indexes
    }
    
    public func bm_lastIndexOf(object: Element) -> Int? {
        return bm_indexesOf(object).last
    }
    
    public mutating func bm_removeObject(object: Element) {
        if let index = self.indexOf(object) {
            self.removeAtIndex(index)
        }
    }
}