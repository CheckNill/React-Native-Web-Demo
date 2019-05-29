//
//  LottaryListCell.m
//  UserClient
//
//  Created by wzz on 2019/2/28.
//  Copyright © 2019 wzz. All rights reserved.
//

#import "LottaryListCell.h"

@implementation LottaryListCell

+ (BaseCell *)dequeuCellWihClassName:(NSString *)className
                           cellModel:(GameLottaryModel *)cellModel
                           tableView:(UITableView *)tableView
                           indexPath:(NSIndexPath *)indexPath {
    NSNumber *showType = cellModel.showType;
    NSString *identifier = [NSString stringWithFormat:@"%@-%@", className, showType];
    LottaryListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.cellModel = cellModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setupUI];
    }
    cell.cellModel = cellModel;
    cell.indexPath = indexPath;
    [cell configCellData];
    return cell;
}


/*
 类型sid                     名称      类型
 201901251110001    六合彩    1
 201901251110002    时时彩    2
 201901251110003    即开彩    3
 201901251110004    PK10     4
 201901251110005    快乐十分   5
 201901251110006    PC蛋蛋    6
 201901251110007    快3       7
 201901251110008    快乐8      8
 201901251110009    快乐十分    9
 201901251110010    十一选五    10
 */
- (void)setupUI {
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
//    if (lottaryModel.styleType == 1) {
        NSInteger showType = [lottaryModel.showType integerValue];
        if (showType == 1) { //六合彩
            [self setupSixGameStyleView];
        } else if (showType == 2) { //时时彩
            [self setupTimeGameStyleView];
        } else if (showType == 4) { //PK10
            [self setupPKStyleView];
        } else if (showType == 6) { //幸运28
            [self setupStylePC];
        } else if (showType == 10) { //11选5
            [self setupEFGameStyleView];
        }
//    } else {
//        [self setupCommon];
//
//    }
}

- (void)setupCommon {
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
    if (lottaryModel.styleType == 1) {
        if (!lottaryModel.isDetailList) {
            //添加箭头
            UIImageView *arrowImgView = [[UIImageView alloc] initWithFrame:CGRectZero];
            arrowImgView.image = [UIImage imageNamed:@"cellRightArrow"];
            [self.contentView addSubview:arrowImgView];
            [arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.contentView);
                make.right.equalTo(self.contentView).offset(-CFSize(20));
            }];
        }
//        NSString *nameValue = lottaryModel.goodsName;
//        NSString *nameValue = @"开奖号码";
        
        NSString *periodValue = lottaryModel.periods;
//        UILabel *nameLabel = [UILabel labelText:nameValue bgColor:nil textColor:CFHexColor(@"#000000") font:CFFont(14)];
        UILabel *nameLabel = [UILabel labelText:@"开奖号码" bgColor:nil textColor:CFHexColor(@"#8E8E93") font:CFFont(14)];
        [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:nameLabel];
//        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(CFSize(11));
//            make.top.mas_equalTo(CFSize(12));
//        }];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(CFSize(18));
        }];
        
        UILabel *periodLabel = [UILabel labelText:periodValue bgColor:nil textColor:CFHexColor(@"#C7C7CC") font:CFFont(12)];
        [periodLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:periodLabel];
        [periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLabel);
            make.left.equalTo(nameLabel.mas_right).offset(CFSize(5));
        }];
    } else if(lottaryModel.styleType == 2){

        NSString *periodValue = lottaryModel.periods;
        UILabel *nameLabel = [UILabel labelText:@"开奖号码" bgColor:nil textColor:CFHexColor(@"#8E8E93") font:CFFont(14)];
        [nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:nameLabel];
        
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(CFSize(18));
        }];
        
        UILabel *periodLabel = [UILabel labelText:periodValue bgColor:nil textColor:CFHexColor(@"#C7C7CC") font:CFFont(12)];
        [periodLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:periodLabel];
        [periodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(nameLabel);
            make.left.equalTo(nameLabel.mas_right).offset(CFSize(5));
        }];
    }else{
        UILabel *tipLabel = [UILabel labelText:@"开奖号码" bgColor:nil textColor:CFHexColor(@"#8E8E93") font:CFFont(14)];
        [tipLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.contentView addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.mas_equalTo(CFSize(18));
        }];
    }
}

