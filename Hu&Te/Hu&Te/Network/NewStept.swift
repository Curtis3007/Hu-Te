//
//  NewStept.swift
//  Hu&Te
//
//  Created by BigSur on 21/05/2021.
//

import ObjectMapper

class NYPNewStep: Mappable, NSCopying {
    
    var id: Int?
    var title: String?
    var stepDescription: String?
    var number: Int?
    var photos: [NYPPhoto]? = []
    var photosDelete : [NYPPhoto]? = []
    var isDelete:Bool?
    var startTime: String?
    var endTime: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        stepDescription <- map["description"]
        number <- map["number"]
        photos <- map["photos"]
        startTime <- map["start_time"]
        endTime <- map["end_time"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = NYPNewStep(id: self.id, title: self.title, stepDescription: self.stepDescription, number: self.number, photos: self.photos, photoDelete: self.photosDelete, isDelete: self.isDelete)
        return copy
    }
    
    init() {
        self.title = ""
        self.stepDescription = ""
        self.number = 0
        self.photos = []
    }
    
    init(id: Int?, title: String?, stepDescription: String?, number: Int?, photos:[NYPPhoto]?, photoDelete:[NYPPhoto]?, isDelete:Bool?) {
        self.id = id
        self.title = title
        self.stepDescription = stepDescription
        self.number = number
        self.photos = photos
        self.photosDelete = photoDelete
        self.isDelete = isDelete
    }
}

class NYPPhoto: Mappable {
    var id : Int?
    var largePhotoUrl : String?
    var squarePhotoUrl : String?
    var image:UIImage?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["id"]
        self.squarePhotoUrl <- map["square_photo_url"]
        self.largePhotoUrl <- map["large_photo_url"]
    }
    
    init() {
       
        self.largePhotoUrl = ""
        self.squarePhotoUrl = ""
    }
}
