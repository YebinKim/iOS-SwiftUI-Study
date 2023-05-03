//
//  HikeBadge.swift
//  Landmarks
//
//  Created by vivi on 2023/05/01.
//

import SwiftUI

struct HikeBadge: View {
    var name: String
    
    var body: some View {
        VStack(alignment: .center) {
            Badge()
                .frame(width: 300, height: 300)
                .scaleEffect(1.0 / 3.0)
                .frame(width: 100, height: 100)
            Text(name)
                .font(.caption)
                .accessibilityLabel("Badge for \(name).")
            // 배지는 단지 그래픽일 뿐이므로 HikeBadge의 텍스트와 AccessibilityLabel(_:) 수정자는 배지의 의미를 다른 사용자에게 더 명확하게 만들어줌
        }
    }
}

struct HikeBadge_Previews: PreviewProvider {
    static var previews: some View {
        HikeBadge(name: "Preview Testing")
    }
}
