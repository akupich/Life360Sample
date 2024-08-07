//
//  CircleManagerHelpers.swift
//  Life360Sample
//
//  Created by Andriy Kupich on 26.10.2021.
//

import Foundation

/// List of additional methods that extend functionality of CircleManager.
protocol CircleManagerHelpers {
    /// Print a list of Circles with their Members
    func printAllCircles()
    
    /// A utility function that takes a list of Circle objects and returns a count of how many Circles are duplicated in the list
    static func countDuplicates(for circles: [Circle]) -> Int
    
    /// Given a list of Circles remove all duplicates and return a list with with unique circles.
    /// If multiple Circles exist with the same id, keep the one with the most members
    static func removeDuplicates(for circles: [Circle]) -> [Circle]
}
