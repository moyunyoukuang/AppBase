
//

#import <Foundation/Foundation.h>

typedef void(^didPlayFinish)();
typedef void(^didRecordFinish)(NSString *urlKey, NSInteger time , BOOL scucess);

/** 音频录制，播放控制*/
@interface MyAudioManager : NSObject

+ (instancetype)sharedInstance;

/** 当前播放的音频地址*/
@property (nonatomic ,strong ) NSString * currentPlayingUrl;
/** 播放结束*/
@property (nonatomic, copy) didPlayFinish finishBlock;
/** 录音结束*/
@property (nonatomic, copy) didRecordFinish finishRecordBlock;
#pragma mark- 播放

- (void)playWithData:(NSData *)data finish:(didPlayFinish) didFinish;

/**  播放声音
 @param all yes 会静音播放声音很小 no不会
 */
- (void)playWithData:(NSData *)data andRecord:(BOOL)all finish:(didPlayFinish) didFinish;

/** 播放声音*/
-(void)playWithFileUrl:(NSString*)url finish:(didPlayFinish) didFinish;;

/** 播放网络声音 （先下载后播放）*/
-(void)playWithUrl:(NSString*)url finish:(didPlayFinish) didFinish;

-(void)stopPlay;


/** 正在播放*/
-(BOOL)isPlaying;


#pragma mark- 录音




/** 开始录音*/
- (BOOL)startRecord;
/** 录制定长音频*/
- (BOOL)startRecordForDuration:(NSTimeInterval)TimeInterval FinishBlock:(didRecordFinish)block;
/** 暂停录音*/
- (void)pauseRecord;
/** 继续录音*/
- (void)continueRecord;
/** 继续录音*/
- (void)continueRecordForDuration:(NSTimeInterval)TimeInterval;
/** 录音结束*/
- (void)stopRecord;
/** 录音结束*/
- (void)stopRecordWithBlock:(didRecordFinish)block;
/** 录音声音大小*/
- (CGFloat)peakPowerMeter;
/** 录音时长*/
- (NSInteger)recordTime;

/** 正在录制*/
-(BOOL)isRecording;


/** 清空所有动作 播放和录制*/
-(void)clearAllAction;


@end
