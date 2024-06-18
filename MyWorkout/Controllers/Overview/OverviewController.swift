import UIKit

struct TraningData {
    struct Data {
        var title: String
        var subtitle: String
        var isDone: Bool
    }

    let date: Date
    var items: [Data]
}

class OverviewController: BaseController {

    private let navBar = OverviewNavBar()
    
    private var isEditingMode = false {
        didSet {
            collectionView.reloadData()
            updateNavBar()
        }
    }

    private var dataSource: [TraningData] = []

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .clear
        
        return view
    }()
}

extension OverviewController {
    override func setupViews() {
        super.setupViews()

        view.setupView(navBar)
        view.setupView(collectionView)
        
        let editAction = #selector(editButtonTapped)
        navBar.editEditingAction(editAction, with: self)
        
        let addAction = #selector(addButtonTapped)
        navBar.addAdditingAction(addAction, with: self)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            navBar.topAnchor.constraint(equalTo: view.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()
        
        navigationController?.navigationBar.isHidden = true

        collectionView.register(TrainingCellView.self, forCellWithReuseIdentifier: TrainingCellView.id)
        collectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.id)

        collectionView.delegate = self
        collectionView.dataSource = self

        dataSource = [
            .init(date: Date(), items: [
                .init(title: "Warm Up Cardio", subtitle: "Stair Climber • 10 minutes", isDone: true),
                .init(title: "High Intensity Cardio", subtitle: "Treadmill • 50 minutes", isDone: true),
            ]),
        ]
        collectionView.reloadData()
    }
    
    private func updateNavBar() {
        let buttonTitle = isEditingMode ? "Cancel" : "Edit"
        navBar.setEditButtonTitle(buttonTitle)
    }
    
    @objc private func addButtonTapped() {
        let alertController = UIAlertController(title: "New Exercise", message: "Enter exercise details", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        alertController.addTextField { textField in
            textField.placeholder = "Subtitle"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let title = alertController.textFields?[0].text,
                  let subtitle = alertController.textFields?[1].text,
                  !title.isEmpty, !subtitle.isEmpty else { return }
            
            let newExercise = TraningData.Data(title: title, subtitle: subtitle, isDone: false)
            self?.dataSource[0].items.append(newExercise)
            self?.collectionView.reloadData()
        }
        alertController.addAction(addAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func editButtonTapped() {
        isEditingMode.toggle()
    }
}

// MARK: - UICollectionViewDataSource
extension OverviewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource[section].items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrainingCellView.id, for: indexPath) as? TrainingCellView else { return UICollectionViewCell() }

        let item = dataSource[indexPath.section].items[indexPath.row]

        let roundedType: CellRoundedType
        if indexPath.row == 0 && indexPath.row == dataSource[indexPath.section].items.count - 1 {
            roundedType = .all
        } else if indexPath.row == 0 {
            roundedType = .top
        } else if indexPath.row == dataSource[indexPath.section].items.count - 1 {
            roundedType = .bottom
        } else {
            roundedType = .notRounded
        }

        cell.configure(with: item.title, subtitle: item.subtitle, isDone: item.isDone, roundedType: roundedType, isEditingMode: isEditingMode)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.id, for: indexPath) as? SectionHeaderView else {
            return UICollectionReusableView()
        }

        view.configure(with: dataSource[indexPath.section].date)
        return view
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OverviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 70)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 32)
    }
}

// MARK: - TrainingCellViewDelegate
extension OverviewController: TrainingCellViewDelegate {
    func trainingCellViewDidTapEdit(_ cell: TrainingCellView) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let item = dataSource[indexPath.section].items[indexPath.row]
        
        let alertController = UIAlertController(title: "Edit Exercise", message: "Update exercise details", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = item.title
        }
        alertController.addTextField { textField in
            textField.text = item.subtitle
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { [weak self] _ in
            guard let title = alertController.textFields?[0].text,
                  let subtitle = alertController.textFields?[1].text,
                  !title.isEmpty, !subtitle.isEmpty else { return }
            
            self?.dataSource[indexPath.section].items[indexPath.row].title = title
            self?.dataSource[indexPath.section].items[indexPath.row].subtitle = subtitle
            self?.collectionView.reloadItems(at: [indexPath])
        }
        alertController.addAction(updateAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func trainingCellView(_ cell: TrainingCellView, didChangeCheckmarkState isDone: Bool) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        dataSource[indexPath.section].items[indexPath.row].isDone = isDone
        collectionView.reloadItems(at: [indexPath])
    }
}
