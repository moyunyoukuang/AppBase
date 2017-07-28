//


#import "MyAudioManager.h"
#import <AVFoundation/AVFoundation.h>

#import "EMVoiceConverter.h"

#pragma mark- —————————————————————— 数据模型——————————————————————
///宏命令
///自定义属性

@interface MyAudioManager()<AVAudioPlayerDelegate,AVAudioRecorderDelegate>
{

    /** 公共播放次序*/
    __block  NSInteger publicplaytag;
}
@property (nonatomic, strong) AVAudioSession *session;
@property (nonatomic, strong) AVAudioPlayer *player;
@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) NSURL *recordFileURL;
@property (nonatomic, copy)   NSString *recordUrlKey;




/** 之前的播放模式设置*/
@property (nonatomic , strong )NSString * preSeting;

@end


@implementation MyAudioManager

/***************数据控制***************/

/***************视图***************/

#pragma mark- ——————————————————————调用层——————————————————————
#pragma mark- ********************生命周期********************
//dealloc 放最上面

+ (instancetype)sharedInstance
{
    static MyAudioManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc ] init];
        
    });
    
    return _sharedInstance;
}


-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        [self chuShiHua];
        [self setUpViews];
    }
    return self;
}

-(void)chuShiHua
{
    [self activeAudioSession];
}

-(void)setUpViews
{

    

}
#pragma mark- ********************调用事件********************


#pragma mark- 播放

- (void)playWithData:(NSData *)data finish:(void (^)())didFinish;
{
    [self playWithData:data andRecord:NO finish:didFinish];
}

/** 播放声音*/
-(void)playWithFileUrl:(NSString*)url finish:(didPlayFinish) didFinish
{
    NSData * data = [NSData dataWithContentsOfFile:url];
    
//    if([[[url pathExtension] lowercaseString]isEqualToString:@"mp3"] && data)
//    {//需要转换amr格式
//        NSString *strUrl = url;
//        NSString *strUrl_new = [NSString stringWithFormat:@"%@/%@.wav", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], [CommonTool UUID]];
//       
//        [EMVoiceConverter amrToWav:strUrl wavSavePath:strUrl_new];
//        data = [NSData dataWithContentsOfFile:strUrl_new];
//        
//        
//    }
    
    [self playWithData:data finish:didFinish];
}

/** 播放网络声音 （先下载后播放）*/
-(void)playWithUrl:(NSString*)url finish:(didPlayFinish) didFinish
{
    
    [self stopALlplay];
    
    publicplaytag ++;
    
    /** 当前播放次序*/
    NSInteger currentPlaytag = publicplaytag;
    
    self.currentPlayingUrl = url;
    dispatch_queue_t glouble = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(glouble, ^{
    
      __block  NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithStringSafe:url]];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(currentPlaytag == publicplaytag)
            {//判断是当前播放
                if([[[url pathExtension] lowercaseString]isEqualToString:@"amr"] && data)
                {//需要转换amr格式
                    NSString *strUrl = [NSString stringWithFormat:@"%@/%@.amr", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], [CommonTool UUID]];
                    NSString *strUrl_new = [NSString stringWithFormat:@"%@/%@.wav", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], [CommonTool UUID]];
                    [data writeToFile:strUrl atomically:YES];
                    [EMVoiceConverter amrToWav:strUrl wavSavePath:strUrl_new];
                    data = [NSData dataWithContentsOfFile:strUrl_new];
                    
                    
                }
                
                [self playWithData:data finish:didFinish];
            }
        });
    });
    
    
    
    
}


/**  播放声音
 @param all yes 会静音播放声音很小 no不会
 */
- (void)playWithData:(NSData *)data andRecord:(BOOL)all finish:(didPlayFinish) didFinish
{
    self.preSeting = self.session.category;
    //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    //[[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    
    NSString * playkey = AVAudioSessionCategoryPlayback;
    if(all )
    {
        playkey = AVAudioSessionCategoryPlayAndRecord;
    }

    NSError *err = nil;
    [self.session setCategory :playkey error:&err];
    
    [self stopALlplay];
    
    self.finishBlock = didFinish;
    
    NSError *playerError = nil;
    self.player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
    if (self.player)  {
        self.player.delegate = self;
        [self.player play];
    }
    
}

