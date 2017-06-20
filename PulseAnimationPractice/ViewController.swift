//
//  ViewController.swift
//  PulseAnimationPractice
//
//  Created by Allied Infosoft on 20/06/17.
//  Copyright © 2017 Allied Infosoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let image : UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.image = #imageLiteral(resourceName: "omg")
        i.layer.cornerRadius = 25
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        i.isUserInteractionEnabled = true
        return i
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(image)
        
        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: 50).isActive = true
        image.widthAnchor.constraint(equalToConstant: 50).isActive = true
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func tapped(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 44, Position: image.center)
//        pulse.animationDuration = 0.8
        self.view.layer.insertSublayer(pulse, below: image.layer)
    }

}

