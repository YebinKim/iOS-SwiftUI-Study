//
//  ProfileHost.swift
//  Landmarks
//
//  Created by vivi on 2023/05/01.
//

import SwiftUI

// summary view 와 edit mode 를 static하게 호스팅하는 뷰
struct ProfileHost: View {
    // SwiftUI는 @Environment 프로퍼티 래퍼를 사용해 접근할 수 있는 값에 대한 Environment 저장소를 제공한다.
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        // onDisappear보다 먼저 불리기 때문에 수정사항이 원래대로 돌아감
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton()
            }
            
            if editMode?.wrappedValue == .inactive /* enum EditMode */ {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHost()
            .environmentObject(ModelData())
        // 이 뷰는 @EnvironmentObject 속성을 사용하지 않지만 하위 뷰가 해당 속성을 사용하므로 상위 뷰에서도 전달해줘야 오류가 발생하지 않음
    }
}
