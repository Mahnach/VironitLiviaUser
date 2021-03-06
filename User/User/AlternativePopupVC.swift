//
//  AlternativePopupVC.swift
//  User
//
//  Created by User on 10/6/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit

class AlternativePopupVC: RootViewController {
    
    @IBOutlet weak var popupViewOutlet: UIView!
    
    
    @IBOutlet weak var yesButtonOutlet: UIButton!
    
    @IBOutlet weak var noButtonOutlet: UIButton!
    
    @IBOutlet weak var questionLabelOutlet: UILabel!
    var delegate: AlternativePopupVCDelegate!
    var cancelReason: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yesButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
        noButtonOutlet.setTitleColor(Colors.Root.greenColorForNavigationBar, for: .normal)
        questionLabelOutlet.textColor = Colors.Root.greenColorForNavigationBar
        popupViewOutlet.layer.cornerRadius = 2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        AlternativeOrderRequest.changeToAlternativeOrder(orderID: RealmDataManager.getOrderDescriptionModel()[0].orderId!)
        dismiss(animated: false) {
            self.delegate.pushToMainScreenViewController()
        }
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
        CancelOrderRequest.deleteReminder(orderID: RealmDataManager.getOrderDescriptionModel()[0].orderId!, cancelReason: cancelReason)
        dismiss(animated: false) {
            self.delegate.pushToMainScreenViewController()
        }
        
    }
    
}
