//
//  CircleManager.swift
//  Life360Sample
//
//  Created by Andriy Kupich on 26.10.2021.
//

import Foundation
import MapKit

struct Circle {
    /// Unique identifier
    let uniqueID: Int
    /// Name of the circle
    let name: String
    /// Set of members that belongs to circle
    var members: [Int: Member]
    
    /// Add new member to circle
    mutating func addMember(member: Member) {
        members[member.uniqueID] = member
    }
    
    /// Remove member from circle by id
    mutating func removeMember(memberId: Int) {
        members.removeValue(forKey: memberId)
    }
    
    /// Get member from circle by id
    /// Returning nil if it does not contain a Member with that ID
    func getMember(by id: Int) -> Member? {
        return members[id]
    }
    
    /// Query all Members with in a given distance of a given location (by longitude and latitude)
    func query(for distance: CLLocationDistance, in coordinates: CLLocationCoordinate2D) -> [Member] {
        return members.values
            .filter {
                let location = CLLocation(latitude: coordinates.latitude,
                                                  longitude: coordinates.longitude)
                
                return $0.location.distance(from: location) < distance
            }
    }
}

/// Circle convenience initializers
extension Circle {
    init(circleId: Int, members: [Member] = []) {
        let dict = Dictionary(uniqueKeysWithValues: members.map{ ($0.uniqueID, $0) })
        self.init(uniqueID: circleId, name: "\(circleId)", members: dict)
    }
}


// MARK: - Hashable
extension Circle: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueID)
    }
    
    public static func == (lhs: Circle, rhs: Circle) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
}

// MARK: - CustomStringConvertible
extension Circle: CustomStringConvertible {
    var description: String {
        return "\n* Circle (\(uniqueID): \(name), members: \(members)"
    }
}
