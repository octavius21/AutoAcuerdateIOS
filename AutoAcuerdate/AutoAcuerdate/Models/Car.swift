//
//  Car.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import Foundation

// MARK: - Car
struct Car: Codable {
    let car: [CarElement]
}

// MARK: - CarElement
struct CarElement: Codable {
    var idCar, brand: String
    var model: Int
    var licensePlate, colorPlate, origin, leftPressureTireFront: String
    var rightPressureTireFront, leftPressureTireBehavior, rightPressureTireBehavior: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case idCar = "id_car"
        case brand, model
        case licensePlate = "license_plate"
        case colorPlate = "color_plate"
        case origin
        case leftPressureTireFront = "left_pressure_tire_front"
        case rightPressureTireFront = "right_pressure_tire_front"
        case leftPressureTireBehavior = "left_pressure_tire_behavior"
        case rightPressureTireBehavior = "right_pressure_tire_behavior"
        case image
    }
}
