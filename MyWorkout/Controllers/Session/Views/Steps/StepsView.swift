import UIKit

final class StepsView: BaseInfoView {

    private let barsView = BarsView()

    func configure(with itmes: [BarView.Data]) {
        barsView.configure(with: itmes)
    }
}

extension StepsView {
    override func setupViews() {
        super.setupViews()

        setupView(barsView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            barsView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            barsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            barsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            barsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
    }
}
