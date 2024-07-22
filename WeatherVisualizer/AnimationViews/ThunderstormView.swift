//
//  ThunderstormView.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 21.07.2024.
//

import UIKit

final class ThunderstormView: UIView {
    
    private var rainLayer: CAEmitterLayer!
    private var lightningLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRainEmitter()
        setupLightningLayer()
        startLightningAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupRainEmitter()
        setupLightningLayer()
        startLightningAnimation()
    }
    
    private func setupRainEmitter() {
        rainLayer = CAEmitterLayer()
        rainLayer.emitterShape = .line
        rainLayer.emitterPosition = CGPoint(x: bounds.midX, y: -10)
        rainLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        
        let rainCell = CAEmitterCell()
        rainCell.contents = UIImage(systemName: "drop.fill")?.cgImage
        rainCell.birthRate = 150
        rainCell.lifetime = 5.0
        rainCell.velocity = 400
        rainCell.velocityRange = 100
        rainCell.yAcceleration = 600
        rainCell.scale = 0.1
        rainCell.scaleRange = 0.05
        rainCell.emissionRange = .pi / 4
        
        rainLayer.emitterCells = [rainCell]
        layer.addSublayer(rainLayer)
    }
    
    private func setupLightningLayer() {
        lightningLayer = CALayer()
        lightningLayer.frame = bounds
        lightningLayer.backgroundColor = UIColor.white.cgColor
        lightningLayer.opacity = 0.0
        layer.addSublayer(lightningLayer)
    }
    
    private func startLightningAnimation() {
        let flashAnimation = CAKeyframeAnimation(keyPath: "opacity")
        flashAnimation.values = [0.0, 1.0, 0.0]
        flashAnimation.keyTimes = [0, 0.1, 0.2]
        flashAnimation.duration = 0.2
        flashAnimation.timingFunctions = [CAMediaTimingFunction(name: .easeInEaseOut)]
        flashAnimation.repeatCount = Float.infinity
        flashAnimation.autoreverses = true
        flashAnimation.beginTime = CACurrentMediaTime() + Double.random(in: 1...5)
        
        lightningLayer.add(flashAnimation, forKey: "flashAnimation")
    }
}
