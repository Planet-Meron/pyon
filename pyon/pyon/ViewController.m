//
//  ViewController.m
//  pyon
//
//  Created by 石橋 弦樹 on 11/10/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//
@class make_probrem;

#import "ViewController.h"

@implementation ViewController
@synthesize btn_start;
@synthesize btn_yellow;
@synthesize btn_green;
@synthesize btn_blue;
@synthesize ad;
@synthesize btn_record;
@synthesize btn_red;
//それぞれ呼び出し用
#define call_red 0
#define call_yellow  1
#define call_blue 2
#define call_green 3

//それぞれジャッジ用
#define push_red 0
#define push_yellow 1
#define push_blue 2
#define push_green 3

#define q_interval 0.3


#define limit 100



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSString *path = [[NSBundle mainBundle] pathForResource:@"so" ofType:@"caf"];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"do_high" ofType:@"caf"];
    NSString *path3 = [[NSBundle mainBundle] pathForResource:@"do_low" ofType:@"caf"];
    NSString *path4 = [[NSBundle mainBundle] pathForResource:@"mi" ofType:@"caf"];
    NSString *path5 = [[NSBundle mainBundle] pathForResource:@"muci_bara_18" ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURL *url2 = [NSURL fileURLWithPath:path2];
    NSURL *url3 = [NSURL fileURLWithPath:path3];
    NSURL *url4 = [NSURL fileURLWithPath:path4];
    NSURL *url5 = [NSURL fileURLWithPath:path5];
    
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url, &soudID);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url2, &soundID2);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url3, &soundID3);
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url4, &soundID4);
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url5, &fail);
    
    //フラグの設定
    gameflg = YES;
    
    //広告
    self.ad = [[ADBannerView alloc] initWithFrame:CGRectZero];
    self.ad.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
    [self.view addSubview:self.ad];
    //self.ad.delegate = self;
    
    self.ad.requiredContentSizeIdentifiers = [NSSet setWithObjects:ADBannerContentSizeIdentifierPortrait, nil];
    [self moveBannerViewOffscreen];
    
    //ボタン初期設定
    //btn_record.titleLabel.text = NSLocalizedString(@"record", @"");
}

//広告バナーを画面の外に
- (void)moveBannerViewOffscreen{
    
    CGRect newBannerView = self.view.frame;
    newBannerView.origin.y = self.view.frame.size.height;
    self.ad.frame = newBannerView;
    
}

//広告バナーを画面の中に
- (void)moveBannerViewOnscreen{
    
    CGRect newBannerView = self.view.frame;
    newBannerView.origin.y = self.view.frame.size.height - self.ad.frame.size.height;
    
    [UIView beginAnimations:@"BannerViewIntro" context:NULL];
    self.ad.frame = newBannerView;
    [UIView commitAnimations];
    
    
    
}

//広告読み込み完了
- (void)bannerViewDidLoadAd:(ADBannerView * )banner{
    [self moveBannerViewOnscreen];
    NSLog(@"complete");
}


//広告読み込み失敗
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    [self moveBannerViewOffscreen];
    NSLog(@"ad fail");
}

- (void)viewDidUnload
{
    [self setBtn_red:nil];
    [self setBtn_start:nil];
    [self setBtn_yellow:nil];
    [self setBtn_green:nil];
    [self setBtn_blue:nil];
    AudioServicesDisposeSystemSoundID(soudID);
    AudioServicesDisposeSystemSoundID(soundID2);
    AudioServicesDisposeSystemSoundID(soundID3);
    AudioServicesDisposeSystemSoundID(soundID4);
    [self setAd:nil];
    [self setBtn_record:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    return NO;
}

//タイマーで引数は渡せんのかね
- (void)kussyon{
    [self make_probrem:level_limit];
}

//記録の保存
- (void)save:(NSInteger)score{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:score forKey:@"score"];
}

//ボタン復活
- (void)revive{
    btn_blue.enabled = YES;
    btn_green.enabled = YES;
    btn_red.enabled = YES;
    btn_yellow.enabled = YES;
    btn_start.enabled = YES;
    gameflg = YES;
}

