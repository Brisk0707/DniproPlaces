//
//  NewPlaceTableVC.swift
//  MyPlaces
//
//  Created by Борис Крисько on 9/25/19.
//  Copyright © 2019 Borys Krisko. All rights reserved.
//

import UIKit

class NewPlaceTableVC: UITableViewController {
    @IBOutlet weak var imageOfPlace: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() //hide line under tableView
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imageMenu = UIAlertController(title: nil,
                                              message: nil,
                                              preferredStyle: .actionSheet)
            
            
            let camera = UIAlertAction(title: "Camera", style: .default) {_ in
                self.chooseImagePicker(source: .camera)
            }
            
            let photoFromLibrary = UIAlertAction(title: "Photo Library", style: .default) {_ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            imageMenu.addAction(camera)
            imageMenu.addAction(photoFromLibrary)
            imageMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(imageMenu, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
}

extension NewPlaceTableVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
}

extension NewPlaceTableVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageOfPlace.image = info[.editedImage] as? UIImage
        imageOfPlace.contentMode = .scaleAspectFill
        imageOfPlace.clipsToBounds = true
        dismiss(animated: true)
    }
}
