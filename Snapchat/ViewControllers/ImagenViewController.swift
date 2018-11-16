//
//  ImagenViewController.swift
//  Snapchat
//
//  Created by Mac Tecsup on 24/10/18.
//  Copyright © 2018 Cayhualla. All rights reserved.
//
import  UIKit
import FirebaseDatabase
import FirebaseStorage
import AVFoundation

class ImagenViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descripcionTextField: UITextField!
    @IBOutlet weak var elegirContactoBoton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioURL : URL?
    

    @IBOutlet weak var recordButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    var imagenId = NSUUID().uuidString
    var audioID = NSUUID().uuidString
    var URLaudio = ""

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        elegirContactoBoton.isEnabled = false
        setuupRecorder()
    }
    
    //audio
    func setuupRecorder(){
        do{
            //creando una sesion de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //creando una direccion para el archivo de audio
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath,"audio.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            print("*************************")
            print(audioURL)
            print("*************************")
            
            
            //Crear opciones para el grabador de audio
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            //Crear el objeto de grabacion de audio
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
            
        }catch
            let error as NSError{
                print(error)
        }    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = image
        imageView.backgroundColor = UIColor.clear
        elegirContactoBoton.isEnabled = true
        imagePicker.dismiss(animated: true, completion: nil)

    }
    
    /////7
    @IBAction func recordTapped(_ sender: Any) {
        
        if audioRecorder!.isRecording{
            //Detener la grabacion
            audioRecorder?.stop()
            //Cambiar el texto del boton grabar
            recordButton.setTitle("Record", for: .normal)
           
        }else{
            //empezar a grabar
            audioRecorder?.record()
            //cambiar el titulo del botn a detener
            recordButton.setTitle("Stop", for: .normal)
        }
    }
    /////
    
    
    
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
   var imagenDowloadURL = ""
   var audioDownloadURL = ""
    
    @IBAction func elegirContactoBoton(_ sender: Any) {
        
        
        let audiosFolder = FIRStorage.storage().reference().child("audios")
        let audioData = NSData(contentsOf: audioURL!)! as Data?
        //asignarle un nombre distinto a cada imagen
        audiosFolder.child("\(audioID).m4p").put(audioData!, metadata: nil, completion:{(metadata,error)in print("Intentando subir audio")
            if error != nil{
                print("ocurrio un error:\(error)")
            }else{
                print("Audio Subido correctamente")
                self.audioDownloadURL = (metadata?.downloadURL()?.absoluteString)!
                
                
            }
        })
        
        
        
        elegirContactoBoton.isEnabled = false
        let imagenesFolder = FIRStorage.storage().reference().child("imagenes")
        let imagenData = NSData(contentsOf: audioURL!)! as Data
        //asignarle un nombre distinto a cada imagen
        imagenesFolder.child("\(imagenId).jpg").put(imagenData, metadata: nil, completion:{(metadata,error)in print("Intentando subir la imagen")
            if error != nil{
                print("ocurrio un error:\(error)")
            }else{
                print("Subido correctamente")
                self.performSegue(withIdentifier: "seleccionarContactoSegue", sender: [self.imagenDowloadURL, self.audioDownloadURL])
                
                
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! ElegirUsuarioViewController
       siguienteVC.imagenURL = imagenDowloadURL as String
        siguienteVC.descrip = descripcionTextField.text!
        siguienteVC.imagenID = imagenId
        siguienteVC.URLaudio = audioDownloadURL as String
        
    }
}
