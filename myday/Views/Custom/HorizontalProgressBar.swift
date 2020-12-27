//
//  HorizontalProgressBar.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import UIKit

@IBDesignable
class HorizontalProgressBar: UIView {
    // MARK: - Properties
    @IBInspectable var progressBarTintColor: UIColor = .systemGreen {
        didSet {
            tintColor = progressBarTintColor
            tintColorDidChange()
        }
    }
    
    @IBInspectable var progress: Float = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private let progressLayer = CALayer()
    private let backgroundLayer = CAShapeLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayers(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayers(frame: .zero)
    }
    
    override func draw(_ rect: CGRect) {
        backgroundLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).cgPath
        layer.mask = backgroundLayer

        let progressFrame = CGRect(origin: .zero, size: CGSize(width: rect.width * CGFloat(progress), height: rect.height))
        progressLayer.frame = progressFrame
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        progressLayer.backgroundColor = tintColor.cgColor
        backgroundColor = tintColor.withAlphaComponent(0.2)
    }
}

// MARK: - Private Functions
private extension HorizontalProgressBar {
    func configureLayers(frame: CGRect) {
        layer.addSublayer(progressLayer)
    }
}
