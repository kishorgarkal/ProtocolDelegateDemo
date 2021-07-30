//
//  SecondVC.swift
//  VibDemoApp
//
//  Created by MYGENOMEBOX INDIA on 30/07/21.
//

import UIKit

protocol MyDataSendingDelegate {
    func sendDataToFirstViewController(myData: [UserModel])
}
class SecondVC: UIViewController {

    //Mark: IBoutlets
    
    var delegate: MyDataSendingDelegate? = nil
    
    @IBOutlet weak var btnImageView: UIButton!
  
    @IBOutlet weak var img_View: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    
    //Mark : Properties and Variables
    
    var selectedCountry: String?
    var countryList = ["Algeria", "Andorra", "Angola", "India", "Thailand"]
    var UserArray = [UserModel]()
    
    private lazy var imagePicker: ImagePicker = {
           let imagePicker = ImagePicker()
           imagePicker.delegate = self
           return imagePicker
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        createPickerView()
        dismissPickerView()
        setImageCorner()
        // Do any additional setup after loading the view.
    }
    
    func setImageCorner(){
        img_View.maskCircle(anyImage: img_View.image!)
    }
    
    @IBAction func btnAddProfileimageTapped(_ sender: UIButton) {
        
        
        self.cameraButtonPressed()

}
    
    @IBAction func btcBack(_ sender: UIButton) {
        
        if self.delegate != nil && self.UserArray.count > 0 {
            
            let dataToBeSent = UserArray
            self.delegate?.sendDataToFirstViewController(myData: dataToBeSent)
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        self.img_View.image = UIImage(systemName: "person.crop.circle.fill.badge.plus")
        self.txtName.text = ""
        self.txtLocation.text = ""
    }
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        if UserArray.contains(where: {$0.username?.compare(txtName.text!, options: .caseInsensitive) == .orderedSame}) {
            self.alert(withmessage: "This Username already exists", withpresentviewcontroller: self, withtype: "Alert")
            print(true)  // true
        }else{
            self.UserArray.append(UserModel(username: txtName.text!, userImage: self.img_View.image!, userLoacation: txtLocation.text!))
        }
     
    }
    //Mark : Camera Press
    
    private func cameraButtonPressed() {
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // create an action
        let firstAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in

            self.imagePicker.cameraAsscessRequest()
        }
        
        let secondAction: UIAlertAction = UIAlertAction(title: "PhotoLibrary", style: .default) { action -> Void in
            self.imagePicker.photoGalleryAsscessRequest()
            
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        actionSheetController.popoverPresentationController?.sourceView = self.view // works for both iPhone & iPad
        
        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
        
        
        
    }
}
// MARK: ImagePickerDelegate

extension SecondVC: ImagePickerDelegate {

    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        img_View.image = image
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss()
        
    }
    
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

// MARK: LocationPicker

extension SecondVC : UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countryList[row]
       
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCountry = countryList[row]
        txtLocation.text = selectedCountry
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        txtLocation.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        txtLocation.inputAccessoryView = toolBar
    }
    
    @objc func action() {
       view.endEditing(true)
    }

}
