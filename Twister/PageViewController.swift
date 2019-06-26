//
//  PageViewController.swift
//  Twister
//
//  Created by Thoralf Thelle on 17/06/2019.
//  Copyright © 2019 twist. All rights reserved.
//

import UIKit

class TRootViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.dataSource = self
        
        let nav = UINavigationController()
        let nav2 = UINavigationController()
        nav.viewControllers = [ViewController()]
        nav2.viewControllers = [ChatView()]
        
        let page1: UIViewController = nav
        let page2: UIViewController = nav2
        
        pages.append(page1)
        pages.append(page2)
        
        setViewControllers([page1], direction: UIPageViewController.NavigationDirection.forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.firstIndex(of: viewController)!
        if currentIndex == 0 { return nil }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.lastIndex(of: viewController)!
        
        if currentIndex == (pages.count - 1) { return nil }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
