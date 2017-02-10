//
//  DetailViewController.swift
//  College Profile Builder
//
//  Created by Sam Burrell on 2/6/17.
//  Copyright © 2017 Sam Burrell. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var numberOfStudentsTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
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
                imageView.image = UIImage(data: college.image)
            }
        }
    }
    @IBAction func onSaveButtonTapped(_ sender: UIButton) {
        if let college = self.detailItem {
            try! realm.write({
                college.name = nameTextField.text!
                college.location = locationTextField.text!
                college.numberOfStudents = Int(numberOfStudentsTextField.text!)!
                college.image = UIImagePNGRepresentation(imageView.image!)!
            })
            
        }
    }
    
}
