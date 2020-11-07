//
//  ContentView.swift
//  BucketList
//
//  Created by 김종원 on 2020/11/04.
//

import LocalAuthentication
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var isUnlocked = false
    var body: some View {
        GeometryReader { geo in
            if isUnlocked {
                ZStack {
                    MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails,annotations: locations)
                        .ignoresSafeArea()
                    Circle()
                        .stroke(lineWidth: 1.0)
                        .fill(Color.red)
                        .opacity(0.8)
                        .blur(radius: 1.0)
                        .frame(width: 32, height: 32)
                    VStack {
                        Spacer()
                        AddButtonView(
                            width: geo.size.width,
                            centerCoordinate: self.$centerCoordinate,
                            locations: self.$locations,
                            selectedPlace: self.$selectedPlace,
                            showingEditScreen: self.$showingEditScreen
                        )
                    }
                    .ignoresSafeArea()
                }
            } else {
                UnlockButtonView(isUnlocked: self.$isUnlocked)
            }
        }
        .alert(isPresented: $showingPlaceDetails, content: {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"), message: Text(selectedPlace?.subtitle ?? "Missing info."), primaryButton: .default(Text("OK")), secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
                })
        })
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if let placemark = self.selectedPlace {
                EditView(placemark: placemark)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let filename = getDocumentDirectory().appendingPathComponent("SavedPlaces")
        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let filename = getDocumentDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
