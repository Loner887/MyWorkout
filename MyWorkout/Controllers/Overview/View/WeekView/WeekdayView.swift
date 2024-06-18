import UIKit

extension WeekView{
    final class WeekdayView: BaseView{
        
        private let nameLabel = UILabel()
        private let dateLabel = UILabel()
        private let stackView = UIStackView()
        
        func configure(with index: Int, and name: String) {
            let startOfWeek = Date().startOfWeek
            let currentDay = startOfWeek.agoForward(to: index)
            let day = Calendar.current.component(.day, from: currentDay)
            
            let isTooday = currentDay.stripTime() == Date().stripTime()
            
            backgroundColor = isTooday ? R.Colors.active : R.Colors.inactive
            
            nameLabel.text = name.uppercased()
            nameLabel.textColor = isTooday ? .black : R.Colors.backbar
            
            dateLabel.text = "\(day)"
            dateLabel.textColor = isTooday ? .black : R.Colors.backbar

        }
    }
}


extension WeekView.WeekdayView {
    override func setupViews() {
        super.setupViews()
        
        setupView(stackView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(dateLabel)
    }
    
    override func constraintViews() {
        super.constraintViews()
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = .black
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        nameLabel.font = R.Fonts.helvilticaRegular(with: 9)
        nameLabel.textAlignment = .center
        
        dateLabel.font = R.Fonts.helvilticaRegular(with: 15)
        dateLabel.textAlignment = .center
        
        stackView.spacing = 3
        stackView.axis = .vertical
    }
}

