//
//  CircleManager.swift
//  Life360Sample
//
//  Created by Andriy Kupich on 26.10.2021.
//

import Foundation

/// A Circle manager that can add and remove members based on a circle ID.
/// Also able to query the number of circles with a given number of members */
protocol CircleManager {
    /// Creates a new circle with 1 member and the provided ID
    func createCircle(circleId: Int, with member: Member)
    
    /// Delete circle by provided ID
    func deleteCircle(circleId: Int)
    
    /// Adds a member to a circle of the id passed in to the signature.
    /// In the case that the circle does not exist they should create it.
    func addMember(member: Member, circleId: Int)
    
    /// Removes a member from the circle of the id passed in to
    /// the signature. Should remove circles with no members
    func removeMember(member: Member, circleId: Int)
    
    /// Return the number of circles with members of size n passed
    /// into the function. Try to optimize this to be as performant as possible.
    func query(memberCount: Int) -> Int
}
