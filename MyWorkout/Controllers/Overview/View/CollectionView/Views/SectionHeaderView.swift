import UIKit

final class SectionHeaderView: UICollectionReusableView {
    static let id = "SectionHeaderView"

    private let title: UILabel = {
        let lable = UILabel()
        lable.font = R.Fonts.helvilticaRegular(with: 13)
        lable.textColor = R.Colors.inactive
        lable.textAlignment = .center
        return lable
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        constraintViews()
        configureAppearance()
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)

        setupViews()
        constraintViews()
        configureAppearance()
    }

    func configure(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd"

        self.title.text = dateFormatter.string(from: date).uppercased()
    }
}

private extension SectionHeaderView {
    func setupViews() {
        setupView(title)
    }

    func constraintViews() {
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }

    func configureAppearance() {}
}

