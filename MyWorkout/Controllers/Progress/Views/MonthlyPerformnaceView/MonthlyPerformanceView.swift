import UIKit

final class MonthlyPerformanceView: BaseInfoView {

    private let chartsView = ChartsView()

    func configure(with itmes: [ChartsView.Data], topChartOffset: Int) {
        chartsView.configure(with: itmes, topChartOffset: topChartOffset)
    }
}

extension MonthlyPerformanceView {
    override func setupViews() {
        super.setupViews()

        setupView(chartsView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            chartsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            chartsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            chartsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            chartsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
    }
}
