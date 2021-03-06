//
//  RegisterCountryModel.swift
//  User
//
//  Created by BAMFAdmin on 22.09.17.
//  Copyright © 2017 BAMFAdmin. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RealmSwift
import ObjectMapper_Realm


class MappedCountryCodesModel: Mappable {
    var CountryCodesModelArray: [CountryCodesModel]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        CountryCodesModelArray <- map["list_of_countries"]
    }
    
    static func writeIntoRealm(response: DataResponse<MappedCountryCodesModel>){
        let result = response.result.value
        let realm = try! Realm()
        if let array = result?.CountryCodesModelArray {
            for element in array {
                try! realm.write {
                    realm.add(element)
                }
            }
        }
    }
}

class CountryCodesModel:Object, Mappable {
    @objc dynamic var countryName: String?
    @objc dynamic var phoneCode: String?
    @objc dynamic var countryFlag: String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        countryName <- map["name"]
        phoneCode <- map["phone_country_code"]
        countryFlag <- map["flag"]
    }
    
}
