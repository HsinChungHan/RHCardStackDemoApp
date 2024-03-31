
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

class CustomCardView: CardView {
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
    
    lazy var goToDetailVCButton = makeGoToDetailVCButton()
    
    override func setupLayout() {
        super.setupLayout()
        uidLabel.removeFromSuperview()
        
        addSubview(nameLabel)
        nameLabel.constraint(bottom: snp.bottom, leading: snp.leading, padding: .init(top: 0, left: 16, bottom: cardViewControlBarSafeAreaInset + 8, right: 0))
        addSubview(goToDetailVCButton)
        goToDetailVCButton.constraint(bottom: snp.bottom, trailing: snp.trailing, padding: .init(top: 0, left: 0, bottom: cardViewControlBarSafeAreaInset + 8, right: 16), size: .init(width: 40, height: 40))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goToDetailVCButton.layer.cornerRadius = 40 / 2
        goToDetailVCButton.clipsToBounds = true
    }
    
    func makeGoToDetailVCButton() -> UIButton {
        let view = UIButton()
        view.backgroundColor = Color.Neutral.v0
        view.setImage(UIImage(named: "detail"), for: .normal)
        view.addTarget(self, action: #selector(handleGoToDetailVCButton), for: .touchUpInside)
        return view
    }
    
    @objc func handleGoToDetailVCButton(_ sender: UIButton) {
    }
}

