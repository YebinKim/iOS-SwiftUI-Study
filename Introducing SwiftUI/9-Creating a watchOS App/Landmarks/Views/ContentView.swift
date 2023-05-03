//
//  ContentView.swift
//  Landmarks
//
//  Created by vivi on 2023/04/27.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem {
                    Label("Featured", systemImage: "star")
                }
                .tag(Tab.featured)
            // tag(_:) modifier 는 각 뷰가 가질 수 있는 값과 매칭되므로 사용자가 사용자 인터페이스에서 항목을 선택할 때 표시할 뷰를 결정할 수 있다
            
            LandmarkList()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
        // 하위 뷰가 EnvironmentObject 객체를 가지고 있지만, 상위 뷰의 preview에 .environmentObject(_:)가 없을 경우 preview가 실패함
    }
}
