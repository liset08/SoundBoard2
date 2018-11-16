//
//  iniciarSesionViewController.swift
//  Snapchat
//
//  Created by Mac Tecsup on 24/10/18.
//  Copyright © 2018 Cayhualla. All rights reserved.
//

import UIKit
import Firebase



class iniciarSesionViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func iniciarSesionTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in print("Intentemos iniciar sesion")
            if error != nil{
                print("tenemos el siguiente error:\(error)")
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: {(user, error) in print("Intentemos crear un usuario")
                    if error != nil {
                        print("tenemos el siguiente error:\(error)")

                    }else{
                        print("El usuario fue creado exitosamente")
            FIRDatabase.database().reference().child("usuarios").child(user!.uid).child("email").setValue(user!.email)
            self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)

                    }
                     })
            }else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
           
    })
    

    }}

