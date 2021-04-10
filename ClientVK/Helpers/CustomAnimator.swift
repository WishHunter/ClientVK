//
//  CustomAnimator.swift
//  ClientVK
//
//  Created by Denis Molkov on 28.03.2021.
//

import UIKit

class CustomAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPush: Bool
    
    init(isPush: Bool = false) {
        self.isPush = isPush
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else { return }
                
        transitionContext.containerView.addSubview(destination.view)
        destination.view.frame = source.view.frame
        let translationRight = CGAffineTransform(translationX: source.view.frame.width + (source.view.frame.height / 2), y: 0)
        let rotateRight = CGAffineTransform(rotationAngle: -(.pi / 2))
        
        let translationLeft = CGAffineTransform(translationX: -(source.view.frame.width + (source.view.frame.height / 2)), y: 0)
        let rotateLeft = CGAffineTransform(rotationAngle: .pi / 2)
        
        if isPush {
            destination.view.transform = rotateRight.concatenating(translationRight)
//            destination.view.transform = translationRight
        } else {
            destination.view.transform = rotateLeft.concatenating(translationLeft)
//            destination.view.transform = translationLeft
        }
        
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: [.calculationModeCubic],
                                animations: {
                                    //1
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        if self.isPush {
                                                            source.view.transform = rotateLeft.concatenating(translationLeft)
//                                                            source.view.transform = translationLeft
                                                        } else {
                                                            source.view.transform = rotateRight.concatenating(translationRight)
//                                                            source.view.transform = translationRight
                                                        }
                                                       })
                                    //2
                                    UIView.addKeyframe(withRelativeStartTime: 0,
                                                       relativeDuration: 0.75,
                                                       animations: {
                                                        destination.view.transform = .identity
                                                       })
                                },
                                completion: {
                                    finished in
                                    if finished && !transitionContext.transitionWasCancelled {
                                            source.view.transform = .identity
                                        }
                                        transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
                                }
        )
    }
}
