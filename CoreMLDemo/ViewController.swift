//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by Adarsha Upadhya on 27/12/18.
//  Copyright © 2018 Adarsha Upadhya. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var mlImageView: UIImageView!
    let pickerController:UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerController.delegate = self
        pickerController.sourceType = .camera
        pickerController.allowsEditing = true
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    self.present(pickerController, animated: true, completion: nil)
        
    }
    
}


extension ViewController{
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            mlImageView.image = image
            
            guard let ciimage = CIImage(image: image) else{
                fatalError("Unaable to convert to ciimage")
            }
            self.detect(image: ciimage)
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func detect(image:CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Unable to initialize model")
        }
        
       let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let result = request.results as? [VNClassificationObservation] else{
                fatalError("classification type cast errot")
            }
        if let firstResult = result.first{
            
            if firstResult.identifier.contains("hotdog"){
                self.navigationItem.title = "Hot Dog"
            }else{
                self.navigationItem.title = "Not Hot Dog"
            }
            
        }
        }
        
        let hadler = VNImageRequestHandler(ciImage:image)
        do{
           try hadler.perform([request])
        }catch{
            fatalError("Didin't get ant resonse")
        }
    }
    
}

