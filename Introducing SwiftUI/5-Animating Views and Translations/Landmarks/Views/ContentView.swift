//
//  ContentView.swift
//  Landmarks
//
//  Created by vivi on 2023/04/27.
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
        // 하위 뷰가 EnvironmentObject 객체를 가지고 있지만, 상위 뷰의 preview에 .environmentObject(_:)가 없을 경우 preview가 실패함
    }
}
