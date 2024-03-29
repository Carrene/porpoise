
import Foundation
import XLActionController

public struct MobileTokenActionSheetHeaderData {
    public init() {
        
    }
}

open class MobileTokenActionSheetHeaderView: UICollectionReusableView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

open class MobileTokenActionSheetController: ActionController<ActionSheet, ActionData, MobileTokenActionSheetHeaderView, MobileTokenActionSheetHeaderData, UICollectionReusableView, Void> {
    
//    private lazy var blurView: UIVisualEffectView = {
//        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
//        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        return blurView
//    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        //backgroundView.addSubview(blurView)
        cancelView?.frame.origin.y = view.bounds.size.height // Starts hidden below screen
        cancelView?.layer.shadowColor = R.color.primaryLight()?.cgColor
        cancelView?.layer.shadowOffset = CGSize( width: 0, height: 0)
        cancelView?.layer.shadowRadius = 0
        cancelView?.layer.shadowOpacity = 0
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //blurView.frame = backgroundView.bounds
    }
    
    public override init(nibName nibNameOrNil: String? = nil, bundle nibBundleOrNil: Bundle? = nil) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        settings.behavior.bounces = true
        settings.behavior.scrollEnabled = true
        settings.cancelView.showCancel = false
        settings.animation.scale = nil
        settings.animation.present.springVelocity = 0.0
        settings.cancelView.hideCollectionViewBehindCancelView = true
        
        cellSpec = .nibFile(nibName: R.nib.actionSheet.name, bundle: Bundle(for: ActionSheet.self), height: { _ in 60 })
        headerSpec = .cellClass( height: { _ in 84 })
        
        onConfigureCellForAction = { [weak self] cell, action, indexPath in
            //cell.setup(action.data?.title, detail: action.data?.subtitle, image: action.data?.image)
            cell.separatorView?.isHidden = indexPath.item == (self?.collectionView.numberOfItems(inSection: indexPath.section))! - 1
            cell.viewDisable.backgroundColor = action.enabled ? R.color.primary()?.withAlphaComponent(0.0) : R.color.primary()?.withAlphaComponent(0.9)
            cell.label.text = action.data?.title
            cell.imageView.image = action.data?.image
        }
        onConfigureHeader = { (header: MobileTokenActionSheetHeaderView, data: MobileTokenActionSheetHeaderData)  in
//            header.title.text = data.title
//            header.artist.text = data.subtitle
//            header.imageView.image = data.image
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func performCustomDismissingAnimation(_ presentedView: UIView, presentingView: UIView) {
        super.performCustomDismissingAnimation(presentedView, presentingView: presentingView)
        cancelView?.frame.origin.y = view.bounds.size.height + 10
    }
    
    open override func onWillPresentView() {
        cancelView?.frame.origin.y = view.bounds.size.height
    }
}