//PK10
- (void)setupPKStyleView {
    [self setupCommon];
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
    if ([lottaryModel.showType intValue] == 1) {
        for (int i=0; i<10; i++) {
            CGFloat x = CFSize(10) + i * (30 + 3);
            CGRect frame = CGRectMake(x, 40, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:nil textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel borderRadius:15];
            [self.contentView addSubview:valueLabel];
        }
    }else{
        for (int i=0; i<10; i++) {
            CGFloat paddingX = [UIScreen mainScreen].bounds.size.width - (CFSize(10) + 10 * (30 + 3));
            CGFloat x = CFSize(10) + i * (30 + 3)+paddingX;
            //        CGFloat x = CFSize(10) + i * (30 + 3);
            //        CGRect frame = CGRectMake(x, 40, 30, 30);
            CGRect frame = CGRectMake(x, 10, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:nil textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel borderRadius:15];
            [self.contentView addSubview:valueLabel];
        }
    }
}

- (void)configPkStyleCellData:(NSArray *)numberArr {
    NSDictionary *colors = @{@"01": CFHexColor(@"#E8DA2D"),@"02": CFHexColor(@"#0097DB"),
                             @"03": CFHexColor(@"#4B4B4B"),@"04": CFHexColor(@"#FE6E09"),
                             @"05": CFHexColor(@"#26E4E5"),@"06": CFHexColor(@"#484BFB"),
                             @"07": CFHexColor(@"#BFBFBF"),@"08": CFHexColor(@"#FD0000"),
                             @"09": CFHexColor(@"#770000"),@"10": CFHexColor(@"#2F79DB")};
    for (int i=0; i<numberArr.count; i++) {
        UILabel *valueLabel = [self.contentView viewWithTag:201 + i];
        valueLabel.text = numberArr[i];
        NSString *value = numberArr[i];
        UIColor *bgColor = colors[value];
        valueLabel.backgroundColor = bgColor;
    }
}

//时时彩类
- (void)setupTimeGameStyleView {
    [self setupCommon];
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
    if ([lottaryModel.showType intValue] == 1) {
        for (int i=0; i<5; i++) {
            CGFloat x = CFSize(10) + i * (30 + 3);
            CGRect frame = CGRectMake(x, 40, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel borderRadius:15];
            [self.contentView addSubview:valueLabel];
        }
    }else{
        for (int i=0; i<5; i++) {
            CGFloat paddingX = [UIScreen mainScreen].bounds.size.width - (CFSize(10) + 5 * (30 + 3));
            CGFloat x = CFSize(10) + i * (30 + 3)+paddingX;
            //        CGFloat x = CFSize(10) + i * (30 + 3);
            //        CGRect frame = CGRectMake(x, 40, 30, 30);
            CGRect frame = CGRectMake(x, 10, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel borderRadius:15];
            [self.contentView addSubview:valueLabel];
        }
    }
  
}

- (void)configTimeGameStyleCellData:(NSArray *)numberArr {
    for (int i=0; i<numberArr.count; i++) {
        UILabel *valueLabel = [self.contentView viewWithTag:201 + i];
        valueLabel.text = numberArr[i];
    }
}

//六合彩类
- (void)setupSixGameStyleView {
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
    [self setupCommon];
    if ([lottaryModel.showType intValue] == 1) {
        for (int i=0; i<8; i++) {
            CGFloat x = CFSize(10) + i * (30 + 3);
            CGRect frame = CGRectMake(x, 40, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:valueLabel];
            
            if (i != 6) {
                [valueLabel borderRadius:15];
            } else {
                valueLabel.backgroundColor = [UIColor clearColor];
                valueLabel.text = @"+";
                valueLabel.textColor = CFHexColor(@"#262628");
                valueLabel.font = [UIFont boldSystemFontOfSize:14 * getCFFontScale()];
            }
        }
    }else{
        for (int i=0; i<8; i++) {
            CGFloat paddingX = [UIScreen mainScreen].bounds.size.width - (CFSize(10) + 8 * (30 + 3));
            CGFloat x = CFSize(10) + i * (30 + 3)+paddingX;
            CGRect frame = CGRectMake(x, 10, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:valueLabel];
            
            if (i != 6) {
                [valueLabel borderRadius:15];
            } else {
                valueLabel.backgroundColor = [UIColor clearColor];
                valueLabel.text = @"+";
                valueLabel.textColor = CFHexColor(@"#262628");
                valueLabel.font = [UIFont boldSystemFontOfSize:14 * getCFFontScale()];
            }
        }
    }
}

- (void)configSixGameStyleCellData:(NSArray *)numberArr {
    for (int i=0; i<numberArr.count; i++) {
        if (i != 6) {
            UILabel *valueLabel = [self.contentView viewWithTag:201 + i];
            if (i < 6) {
                valueLabel.text = numberArr[i];
            } else {
                valueLabel.text = numberArr[numberArr.count - 1];
            }
        }
    }
}

