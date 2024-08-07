//
//  CircleManagerTests.swift
//  Life360SampleTests
//
//  Created by Andriy Kupich on 26.10.2021.
//

import XCTest
import MapKit
@testable import Life360Sample

class CircleManagerTests: XCTestCase {
    
    var sut: CircleManagerImpl!

    override func setUpWithError() throws {
        sut = CircleManagerImpl()
    }

    override func tearDownWithError() throws {
        for circle in sut.circles {
            sut.deleteCircle(circleId: circle.key)
        }
    }

    func testAddMemberWhenCircleExists() {
        let circleId = 11
        let initMember = Member(uniqueID: 1, name: "Member\(1)", coordinates: CLLocationCoordinate2D())
        let newMember = Member(uniqueID: 2, name: "Member\(2)", coordinates: CLLocationCoordinate2D())
        
        sut.createCircle(circleId: circleId, with: initMember)
        sut.addMember(member: newMember, circleId: circleId)
        
        let added = sut.circles[circleId]?.getMember(by: newMember.uniqueID)
        XCTAssertTrue(added != nil,
                      "Member with id = \(newMember.uniqueID) was not added")
    }
    
    func testAddMemberWhenCircleDoesNotExists() {
        let circleId = 12
        let newMember = Member(uniqueID: 2, name: "Member\(2)", coordinates: CLLocationCoordinate2D())
        
        sut.addMember(member: newMember, circleId: circleId)
        
        XCTAssert(!sut.circles.isEmpty)
        let createdCircle = sut.circles.values.first
        XCTAssert(createdCircle != nil, "Circle was not created")
        let addedMember = createdCircle?.getMember(by: newMember.uniqueID)
        XCTAssertTrue(addedMember != nil,
                      "Member with id = \(newMember.uniqueID) was not found")
    }
    
    func testRemoveMemberFromCircleOfId() {
        let circleId = 13
        let firstMember = Member(uniqueID: 1, name: "Member\(1)", coordinates: CLLocationCoordinate2D())
        let secondMember = Member(uniqueID: 2, name: "Member\(2)", coordinates: CLLocationCoordinate2D())
        
        sut.createCircle(circleId: circleId, with: firstMember)
        sut.addMember(member: secondMember, circleId: circleId)
        sut.removeMember(member: firstMember, circleId: circleId)
        
        let removed = sut.circles[circleId]?.getMember(by: firstMember.uniqueID)
        XCTAssertTrue(removed == nil,
                      "Member with id = \(firstMember.uniqueID) expected to be removed from Circle")
    }
    
    func testRemoveLastMemberFromCircleOfId() {
        let circleId = 14
        let firstMember = Member(uniqueID: 1, name: "Member\(1)", coordinates: CLLocationCoordinate2D())
        
        sut.createCircle(circleId: circleId, with: firstMember)
        sut.removeMember(member: firstMember, circleId: circleId)
        
        XCTAssertTrue(sut.circles.isEmpty,
                      "Circle has to be removed, when last member - had been removed")
    }
    
    func testHowManyDuplicatesInList() {
        var circles = [Circle]()
        let duplicatedCirclesCount = 3
        for i in 1...5 {
            circles.append(Circle(circleId: i))
        }
        for i in 1...duplicatedCirclesCount {
            circles.append(Circle(circleId: i))
        }
        
        let result = CircleManagerImpl.countDuplicates(for: circles)
        XCTAssert(result == duplicatedCirclesCount, "List expected to contains \(duplicatedCirclesCount) duplicates, but instead has \(result)")
    }
    
    func testRemovingDuplicatesFromGivenCircles() {
        var circles = [Circle]()
        let uniqueCirclesCount = 6
        let expectedCirclesCount = 3
        
        let lessMembersCount = 3
        let moreMembersCount = 5
        
        for i in 1...uniqueCirclesCount {
            var new = Circle(circleId: i)
            for number in 1...lessMembersCount {
                let newMember = Member(uniqueID: number, name: "Member\(number)", coordinates: CLLocationCoordinate2D())
                new.addMember(member: newMember)
            }
            circles.append(new)
        }
        for i in 1...expectedCirclesCount {
            var new = Circle(circleId: i)
            for number in 1...moreMembersCount {
                let newMember = Member(uniqueID: number, name: "Member\(number)", coordinates: CLLocationCoordinate2D())
                new.addMember(member: newMember)
            }
            circles.append(new)
        }
        
        let uniqueCircles = CircleManagerImpl.removeDuplicates(for: circles)
        let circlesWithMoreMembers = uniqueCircles.filter { $0.members.count == moreMembersCount }
        XCTAssert(uniqueCircles.count == uniqueCirclesCount, "All duplicates should be removed")
        XCTAssert(circlesWithMoreMembers.count == expectedCirclesCount, "Circles with more members should exist after removing duplicates")
    }
}
