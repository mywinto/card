//
//  color.h
//  
//
//  Created by Bravogo tech on 2018/2/2.
//  Copyright © 2018年 haoxingwang. All rights reserved.
//

#ifndef color_h
#define color_h
//#define ColorRGB(r,g,b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:1.0]
//#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define basecolor1 [UIColor colorWithRed:188/256.0 green:188/256.0 blue:188/256.0 alpha:1.0]
//深灰
#define basecolor2 [UIColor colorWithRed:201/256.0 green:201/256.0 blue:201/256.0 alpha:1.0]
#define basecolor21 [UIColor colorWithRed:246/256.0 green:246/256.0 blue:246/256.0 alpha:1.0]
#define basecolor22 [UIColor colorWithRed:243/256.0 green:243/256.0 blue:248/256.0 alpha:1.0]
#define basecolor23 [UIColor colorWithRed:139/256.0 green:139/256.0 blue:139/256.0 alpha:1.0]

//灰色

#define basecolor3 [UIColor blueColor]
//蓝色
#define basecolor31 [UIColor colorWithRed:53/256.0 green:159/256.0 blue:255/256.0 alpha:1.0]
#define basecolor32 [UIColor colorWithRed:0/256.0 green:75/256.0 blue:224/256.0 alpha:1.0]

//浅蓝

#define basecolor4 [UIColor colorWithRed:30/256.0 green:255/256.0 blue:194/256.0 alpha:1.0]
//绿色头像边框
#define basecolor5 [UIColor colorWithRed:254/256.0 green:151/256.0 blue:10/256.0 alpha:1.0]
//橘黄色
#define basecolor6 [UIColor colorWithRed:255/256.0 green:98/256.0 blue:104/256.0 alpha:1.0]
//红色
#define basecolor7 [UIColor colorWithRed:122/256.0 green:208/256.0 blue:11/256.0 alpha:1.0]
//绿色


#define CKDarkMode (@available(iOS 13.0, *) && UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ) //暗黑模式



#define themeColor KUIColorFromRGB(themeColorInt)
#define themeColorInt 0xF39C40

#define CommonColor767676 0x767676
#define CommonColor767676  0x767676 //字体颜色
#define CommonColor757575  0x757575 //字体颜色

#define CommonColorAEAEAE  0xAEAEAE //字体颜色
#define CommonColor979797  0x979797 //边框颜色 字体颜色
#define CommonColorA5A5A5  0xA5A5A5 //浅色 字体颜色


#define CommonColorf2f2f2  0xF2F2F2 //浅色 背景色
#define CommonColorF5F5F5  0xF5F5F5 //浅色
#define CommonColorDBDBDB  0xDBDBDB //浅色
#define CommonColordcdcdc  0xdcdcdc //浅色


#define CommonColor000000  0x000000
#define CommonColorffffff  0xffffff

#define CommonColorfe6237  0xfe6237 // 字体颜色
#define CommonColor72A2A  0xF72A2A // 背景色

//#define themeColor [UIColor colorWithRed:234/256.0 green:104/256.0 blue:70/256.0 alpha:1.0]
//#define themeColor [UIColor colorWithRed:229/256.0 green:85/256.0 blue:55/256.0 alpha:1.0]

#define themeColor1 KUIColorFromRGB(0xDD4D3E)

#endif /* color_h */
