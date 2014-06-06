//
//  SYXAlert.h
//  ModalWindowWithReturnValue
//
//  Created by shenyixin on 14-6-6.
//  Copyright (c) 2014年 shenyixin. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    SYXAlertOkReturn=1000,
    SYXAlertCancelReturn=1001,
};


@interface SYXAlert : NSObject
{
	NSButton *_okButton;
	NSButton *_cancelButton;
    NSTextField *_messageTextField;
    NSWindow    *_window;
    
    NSString *_okTitle;
    NSString *_cancelTitle;
    NSString *_messageText;
    id  _sheetDelegate;
    SEL _sheetDidEnd;

}

@property (assign) IBOutlet NSButton *okButton;
@property (assign) IBOutlet  NSButton *cancelButton;
@property (assign) IBOutlet  NSTextField *messageTextField;
@property (assign) IBOutlet  NSWindow *window;

+(SYXAlert *)alertWithMessageText:(NSString *)messageText okButton:(NSString *)okTitle cancelButton:(NSString *)cancelTitle;


-(NSInteger)runModal;
-(void)beginSheetModalForWindow:(NSWindow *)window modalDelegate:delegate didEndSelector:(SEL)selector contextInfo:(void *)info;

@end
