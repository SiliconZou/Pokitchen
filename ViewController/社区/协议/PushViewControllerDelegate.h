//
//  PushViewControllerDelegate.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PushViewControllerDelegate <NSObject>

-(void)pushViewController:(UIViewController *)destinationViewController;


@end
