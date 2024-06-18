import UIKit

final class OverviewNavBar: BaseView {
    
    private let label = UILabel()
    private let addButton = UIButton()
    private let editButton = UIButton()
    private let weekView = WeekView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func addAdditingAction(_ action: Selector, with target: Any?) {
        addButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func editEditingAction(_ action: Selector, with target: Any?) {
        editButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setEditButtonTitle(_ title: String) {
            editButton.setTitle(title, for: .normal)
        }
}

extension OverviewNavBar {
    override func setupViews() {
        super.setupViews()
        
        setupView(addButton)
        setupView(editButton)
        setupView(label)
        setupView(weekView)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            
            editButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            
            label.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            weekView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            weekView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            weekView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            weekView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            weekView.heightAnchor.constraint(equalToConstant: 47)
            
            
        ])
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = R.Colors.backbar
        
        label.textColor = R.Colors.active
        label.textAlignment = .center
        label.font = R.Fonts.helvilticaRegular(with: 22)
        label.text = "Overview"
        
        addButton.tintColor = R.Colors.active
        addButton.setTitle("Add", for: .normal)
        addButton.titleLabel?.font = R.Fonts.helvilticaRegular(with: 20)

        
        editButton.tintColor = R.Colors.active
        editButton.setTitle("Edit", for: .normal)
        editButton.titleLabel?.font = R.Fonts.helvilticaRegular(with: 20)
        
        
    }
}

