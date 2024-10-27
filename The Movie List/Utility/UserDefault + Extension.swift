//
//  UserDefault + Extension.swift
//  The Movie List
//
//  Created by Mayank Patel on 27/10/24.
//

import Foundation
import UIKit

extension UserDefaults {
    
    var persistOfflineData: [Category]? {
        get {
            if let data = UserDefaults.standard.value(forKey: "persist") as? Data {
                return try! PropertyListDecoder().decode([Category].self, from: data)
            } else {
                return nil
            }
        }
        
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: "persist")
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.set(nil, forKey: "persist")
                UserDefaults.standard.synchronize()
            }
        }
    }
}
