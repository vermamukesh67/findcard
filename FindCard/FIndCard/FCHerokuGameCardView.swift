import UIKit
//Handles when the user select / unselect the checkbox.
public typealias SelectionHandler = (_ isCardOpened: Bool) -> Void

public enum CardStatus {
    case front
    case back
    case resloved
}

public class FCHerokuGameCardView: UIView {
    let flipAnimationDuration = 1.0
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
    /// Load view from nib file
    fileprivate func commonInit() {
        self.addSubview(symBolButtton)
        symBolButtton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        symBolButtton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        symBolButtton.widthAnchor.constraint(equalToConstant: self.frame.size.width).isActive = true
        symBolButtton.heightAnchor.constraint(equalToConstant: self.frame.size.height).isActive = true
        //symBolButtton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        self.layoutIfNeeded()
    }
    lazy var symBolButtton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.backgroundColor = openCardBGColor
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        // initally minimum width and height required for button
        button.layer.cornerRadius = 2.0
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        return button
    } ()
    fileprivate func layoutUIForBackStatus() {
        self.symBolButtton.backgroundColor = closedCardBGColor
    }
    fileprivate func layoutUIForFrontStatus() {
        self.symBolButtton.backgroundColor = openCardBGColor
    }
    fileprivate func layoutUIForResolvedStatus() {
        layoutUIForFrontStatus()
    }
    @objc func symbolButtonTap() {
        switch status {
        case .back:
            self.status = .front
        case .front:
            self.status = .back
        default:
            break
        }
        if self.status != .resloved {
            flip(direction: (self.status == .back) ? UIView.AnimationOptions.transitionFlipFromRight : UIView.AnimationOptions.transitionFlipFromLeft, duration: flipAnimationDuration, completionHandler: {
                print("symbol handler called")
                self.selectionHandler?(true)
            })
        }
    }
    public var selectionHandler: SelectionHandler? {
        didSet {
            if self.selectionHandler == nil {
                self.symBolButtton.isUserInteractionEnabled = false
                self.symBolButtton.removeTarget(self, action: #selector(symbolButtonTap), for: UIControl.Event.touchUpInside)
            } else {
                self.symBolButtton.isUserInteractionEnabled = true
                   self.symBolButtton.addTarget(self, action: #selector(symbolButtonTap), for: UIControl.Event.touchUpInside)
            }
        }
    }
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
    public var text: String? {
        didSet {
            self.symBolButtton.setTitle(self.text, for: UIControl.State.normal)
        }
    }
}
