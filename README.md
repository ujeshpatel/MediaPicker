# MediaPicker

Platform : iOS

MediaPicker Help to pick Image and video from Photos or Camera Source 

copy 'MediaPickerHelper.swift' File in your Project 


For select Video From iPhone

``` @IBAction func selectVideoAction(_ sender: Any) {
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
```
For select Image From iPhone

```@IBAction func selectImageAction(_ sender: Any) {
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

```
Thank you 
