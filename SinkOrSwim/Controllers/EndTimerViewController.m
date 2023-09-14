//
//  EndTimerViewController.m
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//


#import "EndTimerViewController.h"

@interface EndTimerViewController ()

@end

@implementation EndTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)popViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end

