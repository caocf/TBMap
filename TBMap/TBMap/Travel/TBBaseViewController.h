//
//  TBBaseViewController.h
//  TBMap
//
//  Created by libo on 12/9/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBBaseViewController : UIViewController

-(void)configNavigationBar;
-(void)popToParentVC:(id)sender;

/*!
 *  @brief  导航左右按钮区域
 */
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIView *titleView;

@end