- (void)stopPlay{
    
    //[[UIDevice currentDevice] setProximityMonitoringEnabled:NO]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    [self.session setCategory:self.preSeting error:nil ];
    
    
    if (self.player) {
        if (self.player.isPlaying) {
            [self.player stop];
            
        }
        [self.session setCategory:self.preSeting error:nil ];
        self.player.delegate = nil;
        self.player = nil;
    }
    
    if(self.finishBlock)
    {
        self.finishBlock();
        self.finishBlock = nil;
    }
    
    self.currentPlayingUrl = nil;
}

/** 正在播放*/
-(BOOL)isPlaying
{
    return self.player.isPlaying;
}

#pragma mark- 录音


- (BOOL)startRecord
{
    
    if(![self initRecord])
    {
        NSAssert(NO, @"no recoreder");
        return NO;
    }
    
    self.preSeting = self.session.category;
    NSError *err = nil;
    [self.session setCategory :AVAudioSessionCategoryRecord error:&err];
    
    return [self.recorder record];
    
}

/** 录制定长音频*/
- (BOOL)startRecordForDuration:(NSTimeInterval)TimeInterval FinishBlock:(didRecordFinish)block
{
    if(![self initRecord])
    {
        return NO;
    }
    self.finishRecordBlock = block;
    
    self.preSeting = self.session.category;
    NSError *err = nil;
    [self.session setCategory :AVAudioSessionCategoryRecord error:&err];
    
    
    return [self.recorder recordForDuration:TimeInterval];
}

/** 暂停录音*/
- (void)pauseRecord
{
    [self.recorder pause];
}
/** 继续录音*/
- (void)continueRecord
{
    [self.recorder record];
}

/** 继续录音*/
- (void)continueRecordForDuration:(NSTimeInterval)TimeInterval
{
    [self.recorder recordForDuration:TimeInterval];
}

- (void)stopRecord
{

    [self.session setCategory:self.preSeting error:nil ];
    
    NSTimeInterval duration = [self recordTime];
    [self.recorder stop];
    
    if (self.finishRecordBlock) {
        self.finishRecordBlock(self.recordUrlKey, (NSInteger)(round(duration)),YES);
        self.finishRecordBlock = nil;
    }
}

- (void)stopRecordWithBlock:(didRecordFinish)block
{
    self.finishRecordBlock = nil;
    [self.session setCategory:self.preSeting error:nil ];
    NSTimeInterval duration = [self recordTime];
    [self.recorder stop];
    
    if (block) {
        block(self.recordUrlKey, (NSInteger)(round(duration)),YES);
    }
    
    
    
    ///用法
//    [[MyAudioManager sharedInstance] stopRecordWithBlock:^(NSString *urlKey, NSInteger time){
//        self.audioRecord.filePath = urlKey;
//        self.audioRecord.audioData = [NSData dataWithContentsOfFile:self.audioRecord.filePath];
//        self.audioRecord.duration = time;
//    }];
}


- (CGFloat)peakPowerMeter{
    

    [self.recorder updateMeters];
    
    float   level;                // The linear 0.0 .. 1.0 value we need.
    
    float   minDecibels = -120.0f; // Or use -60dB, which I measured in a silent room.
    
    float   decibels = [self.recorder averagePowerForChannel:0];
    
    if (decibels < minDecibels)
        
    {
        
        level = 0.0f;
        
    }
    
    else if (decibels >= 0.0f)
        
    {
        
        level = 1.0f;
        
    }
    
    else
        
    {
        
        float   root            = 2.0f;
        
        float   minAmp          = powf(10.0f, 0.05f * minDecibels);
        
        float   inverseAmpRange = 1.0f / (1.0f - minAmp);
        
        float   amp             = powf(10.0f, 0.05f * decibels);
        
        float   adjAmp          = (amp - minAmp) * inverseAmpRange;
        
        level = powf(adjAmp, 1.0f / root);
        
    }
    
    return level;
}

- (NSInteger)recordTime{
    return self.recorder.currentTime+0.5;
}

/** 正在录制*/
-(BOOL)isRecording
{

    return self.recorder.isRecording;
}

