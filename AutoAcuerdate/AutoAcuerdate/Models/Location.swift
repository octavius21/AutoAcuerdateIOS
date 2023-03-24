//
//  Location.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import Foundation

// MARK: - Location
struct Location: Codable {
    let location: [LocationElement]
}

// MARK: - LocationElement
struct LocationElement: Codable {
    let idLocation, coordinatesLatitude, coordinatesLongitude, locationName: String
    let address, nation: String

    enum CodingKeys: String, CodingKey {
        case idLocation = "id_location"
        case coordinatesLatitude = "coordinates_latitude"
        case coordinatesLongitude = "coordinates_longitude"
        case locationName = "location_name"
        case address, nation
    }
}
