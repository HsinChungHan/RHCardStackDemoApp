//
//  CustomCard.swift
//  SlidingCard
//
//  Created by Chung Han Hsin on 2024/3/29.
//

import Foundation
import RHStackCard

struct CustomCard: Card {
    let uid: String
    let imageURLs: [URL] = []
    let imageNames: [String]
    var cardViewTypeName: String
    let cardName: String
    init(uid: String, imageNames: [String], cardViewTypeName: String, cardName: String) {
        self.uid = uid
        self.imageNames = imageNames
        self.cardViewTypeName = cardViewTypeName
        self.cardName = cardName
    }
}
