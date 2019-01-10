//
//  UploadViewController.swift
//  GoldenHour
//
//  Created by Zach Bachar on 07/01/2019.
//  Copyright © 2019 Zach Bachar. All rights reserved.
//

import UIKit
import Photos

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    let imagePicker = UIImagePickerController()
    var permissions:Permissions?
    
    var x = 0
    var selctedImage: UIImage?
    var data:PhotosStaticData = PhotosStaticData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        permissions = Permissions(target: self, imagePicker: imagePicker)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        
        userImageView.contentMode = .scaleAspectFit
        userImageView.image = image
        self.selctedImage = image
        selectBtn.isHidden = true
        userImageView.isHidden = false
    }

    @IBAction func editImagePressed(_ sender: Any) {
        selectBtnPressed(sender)
    }
    
    @IBAction func selectBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.permissions?.checkPermissionCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.permissions?.checkPermissionGallery()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //addInfo segue
        let vc = segue.destination as! AddPostInfoViewController
        if let img = selctedImage{
            vc.userImage = img
        }
     }
    
    
}