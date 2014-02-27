//
//  ModalViewController.m
//  RestorePresentedIssue
//
//  Created by Ariel Cardieri on 27/02/14.
//  Copyright (c) 2014 Forcha. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController () <UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@end

@implementation ModalViewController

- (void)awakeFromNib {
    [super awakeFromNib];

// If you comment next 2 lines, you get the same issue.
//    self.transitioningDelegate = self;
//    self.modalPresentationStyle = UIModalPresentationCustom;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)applicationFinishedRestoringState {
    [super applicationFinishedRestoringState];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController* vc1 = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController* vc2 = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView* con = [transitionContext containerView];
    UIView* v1 = vc1.view;
    UIView* v2 = vc2.view;

    if (self == vc2) {
        v2.frame = con.bounds;
        v2.alpha = 0.0;
        CGAffineTransform scale = CGAffineTransformMakeScale(.5, .5);
        v2.transform = CGAffineTransformConcat(scale, v2.transform);
        [con addSubview: v2];

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            v2.transform = CGAffineTransformConcat(CGAffineTransformInvert(scale), v2.transform);
            v2.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        // During restoration we won't have v2 on containerView
        if (![con.subviews containsObject:vc2]) {
            [con insertSubview:v2 belowSubview:v1];
        }
        
        CGAffineTransform scale = CGAffineTransformMakeScale(1.5, 1.5);

        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            v1.alpha = 0.0;
            v1.transform = CGAffineTransformConcat(scale, v1.transform);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}


@end
