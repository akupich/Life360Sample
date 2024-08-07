//
//  CircleManagerImpl.swift
//  Life360Sample
//
//  Created by Andriy Kupich on 26.10.2021.
//

import Foundation

class CircleManagerImpl: CircleManager {
    typealias CircleType = [Int : Circle]
    
    private let concurrentQueue = DispatchQueue(label: "CircleManagerQueue", attributes: .concurrent)
    private var _circles: CircleType = [:]
    
    private(set) var circles: [Int : Circle] {
        get {
            concurrentQueue.sync { self._circles }
        }
        set {
            concurrentQueue.async(flags: .barrier) {
                self._circles = newValue
            }
        }
    }
    
    func createCircle(circleId: Int, with member: Member) {
        let newCircle = Circle(circleId: circleId, members: [member])
        circles[circleId] = newCircle
    }
    
    func deleteCircle(circleId: Int) {
        circles[circleId] = nil
    }
    
    func addMember(member: Member, circleId: Int) {
        if var circle = circles[circleId] {
            circle.addMember(member: member)
            circles[circleId] = circle
        } else {
            createCircle(circleId: circleId, with: member)
        }
    }
    
    func removeMember(member: Member, circleId: Int) {
        guard var circle = circles[circleId] else {
            return
        }
        
        circle.removeMember(memberId: member.uniqueID)
        if circle.members.isEmpty {
            circles[circle.uniqueID] = nil
        } else {
            circles[circle.uniqueID] = circle
        }
        
    }
    
    func query(memberCount: Int) -> Int {
        return circles.values.filter { $0.members.count == memberCount }.count
    }
}
