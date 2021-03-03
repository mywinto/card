//
//  apiheader.h
//
//
//  Created by Bravogo tech on 2018/2/2.
//  Copyright © 2018年 haoxingwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifndef apiheader_h
#define apiheader_h
#define webShareBaseUrl @"http://211.138.12.16:8090/static/template/"

//#define debugUrl @"http://192.168.31.149:8081"
#define debugUrl @"http://192.168.31.143:8088"
//#define debugUrl @"http://test-zhiboapi.xiaoya.cn"

//static NSString *const BaseCommonPortUrl =  @"http://36y0063z20.wicp.vip:47336";
static NSString *const BaseCommonPortUrl =  @"http://fanxianapi.yihuo.cn";

#ifdef DEBUG

//上传图片到cdn服务器
static NSString *const CdnUploadfile =  @"http://192.168.3.104:8081/api/upload/uploadfile";
static NSString *const CdnUploadfile1 =  @"http://down.xiaoyataoke.com/uploadfile/api/upload/uploadfile";

#define isNoDebug [[NSUserDefaults standardUserDefaults] boolForKey:IosIsPortNoDebug]
#define isDebugUrl [[NSUserDefaults standardUserDefaults] stringForKey:IosIsPortDebugUrl]

#define BasePortUrl isDebugUrl ?isDebugUrl : BaseCommonPortUrl

#else
static NSString *const CdnUploadfile =  @"http://down.xiaoyataoke.com/uploadfile/api/upload/uploadfile";
static NSString *const CdnUploadfile1 =  @"http://down.xiaoyataoke.com/uploadfile/api/upload/uploadfile";

#define BasePortUrl BaseCommonPortUrl


#endif


#define webUrl(str) [NSString stringWithFormat:@"%@%@",webShareBaseUrl,str]
#define BaseUrl(str) [NSString stringWithFormat:@"%@%@",BasePortUrl,str]

//html5连接
static NSString *const toShare =@"visitor/toShare.html";


  //获取聊天记录
  static NSString *const  liaotianListGet =
     @"/api/zhibo/liaotianlistget";



//发送验证码 - 绑定手机号
static NSString *const SendCodeForBindPhoneNumber =  @"/api/FanLi/SendCodeForBindPhoneNumber";
//获取分类下所有子分类列表
static NSString *const GetChildGoodsTypeListByCatId = @"/api/FanLi/GetChildGoodsTypeListByCatId";
//获取所有分类列表
static NSString *const GetGoodsTypeList = @"/api/FanLi/GetGoodsTypeList";
//绑定手机号
static NSString *const BindPhoneNumber = @"/api/FanLi/BindPhoneNumber";
//手机号登录
static NSString *const UserLoginPhone = @"/api/FanLi/UserLoginPhone";
//发送验证码 - 手机号登录
static NSString *const SendCodeForPhoneLogin = @"/api/FanLi/SendCodeForPhoneLogin";
//微信登录
static NSString *const UserLoginWx = @"/api/FanLi/UserLoginWx";
//获取用户详情
static NSString *const GetUserInfoById = @"/api/FanLi/GetUserInfoById";
//获取商品列表
static NSString *const GetGoodsList = @"/api/FanLi/GetGoodsList";
//获取订单列表
static NSString *const GetOrderList = @"/api/FanLi/GetOrderList";
//GetOrderInfo
static NSString *const GetOrderInfo = @"/api/FanLi/GetOrderInfo";
//获取商品推广链接
static NSString *const GetGoodsLink = @"/api/FanLi/GetGoodsLink";
//获取商品详情
static NSString *const GetItemInfo = @"/api/FanLi/GetItemInfo";
//首页 - 获取热门推荐商品
static NSString *const GetHotItemList = @"/api/FanLi/GetHotItemList";
//首页 - 获取超级返商品
static NSString *const GetSupperBackGoods = @"/api/FanLi/GetSupperBackGoods";
//首页 - 获取广告列表
static NSString *const GetAdList = @"/api/FanLi/GetAdList";
//团队 - 获取我的团队信息
static NSString *const GetMyTeam = @"/api/FanLi/GetMyTeam";
//团队 - 获取返利明细
static NSString *const GetRebateList = @"/api/FanLi/GetRebateList";
//检测APP是否需要更新
static NSString *const CheckAppIsNeedUpadte = @"/api/FanLi/CheckAppIsNeedUpadte";
//获取消息列表
static NSString *const GetMessageList = @"/api/FanLi/GetMessageList";
//获取返利详情
static NSString *const GetWithdrawalInfo = @"/api/FanLi/GetWithdrawalInfo";
//获取提现记录
static NSString *const GetWithdrawalList = @"/api/FanLi/GetWithdrawalList";
//提现验证码
static NSString *const SendCodeForWithdrawal = @"/api/FanLi/SendCodeForWithdrawal";
//提现
static NSString *const GetWithdrawal = @"/api/FanLi/GetWithdrawal";

//根据口令获取商品信息
static NSString *const GetGoodsByCommand = @"/api/FanLi/GetGoodsByCommand";


//static int  const CommonColorffffff =   0xffffff; // CommonColorffffff  0xffffff
//static int  const themeColor =   0xffffff; // CommonColorffffff  0xffffff


//正则

//手机号
//https://blog.csdn.net/to_study/article/details/106832942
//static NSString *const regularPhone  = @"^1(3([0-35-9]\\d|4[1-8])|4[14-9]\\d|5([0125689]\\d|7[1-79])|66\\d|7[2-35-8]\\d|8\\d{2}|9[89]\\d)\\d{7}$";
static NSString *const regularPhone  = @"^1\\d{10}$";
static NSString *const kATRegular  = @"@([^@\\s]*)\\s";
//@"@[\\u4e00-\\u9fa5\\w\\-\\_]+ ";


///** 直接传入精度丢失有问题的Double类型*/
//NSString * decimalNumberWithJSONDouble(double conversionValue){
//    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
//    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
//    return [decNumber stringValue];
//}




#endif /* apiheader_h */
