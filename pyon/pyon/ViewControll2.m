//
//  ViewControll2.m
//  pyon
//
//  Created by 石橋 弦樹 on 11/11/12.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import "ViewControll2.h"

@implementation ViewControll2
@synthesize lbl_top;
@synthesize lbl_record;
@synthesize lbl_times;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //テキスト代入
    lbl_top.text = NSLocalizedString(@"top_text", @"");
    lbl_times.text = NSLocalizedString(@"times", @"");
    //記録代入
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults integerForKey:@"score"]) {//記録未設定
        [defaults setInteger:0 forKey:@"score"];
        lbl_record.text = @"0";
    }else{//記録設定後
        lbl_record.text = [[NSNumber numberWithInteger:[defaults integerForKey:@"score"]] stringValue];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)viewDidUnload
{
    [self setLbl_top:nil];
    [self setLbl_record:nil];
    [self setLbl_times:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
