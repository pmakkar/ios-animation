//
//  CanvasViewController.m
//  Canvas
//
//  Created by Puneet Makkar on 9/17/15.
//  Copyright © 2015 Puneet Makkar. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()

@property (weak, nonatomic) IBOutlet UIView *trayView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panRecognizer;
@property CGPoint trayOriginalCenter;

@property (strong, nonatomic) UIImageView *newlyCreatedFace;
@property (strong, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIImageView *deadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *excitedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tongueImageView;

@property (weak, nonatomic) IBOutlet UIImageView *winkImageView;
@property (weak, nonatomic) IBOutlet UIImageView *happyImageView;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *deadRecognizer;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *excitedRecognizer;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *happyrecognizer;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *sadRecognizer;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *tongueRecognizer;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *winkRecognizer;


@end

@implementation CanvasViewController


- (IBAction)onImagePan:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:sender.view];
    
    NSLog(@"image x is: %f", sender.view.center.x);
    NSLog(@"image y is: %f", sender.view.center.y);
    NSLog(@"trans x is: %f", translation.x);
    NSLog(@"trans y is: %f", translation.y);
    
    UIImageView *imageView = (UIImageView *)sender.view;
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        self.newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
        NSLog(@"Moving image Started");
            }
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        NSLog(@"Image Moving");
        
        self.newlyCreatedFace.center = CGPointMake(imageView.center.x, imageView.center.y);
        self.newlyCreatedFace.center = CGPointMake(imageView.center.x + self.trayView.frame.origin.x + translation.x, imageView.center.y + self.trayView.frame.origin.y + translation.y);
        [self.view addSubview:self.newlyCreatedFace];
        
    }
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        NSLog(@"Image Ended");
    }
    
}

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {

    CGPoint translation = [sender translationInView:self.view];
    CGPoint velocity = [sender velocityInView:self.view];
    
    NSLog(@"trayview x is: %f", self.trayView.center.x);
    NSLog(@"trayview y is: %f", self.trayView.center.y);
    NSLog(@"velocityx is: %f", velocity.x);
    NSLog(@"velocityy is: %f", velocity.y);
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"Tray Started");
        self.trayOriginalCenter = self.trayView.center;
    }
    
    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        NSLog(@"Tray Changing");
        self.trayView.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + translation.y);
    }

    if ([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
       NSLog(@"Tray Ended");
        if(velocity.y > 0) {
            self.trayView.center = CGPointMake(self.trayOriginalCenter.x, 730);
        } else if(velocity.y < 0) {
            self.trayView.center = CGPointMake(self.trayOriginalCenter.x, 580);
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTrayPanGesture:)];
    UIPanGestureRecognizer *excitedRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    UIPanGestureRecognizer *deadRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    UIPanGestureRecognizer *happyRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    UIPanGestureRecognizer *sadRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    UIPanGestureRecognizer *tongueRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    UIPanGestureRecognizer *winkRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onImagePan:)];
    
    [self.trayView addGestureRecognizer:panRecognizer];
     self.trayView.center = CGPointMake(181, 730);
    
    [self.deadImageView addGestureRecognizer:deadRecognizer];
    [self.excitedImageView addGestureRecognizer:excitedRecognizer];
    [self.happyImageView addGestureRecognizer:happyRecognizer];
    [self.sadImageView addGestureRecognizer:sadRecognizer];
    [self.tongueImageView addGestureRecognizer:tongueRecognizer];
    [self.winkImageView addGestureRecognizer:winkRecognizer];
}
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
