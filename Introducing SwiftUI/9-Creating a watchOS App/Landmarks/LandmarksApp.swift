//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by vivi on 2023/04/27.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
        
        // watchOS 9.4 시뮬에서는 노티피케이션이 동작하지 않아서 9.1 시뮬레이터 실행으로 알림을 받는데 성공했다 🤔
        #if os(watchOS)
        WKNotificationScene(controller: NotificationController.self, category: "LandmarkNear")
        #endif
    }
}