//11选5
- (void)setupEFGameStyleView {
    [self setupCommon];
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
    if ([lottaryModel.showType intValue] == 1) {
        for (int i=0; i<5; i++) {
            CGFloat x = CFSize(10) + i * (30 + 3);
            CGRect frame = CGRectMake(x, 40, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel borderRadius:15];
            [self.contentView addSubview:valueLabel];
        }
    }else{
        for (int i=0; i<5; i++) {
            CGFloat paddingX = [UIScreen mainScreen].bounds.size.width - (CFSize(10) + 5 * (30 + 3));
            CGFloat x = CFSize(10) + i * (30 + 3)+paddingX;
            //        CGRect frame = CGRectMake(x, 40, 30, 30);
            CGRect frame = CGRectMake(x, 10, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel borderRadius:15];
            [self.contentView addSubview:valueLabel];
        }
    }
}

- (void)configEFGameStyleCellData:(NSArray *)numberArr {
    for (int i=0; i<numberArr.count; i++) {
        UILabel *valueLabel = [self.contentView viewWithTag:201 + i];
        valueLabel.text = numberArr[i];
    }
}

//幸运28
- (void)setupStylePC {
    [self setupCommon];
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
    if ([lottaryModel.showType intValue] == 1) {
        for (int i=0; i<7; i++){
            CGFloat x = CFSize(10) + i * (30 + 3);
            CGRect frame = CGRectMake(x, 40, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            if (i % 2 == 0) {
                [valueLabel borderRadius:15 borderColor:CFHexColor(@"#E5E5E5") borderWidth:1];
            }
            if (i % 2 != 0) {
                valueLabel.textColor = RGBCOLOR(38, 38, 40);
                valueLabel.backgroundColor = [UIColor clearColor];
                valueLabel.font = [UIFont boldSystemFontOfSize:18 * getCFFontScale()];
                valueLabel.text = @"+";
                if (i == 5) {
                    valueLabel.text = @"=";
                }
            }
            [self.contentView addSubview:valueLabel];
        }
    }else{
        for (int i=0; i<7; i++){
            CGFloat paddingX = [UIScreen mainScreen].bounds.size.width - (CFSize(10) + 7 * (30 + 3));
            CGFloat x = CFSize(10) + i * (30 + 3)+paddingX;
            //        CGFloat x = CFSize(10) + i * (30 + 3);
            CGRect frame = CGRectMake(x, 10, 30, 30);
            UILabel *valueLabel = [UILabel labelFrame:frame text:@"" bgColor:CFHexColor(@"#ED4230") textColor:CFHexColor(@"#FFFFFF") font:CFFont(14)];
            valueLabel.tag = 201+i;
            valueLabel.textAlignment = NSTextAlignmentCenter;
            [valueLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
            if (i % 2 == 0) {
                [valueLabel borderRadius:15 borderColor:CFHexColor(@"#E5E5E5") borderWidth:1];
            }
            if (i % 2 != 0) {
                valueLabel.textColor = RGBCOLOR(38, 38, 40);
                valueLabel.backgroundColor = [UIColor clearColor];
                valueLabel.font = [UIFont boldSystemFontOfSize:18 * getCFFontScale()];
                valueLabel.text = @"+";
                if (i == 5) {
                    valueLabel.text = @"=";
                }
            }
            [self.contentView addSubview:valueLabel];
        }
    }
}

- (void)configPCGameStyleCellData:(NSArray *)numberArr {
    for (int i=0; i<numberArr.count; i++) {
        NSInteger tag = 201 + 2*i;
        UILabel *valueLabel = [self.contentView viewWithTag:tag];
        if (!valueLabel) {return;}
        valueLabel.text = numberArr[i];
    }
}

- (void)configCellData {
    GameLottaryModel *lottaryModel = (GameLottaryModel *)self.cellModel;
//    if (lottaryModel.styleType == 1) {
        NSInteger showType = [lottaryModel.showType integerValue];
        if (showType == 1) {
            [self configSixGameStyleCellData: lottaryModel.numberArr];
        } else if (showType == 2) {
            [self configTimeGameStyleCellData: lottaryModel.numberArr];
        } else if (showType == 4) { //赛车类
            [self configPkStyleCellData: lottaryModel.numberArr];
        } else if (showType == 6) { //幸运28
            [self configPCGameStyleCellData:lottaryModel.numberArr];
        } else if (showType == 10) { //11选5
            [self configEFGameStyleCellData:lottaryModel.numberArr];
        }
//    } else {
//
//    }
}



@end
