//
//  FavoriteButton.swift
//  Landmarks
//
//  Created by vivi on 2023/04/27.
//

import SwiftUI

struct FavoriteButton: View {
    // 바인딩을 사용하고 있기 때문에 이 뷰에서 변경한 내용은 데이터 소스로 다시 전파됨
    @Binding var isSet: Bool
    
    var body: some View {
        Button {
            isSet.toggle()
        } label: {
            // "Toggle Favorite"은 UI에 나타나지 않지만 VoiceOver 접근성 개선을 위해 사용
            Label("Toggle Favorite", systemImage: isSet ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .yellow : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
