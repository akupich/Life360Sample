//
//  CircleManager.swift
//  Life360Sample
//
//  Created by Andriy Kupich on 26.10.2021.
//

import Foundation
import MapKit

struct Member {
    /// Unique identifier
    let uniqueID: Int
    /// Name of the member
    let name: String
    /// Coordinates of the last known location
    let coordinates: CLLocationCoordinate2D
    
    var location: CLLocation {
        CLLocation(latitude: coordinates.latitude,
                   longitude: coordinates.longitude)
    }
}

// MARK: - Hashable
extension Member: Hashable {
    public static func == (lhs: Member, rhs: Member) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueID)
    }
}

// MARK: - CustomStringConvertible
extension Member: CustomStringConvertible {
    var description: String {
        return "\n   Member (\(uniqueID): \(name), \(coordinates)"
    }
}
