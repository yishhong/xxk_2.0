//
//  QRCodeScanView.h
//  QRCode
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ScanBlock)(AVAuthorizationStatus authorizationStatus, NSString *value);

@interface QRCodeScanView : UIView

/**
 *  开始扫描
 *
 *  @param scanBlock 扫描的回调
 */
- (void)scanCode:(ScanBlock)scanBlock;

/**
 *  停止扫描
 */
- (void)stopScan;

@end
