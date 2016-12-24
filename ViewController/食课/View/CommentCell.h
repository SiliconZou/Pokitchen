//
//  CommentCell.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/29.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nickL;

@property (weak, nonatomic) IBOutlet UILabel *timeL;

@property (weak, nonatomic) IBOutlet UILabel *contentL;


@end
