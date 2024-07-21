//
//  RainView.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 21.07.2024.
//

import UIKit

final class RainView: UIView {
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
    
    private var emitterLayer: CAEmitterLayer {
        return layer as! CAEmitterLayer
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupEmitter()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupEmitter()
    }
    
    private func setupEmitter() {
        emitterLayer.emitterShape = .line
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: 0)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: 1)
        emitterLayer.emitterCells = [createRainCell()]
    }
    
    private func createRainCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(systemName: "drop.fill")?.cgImage
        cell.birthRate = 150
        cell.lifetime = 4.0
        cell.velocity = 200
        cell.velocityRange = 50
        cell.yAcceleration = 300
        cell.emissionRange = .pi / 6
        cell.scale = 0.05
        cell.scaleRange = 0.02
        cell.alphaSpeed = -0.1
        return cell
    }
}
