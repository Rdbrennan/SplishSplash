//
//  Model.swift
//  SplishSplash
//
//  Created by Robert Brennan on 2/7/19.
//  Copyright © 2019 Creatility. All rights reserved.
//

import Foundation
import UIKit

//Variable Declaration
public class SplishSplashModel {
    static var splishColor = UIColor()
    static var splashColor = UIColor()
    static var xCooridinate = CGFloat()
    static var yCooridinate = CGFloat()
    static var touchPoint = CGPoint()
    static var finalRadius = CGFloat()
    static var scale = CABasicAnimation(keyPath: "transform.scale")
    static var fade = CABasicAnimation(keyPath: "opacity")
    static var CenterOffsetX = CGFloat()
    static var CenterOffsetY = CGFloat()
}
