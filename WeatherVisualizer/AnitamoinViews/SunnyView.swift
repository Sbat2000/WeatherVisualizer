//
//  SunnyView.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 21.07.2024.
//


import UIKit

final class SunnyView: UIView {
    
    private var sunLayer: CALayer!
    private var haloLayer: CAGradientLayer!
    private var raysLayer: CALayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSunLayer()
        setupHaloLayer()
        setupRaysLayer()
        addHaloPulsation()
        addRaysAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupSunLayer() {
        sunLayer = CALayer()
        let sunSize: CGFloat = 120
        sunLayer.frame = CGRect(x: bounds.midX - sunSize / 2, y: bounds.midY - sunSize / 2, width: sunSize, height: sunSize)
        sunLayer.cornerRadius = sunSize / 2
        sunLayer.backgroundColor = UIColor.yellow.cgColor
        sunLayer.shadowColor = UIColor.yellow.withAlphaComponent(0.6).cgColor
        sunLayer.shadowOffset = CGSize(width: 0, height: 0)
        sunLayer.shadowOpacity = 1
        sunLayer.shadowRadius = sunSize / 2
        layer.addSublayer(sunLayer)
    }
    
    private func setupHaloLayer() {
        haloLayer = CAGradientLayer()
        haloLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.yellow.withAlphaComponent(0.5).cgColor
        ]
        haloLayer.locations = [0.0, 1.0]
        haloLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        haloLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        haloLayer.frame = CGRect(x: sunLayer.frame.minX - 30, y: sunLayer.frame.minY - 30, width: sunLayer.bounds.width + 60, height: sunLayer.bounds.height + 60)
        haloLayer.cornerRadius = haloLayer.bounds.width / 2
        haloLayer.type = .radial
        layer.insertSublayer(haloLayer, below: sunLayer)
    }
    
    private func setupRaysLayer() {
        raysLayer = CALayer()
        raysLayer.frame = bounds
        raysLayer.backgroundColor = UIColor.clear.cgColor
        layer.addSublayer(raysLayer)
    }
    
    private func addRaysAnimation() {
        for i in 0..<12 {
            let ray = CALayer()
            let rayWidth: CGFloat = 2
            let rayLength: CGFloat = 100
            ray.frame = CGRect(x: bounds.midX - rayWidth / 2, y: bounds.midY - rayLength / 2, width: rayWidth, height: rayLength)
            ray.backgroundColor = UIColor.yellow.withAlphaComponent(0.5).cgColor
            ray.anchorPoint = CGPoint(x: 0.5, y: 1.0)
            ray.position = CGPoint(x: bounds.midX, y: bounds.midY)
            ray.transform = CATransform3DMakeRotation(CGFloat(i) * .pi / 6, 0, 0, 1)
            raysLayer.addSublayer(ray)
            
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0.5
            animation.toValue = 1.0
            animation.duration = 1.0
            animation.autoreverses = true
            animation.repeatCount = .infinity
            animation.beginTime = CACurrentMediaTime() + Double(i) * 0.1
            ray.add(animation, forKey: "opacityAnimation")
        }
    }
    
    private func addHaloPulsation() {
        let pulsation = CABasicAnimation(keyPath: "transform.scale")
        pulsation.fromValue = 1.0
        pulsation.toValue = 1.2
        pulsation.duration = 2.0
        pulsation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pulsation.autoreverses = true
        pulsation.repeatCount = .infinity
        haloLayer.add(pulsation, forKey: "pulsation")
    }
}
