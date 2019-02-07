//
//  ViewController.swift
//  SplishSplash
//
//  Created by Robert Brennan on 2/6/19.
//  Copyright © 2019 Creatility. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //Variables Model
    let model = SplishSplashModel.self

    override func viewDidLoad() {
        super.viewDidLoad()
        //Interaction Listener
        let tapGestRecognizer = UITapGestureRecognizer(target: self, action: #selector(createSplish))
        view.addGestureRecognizer(tapGestRecognizer)
    }
    
    //Save Tap Location
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self.view)
        model.touchPoint = location
    }
    
    ///MARK: FUNCTIONS
    
    //Initiate Splish Circle
    @objc func createSplish(){
        model.splishColor = UIColor.random()
        model.splashColor = model.splishColor
        model.finalRadius = CGFloat.random(in: 60 ..< 150)

        let circlePath = UIBezierPath(arcCenter: CGPoint(x:model.touchPoint.x,y: model.touchPoint.y), radius: model.finalRadius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.bounds = circlePath.bounds
        shapeLayer.fillColor = model.splishColor.cgColor
        shapeLayer.opacity = 0.8
        shapeLayer.frame.origin = CGPoint(x: model.touchPoint.x - model.finalRadius, y: model.touchPoint.y - model.finalRadius)
        
        view.layer.addSublayer(shapeLayer)

        //Scale Animation
        model.scale.fromValue = 0
        model.scale.toValue = 1
        model.scale.duration = 0.2
        model.scale.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        model.scale.fillMode = CAMediaTimingFillMode.forwards
        model.scale.isRemovedOnCompletion = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
        self.createSplash()
        }
        
        //Fade Animation
        model.fade.keyPath = "opacity"
        model.fade.byValue = -1
        model.fade.duration = 0.5
        model.fade.isRemovedOnCompletion = true
        model.fade.fillMode = CAMediaTimingFillMode.forwards
        
        //Scale Animation
        shapeLayer.add(model.scale, forKey: "transform.scale")

        //Fade Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
            CATransaction.begin()
            CATransaction.setCompletionBlock({
                //Remove Splish Circle from View
                shapeLayer.isHidden = true
                shapeLayer.removeFromSuperlayer()
            })
            shapeLayer.add(self.model.fade, forKey: "opacity")
            CATransaction.commit()
        }
    }
    
    //Initiate Splash Circle
    @objc func createSplash(){
        let smallerRadius = CGFloat.random(in: 0.2 ... 0.4)     //Circles  20% - 40% smaller
        let numofCircles = CGFloat.random(in: 2 ... 6)          //Between 2 - 5 Circles (Exclusion)
        let num = Int(numofCircles)
        
        //Loop and randomize # of circles & position of circles
        print("-----------------------------")
        for _ in 0...num{
            var CenterOffsetX = CGFloat()
            var CenterOffsetY = CGFloat()

            let random = Int.random(in: 1 ... 4)
            switch (random) {
            case 1:
                //X: Positive, Y: Positive
                CenterOffsetX = CGFloat.random(in: 60 ... 100)
                CenterOffsetY = CGFloat.random(in: 60 ... 100)
            case 2:
                //X: Positive, Y: Negative
                CenterOffsetX = CGFloat.random(in: 60 ... 100)
                CenterOffsetY = CGFloat.random(in: -100 ... -60)
            case 3:
                //X: Negative, Y: Positive
                CenterOffsetX = CGFloat.random(in: -100 ... -60)
                CenterOffsetY = CGFloat.random(in: 60 ... 100)
            case 4:
                //X: Negative, Y: Negative
                CenterOffsetX = CGFloat.random(in: -100 ... -60)
                CenterOffsetY = CGFloat.random(in: -100 ... -60)
            default:
                print("nil")
            }
            let circlePath = UIBezierPath(arcCenter: CGPoint(x: model.touchPoint.x + CenterOffsetX,y: model.touchPoint.y + CenterOffsetY), radius: model.finalRadius - (model.finalRadius * smallerRadius), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
            
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = circlePath.cgPath
            shapeLayer.bounds = circlePath.bounds
            shapeLayer.fillColor = model.splishColor.cgColor
            shapeLayer.opacity = 0.8
            shapeLayer.frame.origin = CGPoint(x: (model.touchPoint.x - model.finalRadius) + CenterOffsetX, y: (model.touchPoint.y - model.finalRadius) + CenterOffsetY)

            view.layer.addSublayer(shapeLayer)
            
            //Scale Animation
            shapeLayer.add(model.scale, forKey: "transform.scale")
            
            //Fade with Delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                CATransaction.begin()
                CATransaction.setCompletionBlock({
                    //Remove Splish Circle from View
                    shapeLayer.isHidden = true
                    shapeLayer.removeFromSuperlayer()
                })
                shapeLayer.add(self.model.fade, forKey: "fade")
                CATransaction.commit()
            }
        }
        print("Number of splashes is: ", num)
        print("-----------------------------")
    }
}
