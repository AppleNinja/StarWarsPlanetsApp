//
//  PlanetLocalDataSource.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation
import CoreData

protocol PlanetLocalDataSourceProtocol {
    func savePlanets(planets: [Planet])
    func getPlanets() -> [Planet]
}

final class PlanetLocalDataSource: PlanetLocalDataSourceProtocol {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.viewContext) {
        self.context = context
    }

    func savePlanets(planets: [Planet]) {
        context.performAndWait {
            let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()
            do {
                let existingPlanets = try context.fetch(fetchRequest)
                for planet in existingPlanets {
                    context.delete(planet)
                }
            } catch {
                print("Failed to fetch or delete existing planets: \(error)")
            }

            for planet in planets {
                let entity = PlanetEntity(context: context)
                entity.id = planet.id
                entity.name = planet.name
                entity.rotationPeriod = planet.rotationPeriod
                entity.orbitalPeriod = planet.orbitalPeriod
                entity.diameter = planet.diameter
                entity.climate = planet.climate
                entity.gravity = planet.gravity
                entity.terrain = planet.terrain
                entity.surfaceWater = planet.surfaceWater
                entity.population = planet.population
            }

            do {
                try context.save()
            } catch {
                print("Failed to save planets: \(error)")
            }
        }
    }

    func getPlanets() -> [Planet] {
        let fetchRequest: NSFetchRequest<PlanetEntity> = PlanetEntity.fetchRequest()

        do {
            let planetEntities = try context.fetch(fetchRequest)
            return planetEntities.compactMap { entity -> Planet? in
                guard
                    let id = entity.id,
                    let name = entity.name,
                    let rotationPeriod = entity.rotationPeriod,
                    let orbitalPeriod = entity.orbitalPeriod,
                    let diameter = entity.diameter,
                    let climate = entity.climate,
                    let gravity = entity.gravity,
                    let terrain = entity.terrain,
                    let surfaceWater = entity.surfaceWater,
                    let population = entity.population
                else {
                    return nil
                }

                return Planet(
                    id: id,
                    name: name,
                    rotationPeriod: rotationPeriod,
                    orbitalPeriod: orbitalPeriod,
                    diameter: diameter,
                    climate: climate,
                    gravity: gravity,
                    terrain: terrain,
                    surfaceWater: surfaceWater,
                    population: population
                )
            }
        } catch {
            print("Failed to fetch planets: \(error)")
            return []
        }
    }
}
