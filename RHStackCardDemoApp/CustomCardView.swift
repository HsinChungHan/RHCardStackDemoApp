
//
//  CustomCardView.swift
//  SlidingCard
//
//  Created by Chung Han Hsin on 2024/3/29.
//

import Foundation
import RHStackCard
import UIKit

class CustomCardView: CardView {
    var _card: CustomCard {
        guard let card = card as? CustomCard else { fatalError() }
        return card
    }
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = _card.cardName
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        return label
    }()
    
    override func setupLayout() {
        super.setupLayout()
        addSubview(nameLabel)
        nameLabel.constraint(centerX: snp.centerX, centerY: snp.centerY)
        uidLabel.removeFromSuperview()
    }
}

