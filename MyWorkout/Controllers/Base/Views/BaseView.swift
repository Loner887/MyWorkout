import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
        constraintViews()
        configureAppearance()
    }
}

@objc extension BaseView {
    func setupViews(){}
    
    func constraintViews() {}
    
    func configureAppearance() {}
}
