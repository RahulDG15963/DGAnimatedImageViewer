//
//  AnimateTransition.swift
//  AnimationSample
//
//  Created by Innofied on 21/09/17.
//  Copyright © 2017 Innofied. All rights reserved.
//

import UIKit

enum TransitionType {
    case Presenting, Dismissing
}

class AnimateTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval
    var isPresenting: Bool
    var originFrame: CGRect
    var collectionView: UICollectionView
    init(withDuration duration: TimeInterval, forTransitionType type: TransitionType, originFrame: CGRect, collectionView: UICollectionView) {
        self.duration = duration
        self.isPresenting = type == .Presenting
        self.originFrame = originFrame
        self.collectionView = collectionView
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        var selected: IndexPath?
        if collectionView.indexPathsForSelectedItems?.count == 0 {
            selected = IndexPath(row: 0, section: 0)
        }
        else {
            selected = collectionView.indexPathsForSelectedItems?[0]
        }
        print("Selected cell: \(String(describing: selected?.row))")
        let cell = collectionView.cellForItem(at: selected!)
        let container: UIView? = transitionContext.containerView
        let fromVC: UIViewController? = transitionContext.viewController(forKey: .from)
        let toVC: UIViewController? = transitionContext.viewController(forKey: .to)
        let fromView: UIView? = fromVC?.view
        let toView: UIView? = toVC?.view
        let beginFrame: CGRect? = container?.convert((cell?.contentView.bounds)!, from: cell?.contentView)
        var endFrame: CGRect = transitionContext.initialFrame(for: fromVC!)
        endFrame = toView?.frame ?? CGRect.zero
        var move: UIView? = nil
        var transitionDuration: CGFloat
        if isPresenting {
            transitionDuration = CGFloat(self.duration)
            toView?.frame = endFrame
            move = toView?.snapshotView(afterScreenUpdates: true)
            move?.frame = beginFrame!
            cell?.isHidden = true
        }
        else {
            transitionDuration =  CGFloat(self.duration)
            move = cell?.contentView.snapshotView(afterScreenUpdates: true)
            move?.frame = (fromView?.frame)!
            fromView?.removeFromSuperview()
        }
        container?.addSubview(move!)
        if isPresenting {
            UIView.animate(withDuration: TimeInterval(transitionDuration) , animations: {() -> Void in
                move?.frame = endFrame
            }, completion: {(_ finished: Bool) -> Void in
                move?.removeFromSuperview()
                toView?.frame = endFrame
                container?.addSubview(toView!)
                transitionContext.completeTransition(true)
            })
        }
        else {
            UIView.animate(withDuration: TimeInterval(transitionDuration) , delay: 0, usingSpringWithDamping: 20, initialSpringVelocity: 15, options: [], animations: {() -> Void in
                move?.frame = beginFrame!
            }, completion: {(_ finished: Bool) -> Void in
                cell?.isHidden = false
                transitionContext.completeTransition(true)
            })
        }
    }
}
