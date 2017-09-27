//
//  FillRegistrationInfoViewController.swift
//  User
//
//  Created by User on 9/23/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import RealmSwift

class FillRegistrationInfoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PopupTitleForPersonViewControllerDelegate {
    
    var token = NotificationToken()
    let realm = try! Realm()
    
    var yearsOld18IsChecked = false
    var agreeWithTermsIsChecked = false
    var imagePicker = UIImagePickerController()
    var sex = "Female"
    
    let lightBluecolor = UIColor(red: CGFloat(0/255.0), green: CGFloat(128/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1.0))
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet weak var personTitleLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    @IBOutlet weak var ageTextFieldOutlet: UITextField!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var check18YearsOldImageViewOutlet: UIImageView!
    @IBOutlet weak var checkTermsAndConditionsImageViewOutlet: UIImageView!
    @IBOutlet weak var nextButtonOutlet: UIButton!
    
    @IBOutlet weak var nextLabelOutlet: UILabel!
    
    
    var indexOfCountry = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor(red: 0.4, green: 0.8, blue: 0.7, alpha: 1)
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        navigationController?.navigationBar.layer.shadowRadius = 4.0
        navigationController?.navigationBar.layer.shadowOpacity = 0.5
        navigationController?.navigationBar.layer.masksToBounds = false
        
        let titleLabel = UILabel()
        titleLabel.text = "Create profile"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        
        let titleLabelBarButton = UIBarButtonItem(customView: titleLabel)
        
        navigationItem.leftBarButtonItem = titleLabelBarButton
        
        personTitleLabelOutlet.text = "Dr."
        
        nextButtonOutlet.layer.cornerRadius = 2
        nextButtonOutlet.backgroundColor = lightBluecolor
        nextButtonOutlet.isHidden = true
        nextLabelOutlet.layer.cornerRadius = 2
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func check18YearsOldButtonTapped(_ sender: UIButton) {
        if agreeWithTermsIsChecked {
            check18YearsOldImageViewOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            agreeWithTermsIsChecked = false
        } else {
            check18YearsOldImageViewOutlet.image = UIImage(named: "checkBoxChecked.png")
            agreeWithTermsIsChecked = true
        }
        if checkIfCheksAreSet(check18YearsOld: yearsOld18IsChecked, checkAgreeWithTermsAndConditions: agreeWithTermsIsChecked) {
            nextLabelOutlet.isHidden = true
            nextButtonOutlet.isHidden = false
        } else {
            nextLabelOutlet.isHidden = false
            nextButtonOutlet.isHidden = true
        }
    }
    
    
    @IBAction func agreeWithTermsButtonTapped(_ sender: UIButton) {
        if yearsOld18IsChecked {
            checkTermsAndConditionsImageViewOutlet.image = UIImage(named: "checkBoxUnchecked.png")
            yearsOld18IsChecked = false
        } else {
            checkTermsAndConditionsImageViewOutlet.image = UIImage(named: "checkBoxChecked.png")
            yearsOld18IsChecked = true
        }
        if checkIfCheksAreSet(check18YearsOld: yearsOld18IsChecked, checkAgreeWithTermsAndConditions: agreeWithTermsIsChecked) {
            nextLabelOutlet.isHidden = true
            nextButtonOutlet.isHidden = false
        } else {
            nextLabelOutlet.isHidden = false
            nextButtonOutlet.isHidden = true
        }
    }
    
    func checkIfCheksAreSet(check18YearsOld: Bool, checkAgreeWithTermsAndConditions: Bool) -> Bool {
        if check18YearsOld == false || checkAgreeWithTermsAndConditions == false {
            return false
        }
        return true
    }
    
    
    @IBAction func changeTitleButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func changeSexSegmentedControl(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            sex = "Female"
        } else if sender.selectedSegmentIndex == 1 {
            sex = "Male"
        }
    }
    @IBAction func addPhotoAction(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func registerUserAction(_ sender: UIButton) {
        let loadingAnimationStoryboard = UIStoryboard(name: "LoadingAnimation", bundle: Bundle.main)
        let loadingAnimationController = loadingAnimationStoryboard.instantiateViewController(withIdentifier: "kLoadingAnimationViewController") as! LoadingAnimationViewController
        present(loadingAnimationController, animated: false, completion: nil)
        
        let userRegistrationObject = RegistrationUserRequest()
        userRegistrationObject.registerUserFunc(prefixName: personTitleLabelOutlet.text!,
                                           fName: firstNameTextFieldOutlet.text!,
                                           lName: lastNameTextFieldOutlet.text!,
                                           age: ageTextFieldOutlet.text!,
                                           sex: sex,
                                           mail: emailTextFieldOutlet.text!,
                                           imageUrl: RealmDataManager.getImageUrlFromRealm()[0].imageUrl!,
                                           codeIndex: indexOfCountry) { success in
                                            if success {
                                                let mainScreenStoryboard = UIStoryboard(name: "MainScreen", bundle: nil)
                                                let mainScreenViewController = mainScreenStoryboard.instantiateViewController(withIdentifier: "kMainScreenController") as? MainScreenController
                                                mainScreenViewController?.userIsRegistred = true
                                                loadingAnimationController.dismiss(animated: false, completion: nil)
                                                self.navigationController?.pushViewController(mainScreenViewController!, animated: true)
                                            }
        }

    }
    
    var imageStr = ""
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        
        let queue = OperationQueue()
        
        queue.addOperation {
            let imageData = UIImagePNGRepresentation(selectedImage)! as NSData
            self.imageStr = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            queue.addOperation {
                let obj = UploadImageRequest()
                obj.uploadImage(imageString: self.imageStr)
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func termsAndConditionsLinkTapped(_ sender: UIButton) {
        let termsAndConditions = UIStoryboard(name: "TermsAndConditions", bundle: nil)
        let termsAndConditionsViewController = termsAndConditions.instantiateViewController(withIdentifier: "kTermsAndConditionsWebViewViewController") as? TermsAndConditionsWebViewViewController
        navigationController?.pushViewController(termsAndConditionsViewController!, animated: true)
    }
    
    func trasferUsetTitle(personTitle: String) {
        personTitleLabelOutlet.text = personTitle
    }
    
    // showPopupWithTitlesForRegistration
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopupWithTitlesForRegistration" {
            let popupTitleForPersonViewController = segue.destination as? PopupTitleForPersonViewController
            popupTitleForPersonViewController?.delegate = self
        }
    }
    
}
