//
//  QRCodeScanView.m
//  QRCode
//
//  Created by Apricot on 16/7/20.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "QRCodeScanView.h"


#define BOXWIDTH  250 //扫描范围宽度
#define BOXHEIGHT 250 //扫描范围高度


@interface QRCodeScanView () <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer *preview;
@property (nonatomic, copy) ScanBlock scanBlock;


/**
 *  闪关灯的按钮
 */
@property (nonatomic, strong) UIButton *torchBtn;
@end

@implementation QRCodeScanView
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)shade{
    UIView * maskView = [[UIView alloc] init];
    maskView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [self addSubview:maskView];
    //创建路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, CGRectGetWidth(maskView.frame), CGRectGetHeight(maskView.frame))];//绘制和透明黑色遮盖层一样的矩形
    //路径取反
    [path appendPath:[[UIBezierPath bezierPathWithRect:CGRectMake((CGRectGetWidth(self.frame)-BOXWIDTH)/2.0, (CGRectGetHeight(self.frame)-BOXHEIGHT)/2.0, BOXWIDTH, BOXHEIGHT)] bezierPathByReversingPath]];//绘制中间空白透明的矩形，并且取反路径。这样整个绘制的范围就只剩下，中间的矩形和边界之间的部分
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;//将路径交给layer绘制
    [maskView.layer setMask:shapeLayer];//设置遮罩层
    
    //闪光灯的按钮
    self.torchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.torchBtn.frame = CGRectMake(5, 5, 44, 44);
    //隐藏打开闪关灯的按钮
    self.torchBtn.hidden = YES;
    
    [self.torchBtn setTitle:@"开/关闪光灯" forState:UIControlStateNormal];
    [self.torchBtn addTarget:self action:@selector(turnTorch) forControlEvents:UIControlEventTouchUpInside];
    [maskView addSubview:self.torchBtn];
}

/**
 *  处理闪光灯
 */
- (void)turnTorch{
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    NSError *error = nil;
    if (captureDeviceClass != nil) {
        self.torchBtn.hidden = NO;
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            BOOL locked = [device lockForConfiguration:&error];
            if(locked){
                AVCaptureTorchMode torchMode = device.torchMode;
                switch (torchMode) {
                    case AVCaptureTorchModeOn:{
                        [device setTorchMode:AVCaptureTorchModeOff];
                    }break;
                    case AVCaptureTorchModeOff:{
                        [device setTorchMode:AVCaptureTorchModeOn];
                    }
                    default:
                        break;
                }
            }
            [device unlockForConfiguration];
        }
    }else{
        self.torchBtn.hidden = YES;
        NSLog(@"不存在闪关灯");
    }
}


- (void)scanCode:(ScanBlock)scanBlock{
    if(scanBlock){
        self.scanBlock = scanBlock;
    }
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSLog(@"无法打开相机");
        self.scanBlock(AVAuthorizationStatusNotDetermined,nil);
        return;
    }
    
    [self shade];
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        //没有权限的回调
        self.scanBlock(authStatus,nil);
        return;
    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:mediaType];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
//    dispatch_queue_t queue = dispatch_queue_create("com.Apricot.TH.HotelBusiness", DISPATCH_QUEUE_SERIAL);
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    AVCaptureConnection *outputConnection = [output connectionWithMediaType:mediaType];
    outputConnection.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    AVCaptureSession *session = [[AVCaptureSession alloc]init];
    self.session =session;
    //设置识别的分辨率
    [session setSessionPreset:([UIScreen mainScreen].bounds.size.height<500)?AVCaptureSessionPreset640x480:AVCaptureSessionPresetHigh];
    
    if ([session canAddInput:input])  {
        [session addInput:input];
    }
    
    if ([session canAddOutput:output])  {
        [session addOutput:output];
    }
    // 条码类型 AVMetadataObjectTypeQRCode
    output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
//    NSLog(@"%@",[output availableMetadataObjectTypes]);
    // Preview
    self.preview =[AVCaptureVideoPreviewLayer layerWithSession:session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = self.layer.bounds;
    [self.layer insertSublayer:self.preview atIndex:0];
    
//    //设置preview的放大倍数
//    self.preview.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
//    self.preview.affineTransform = CGAffineTransformMakeScale(1.5, 1.5);
//    //设置AVCaptureOutput焦点倍数
//    AVCaptureOutput * output2 = (AVCaptureOutput *)session.outputs[0];
//    AVCaptureConnection * focus = [output2 connectionWithMediaType:AVMediaTypeVideo];//获得摄像头焦点
//    focus.videoScaleAndCropFactor = 1.5;//焦点放大
    
    //设置扫描输出口的视图捕捉范围 通过AVCaptureVideoPreviewLayer 的metadataOutputRectOfInterestForRect方法计算
    //来源https://github.com/CxDtreeg/QRScanDemo
    //    [output setRectOfInterest:CGRectMake(0, 0, 1, 0.5)];
    CGRect cropRect = CGRectMake((CGRectGetWidth(self.frame)-BOXWIDTH)/2.0, (CGRectGetHeight(self.frame)-BOXHEIGHT)/2.0, BOXWIDTH, BOXHEIGHT);
    
//    output.rectOfInterest = [self.preview metadataOutputRectOfInterestForRect:cropRect];
    output.rectOfInterest =CGRectMake(cropRect.origin.y/CGRectGetHeight(self.frame), cropRect.origin.x/CGRectGetWidth(self.frame), CGRectGetHeight(cropRect)/CGRectGetHeight(self.frame), CGRectGetWidth(cropRect)/CGRectGetWidth(self.frame));
    [self.session startRunning];
}

- (void)stopScan{
    [self.session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *stringValue;
        if ([metadataObjects count] >0){
            //停止扫描
            [self.session stopRunning];
            AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
            stringValue = metadataObject.stringValue;
            NSLog(@"%@",stringValue);
            self.scanBlock(AVAuthorizationStatusAuthorized,stringValue);
            //扫码成功的回调
        }else{
            //扫码失败
            [self.session startRunning];
            return;
        }
    });
    
}
@end
