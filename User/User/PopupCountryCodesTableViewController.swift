//
//  PopupCountryCodesTableViewController.swift
//  User
//
//  Created by User on 9/22/17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import UIKit
import CoreGraphics
import RealmSwift

class PopupCountryCodesTableViewController: UIViewController{
    
    @IBOutlet weak var countryCodesTableView: UITableView!
    
    let countryCodeDataManagerObject = CountryCodesDataManager()
    
    var array:[RealmDataManager] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.countryCodesTableView.layer.cornerRadius = 5
        self.countryCodesTableView.indicatorStyle = .default
     /*
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissIfTappedOnView(_:)))
        tap.delegate = self as? UIGestureRecognizerDelegate
        self.view.addGestureRecognizer(tap)
     */
        countryCodesTableView.delegate = self
        countryCodesTableView.dataSource = self
        


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissIfTappedOnView(_ sender: UITapGestureRecognizer) {
     //   dismiss(animated: false, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
 }

extension PopupCountryCodesTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RealmDataManager.getDataFromCountries().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCodeCell", for: indexPath) as! CountryCodeCell
        
        
        cell.countryCodeLabelOutlet.text = "+" + RealmDataManager.getDataFromCountries()[indexPath.row].phoneCode!
        cell.countryNameLabelOutlet.text = RealmDataManager.getDataFromCountries()[indexPath.row].countryName
        let urlImage = "https://test.liviaapp.com" + RealmDataManager.getDataFromCountries()[indexPath.row].countryFlag!
        countryCodeDataManagerObject.getImage(pictureUrl: urlImage) { success, image in
            if success {
                cell.countryFlagImageViewOutlet.image = image
            }
        }
        
        
        
        return cell
    }
}

extension PopupCountryCodesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let realm = try! Realm()
        if RealmDataManager.getIndexCountryFromRealm().count != 0 {
            try! realm.write {
                realm.delete(RealmDataManager.getIndexCountryFromRealm()[0])
            }
        }
        let indexOfCountry = CountryCodesIndexModel()
        indexOfCountry.index = indexPath.row
       

        
        RealmDataManager.writeIntoRealm(object: indexOfCountry, realm: realm)
        
        
        dismiss(animated: false, completion: nil)
    }
}
