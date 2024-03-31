
//
//  CustomCardView.swift
//  SlidingCard
//
//  Created by Chung Han Hsin on 2024/3/29.
//

import Foundation
import RHStackCard
import RHUIComponent
import UIKit

class ADCardView: CardView {
    let cardViewControlBarSafeAreaInset: CGFloat = 64
    
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
        uidLabel.removeFromSuperview()
        
        addSubview(nameLabel)
        nameLabel.constraint(bottom: snp.bottom, centerX: snp.centerX, padding: .init(top: 0, left: 16, bottom: cardViewControlBarSafeAreaInset + 8, right: 0))
    }
}

