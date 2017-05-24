//
//  MediaPickerHelper.swift
//  MediaPicker
//
//  Created by Ujesh Patel on 24/05/17.
//

import Foundation
import UIKit
import MobileCoreServices

typealias MediaPickerHelperCallback<inputType> = ((inputType?) -> Void)

class MediaPickerHelper: NSObject {
    
    var controller:UIViewController!
    var callbackForImage: MediaPickerHelperCallback<UIImage>?
    var callbackForVideo: MediaPickerHelperCallback<NSURL>?
    var isForVideo : Bool
    
    
    var titleForActionSheet : String?
    var titleForCameraButton : String?
    var titleForPhotosButton : String?
    
    init(viewController:UIViewController ,isForVideo : Bool, imageCallback: MediaPickerHelperCallback<UIImage>?, videoCallback: MediaPickerHelperCallback<NSURL>?) {
        
        self.controller = viewController
        
        self.callbackForVideo = videoCallback
        self.callbackForImage = imageCallback
        self.isForVideo = isForVideo
        super.init()
    }
    
    func showPhotoSourceSelection() {
        let actionSheet = UIAlertController(title: nil, message:self.titleForActionSheet ?? (self.isForVideo ? "Take Video" :"Take image"), preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cancelAction)
        
        if (UIImagePickerController.isCameraDeviceAvailable(.rear) ) {
            let cameraAction = UIAlertAction(title: self.titleForCameraButton
                ?? "Camera", style: .default, handler: { (action) -> Void in
                self.showImagePickerController(sourceType: .camera)
            })
            
            actionSheet.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: self.titleForPhotosButton ?? "Photos", style: .default) { (action) -> Void in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        
        actionSheet.addAction(photoLibraryAction)
        
        self.controller.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = sourceType
        imagePickerController.mediaTypes = self.isForVideo ?  [kUTTypeMovie as String] : [kUTTypeImage as String]
        self.controller.present(imagePickerController, animated: true, completion: nil)
    }

}
extension MediaPickerHelper : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        self.controller.dismiss(animated: true, completion: nil)

    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            let fixedImaage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: image.imageOrientation)
            self.callbackForImage!(fixedImaage)
            
        } else if let videoURL = info[UIImagePickerControllerReferenceURL] as? NSURL {
            self.callbackForVideo!(videoURL)
            
        }
        self.controller.dismiss(animated: true, completion: nil)
    }
}



