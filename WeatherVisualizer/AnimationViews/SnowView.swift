//
//  SnowView.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 21.07.2024.
//

import UIKit

final class SnowView: UIView {

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
        emitterLayer.emitterCells = [createSnowflakeCell()]
    }

    private func createSnowflakeCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        if let image = UIImage(systemName: "snowflake")?.cgImage {
            cell.contents = image
        }
        cell.birthRate = 20
        cell.lifetime = 7.0
        cell.velocity = 30
        cell.velocityRange = 20
        cell.yAcceleration = 30
        cell.emissionRange = .pi
        cell.spin = 0.5
        cell.spinRange = 1.0
        cell.scale = 0.05
        cell.scaleRange = 0.1
        return cell
    }
}
