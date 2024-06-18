import UIKit

final class NavBarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = R.Colors.backbar
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: R.Colors.titleWhite,
            .font: R.Fonts.helvilticaRegular(with: 22)
        ]
    }
}
