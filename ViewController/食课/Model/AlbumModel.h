//
//  AlbumModel.h
//  PoKitchen
//
//  Created by Silicon.Zou on 16/11/28.
//  Copyright © 2016年 siliconzou. All rights reserved.
//

#import "JSONModel.h"

@interface AlbumModel : JSONModel

@property (nonatomic, copy) NSString * album;

@property (nonatomic, copy) NSString * albumLogo;

@property (nonatomic, copy) NSString * chargeCount;

@property (nonatomic, copy) NSString * seriesId;


@end
