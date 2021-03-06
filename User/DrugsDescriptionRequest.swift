//
//  GetDrugsRequest.swift
//  User
//
//  Created by BAMFAdmin on 29.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import AlamofireObjectMapper

class DrugsDescriptionRequest {
    func drugsDescription(drugId:String, completion: @escaping (Bool) -> Void) {
        
        let url = "https://test.liviaapp.com/api/drug/"+drugId+"?type="+String(describing: RealmDataManager.getDrugsFromRealm()[0].type)
        var headers = [String: String]()
        if RealmDataManager.getUserDataFromRealm().count != 0 {
            headers = [
                "Content-Type": "application/json",
                "LiviaApp-language": "en",
                "LiviaApp-Token": RealmDataManager.getTokensFromRealm()[0].accessToken!,
                "LiviaApp-country": RealmDataManager.getUserDataFromRealm()[0].countryCode!,
                "LiviaApp-city": RealmDataManager.getUserDataFromRealm()[0].cityId!,
                "LiviaApp-APIVersion": "2.0"
            ]
        } else {
            headers = [
                "Content-Type": "application/json",
                "LiviaApp-language": "en",
                "LiviaApp-country": "by",
                "LiviaApp-city": "625144",
                "LiviaApp-APIVersion": "2.0"
            ]
        }
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers).responseObject { (response: DataResponse
            <DrugsDescriptionModel>) in
            DrugsDescriptionModel.writeIntoRealm(response: response)
            completion(true)
        }
        
    }
}

