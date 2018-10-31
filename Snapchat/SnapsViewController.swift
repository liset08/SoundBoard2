//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Mac Tecsup on 24/10/18.
//  Copyright © 2018 Cayhualla. All rights reserved.
//

import  UIKit

class SnapsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cerrarSesionTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
