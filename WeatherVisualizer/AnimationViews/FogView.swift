//
//  FogView.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 21.07.2024.
//

import UIKit

final class FogView: UIView {

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

    override func layoutSubviews() {
        super.layoutSubviews()
        updateEmitterLayer()
    }

    private func setupEmitter() {
        emitterLayer.emitterShape = .rectangle
        emitterLayer.emitterCells = [createFogCell()]
        updateEmitterLayer()
    }

    private func updateEmitterLayer() {
        emitterLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        emitterLayer.emitterSize = CGSize(width: bounds.size.width, height: bounds.size.height)
    }

    private func createFogCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 2
        cell.lifetime = 20.0
        cell.velocity = 10
        cell.velocityRange = 10
        cell.yAcceleration = -5
        cell.xAcceleration = 5
        cell.emissionRange = .pi * 2
        cell.scale = 0.6
        cell.scaleRange = 0.3
        cell.alphaSpeed = -0.02
        cell.color = UIColor(white: 1.0, alpha: 0.3).cgColor

        cell.contents = createParticleImage()?.cgImage
        return cell
    }

    private func createParticleImage() -> UIImage? {
        let size = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let colors = [UIColor(white: 1.0, alpha: 0.0).cgColor,
                      UIColor(white: 1.0, alpha: 0.4).cgColor] as CFArray
        guard let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: [0, 1]) else { return nil }

        context.drawRadialGradient(
            gradient,
            startCenter: CGPoint(x: size.width / 2,y: size.height / 2),
            startRadius: 0,
            endCenter: CGPoint(x: size.width / 2,y: size.height / 2),
            endRadius: size.width / 2,
            options: [])
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
