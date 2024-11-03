//
//  PlanetMapper.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation

protocol PlanetMapperProtocol {
    func mapDTOToDomain(_ dto: PlanetDTO) -> Planet
}

final class PlanetMapper: PlanetMapperProtocol {
    func mapDTOToDomain(_ dto: PlanetDTO) -> Planet {
        return Planet(
            id: UUID().uuidString,
            name: dto.name,
            rotationPeriod: dto.rotation_period,
            orbitalPeriod: dto.orbital_period,
            diameter: dto.diameter,
            climate: dto.climate,
            gravity: dto.gravity,
            terrain: dto.terrain,
            surfaceWater: dto.surface_water,
            population: dto.population
        )
    }
}
