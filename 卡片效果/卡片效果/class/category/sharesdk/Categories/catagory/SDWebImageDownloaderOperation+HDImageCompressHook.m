#import "SDWebImageDownloaderOperation+HDImageCompressHook.h"
#import "HDBJHookTool.h"

@implementation SDWebImageDownloaderOperation (HDImageCompressHook)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        SEL originalSelector1 = @selector(URLSession: task: didCompleteWithError:);
//        SEL swizzledSelector1 = @selector(hd_URLSession: task: didCompleteWithError:);
//        [HDBJHookTool swizzlingInClass:[self class] originalSelector:originalSelector1 swizzledSelector:swizzledSelector1];
//        [HDBJHookTool swizzlingInClass:[self class] originalSelector:originalSelector1 swizzledSelector:swizzledSelector1];
//
//        SEL originalSelector2 = @selector(callCompletionBlocksWithImage:
//                                          imageData:
//                                          error:
//                                          finished:);
//        SEL swizzledSelector2 = @selector(hd_callCompletionBlocksWithImage:
//                                          imageData:
//                                          error:
//                                          finished:);
//        [HDBJHookTool swizzlingInClass:[self class] originalSelector:originalSelector2 swizzledSelector:swizzledSelector2];
    });
}
#pragma mark - Method Swizzling
- (void)hd_URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{

    Ivar ivar1 = class_getInstanceVariable([self class], "_imageData");
    if (object_getIvar(self, ivar1)) {
        NSMutableData * imageData = (NSMutableData *)object_getIvar(self, ivar1);
        NSData *imgData = UIImageJPEGRepresentation([UIImage imageWithData:[imageData copy]],1);
        NSUInteger sizeOriginKB = imageData.length / 1024;
         if (sizeOriginKB > 500){
            imgData = UIImageJPEGRepresentation([UIImage imageWithData:[imageData copy]],0.1);
            [[SDImageCache sharedImageCache] setValue:nil forKey:@"memCache"];
        }
//        imgData = [self resetSizeOfImageData:[UIImage imageWithData:[imageData copy]] maxSize:50];
        
        if (imgData.length/1024 > 200) {
            UIImage *image = [self compressImageWith:[UIImage imageWithData:imgData]];
            imgData = UIImagePNGRepresentation(image);
//            MyLog(@"didCompleteWithError---------%ld",imgData.length/1024);
            if (imgData.length/1024 > 200) {
                imageData = [NSMutableData dataWithData:[self resetSizeOfImageData:image maxSize:90]];
//                MyLog(@"didCompleteWithErrorresetSizeOfImageData---------%ld",imageData.length/1024);
            }
        }
        imageData = [NSMutableData dataWithData:imgData];
        object_setIvar(self, ivar1, imageData);
    }
    [self hd_URLSession:session task:task didCompleteWithError:error];
}

- (void)hd_callCompletionBlocksWithImage:(nullable UIImage *)image
                               imageData:(nullable NSData *)imageData
                                   error:(nullable NSError *)error
                                finished:(BOOL)finished{
    NSUInteger sizeOriginKB = imageData.length / 1024;
    if (sizeOriginKB > 500){
        imageData = UIImageJPEGRepresentation(image,0.1);
        image = [UIImage imageWithData:imageData];
    }
//    imageData = [self resetSizeOfImageData:image maxSize:90];
    image = [UIImage imageWithData:imageData];
    if (imageData.length/1024 > 200) {
        image = [self compressImageWith:image];
        imageData = UIImagePNGRepresentation(image);
//        MyLog(@"hd_callCompletionBlocksWithImage---------%ld",imageData.length/1024);
        if (imageData.length/1024 > 200) {
            imageData = [self resetSizeOfImageData:image maxSize:90];
            image = [UIImage imageWithData:imageData];
//            MyLog(@"hd_callCompletionBlocksWithImageresetSizeOfImageData---------%ld",imageData.length/1024);
        }
    }
    
    [self hd_callCompletionBlocksWithImage:image
                                 imageData:imageData
                                     error:error
                                  finished:finished];
}
-(UIImage *)compressImageWith:(UIImage *)image{
    
    float imageWidth = image.size.width;
    float imageHeight = image.size.height;
    float width = 320;
    float height = image.size.height/(image.size.width/width);
    float widthScale = imageWidth /width;
    float heightScale = imageHeight /height;
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    if (widthScale > heightScale) {
        [image drawInRect:CGRectMake(0, 0, imageWidth /heightScale , height)];
    }else{
        [image drawInRect:CGRectMake(0, 0, width , imageHeight /widthScale)];
    }
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark - 图片压缩
- (NSData *)resetSizeOfImageData:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}
#pragma mark 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark 二分法
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
//        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
//        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}
@end
