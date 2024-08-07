//
//  CircleManagerImpl+Helpers.swift
//  Life360Sample
//
//  Created by Andriy Kupich on 26.10.2021.
//

extension CircleManagerImpl: CircleManagerHelpers {
    func printAllCircles() {
        print ("All \(circles.count) Circles:\n \(circles)")
    }
    
    static func countDuplicates(for circles: [Circle]) -> Int {
        let unique = Set(circles)
        return circles.count - unique.count
    }
    
    static func removeDuplicates(for circles: [Circle]) -> [Circle] {
        var unique = Set<Circle>()
        unique.reserveCapacity(circles.count)
        
        for circle in circles {
            let result = unique.insert(circle)
            
            if !result.inserted {
                let existedCircle = result.memberAfterInsert
                if circle.members.count > existedCircle.members.count {
                    unique.remove(existedCircle)
                    unique.insert(circle)
                }
            }
        }
        return Array(unique)
    }
}
