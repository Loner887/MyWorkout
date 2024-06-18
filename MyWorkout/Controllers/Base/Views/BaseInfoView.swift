import UIKit

class BaseInfoView: BaseView {
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = R.Fonts.helvilticaRegular(with: 13)
        label.textColor = R.Colors.inactive
        return label
    }()
    
    private let button = WAButton(with: .primary)
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        return view
    }()
    
    init(with title: String? = nil, buttonTitle: String? = nil) {
        titleLabel.text = title?.uppercased()
        titleLabel.textAlignment = buttonTitle == nil ? .center : .left
        
        button.setTitle(buttonTitle)
        button.isHidden = buttonTitle == nil ? true : false
        
        super.init(frame: .zero)

    }
    
    required init?(coder: NSCoder) {
        super.init(frame: .zero)
    }
    
    func addButtonTarget(target: Any?, action: Selector) {
        button.addTarget(action, action: action, for: .touchUpInside)
    }
    
}

extension BaseInfoView {
    override func setupViews(){
        super.setupViews()
        
        setupView(titleLabel)
        setupView(contentView)
        setupView(button)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        let contentTopAnchor: NSLayoutAnchor = titleLabel.text == nil ? topAnchor : titleLabel.bottomAnchor
        let contentTopOffset: CGFloat = titleLabel.text == nil ? 0 : 10
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 30),
            
            
            contentView.topAnchor.constraint(equalTo: contentTopAnchor, constant: contentTopOffset),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .clear
    }
}
