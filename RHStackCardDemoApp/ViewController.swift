//
//  ViewController.swift
//  SlidingCard
//
//  Created by Chung Han Hsin on 2024/3/22.
//

import RHUIComponent
import RHStackCard
import UIKit

class ViewController: UIViewController {
    private let CUSTOM_CARD_VIEW_ID = "CustomCardViewID"
    private let AD_CARD_VIEW_ID = "ADCardViewID"
    
    private let componentFactory = CardViewComponentsFactory()
    private lazy var cardDeskViewController = componentFactory.makeCardDeskViewController(with: self, in: self)
    private lazy var cardDeskView = cardDeskViewController.view!
    
    private lazy var slidingEventObserver: SlidingEventObserver? = componentFactory.makeSlidingEventObserver()
    
    private lazy var testTaskManagerButton = makeTestTaskManagerButton()
    private lazy var gradientLayer = makeGradientLayer()
    private lazy var titleLabel = makeTitleLabel()
    private lazy var descriptionLabel = makeDesciprtionLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.Purple.v600
        registerCardView()
        setupLayout()
        
        addObserver(with: slidingEventObserver)
        bindEvent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
    }
    
    deinit {
        slidingEventObserver = nil
    }
}

// MARK: - Helpers
private extension ViewController {
    func addObserver(with slidingEventObserver: SlidingEventObserver?) {
        guard let slidingEventObserver else { return }
        ObservableSlidingAnimation.shared.addObserver(slidingEventObserver)
    }
    
    func bindEvent() {
        slidingEventObserver?.didUpdateValue = { event in }
    }
    
    func registerCardView() {
        cardDeskViewController.registerCardViewType(withCardViewID: CUSTOM_CARD_VIEW_ID, cardViewType: CustomCardView.self)
        cardDeskViewController.registerCardViewType(withCardViewID: AD_CARD_VIEW_ID, cardViewType: ADCardView.self)
    }
}

// MARK: - Layout
extension ViewController {
    private func setupLayout() {
        view.layer.addSublayer(gradientLayer)
        view.addSubview(testTaskManagerButton)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        titleLabel.constraint(top: view.safeAreaLayoutGuide.snp.top, centerX: view.snp.centerX, padding: .init(top: 18, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width - 32, height: 0))
        descriptionLabel.constraint(top: titleLabel.snp.bottom, centerX: view.snp.centerX, padding: .init(top: 8, left: 0, bottom: 0, right: 0), size: .init(width: UIScreen.main.bounds.width - 32, height: 0))
        testTaskManagerButton.constraint(bottom: view.safeAreaLayoutGuide.snp.bottom, leading: view.snp.leading, trailing: view.snp.trailing, padding: .init(top: 0, left: 16, bottom: 44, right: 16), size: .init(width: 0, height: 44))
        
        view.addSubview(cardDeskView)
        let cardWidth = UIScreen.main.bounds.width - 96
        cardDeskView.constraint(top: descriptionLabel.snp.bottom, centerX: view.snp.centerX, padding: .init(top: 32, left: 0, bottom: 0, right: 0), size: .init(width: cardWidth, height: cardWidth * 16 / 9))
        
    }
}

// MARK - Factory Mthods
private extension ViewController {
    func makeTestTaskManagerButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("Intercept Sliding Actions", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(didTapTestTaskManagerButton), for: .touchUpInside)
        return button
    }
    
    @objc func didTapTestTaskManagerButton() {
        let actions: [CardViewAction] = [.like, .superLike, .nope]
        cardDeskViewController.testTaskManager(slideAction: actions.randomElement()!)
    }
    
    func makeGradientLayer() -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        layer.locations = [0.8, 1.0]
        return layer
    }
    
    func makeTitleLabel() -> UILabel {
        let label = UILabel()
        label.text = "Vogue"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        return label
    }
    
    func makeDesciprtionLabel() -> UILabel {
        let label = UILabel()
        label.text = "The latest fashion news, beauty coverage, celebrity style on Vogue.com. "
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }
}

// MARK - Mock data
extension ViewController {
    func randomName() -> String {
        let names = ["Alice", "Bob", "Charlie", "Daisy", "Ethan", "Fiona", "George", "Hannah", "Ian", "Jasmine", "Kyle", "Lily", "Max", "Nina", "Oscar", "Piper", "Quinn", "Ruby", "Steven", "Tina", "Ulysses", "Violet", "Walter", "Xena", "Yves", "Zoe"]
        return names.randomElement()!
    }
    
    func makeImageNameCards() -> [CustomCard] {
        let cardUIDs = Array(100...120)
         var cards: [CustomCard] = []
         
         for (index, uid) in cardUIDs.enumerated() {
             let start = 1 + index * 8
             let end = start + 7
             let imageNames = (start...end).map { "\($0)" }
             let cardName = randomName()
             
             let card = CustomCard(uid: "\(uid)", imageNames: imageNames, cardViewTypeName: CUSTOM_CARD_VIEW_ID, cardName: cardName)
             cards.append(card)
         }
         return cards
    }
    
