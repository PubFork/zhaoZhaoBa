//
//  XYCoachTableViewCell.m
//  zhaoZhaoBa
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XYCoachTableViewCell.h"

@implementation XYCoachTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMyData:(NSDictionary *)myData
{
    _myData = myData;
    
    [self.coach_imageView setImageWithURL:[NSURL URLWithString:myData[coach_c_img]] placeholder:kDefaultImage];
    self.nameLabel.text = myData[coach_c_name];
    self.schoolNameLabel.text = myData[driverSchool_schoolname];
    self.coachHistory.text = [kManager getStringAddXXYearWithObj:myData[coach_c_driving]];
    [self.praiseBtn setTitle:[kManager getStringWithObj:myData[coach_c_praiseNubmer]] forState:UIControlStateNormal];
    [self.unPraiseBtn setTitle:[kManager getStringWithObj:myData[coach_unlike]] forState:UIControlStateNormal];
    [self.distanceBtn setTitle:[kManager getStringAddKMWithObj:myData[DriverSchoolSortType_distance]] forState:UIControlStateNormal];
    self.passPro.text = myData[coach_passrate];
}

@end
