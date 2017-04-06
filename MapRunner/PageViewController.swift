//
//  PageViewController.swift
//  MapRunner
//
//  Created by Minhung Ling on 2017-04-06.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var viewControllerArray = [UIViewController]()
    var pageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        dataSource = self
        setViewControllers([viewControllerArray[1]],
                           direction: .forward,
                           animated: true,
                           completion: nil)
    }
    
    func setUp() {
        let suvc = storyboard!.instantiateViewController(withIdentifier: "SetUpViewController")
        let rvc = storyboard!.instantiateViewController(withIdentifier: "RunViewController")
        viewControllerArray = [suvc, rvc]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllerArray.index(of: viewController) else {
            return nil
        }

        let previousPage = index - 1

        if previousPage < 0 {
            return nil
        }
        
        if previousPage > viewControllerArray.count - 1 {
            return nil
        }
        
        return viewControllerArray[previousPage]
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewControllerArray.index(of: viewController) else {
            return nil
        }
        
        let nextPage = index + 1
        
        if nextPage < 0 {
            return nil
        }
        
        if nextPage > viewControllerArray.count - 1 {
            return nil
        }
        
        return viewControllerArray[nextPage]
    }
}