    func makeImageURLCards() -> [BasicCard] {
        let urls = [
            "https://img.onl/secZNX", "https://img.onl/ZH5sWF", "https://img.onl/svq3BT", 
            "https://img.onl/iZFN8N", "https://img.onl/0wemvT", "https://img.onl/7XELcY", 
            "https://img.onl/CPKg1e", "https://img.onl/1KYoX8", "https://img.onl/qR1lFr",
            "https://img.onl/4DuU5A", "https://img.onl/buCSyk", "https://img.onl/YtXgXr",
            "https://img.onl/XlhMSt", "https://img.onl/eJGtug", "https://img.onl/QNenY", 
            "https://img.onl/aXiaX6", "https://img.onl/W4O0AZ", "https://img.onl/bMQeW1",
            "https://img.onl/kQrXul", "https://img.onl/L2ye3l", "https://img.onl/lOPDrl",
            "https://img.onl/k3CYUk", "https://img.onl/cSg1E", "https://img.onl/VWokW8",
            "https://img.onl/6hnbsJ", "https://img.onl/f9wrd0", "https://img.onl/TeDDKj",
            "https://img.onl/WBDw8R", "https://img.onl/GgAxcz", "https://img.onl/B0REiI",
            "https://img.onl/4sduLt", "https://img.onl/tQgXqX", "https://img.onl/HvDsN",
            "https://img.onl/Bc37tQ", "https://img.onl/sBy1Wv", "https://img.onl/6r5VEn",
            "https://img.onl/f7Q15i", "https://img.onl/STASrM", "https://img.onl/Zi0bBW",
            "https://img.onl/MXAq0O", "https://img.onl/SrJPxh", "https://img.onl/Skrcil",
            "https://img.onl/hUHz2H", "https://img.onl/tiaccS", "https://img.onl/gSgl2i",
            "https://img.onl/RkdhZs", "https://img.onl/Z2w84", "https://img.onl/eMqUlI",
            "https://img.onl/HBuRMB", "https://img.onl/5Uj6Hr", "https://img.onl/7BoR",
            "https://img.onl/LbSOg7", "https://img.onl/GOSUqx", "https://img.onl/zQsW2u",
            "https://img.onl/UOF8C8", "https://img.onl/oqdqWE", "https://img.onl/1b015H",
            "https://img.onl/530DGM", "https://img.onl/lVtiDx", "https://img.onl/zaVBcu",
            "https://img.onl/RMrMwY", "https://img.onl/Ih8RYX", "https://img.onl/r5HVBG",
            "https://img.onl/VLnbS7", "https://img.onl/vtVK60", "https://img.onl/wwCO3L",
            "https://img.onl/eksZyu", "https://img.onl/tNWP0", "https://img.onl/bLTSQ",
            "https://img.onl/stUTZP", "https://img.onl/yfbSC0", "https://img.onl/j028gc",
            "https://img.onl/TDAtZW", "https://img.onl/Zck8OG", "https://img.onl/Nm5yu7",
            "https://img.onl/kgBC9H", "https://img.onl/DS817d", "https://img.onl/IQ8AoJ",
            "https://img.onl/rPzcr9", "https://img.onl/DjSyn4", "https://img.onl/hc8Afr",
            "https://img.onl/ysJsp9", "https://img.onl/yTEHRZ", "https://img.onl/hHI6EL",
            "https://img.onl/yDZgLA", "https://img.onl/SmsC19"
        ]
        
        var cards: [BasicCard] = []
        
        for i in stride(from: 0, to: urls.count, by: 4) {
            let cardURLs = urls[i..<min(i+3, urls.count)].compactMap { URL(string: $0) }
            let card = BasicCard(uid: "\(i/3)", imageURLs: cardURLs)
            cards.append(card)
        }
        return cards
    }
    
    func makeADCards() -> [CustomCard] {
        var cards: [CustomCard] = []
        let totalImages = 191 // There are total 191 images

        for start in stride(from: 2, through: totalImages, by: 5) {
            let end = min(start + 4, totalImages)
            let imageNames = (start...end).map { "AD\($0)" }
            let cardName = "Vogue - \(randomName())"
            
            // Set first imageName of each group be CustomCardView's uid
            let uid = "AD \(start)"
            
            let card = CustomCard(uid: uid, imageNames: imageNames, cardViewTypeName: AD_CARD_VIEW_ID, cardName: cardName)
            cards.append(card)
        }
        return cards
    }
    
    func makeDemoCard() -> CustomCard {
        let uid = "AD Demo"
        let cardName = "Vogue - \(randomName())"
        let imageNames = [
            "AD117",
            "AD18",
            "AD34",
            "AD56",
            "AD92",
        ]
        let card = CustomCard(uid: uid, imageNames: imageNames, cardViewTypeName: AD_CARD_VIEW_ID, cardName: cardName)
        return card
    }

}

// MARK: - CardDeskViewControllerDataSource
extension ViewController: CardDeskViewControllerDataSource {
    var domainURL: URL? {
        .init(string: "https://img.onl/")
    }
    
    var cards: [Card] {
        let imageNameCards = makeImageNameCards()
        let imageURLCards = makeImageURLCards()
        let adCards = makeADCards()
//        return adCards
        return [makeDemoCard()] + (imageNameCards + imageURLCards + adCards).shuffled()
    }
}




