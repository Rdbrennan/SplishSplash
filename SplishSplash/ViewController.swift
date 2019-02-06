//
//  ViewController.swift
//  SplishSplash
//
//  Created by Robert Brennan on 2/6/19.
//  Copyright © 2019 Creatility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var splishColor = UIColor()
    var splashColor = UIColor()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(createSplish))
        view.addGestureRecognizer(tapGestRecognizer)
    }

    @objc func createSplish(){
        splishColor = UIColor.random()
        splashColor = splishColor
        let xCooridinate = CGFloat.random(in: view.frame.minX ..< view.frame.maxX)
        let yCooridinate = CGFloat.random(in: view.frame.minY ..< view.frame.maxY)
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: xCooridinate,y: yCooridinate), radius: CGFloat(105), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.opacity = 0.8
        shapeLayer.fillColor = splishColor.cgColor
        print(splashColor)

        view.layer.addSublayer(shapeLayer)
        createSplash()
    }
    func createSplash(){
        let xCooridinate = CGFloat.random(in: view.frame.minX ..< view.frame.maxX)
        let yCooridinate = CGFloat.random(in: view.frame.minY ..< view.frame.maxY)
        print(splishColor)

        let circlePath = UIBezierPath(arcCenter: CGPoint(x: xCooridinate - 5,y: yCooridinate - 5), radius: CGFloat(70), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = splishColor.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
