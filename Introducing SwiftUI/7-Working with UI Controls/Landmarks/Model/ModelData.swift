//
//  ModelData.swift
//  Landmarks
//
//  Created by vivi on 2023/04/27.
//

import Foundation
import Combine

// SwiftUI는 observable 객체를 구독하고, 데이터가 변경되었을 때 리프레시가 필요한 모든 뷰를 업데이트 한다.
final class ModelData: ObservableObject {
    // Observable 객체는 Subscriber가 변경 사항을 선택할 수 있도록 변경할 데이터에 Published 프로퍼티 래퍼 적용
    @Published var landmarks: [Landmark] = load("landmarkData.json")
    // Hike 데이터는 초기화 후 수정되지 않기 때문에 @Published를 붙일 필요 없음
    var hikes: [Hike] = load("hikeData.json")
    @Published var profile = Profile.default
    
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarks,
            by: { $0.category.rawValue }
        )
    }
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
