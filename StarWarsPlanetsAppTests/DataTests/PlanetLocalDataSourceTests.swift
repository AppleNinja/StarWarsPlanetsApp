//
//  PlanetLocalDataSourceTests.swift
//  StarWarsPlanetsAppTests
//
//  Created by Sreekumar on 03/11/2024.
//

import XCTest
import Combine
import CoreData
@testable import StarWarsPlanetsApp

final class PlanetLocalDataSourceTests: XCTestCase {
    var localDataSource: PlanetLocalDataSource!
    var inMemoryContext: NSManagedObjectContext!

    override func setUp() {
        super.setUp()
        let persistentContainer = NSPersistentContainer(name: "StarWarsPlanets")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        let expectation = XCTestExpectation(description: "Load persistent stores")
        persistentContainer.loadPersistentStores { _, error in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
        inMemoryContext = persistentContainer.viewContext
        localDataSource = PlanetLocalDataSource(context: inMemoryContext)
    }

    override func tearDown() {
        localDataSource = nil
        inMemoryContext = nil
        super.tearDown()
    }

    func testSaveAndFetchPlanets() {
        let planet = Planet(
            id: "1",
            name: "Test Planet",
            rotationPeriod: "24",
            orbitalPeriod: "365",
            diameter: "12742",
            climate: "temperate",
            gravity: "1 standard",
            terrain: "varied",
            surfaceWater: "71",
            population: "1000000"
        )

        localDataSource.savePlanets(planets: [planet])
        let fetchedPlanets = localDataSource.getPlanets()

        XCTAssertEqual(fetchedPlanets.count, 1)
        XCTAssertEqual(fetchedPlanets.first?.name, "Test Planet")
    }
}
