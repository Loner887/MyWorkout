import UIKit

enum CellRoundedType {
    case top, bottom, all, notRounded
}

protocol TrainingCellViewDelegate: AnyObject {
    func trainingCellViewDidTapEdit(_ cell: TrainingCellView)
    func trainingCellView(_ cell: TrainingCellView, didChangeCheckmarkState isDone: Bool)
}

final class TrainingCellView: UICollectionViewCell {
    static let id = "TrainingCellView"

    private let checkmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(R.Images.Overview.checkmarkNotDone, for: .normal)
        return button
    }()

    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 3
        return view
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvilticaRegular(with: 17)
        label.textColor = R.Colors.active
        return label
    }()

    private let subtitle: UILabel = {
        let label = UILabel()
        label.font = R.Fonts.helvilticaRegular(with: 13)
        label.textColor = R.Colors.inactive
        return label
    }()

    private let rightArrowView: UIImageView = {
        let imageView = UIImageView(image: R.Images.Overview.rightArrow)
        imageView.isHidden = true // Стрелка скрыта по умолчанию
        return imageView
    }()
    
    weak var delegate: TrainingCellViewDelegate?
    
    private var isEditingMode = false {
        didSet {
            rightArrowView.isHidden = !isEditingMode
        }
    }
    
    private var isDone = false {
        didSet {
            let image = isDone ? R.Images.Overview.checkmarkDone : R.Images.Overview.checkmarkNotDone
            checkmarkButton.setImage(image, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        constaintViews()
        configureAppearance()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        self.addGestureRecognizer(tapGesture)
        
        checkmarkButton.addTarget(self, action: #selector(checkmarkTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        super.init(frame: .zero)

        setupViews()
        constaintViews()
        configureAppearance()
    }
    
    @objc private func cellTapped() {
        if isEditingMode {
            delegate?.trainingCellViewDidTapEdit(self)
        }
    }
    
    @objc private func checkmarkTapped() {
        isDone.toggle()
        delegate?.trainingCellView(self, didChangeCheckmarkState: isDone)
    }
    
    func configure(with title: String, subtitle: String, isDone: Bool, roundedType: CellRoundedType, isEditingMode: Bool) {
        self.title.text = title
        self.subtitle.text = subtitle
        self.isDone = isDone
        self.isEditingMode = isEditingMode

        switch roundedType {
        case .all: self.roundCorners([.allCorners], radius: 5)
        case .bottom: self.roundCorners([.bottomLeft, .bottomRight], radius: 5)
        case .top: self.roundCorners([.topLeft, .topRight], radius: 5)
        case .notRounded: self.roundCorners([.allCorners], radius: 0)
        }
    }
}

private extension TrainingCellView {
    func setupViews() {
        setupView(checkmarkButton)
        setupView(stackView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        setupView(rightArrowView)
    }

    func constaintViews() {
        NSLayoutConstraint.activate([
            checkmarkButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            checkmarkButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 28),
            checkmarkButton.widthAnchor.constraint(equalTo: checkmarkButton.heightAnchor),

            stackView.leadingAnchor.constraint(equalTo: checkmarkButton.trailingAnchor, constant: 15),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: rightArrowView.leadingAnchor, constant: -15),

            rightArrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightArrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            rightArrowView.heightAnchor.constraint(equalToConstant: 12),
            rightArrowView.widthAnchor.constraint(equalToConstant: 7),
        ])
    }

    func configureAppearance() {
    }
}
