//
//  UserDefaultHelper.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import Foundation
import ObjectMapper

enum UserDefaultKeys: String {
    case editTitleProfile = "editTitleProfile"
    case isLoggedIn = "isLoggedIn"
    case saveUser = "saveUser"
    case accessToken = "accessToken"
    case isFirstLogin = "isFirstLogin"
    case userId = "userId"
    case isUpdateProfile = "updateProfile"
    case role = "role"
    case eventFilter = "eventFilter"
    case isShowUpdateProfile = "isShowPopupUpdateProfile"
    case deviceID = "deviceID"
    case deviceToken = "deviceToken"
    case filterSite = "filterSite"
    case filterCategory = "filterCategory"
    case filterLearning = "filterLearning"
    case filterSeries = "filterSeries"
    case filterEventComing = "filterEventComing"
    case filterEventPast = "filterEventPast"
    case userLoggedIn = "UserLoggedIn"
    case comingFilter = "comingFilter"
    case pastFilter = "pastFilter"
    case seriesFilter = "seriesFilter"
    case textFieldEvent = "textFieldEvent"
    case resourcesKeyword = "resourcesKeyword"
    case isShowKeyboard = "isShowKeyboard"
    case comingKeyword = "comingKeyword"
    case pastKeyword = "pastKeyword"
    case seriesKeyword = "seriesKeyword"
    case isAdmin = "isAdmin"
    case userName = "userName"
}

enum Role: String {
    case Student = "Student"
    case Staff = "Staff"
}

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    var isAdmin: Bool? {
        get {
            return loadObject(.isAdmin) as? Bool
        }
        set {
            let newTitle = newValue
            self.setObject(newTitle, key: .isAdmin)
        }
    }
    
    var userName: String? {
        get {
            return loadObject(.userName) as? String
        }
        set {
            let newTitle = newValue
            self.setObject(newTitle, key: .userName)
        }
    }
    
    var accessToken: String? {
        get {
            return loadObject(.accessToken) as? String
        }
        set {
            let newTitle = newValue
            self.setObject(newTitle, key: .accessToken)
        }
    }
    var userLoggedInString: String? {
        get {
            return loadObject(.userLoggedIn) as? String
        }
        set {
            let newTitle = newValue
            self.setObject(newTitle, key: .userLoggedIn)
        }
    }
    var isFirstLogin: Bool {
        get {
            return loadObject(.isFirstLogin) as? Bool ?? false
        }
        set {
            self.setObject(newValue, key: .isFirstLogin)
        }
    }
    
    var isLoggedIn: Bool? {
        get {
            return loadObject(.isLoggedIn) as? Bool
        }
        set {
            self.setObject(newValue, key: .isLoggedIn)
        }
    }
    
    var saveUser: String? {
        get {
            return loadObject(.saveUser) as? String
        }
        set {
            self.setObject(newValue, key: .saveUser)
        }
    }
    
    var userId: String? {
        get {
            return (loadObject(.userId) as? String) ?? ""
        }
        
        set {
            self.setObject(newValue, key: .userId)
        }
    }
    
    var isUpdateProfile: Bool? {
        get {
            return (loadObject(.isUpdateProfile) as? Bool) ?? false
        }
        
        set {
            self.setObject(newValue, key: .isUpdateProfile)
        }
    }
    
    var role: String? {
        get {
            return (loadObject(.role) as? String) ?? "student"
        }
        
        set {
            self.setObject(newValue, key: .role)
        }
    }
    
    var isShowUpdateProfile: Bool {
        get {
            return (loadObject(.isShowUpdateProfile) as? Bool) ?? true
        }
        
        set {
            setObject(newValue, key: .isShowUpdateProfile)
        }
    }
    
    var deviceID: String? {
        get {
            return loadObject(.deviceID) as? String
        }
        set {
            let newTitle = newValue
            self.setObject(newTitle, key: .deviceID)
        }
    }
    
    var deviceToken: String? {
        get {
            return loadObject(.deviceToken) as? String
        }
        set {
            self.setObject(newValue, key: .deviceToken)
        }
    }
    
    
    private func setObject(_ value: Any?, key: UserDefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    private func loadObject(_ key: UserDefaultKeys) -> Any? {
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    func removeLoginUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.saveUser.rawValue)
        
    }
    
    func removeAll() {
        //UserDefaults.standard.removeObject(forKey: UserDefaultKeys.saveUser.rawValue)
        //UserDefaults.standard.removeObject(forKey: UserDefaultKeys.isLogin.rawValue)
    }
}


extension Encodable {
    var toData: Data? {
        return try? JSONEncoder().encode(self)
    }
}
extension Data {
    func toObject<T: Decodable>(type: T.Type) -> T? {
        return try? JSONDecoder().decode(type, from: self)
    }
}

