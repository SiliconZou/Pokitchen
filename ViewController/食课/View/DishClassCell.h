//
//  DishClassCell.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DishClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *dishImage;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *updateL;

@property (weak, nonatomic) IBOutlet UILabel *numL;

@property (weak, nonatomic) IBOutlet UILabel *albumL;

@property (weak, nonatomic) IBOutlet UIImageView *albumLogo;

@end
