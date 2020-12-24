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
    @IBInspectable var viewBackgroundColor: UIColor = .clear {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var progressBarBackgroundColor: UIColor = .lightGray {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var progressBarTintColor: UIColor = .systemGreen {
        didSet { setNeedsDisplay() }
    }
    
    @IBInspectable var progress: Float = 0 {
        didSet { setNeedsDisplay() }
    }
    
    private let progressLayer = CALayer()
    private let backgroundLayer = CAShapeLayer()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    override func draw(_ rect: CGRect) {
        backgroundLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).cgPath
        layer.mask = backgroundLayer

        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * CGFloat(progress), height: rect.height))
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = progressBarTintColor.cgColor
    }
}

// MARK: - Private Functions
private extension HorizontalProgressBar {
    func setupLayers() {
        backgroundColor = progressBarTintColor.withAlphaComponent(0.2)
        layer.addSublayer(progressLayer)
    }
}
