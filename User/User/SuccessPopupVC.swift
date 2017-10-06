//
//  SuccessPopupVC.swift
//  User
//
//  Created by User on 10/5/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class SuccessPopupVC: RootViewController {

    @IBOutlet weak var okButtonOutlet: UIButton!
    
    var delegate: SuccessPopupVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate.pushToMainMenu()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        delegate.pushToMainMenu()
        dismiss(animated: false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
