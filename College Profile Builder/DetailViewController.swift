//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Sam Burrell on 2/6/17.
//  Copyright © 2017 Sam Burrell. All rights reserved.
//

import UIKit
import RealmSwift
import SafariServices
import CoreLocation

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var numberOfStudentsTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var websiteTextField: UITextField!
    let imagePicker = UIImagePickerController()
    let realm = try! Realm()
   
    var detailItem: College? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item
        if let college = self.detailItem {
            if  nameTextField != nil {
                nameTextField.text = college.name
                locationTextField.text = college.location
                numberOfStudentsTextField.text = String(college.numberOfStudents)
                websiteTextField.text = college.website
                imageView.image = UIImage(data: college.image)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dvc = segue.destination as! MapViewController
        if segue.identifier == "ShowMapSegue" {
        dvc.locationText = "\(locationTextField.text!)"
        }
    }
    @IBAction func onTappedGoButton(_ sender: UIButton) {
        let urlString = websiteTextField.text!
        let url = URL(string: urlString)
        let svc = SFSafariViewController(url: url!)
        present(svc, animated: true, completion: nil)
        
    }
    
    @IBAction func onPhotoButtonTapped(_ sender: UIButton) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onSaveButtonTapped(_ sender: UIButton) {
        if let college = self.detailItem {
            try! realm.write({
                college.name = nameTextField.text!
                college.location = locationTextField.text!
                college.numberOfStudents = Int(numberOfStudentsTextField.text!)!
                college.website = websiteTextField.text!
                college.image = UIImagePNGRepresentation(imageView.image!)!
            })
            
        }
    }
    
}
