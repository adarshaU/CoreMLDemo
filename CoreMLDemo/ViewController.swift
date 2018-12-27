//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by Adarsha Upadhya on 27/12/18.
//  Copyright © 2018 Adarsha Upadhya. All rights reserved.
//

import UIKit

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
            
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

