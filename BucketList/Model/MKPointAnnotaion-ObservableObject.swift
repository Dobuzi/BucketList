//
//  MKPointAnnotaion-ObservableObject.swift
//  BucketList
//
//  Created by 김종원 on 2020/11/06.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? ""
        }
        
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? ""
        }
        
        set {
            subtitle = newValue
        }
    }
}
