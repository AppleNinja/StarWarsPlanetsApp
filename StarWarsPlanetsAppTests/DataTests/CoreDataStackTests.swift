//
//  CoreDataStackTests.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import CoreData
@testable import StarWarsPlanetsApp

final class CoreDataStackTests: XCTestCase {
    func testPersistentContainerInitialization() {
        let coreDataStack = CoreDataStack.shared
        XCTAssertNotNil(coreDataStack.persistentContainer)
    }

    func testViewContextIsAvailable() {
        let context = CoreDataStack.shared.viewContext
        XCTAssertNotNil(context)
    }
}
