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
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    
    var currentPlace: Place?

    var imageWasChanged = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        saveButton.isEnabled = false
        
        nameField.addTarget(self,
                            action:  #selector(textFieldDidChange),
                            for: .editingChanged)
        
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1)) //hide line under tableView
        
        setupEditScreen()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cameraIcon = #imageLiteral(resourceName: "camera")
        let photoIcon = #imageLiteral(resourceName: "photo")

        if indexPath.row == 0 {
            let imageMenu = UIAlertController(title: nil,
                                              message: nil,
                                              preferredStyle: .actionSheet)
            
            
            let camera = UIAlertAction(title: "Camera", style: .default) {_ in
                self.chooseImagePicker(source: .camera)
            }
            
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
            let photoFromLibrary = UIAlertAction(title: "Photo Library", style: .default) {_ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            photoFromLibrary.setValue(photoIcon, forKey: "image")
            photoFromLibrary.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            imageMenu.addAction(camera)
            imageMenu.addAction(photoFromLibrary)
            imageMenu.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(imageMenu, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func setupEditScreen() {
        
        if currentPlace != nil { //when user taped on row
            
            imageWasChanged = true
            
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            
            imageOfPlace.image = image
            imageOfPlace.contentMode = .scaleAspectFill
            nameField.text = currentPlace?.name
            locationField.text = currentPlace?.location
            typeField.text = currentPlace?.type
            
            navigationItem.leftBarButtonItem = nil
            navigationItem.title = currentPlace?.name
            
            saveButton.isEnabled = true
            
        }
        
    }
    
    func savePlace() { //saving or editing to DB
        
        var image: UIImage
        
        if imageWasChanged { //setting a default image
            image = imageOfPlace.image!
        } else {
            image = #imageLiteral(resourceName: "imagePlaceholder")
        }
        
        let imageData = image.pngData() // convert to Data
        
        let newPlace = Place(name: nameField.text!,
                             location: locationField.text!,
                             type: typeField.text!,
                             imageData: imageData)
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
                
            }
        } else {
            StorageManager.saveNewPlace(newPlace)
        }
    }
}

extension NewPlaceTableVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { //hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if nameField.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
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
        imageWasChanged = true
        dismiss(animated: true)
    }
}