//正誤判定
- (void)judge:(int)color{
    
    if (gameflg == NO) {
    if (n_max[index] == color) {
        index++;
    }else{
        AudioServicesPlaySystemSound(fail);
        //ボタンの無効化
        btn_blue.enabled = false;
        btn_green.enabled = NO;
        btn_red.enabled = NO;
        btn_yellow.enabled = NO;
        btn_start.enabled = NO;
        
        //ボタン復活へ
        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(revive) userInfo:nil repeats:NO];
    }
    
        
    //次のレベルへ
    if (index == level_limit) {
        if (level_limit<limit) {
            level_limit++;
        }
        
        [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(kussyon) userInfo:nil repeats:NO];
        index = 0;
        
        //記録の保存
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ((level_limit-1)>[defaults integerForKey:@"score"]) {
            [defaults setInteger:(level_limit-1) forKey:@"score"];
        }
    }
    }
    
}
//青を戻す
- (void)blue_back{
    UIImage *image2 = [UIImage imageNamed:@"btn_blue.png"];
    [btn_blue setImage:image2 forState:UIControlStateNormal];
}

//問題出題時の青
- (void)q_blue{
    UIImage *image1 = [UIImage imageNamed:@"btn_blue_push.png"];
    [btn_blue setImage:image1 forState:UIControlStateNormal];
    AudioServicesPlaySystemSound(soudID);
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(blue_back) userInfo:nil repeats:NO];
}
//青いボタンをしたら…
- (IBAction)btn_blue:(id)sender {
    
    [self judge:push_blue];
    AudioServicesPlaySystemSound(soudID);

}

//緑を戻す
- (void)green_back{
    UIImage *image2 = [UIImage imageNamed:@"btn_green.png"];
    [btn_green setImage:image2 forState:UIControlStateNormal];
}

//問題出題時の緑
- (void)q_green{
    UIImage *image1 = [UIImage imageNamed:@"btn_green_push.png"];
    [btn_green setImage:image1 forState:UIControlStateNormal];
    AudioServicesPlaySystemSound(soundID2);
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(green_back) userInfo:nil repeats:NO];
}

//緑のボタン押したら…
- (IBAction)btn_green:(id)sender {
    
    [self judge:push_green];
    AudioServicesPlaySystemSound(soundID2);
}

//赤を戻す
- (void)red_back{
        UIImage *image2 = [UIImage imageNamed:@"btn_red.png"];
    [btn_red setImage:image2 forState:UIControlStateNormal];
}

//問題出題時の赤
- (void)q_red{
    UIImage *image1 = [UIImage imageNamed:@"btn_red_push.png"];
    [btn_red setImage:image1 forState:UIControlStateNormal];
    AudioServicesPlaySystemSound(soundID3);
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(red_back) userInfo:nil repeats:NO];
}

//赤いボタン押したら…
- (IBAction)btn_red:(id)sender {
    [self judge:push_red];
    AudioServicesPlaySystemSound(soundID3);
}


//黄色戻す
- (void)yellow_back{
    UIImage *img_y = [UIImage imageNamed:@"btn_yellow.png"];
    [btn_yellow setImage:img_y forState:UIControlStateNormal];
    
}

//問題出題時の黄
- (void)q_yellow{
    UIImage *image1 = [UIImage imageNamed:@"btn_yellow_push.png"];
    [btn_yellow setImage:image1 forState:UIControlStateNormal];
    AudioServicesPlaySystemSound(soundID4);
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(yellow_back) userInfo:nil repeats:NO];
}

//黄色いボタン押したら…
- (IBAction)btn_yellow:(id)sender {
    
    [self judge:push_yellow];
    AudioServicesPlaySystemSound(soundID4);
}

//問題を作る
- (void)make_probrem:(int)level{
    
    NSLog(@"make_probrem");
    int i;
    for (i=0; i<level; i++) {
        n[level] = arc4random()%4;
        switch (n[level]) {
            case call_red:
                [NSTimer scheduledTimerWithTimeInterval:q_interval*(i+1) target:self selector:@selector(q_red) userInfo:nil repeats:NO];
                break;
            case call_blue:
                [NSTimer scheduledTimerWithTimeInterval:q_interval*(i+1) target:self selector:@selector(q_blue) userInfo:nil repeats:NO];
                break;
            case call_yellow:
                [NSTimer scheduledTimerWithTimeInterval:q_interval *(i+1)target:self selector:@selector(q_yellow) userInfo:nil repeats:NO];
                break;
            case call_green:
                [NSTimer scheduledTimerWithTimeInterval:q_interval*(i+1) target:self selector:@selector(q_green) userInfo:nil repeats:NO];
                break;
            default:
                break;
        }
    
        n_max[i] = n[level];
    }

    
    
    
}


//ゲーム開始
- (IBAction)btn_start:(id)sender {
    
    if (gameflg == YES) {
       //スタート時初期値代入
        level_limit = 3;
        index = 0;
        [self make_probrem:level_limit];
        gameflg = NO;
        
    }
    

}
@end