#pragma mark- ********************点击事件********************
#pragma mark- ********************代理方法********************

#pragma mark- AVAudioRecorderDelegate <NSObject>


/* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
//- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
//{
//    
//    [self.session setCategory:self.preSeting error:nil ];
//    if(self.finishRecordBlock  )
//    {
//        NSTimeInterval duration = [self recordTime];
//      
//        self.finishRecordBlock(self.recordUrlKey, (NSInteger)(round(duration)) ,flag);
//    
//    }
//    
//}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error
{
    NSString * errorString = [NSString stringWithFormat:@"录音出错:%@",error];
    
    [[AppManager shareManager] showtagMessage:errorString ControllerTag:0];
    
    [self.session setCategory:self.preSeting error:nil ];
    
    if(self.finishRecordBlock  )
    {
        NSTimeInterval duration = [self recordTime];
        
        self.finishRecordBlock(self.recordUrlKey, (NSInteger)(round(duration)) ,NO);
        self.finishRecordBlock = nil;
    }
    
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
  
    
    [self stopPlay];
    
    
    
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    NSString * errorString = [NSString stringWithFormat:@"播放出错:%@",error];
    
    [[AppManager shareManager] showtagMessage:errorString ControllerTag:0];
    self.currentPlayingUrl = nil;
     //[[UIDevice currentDevice] setProximityMonitoringEnabled:NO]; //建议在播放之前设置yes，播放结束设置NO，这个功能是开启红外感应
    [self.session setCategory:self.preSeting error:nil ];

    if (self.finishBlock) {
        self.finishBlock();
    }
    self.currentPlayingUrl = nil;
}

#pragma mark - 红外线感知事件
//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState] == YES)
    {
        NSLog(@"Device is close to user");
        [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        
    }
    else
    {
        [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}
#pragma mark- ——————————————————————实现层——————————————————————
#pragma mark- ********************数据获取********************
//网络请求 数据获取
#pragma mark- ********************获得数据********************
#pragma mark- ********************视图创建********************
/** 创建所有视图*/
-(void)createAllView
{

}
#pragma mark- ********************界面样式控制********************
//更改界面数据显示 视图样式 动态视图
#pragma mark- ********************界面相关处理事件********************
//视图功能集合
#pragma mark- ********************功能实现********************
//不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
/** 开启始终以扬声器模式播放声音*/
- (void)activeAudioSession
{
    self.session = [AVAudioSession sharedInstance];
    NSError *sessionError = nil;
    [self.session setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    self.preSeting = AVAudioSessionCategoryPlayback;
    //    AVAudioSessionCategorySoloAmbient/kAudioSessionCategory_SoloAmbientSound
    
    
    //    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    //    AudioSessionSetProperty (
    //                             kAudioSessionProperty_OverrideAudioRoute,
    //                             sizeof (audioRouteOverride),
    //                             &audioRouteOverride
    //                             );
    
    [self.session setActive: YES error: nil];
 
    
    
    
    //添加红外监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:@"UIDeviceProximityStateDidChangeNotification"
                                               object:nil];
}


- (BOOL)initRecord{
    
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:8] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityLow] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@/%@.aac", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject], [CommonTool UUID]];
    NSURL *url = [NSURL fileURLWithPath:strUrl];
    self.recordUrlKey = strUrl;
    //    self.audioRecord.filePath = strUrl;
    
    NSError *error;
    //初始化
    _recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    self.recorder.meteringEnabled = NO;
    self.recorder.delegate        = self;
    
    if ([self.recorder prepareToRecord]){
        return YES;
    }
    return NO;
}





/** 清空所有动作 播放和录制*/
-(void)clearAllAction
{
    if([self isPlaying])
    {
        [self stopPlay];
    }
    
    if([self isRecording])
    {
        [self stopRecord];
    }
    
    
}

/** topallplay 清除播放动作*/
-(void)stopALlplay
{
    if (self.player) {
        if (self.player.isPlaying) {
            [self.player stop];
            
        }
        
        self.player.delegate = nil;
        self.player = nil;
    }
    if(self.finishBlock)
    {
        self.finishBlock();
        self.finishBlock = nil;
    }
}
#pragma mark- ********************跳转其他页面********************


@end
