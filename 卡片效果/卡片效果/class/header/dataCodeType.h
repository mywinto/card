//
//  dataCodeType.h
//  yihuo
//
//  Created by YHIOS on 2020/6/6.
//  Copyright © 2020 YHIOS. All rights reserved.
//

#ifndef dataCodeType_h
#define dataCodeType_h

typedef enum  {
    DataErrorCodeTypeWifiError = -100,
    DataErrorCodeTypeNoData,
    DataErrorCodeTypeNoComment,
    DataErrorCodeTypeNoAnswer,
    DataErrorCodeTypeNoLogin,
    DataErrorCodeTypeNoKnown,
    DataErrorCodeTypeNoDataSoft,
    DataErrorCodeTypeNoAddress,
    DataErrorCodeTypeLoading,
    DataErrorCodeTypeNormal,


} DataErrorCodeType;

static NSString * const DataErrorCodeTypeWifiErrorMsg = @"您的网络开小差了";
static NSString * const DataErrorCodeTypeWifiErrorImg = @"nowifi.png";

static NSString * const DataErrorCodeTypeNoDataMsg = @"暂时还没有数据";
static NSString * const DataErrorCodeTypeNoDataImg = @"nowifi.png";

static NSString * const DataErrorCodeTypeNoCommentMsg = @"暂时没有评论";
static NSString * const DataErrorCodeTypeNoCommentImg = @"nowifi.png";

static NSString * const DataErrorCodeTypeNoAnswerMsg = @"暂时没有回答";
static NSString * const DataErrorCodeTypeNoAnswerImg = @"nowifi.png";

static NSString * const DataErrorCodeTypeNoLoginMsg = @"未登录";
static NSString * const DataErrorCodeTypeNoLoginBtnMsg = @"登录";
static NSString * const DataErrorCodeTypeNoLoginImg = @"nowifi.png";

static NSString * const DataErrorCodeTypeNoDataSoftMsg = @"暂无相关订单";
static NSString * const DataErrorCodeTypeNoDataSoftImg = @"nosoftdata.png";

static NSString * const DataErrorCodeTypeLoadingMsg = @"加载中...";
static NSString * const DataErrorCodeTypeLoadingImg = @"";

static NSString * const DataErrorCodeTypeNoAddressMsg = @"您还没有创建收货地址,点此添加";

#endif /* dataCodeType_h */
