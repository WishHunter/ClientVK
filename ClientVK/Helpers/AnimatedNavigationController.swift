//
//  AnimatedNavigationController.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.03.2021.
//

import UIKit

class AnimatedNavigationController: UINavigationController, UINavigationControllerDelegate {

    let interactiveTransition = CustomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
            case .pop:
                if navigationController.viewControllers.first != toVC {
                    interactiveTransition.viewController = toVC
                }
                return CustomAnimator()
            case .push:
                interactiveTransition.viewController = toVC
                return CustomAnimator(isPush: true)
            default:
                return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}
