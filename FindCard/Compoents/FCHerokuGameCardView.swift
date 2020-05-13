import UIKit
/// A enum that represent the card status.
public enum CardStatus {
    /// card is in front.
    case front
    /// card is in back.
    case back
    /// card resolved.
    case resloved
}
/// A UIView class that display the card.
public class FCHerokuGameCardView: UIView {
    let openCardBGColor = UIColor.lightGray
    let closedCardBGColor = UIColor.systemBlue
    /**
     Initializes and returns a newly allocated view object with the specified frame rectangle.
     - parameter frame:   The frame rectangle for the view
     - returns: An initialized view object.
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    ///  Initializes and returns a newly allocated view object.
    public init() {
        super.init(frame: CGRect.zero)
        commonInit()
    }
    /**
     Returns an object initialized from data in a given unarchiver.
     - parameter decoder:   An unarchiver object.
     - returns: self, initialized using the data in decoder.
     */
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    fileprivate func applyConstraint() {
        symBolLabel.frame = self.bounds
        NSLayoutConstraint.activate([
            symBolLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            symBolLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            symBolLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            symBolLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        applyConstraint()
    }
    fileprivate func commonInit() {
        self.addSubview(symBolLabel)
    }
    lazy private(set) var symBolLabel: UILabel = {
        let label = UILabel.init(frame: CGRect.zero)
        label.backgroundColor = openCardBGColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.layer.cornerRadius = 2.0
        label.clipsToBounds = true
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.borderWidth = 2.0
        label.isUserInteractionEnabled = false
        label.textAlignment = .center
        return label
    }()
    /// Prepare the ui for back card status.
    func layoutUIForBackStatus() {
        self.symBolLabel.backgroundColor = closedCardBGColor
    }
    /// Prepare the ui for front card status.
    func layoutUIForFrontStatus() {
        self.symBolLabel.backgroundColor = openCardBGColor
    }
    /// Prepare the ui for back card resolved.
    func layoutUIForResolvedStatus() {
        layoutUIForFrontStatus()
    }
    /// Update the card status.
    public var status: CardStatus = .back {
        didSet {
            switch self.status {
            case .back:
                layoutUIForBackStatus()
            case .front:
                layoutUIForFrontStatus()
            case .resloved:
                layoutUIForResolvedStatus()
            }
        }
    }
    /// Sets the text on card label.
    public var text: String? {
        didSet {
            self.symBolLabel.text = text
        }
    }
}
