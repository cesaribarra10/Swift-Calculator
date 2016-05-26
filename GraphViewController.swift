//
//  GraphViewController.swift
//  Calculator
//
//  Created by Cesar Ibarra on 5/23/16.
//  Copyright © 2016 Cesar Ibarra. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    @IBOutlet weak var graphView: GraphView! {
        didSet {
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: #selector(GraphView.changeScale(_:))))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: #selector(GraphView.moveAxis(_:))))
            let tap = UITapGestureRecognizer(target: graphView, action: #selector(GraphView.setOrigin(_:)))
            tap.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tap)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
}
