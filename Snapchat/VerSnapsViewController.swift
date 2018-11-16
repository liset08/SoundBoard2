//
//  VerSnapsViewController.swift
//  Snapchat
//
//  Created by Mac Tecsup on 7/11/18.
//  Copyright © 2018 Cayhualla. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class VerSnapsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    var snap = Snap()

    
    override func viewDidLoad() {
        super.viewDidLoad()
label.text? = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imagenURL))
        
        
    }
    //eliminar un registro de la base de datos
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference().child("usuarios").child((FIRAuth.auth()?.currentUser!.uid)!).child("snaps").child(snap.id).removeValue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
