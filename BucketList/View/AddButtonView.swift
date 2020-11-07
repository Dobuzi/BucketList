//
//  AddButtonView.swift
//  BucketList
//
//  Created by 김종원 on 2020/11/07.
//

import SwiftUI
import MapKit

struct AddButtonView: View {
    let width: CGFloat
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingEditScreen: Bool
    var body: some View {
        Button(action: {
            let newLocation = CodableMKPointAnnotation()
            newLocation.coordinate = self.centerCoordinate
            self.locations.append(newLocation)
            self.selectedPlace = newLocation
            self.showingEditScreen = true
        }) {
            HStack {
                Label("Add place", systemImage: "plus.circle")
            }
            .frame(width: width, height: 50)
            .background(Color.black.opacity(0.75))
            .foregroundColor(.white)
            .font(.headline)
        }
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(width: 200,
                      centerCoordinate: .constant(CLLocationCoordinate2D(latitude: 50, longitude: -5)),
                      locations: .constant([CodableMKPointAnnotation()]), selectedPlace: .constant(CodableMKPointAnnotation()), showingEditScreen: .constant(false))
    }
}
