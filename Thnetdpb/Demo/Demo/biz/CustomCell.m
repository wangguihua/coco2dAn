//
//  CustomCell.m
//  Demo
//
//  Created by llbt_wgh on 14-3-5.
//  Copyright (c) 2014年 llbt. All rights reserved.
//

#import "CustomCell.h"
#import "MBConstant.h"
@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height)];
        
        [self addSubview:_headImageView];
        _headImageView.backgroundColor =[UIColor grayColor];
        _itemLbl =[[UILabel alloc]initWithFrame:CGRectMake(40, 0, 240, 40)];
        _itemLbl.backgroundColor =[UIColor clearColor];
        _itemLbl.font=kNormalTextFont;
        _itemLbl.textColor=kNormalTextColor;
        _itemLbl.numberOfLines=0;
        [self addSubview:_itemLbl];
        
        UIImageView*loogImage =[[UIImageView alloc]initWithFrame:CGRectMake(280, 6, 28, 28)];
        loogImage.image=[UIImage imageNamed:@"main_go.png"];
        [self addSubview:loogImage];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
