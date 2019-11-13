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
    @IBOutlet weak var ratingControl: RaitingControl!
    @IBOutlet weak var typeTextField: UITextField!
    
    var currentPlace: Place!

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
            typeTextField.text = currentPlace?.type
            ratingControl.rating = Int(currentPlace.rating)
            
            navigationItem.leftBarButtonItem = nil
            navigationItem.title = currentPlace?.name
            
            saveButton.isEnabled = true
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard
            let identifier = segue.identifier,
            let mapVC = segue.destination as? MapViewController
            else {return}
        
        mapVC.incomeSegueIdentifier = identifier
        mapVC.mapViewControllerDelegate = self
        
        
        if identifier == "showPlace" {
            mapVC.place.name = nameField.text!
            mapVC.place.type = typeTextField.text!
            mapVC.place.location = locationField.text!
            mapVC.place.imageData = imageOfPlace.image?.pngData()
        }
        
    
    }
    
    func savePlace() { //saving or editing to DB
        
        let image = imageWasChanged ? imageOfPlace.image : #imageLiteral(resourceName: "imagePlaceholder")
        
        let imageData = image?.pngData() // convert to Data
        
        let newPlace = Place(name: nameField.text!,
                             location: locationField.text!,
                             type: typeTextField.text!,
                             imageData: imageData,
                             rating: Double(ratingControl.rating))
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
                currentPlace?.rating = newPlace.rating
                
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

extension NewPlaceTableVC: MapViewContorllerDelegate {
    func getAdress(_ address: String?) {
        locationField.text = address
    }
}
