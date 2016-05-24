//
//  GraphView.swift
//  Calculator
//
//  Created by Cesar Ibarra on 5/23/16.
//  Copyright © 2016 Cesar Ibarra. All rights reserved.
//

import UIKit

@IBDesignable
class GraphView: UIView {
    
    @IBInspectable
    private var scale: CGFloat = 1.0 { didSet{ setNeedsDisplay() } }
    
    private var axis =  AxesDrawer(color: UIColor.blackColor(), contentScaleFactor: 1.0)
    
    override func drawRect(rect: CGRect) {
        axis.minimumPointsPerHashmark = 30
        let origin = CGPoint(x: bounds.midX, y: bounds.midY)
        axis.drawAxesInRect(rect, origin: origin, pointsPerUnit: 1.0)
    }
    
    func changeScale(recognizer: UIPinchGestureRecognizer) {
        print("pinched")
        switch recognizer.state {
        case .Ended, .Changed:
            scale *= recognizer.scale
            recognizer.scale = 1.0
        default:
            break
        }
    }
    
    //TODOSOON
    func moveAxis(recoginzer: UIPanGestureRecognizer) {
        print("panned")
    }
    
    //TODO
    func setOrigin(recognizer: UITapGestureRecognizer) {
        print("tapped")
    }
}
