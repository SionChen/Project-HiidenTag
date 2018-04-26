//
//  SDWebImageManager+MJ.m
//  FingerNews
//
//  Created by mj on 13-9-23.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SDWebImageManager+MJ.h"

@implementation SDWebImageManager (MJ)

+ (void)downloadImageWithURL:(NSURL *)url
{
    // cmp不能为空
    [[SDWebImageManager sharedManager] downloadImageWithURL:url options:(SDWebImageLowPriority | SDWebImageRetryFailed) progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
    }];
}

@end
