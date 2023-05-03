//
//  ContentView.swift
//  WatchLandmarks Watch App
//
//  Created by vivi on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
