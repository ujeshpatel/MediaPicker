//
//  ViewController.swift
//  MediaPicker
//
//  Created by Ujesh Patel on 24/05/17.
//
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblURL: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    var mediaPickerhelper : MediaPickerHelper?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
}

extension ViewController {
    @IBAction func selectVideoAction(_ sender: Any) {
        //Init Picker Methods
        mediaPickerhelper = MediaPickerHelper(viewController: self, isForVideo : true, imageCallback: nil, videoCallback: {
            url in
            self.lblURL.text = "\(url!)"
        })
        
        // it's Optional
        mediaPickerhelper?.titleForActionSheet = "Select option for upload image"
        mediaPickerhelper?.titleForCameraButton = "From Camera"
        mediaPickerhelper?.titleForPhotosButton = "From Photos"
       
        //For Display action sheet
        mediaPickerhelper?.showPhotoSourceSelection()
    }
    
    @IBAction func selectImageAction(_ sender: Any) {
        //Init Picker Methods
        mediaPickerhelper = MediaPickerHelper(viewController: self, isForVideo : false, imageCallback: {
            image in
            self.imgView.image = image
        }, videoCallback: nil)
        
        // it's Optional
        mediaPickerhelper?.titleForActionSheet = "Select option for upload Video"
        mediaPickerhelper?.titleForCameraButton = "by Camera"
        mediaPickerhelper?.titleForPhotosButton = "by Photos"
        
        //For Display action sheet
        mediaPickerhelper?.showPhotoSourceSelection()
        
    }
}

