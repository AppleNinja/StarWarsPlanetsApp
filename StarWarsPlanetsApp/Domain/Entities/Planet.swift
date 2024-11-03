//
//  Planet.swift
//  StarWarsPlanetsApp
//
//  Created by Sreekumar on 03/11/2024.
//

import Foundation

struct Planet: Identifiable, Equatable, Codable {
    let id: String
    let name: String
    let rotationPeriod: String
    let orbitalPeriod: String
    let diameter: String
    let climate: String
    let gravity: String
    let terrain: String
    let surfaceWater: String
    let population: String
}

