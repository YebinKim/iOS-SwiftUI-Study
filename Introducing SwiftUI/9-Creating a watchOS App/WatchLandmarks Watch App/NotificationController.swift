//
//  NotificationController.swift
//  WatchLandmarks Watch App
//
//  Created by vivi on 2023/05/03.
//

import WatchKit
import SwiftUI
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
    var landmark: Landmark?
    var title: String?
    var message: String?
    
    // 이 키를 사용해서 랜드마크 인덱스를 추출
    let landmarkIndexKey = "landmarkIndex"
    
    override var body: NotificationView {
        NotificationView(
            title: title,
            message: message,
            landmark: landmark
        )
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    // 컨트롤러의 속성을 업데이트하는 메서드
    // 이 메서드를 호출한 후 시스템은 네비게이션 뷰를 업데이트하는 컨트롤러의 body 프로퍼티를 무효화시키고 Apple Watch에 알림 표시
    override func didReceive(_ notification: UNNotification) {
        let modelData = ModelData()
        
        let notificationData =
        notification.request.content.userInfo as? [String: Any]
        
        let aps = notificationData?["aps"] as? [String: Any]
        let alert = aps?["alert"] as? [String: Any]
        
        title = alert?["title"] as? String
        message = alert?["body"] as? String
        
        if let index = notificationData?[landmarkIndexKey] as? Int {
            landmark = modelData.landmarks[index]
        }
    }
}
