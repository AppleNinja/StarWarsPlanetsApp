//
//  PlanetResponseDTO.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation

struct PlanetResponseDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlanetDTO]
}

struct PlanetDTO: Codable {
    let name: String
    let rotation_period: String
    let orbital_period: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surface_water: String
    let population: String
}
