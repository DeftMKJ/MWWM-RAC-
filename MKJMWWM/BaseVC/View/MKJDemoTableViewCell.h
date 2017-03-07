//
//  MKJDemoTableViewCell.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseTableViewCell.h"
#import "MKJDemoTableViewCellViewModel.h"

@interface MKJDemoTableViewCell : MKJBaseTableViewCell

@property (nonatomic,strong ,readonly) MKJDemoTableViewCellViewModel *viewModel;

@end
