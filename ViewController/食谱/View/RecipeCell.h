//
//  RecipeCell.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/24.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *dishImage;

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *descriptionL;

@end
