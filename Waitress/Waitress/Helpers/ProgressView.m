

#import "ProgressView.h"
#import "SVProgressHUD.h"

static NSString * const kLPPopupAnimationKey = @"kLPPopupAnimationKey";

@implementation ProgressView
@synthesize delegate;
@synthesize willNotIgnore;

-(instancetype)initWithTextFiled:(NSString *)title andMessage:(NSString *)message{
    
    self = [self initWithFrame:[self getFrame]];
    
    if (self) {
        
        titleText = title;
        messageText = message;
        [self setUp];
        [self setUpTextFilde];
        [self setUpButtons];
    }
    return self;
}
-(instancetype)initWithSpinnerAndTitle:(NSString *)title andMessage:(NSString *)message{
    
    self = [self initWithFrame:[self getFrame]];
    
    if (self) {
        
        titleText = title;
        messageText = message;
        [self setUp];
//        [self setUpSpinner];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self) {
        
        _popupColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(CGRect)getFrame{
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return screenRect;
}
-(void)setUp{
    
    [self setUpbackGroundView];
    [self setUpAlertView];
    [self setUpLblTitle];
    [self setUpLblMessage];
}
-(void)setUpbackGroundView{
    
    UIView *bg = [[UIView alloc]initWithFrame:self.frame];
    bg.backgroundColor = [UIColor blackColor];
    bg.alpha = 0.2;
    [self addSubview:bg];
}
-(void)setUpAlertView{
    
    alertView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.frame) / 1.4, 130)];
    
    alertView.center = self.center;
    
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.shadowColor = [[UIColor blackColor] CGColor];
    //   alertView.layer.shadowOffset = CGSizeMake(0f, 10.0f);
    alertView.layer.shadowOpacity = 1.0f;
    alertView.layer.shadowRadius = 10.0f;
    alertView.layer.cornerRadius = 10.0f;
}
-(void)setUpLblTitle{
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame), 20)];
    lbl.center = CGPointMake(CGRectGetWidth(alertView.frame) / 2, 20);
    lbl.text = titleText;
    //    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.textColor = [UIColor blackColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    lbl.font = [UIFont boldSystemFontOfSize:17];
    [alertView addSubview:lbl];
    
}
-(void)setUpLblMessage{
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(alertView.frame), 30)];
    lbl.center = CGPointMake(CGRectGetWidth(alertView.frame) / 2, 45);
    lbl.text = messageText;
    //    lbl.translatesAutoresizingMaskIntoConstraints = NO;
    lbl.textColor = [UIColor blackColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.numberOfLines = 0;
    lbl.font = [UIFont systemFontOfSize:15];
    [alertView addSubview:lbl];
}
-(void)setUpTextFilde{
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    textField.center = CGPointMake(CGRectGetWidth(alertView.frame) / 2, 60);
    textField.borderStyle = UITextBorderStyleLine;
    textField.placeholder = @"E-MAIL";
    [textField setFont:[UIFont fontWithName:@"Lato-Light" size:17]];
    textField.backgroundColor = [UIColor whiteColor];
    textField.returnKeyType = UIReturnKeySend;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    [textField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    textField.delegate = self;
    
    NSString *lastMail = [[NSUserDefaults standardUserDefaults]stringForKey:@"lastMail"];
    if (lastMail && ![lastMail isEqualToString:@""]) {
        
        textField.text = lastMail;
    }
    [alertView addSubview:textField];
}
-(void)becomeFirstResponder{
    
    [textField becomeFirstResponder];
}
-(void)setUpButtons{
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnCancel.frame = CGRectMake(0, 0, 100, 30);
    [btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    btnCancel.center = CGPointMake(80, CGRectGetHeight(alertView.frame) - 15);
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:17];
    
    UIButton *btnSend = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnSend.frame = CGRectMake(0, 0, 100, 30);
    [btnSend setTitle:@"Send" forState:UIControlStateNormal];
    btnSend.center = CGPointMake(180, CGRectGetHeight(alertView.frame) - 15);
    btnSend.titleLabel.font = [UIFont systemFontOfSize:17];
    btnSend.tag = 1;
    
    [btnCancel addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnSend addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [alertView addSubview:btnCancel];
    [alertView addSubview:btnSend];
}
-(void)setUpSpinner{
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(CGRectGetWidth(alertView.frame) / 2, CGRectGetHeight(alertView.frame) / 2 + 30);
    [spinner startAnimating];
    [alertView addSubview:spinner];
}
- (void)showInView:(UIView *)parentView{
    if (!willNotIgnore) {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }

    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0f]];
    [SVProgressHUD setForegroundColor:[UIColor colorWithRed:252/255.0f green:107/255.0f blue:107/255.0f alpha:1.0f]];
    [SVProgressHUD show];
    
    [parentView addSubview:self];
//    [self showAlertView];
}
-(void)showAlertView{
    
    CGFloat forwardAnimationDuration = 0.6f;
    //    self.animationCompletion = block;
    //
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.9f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    //
    //    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    //    animationGroup.animations = [NSArray arrayWithObjects:forwardAnimation, nil];
    //    animationGroup.delegate = self;
    //    animationGroup.duration = forwardAnimation.duration + 1;
    //    animationGroup.removedOnCompletion = NO;
    //    animationGroup.fillMode = kCAFillModeForwards;
    
    [self addSubview:alertView];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:0
                     animations:^{
                         [self.layer addAnimation:forwardAnimation
                                           forKey:kLPPopupAnimationKey];
                     }
                     completion:^(BOOL finished) {
                     }];
    
}
-(void)btnClick:(UIButton *)sender{
    
    [delegate clickedButtonAtIndex:sender.tag mail:textField.text];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField1 {
    
    [delegate clickedButtonAtIndex:1 mail:textField.text];
    return YES;
}
- (void)hidden{
    [SVProgressHUD dismiss];
    [self removeFromSuperview];
    
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];

//    CGFloat backwardAnimationDuration = 0.4f;
//    CABasicAnimation *reverseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    reverseAnimation.duration = backwardAnimationDuration;
//    //    reverseAnimation.beginTime = 1.4;
//    reverseAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
//    reverseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
//    reverseAnimation.toValue = [NSNumber numberWithFloat:0.9f];
//    
//    [self removeFromSuperview];
//    [UIView animateWithDuration:0.5
//                          delay:0.0
//                        options:0
//                     animations:^{
//                         [self.layer addAnimation:reverseAnimation
//                                           forKey:kLPPopupAnimationKey];
//                     }
//                     completion:^(BOOL finished) {
//                     }];
    
}
//- (void)drawRect:(CGRect)rect{
//    
//}

@end
