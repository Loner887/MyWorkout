import UIKit

final class SessionController: BaseController {
    private let timerView = TimerView()
    private let statsView = StatsView(with: R.Strings.Session.workoutStats)
    private let stepsView = StepsView(with: R.Strings.Session.stepsCounter)

    private var timerDuration = 60.0
    
    private let setDurationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set Time", for: .normal)
        button.setTitleColor(R.Colors.active, for: .normal)
        button.backgroundColor = R.Colors.inactive
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(setTimerDuration), for: .touchUpInside)
        return button
    }()

    override func navBarLeftButtonHendler() {
        if timerView.state == .isStopped {
            timerView.startTimer()
        } else {
            timerView.pauseTimer()
        }

        timerView.state = timerView.state == .isRuning ? .isStopped : .isRuning
        addNavBarButton(
            at: .left,
            with: timerView.state == .isRuning
                ? R.Strings.Session.navBarPause : R.Strings.Session.navBarStart
        )
    }

    override func navBarRightButtonHendler() {
        timerView.stopTimer()
        timerView.state = .isStopped

        addNavBarButton(at: .left, with: R.Strings.Session.navBarStart)
    }

    @objc private func setTimerDuration() {
        let alertController = UIAlertController(title: "Set Timer Duration", message: "Enter the timer duration in seconds", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Enter duration"
            textField.keyboardType = .numberPad
        }
        
        let setAction = UIAlertAction(title: "Set", style: .default) { [weak self] _ in
            guard let self = self else { return }
            if let text = alertController.textFields?.first?.text, let duration = Double(text) {
                self.timerDuration = duration
                self.timerView.configure(with: self.timerDuration, progress: 0)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(setAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
extension SessionController {
    override func setupViews() {
        super.setupViews()

        view.setupView(timerView)
        view.setupView(setDurationButton)
        view.setupView(statsView)
        view.setupView(stepsView)
    }

    override func constraintViews() {
        super.constraintViews()

        NSLayoutConstraint.activate([
            timerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            timerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            timerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            setDurationButton.topAnchor.constraint(equalTo: timerView.bottomAnchor),
            setDurationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setDurationButton.heightAnchor.constraint(equalToConstant: 30),
            setDurationButton.widthAnchor.constraint(equalToConstant: 120),

            statsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            statsView.topAnchor.constraint(equalTo: setDurationButton.bottomAnchor, constant: 10),
            statsView.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -7.5),

            stepsView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 7.5),
            stepsView.topAnchor.constraint(equalTo: statsView.topAnchor),
            stepsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stepsView.heightAnchor.constraint(equalTo: statsView.heightAnchor),
        ])
    }

    override func configureAppearance() {
        super.configureAppearance()

        title = R.Strings.NavBar.session
        navigationController?.tabBarItem.title = R.Strings.TabBar.title(for: .session)

        addNavBarButton(at: .left, with: R.Strings.Session.navBarStart)
        addNavBarButton(at: .right, with: R.Strings.Session.navBarFinish)

        timerView.configure(with: timerDuration, progress: 0)

        statsView.configure(with: [.heartRate(value: "155"),
                                   .averagePace(value: "8'20''"),
                                   .totalSteps(value: "7,682"),
                                   .totalDistance(value: "8.25")])

        stepsView.configure(with: [.init(value: "8k", heightMultiplier: 1, title: "2/14"),
                                   .init(value: "7k", heightMultiplier: 0.8, title: "2/15"),
                                   .init(value: "5k", heightMultiplier: 0.6, title: "2/16"),
                                   .init(value: "6k", heightMultiplier: 0.3, title: "2/17")])
    }
}

