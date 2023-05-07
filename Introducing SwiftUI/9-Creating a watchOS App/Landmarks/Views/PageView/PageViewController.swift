//
//  PageViewController.swift
//  Landmarks
//
//  Created by vivi on 2023/05/01.
//

import SwiftUI
import UIKit

struct PageViewController<Page: View>: UIViewControllerRepresentable {
    var pages: [Page]
    @Binding var currentPage: Int
    
    // SwiftUI는 makeUIViewController(context:) 메서드 호출 전에 makeCoordinator() 메서드를 호출하므로 뷰컨트롤러를 구성할 때 coordinator 개체에 액세스할 수 있음
    // 이 코디네이터를 사용하여 Delagetes, Data Source 및 target-action을 통한 사용자 이벤트 응답과 같은 일반적인 Cocoa 패턴을 구현할 수 있음
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // SwiftUI는 뷰를 표시할 준비가 되었을 때 이 메서드를 한 번 호출한 다음 뷰 컨트롤러의 생명 주기를 관리함
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        return pageViewController
    }
    
    // SwiftUI 뷰의 모든 업데이트에서 호스팅되는 UIHostingController 페이지를 생성
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        pageViewController.setViewControllers([context.coordinator.controllers[currentPage]], direction: .forward, animated: true)
    }
    
    // UIKit 뷰컨트롤러를 나타내는 SwiftUI 뷰는 SwiftUI가 관리하고 표현 가능한 뷰 컨텍스트의 일부로 제공하는 코디네이터 유형을 정의할 수 있음
    // SwiftUI는 UIViewControllerRepresentable 타입 코디네이터를 관리하며 위에서 만든 메서드를 호출할 때 컨텍스트의 일부로도 제공함
    class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var parent: PageViewController
        var controllers = [UIViewController]()
        
        init(_ pageViewController: PageViewController) {
            parent = pageViewController
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerBefore viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index - 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            viewControllerAfter viewController: UIViewController) -> UIViewController?
        {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index + 1]
        }
        
        func pageViewController(
            _ pageViewController: UIPageViewController,
            didFinishAnimating finished: Bool,
            previousViewControllers: [UIViewController],
            transitionCompleted completed: Bool) {
                if completed,
                   let visibleViewController = pageViewController.viewControllers?.first,
                   let index = controllers.firstIndex(of: visibleViewController) {
                    parent.currentPage = index
                }
            }
    }
}
