//
//  main.swift
//  Protocol
//
//  Created by Mishana on 05.09.2022.
//

import Foundation





protocol MobileStorage {
func getAll() -> Set<Mobile>
func findByImei(_ imei: String) -> Mobile?
func save(_ mobile: Mobile) throws -> Mobile
func delete(_ product: Mobile) throws
func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
let imei: String
let model: String
}

class Phone: MobileStorage {
    
    enum MobileStorageError {
        case saveError
         
        case deleteError
    }
    
    var mobileStorage = Set<Mobile>()
    
    func getAll() -> Set<Mobile> {
        return Set(fetchData())
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        for mobile in mobileStorage{
            if mobile.imei.lowercased().contains(imei.lowercased()){
                return mobile
            }
        }
        return nil
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        do {
            try mobileStorage.insert(mobile)
        }catch let error as NSError, MobileStorageError.saveError {
            print(error.localizedDescription)
            throw error
        }
        
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if let delete = findByImei(product.imei){
            do{
              try mobileStorage.remove(delete)
            }catch let error as NSError, MobileStorageError.deleteError {
                print(error.localizedDescription)
                throw error
            }
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        if findByImei(product.imei) != nil {
            return true
        }else {
            return false
        }
    }
    
    
}

extension Phone {
    func fetchData() -> [Mobile] {
        let image1 = Mobile(imei: "123 123 123 132", model: "iPhone12")
        
        return [image1, image1, image1]
    }
}


//Phone.save()

