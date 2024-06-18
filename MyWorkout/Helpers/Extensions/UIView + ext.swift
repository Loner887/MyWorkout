import UIKit

extension UIView {
    @objc func setupView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))

        let borderLayer = CAShapeLayer()
        borderLayer.frame = bounds
        borderLayer.path = path.cgPath
        borderLayer.strokeColor = R.Colors.inactive.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.lineWidth = 1
        layer.addSublayer(borderLayer)
    }
}
