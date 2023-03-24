//
//  Card.swift
//  AutoAcuerdate
//
//  Created by DISMOV on 22/03/23.
//

import Foundation

// MARK: - Card
struct Card: Codable {
    let circulationCards: [CirculationCard]

    enum CodingKeys: String, CodingKey {
        case circulationCards = "circulation_cards"
    }
}

// MARK: - CirculationCard
struct CirculationCard: Codable {
    var idCard, efeDate, expDate, itin: String
    var origin, name: String

    enum CodingKeys: String, CodingKey {
        case idCard = "id_card"
        case efeDate = "efe_date"
        case expDate = "exp_date"
        case itin, origin, name
    }
}
