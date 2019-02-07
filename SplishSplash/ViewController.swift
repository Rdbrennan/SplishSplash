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
    var xCooridinate = CGFloat()
    var yCooridinate = CGFloat()
    var touchPoint = CGPoint()
    var finalRadius = CGFloat()
    let scaleX = CABasicAnimation(keyPath: "transform.scale")
    let fade = CABasicAnimation(keyPath: "opacity")


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(createSplish))
        view.addGestureRecognizer(tapGestRecognizer)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        touchPoint = location
    }
    

    @objc func createSplish(){
        print(touchPoint)
        
        splishColor = UIColor.random()
        splashColor = splishColor
        finalRadius = CGFloat.random(in: 60 ..< 150)

        let circlePath = UIBezierPath(arcCenter: CGPoint(x:touchPoint.x,y: touchPoint.y), radius: finalRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.bounds = circlePath.bounds
        shapeLayer.fillColor = splishColor.cgColor
        shapeLayer.opacity = 0.8
        shapeLayer.frame.origin = CGPoint(x: touchPoint.x - finalRadius, y: touchPoint.y - finalRadius)
        
        //Animate Circle
        view.layer.addSublayer(shapeLayer)

        //Scale Animation
        scaleX.fromValue = 0
        scaleX.toValue = 1
        scaleX.duration = 0.2
        scaleX.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        scaleX.fillMode = CAMediaTimingFillMode.forwards
        scaleX.isRemovedOnCompletion = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
        self.createSplash()
        }
        
        //Fade Animation
        fade.keyPath = "opacity"
        fade.byValue = -1
        fade.duration = 0.5
        fade.isRemovedOnCompletion = true
        fade.fillMode = CAMediaTimingFillMode.forwards

        print(finalRadius)
        
        shapeLayer.add(scaleX, forKey: "transform.scale")

        //Remove Splish Circle
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                shapeLayer.isHidden = true
                shapeLayer.removeFromSuperlayer()
            })
            shapeLayer.add(self.fade, forKey: "opacity")
            
            CATransaction.commit()
        }

    }
    @objc func createSplash(){
        let smallerRadius = CGFloat.random(in: 0.2 ... 0.4)
        let numofCircles = CGFloat.random(in: 2 ... 6)
        let num = Int(numofCircles)
        
        print("-----------------------------")
        print("Set:")
        for _ in 1...num{
            var CenterOffsetX = CGFloat()
            var CenterOffsetY = CGFloat()

            let random = Int.random(in: 1 ... 4)
            switch (random) {
            case 1:
                //X: Positive, Y: Positive
                CenterOffsetX = CGFloat.random(in: 60 ... 101)
                CenterOffsetY = CGFloat.random(in: 60 ... 101)
            case 2:
                //X: Positive, Y: Negative
                CenterOffsetX = CGFloat.random(in: 60 ... 101)
                CenterOffsetY = CGFloat.random(in: -101 ... -60)
            case 3:
                //X: Negative, Y: Positive
                CenterOffsetX = CGFloat.random(in: -101 ... -60)
                CenterOffsetY = CGFloat.random(in: 60 ... 101)
            case 4:
                //X: Negative, Y: Negative
                CenterOffsetX = CGFloat.random(in: -101 ... -60)
                CenterOffsetY = CGFloat.random(in: -101 ... -60)
            default:
                print("nil")
            }
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: touchPoint.x + CenterOffsetX,y: touchPoint.y + CenterOffsetY), radius: finalRadius - (finalRadius * smallerRadius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.bounds = circlePath.bounds
            shapeLayer.fillColor = splishColor.cgColor
            shapeLayer.opacity = 0.8
            shapeLayer.frame.origin = CGPoint(x: (touchPoint.x - finalRadius) + CenterOffsetX, y: (touchPoint.y - finalRadius) + CenterOffsetY)
            print(CenterOffsetX)
            print(CenterOffsetY)

            view.layer.addSublayer(shapeLayer)
            
            
            shapeLayer.add(scaleX, forKey: "transform.scale")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                CATransaction.begin()
                CATransaction.setCompletionBlock({
                    shapeLayer.isHidden = true
                    shapeLayer.removeFromSuperlayer()
                })
                shapeLayer.add(self.fade, forKey: "fade")
                CATransaction.commit()
            }
        }
        
        print("Number printed is: ", num)
        print("-----------------------------")
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
