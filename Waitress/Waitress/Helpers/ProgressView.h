#import <UIKit/UIKit.h>

@protocol AlertViewDelegate <NSObject>

@optional
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)clickedButtonAtIndex:(NSInteger)buttonIndex mail:(NSString *)mail;

@end

@interface ProgressView : UIView <UITextFieldDelegate>
{
    NSString *messageText;
    NSString *titleText;
    UIView *alertView;
    UITextField *textField;
}
@property (nonatomic) BOOL willNotIgnore;
@property (strong, nonatomic) UIColor *popupColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, weak)id<AlertViewDelegate> delegate;
-(instancetype)initWithTextFiled:(NSString *)title andMessage:(NSString *)message;
-(instancetype)initWithSpinnerAndTitle:(NSString *)title andMessage:(NSString *)message;

- (void)showInView:(UIView *)parentView;
- (void)hidden;
- (void)becomeFirstResponder;

@end

