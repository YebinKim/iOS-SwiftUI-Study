//
//  LandmarkList.swift
//  WatchLandmarks Watch App
//
//  Created by vivi on 2023/05/03.
//

import SwiftUI

struct LandmarkList: View {
    // modelData 프로퍼티는 environmentObject(_:) modifier가 부모로부터 적용될 때 자동으로 값이 지정됨
    @EnvironmentObject var modelData: ModelData
    // 하위 뷰 또는 자신만 정보를 가지고 있으므로 항상 private
    @State private var showFavoritesOnly: Bool = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationStack {
            // 리스트에서 static 뷰와 dynamic 뷰를 합치거나 두 개 이상의 dynamic 뷰 그룹을 합치려면 List 에 콜렉션을 전달하는 대신 ForEach를 사용해야 한다.
            List {
                // $ 를 사용해 state 변수 또는 해당 속성 중 하나의 요소에 대한 바인딩을 제공할 수 있다.
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmark")
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkList()
            .environmentObject(ModelData())
    }
}
