import UIKit

extension TimerView {
    final class PercentView: BaseView {
        
        private let stackView: UIStackView = {
            let view = UIStackView()
            view.axis = .vertical
            view.distribution = .fillProportionally
            view.spacing = 5
            return view
        }()
        
        private let percentLable: UILabel = {
            let label = UILabel()
            label.font = R.Fonts.helvilticaRegular(with: 23)
            label.textColor = R.Colors.active
            label.textAlignment = .center
            return label
        }()
        
        private let subTitleLable: UILabel = {
            let label = UILabel()
            label.font = R.Fonts.helvilticaRegular(with: 10)
            label.textColor = R.Colors.inactive
            label.textAlignment = .center
            return label
        }()
        
        override func setupViews(){
            super.setupViews()
            
            setupView(stackView)
            stackView.addArrangedSubview(percentLable)
            stackView.addArrangedSubview(subTitleLable)
        }
        
        override func constraintViews() {
            super.constraintViews()
            
            NSLayoutConstraint.activate([
            
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                
                
            ])
        }
        
        func configure(with title: String, andValue value: Int) {
            subTitleLable.text = title
            percentLable.text = "\(value)%"
        }
        
    }
}


