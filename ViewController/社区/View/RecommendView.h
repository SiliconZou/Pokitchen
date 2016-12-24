//
//  RecommendView.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/12/1.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PushViewControllerDelegate.h"

#import "XTADScrollView.h"

@interface RecommendView : UICollectionViewCell<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@property(nonatomic, strong) XTADScrollView *adView;

@property(nonatomic, weak) id<PushViewControllerDelegate> delegate;

@end
