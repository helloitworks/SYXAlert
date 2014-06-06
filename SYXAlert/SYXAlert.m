//
//  SYXAlert.m
//  ModalWindowWithReturnValue
//
//  Created by shenyixin on 14-6-6.
//  Copyright (c) 2014年 shenyixin. All rights reserved.
//

#import "SYXAlert.h"

@implementation SYXAlert
@synthesize okButton = _okButton;
@synthesize cancelButton = _cancelButton;
@synthesize messageTextField = _messageTextField;
@synthesize window = _window;


- (id)initWithWindowNibName:(NSString *)windowNibName {
	self = [super init];
	if (self) {
        if (!_window)
        {
            [[NSBundle mainBundle] loadNibNamed:windowNibName owner:self topLevelObjects:nil];
        }
    }
    return self;
}

- (id)init
{
    return [self initWithWindowNibName:@"SYXAlert"];
}



+(SYXAlert *)alertWithMessageText:(NSString *)messageText okButton:(NSString *)okTitle cancelButton:(NSString *)cancelTitle
{
    SYXAlert *alert = [[[self alloc] init] autorelease];
    alert.messageTextField.stringValue = messageText;
    
    if (okTitle == nil)
    {
        okTitle = @"OK";
    }
    [alert.okButton setTitle:okTitle];
    [alert.okButton setTarget:alert];
    [alert.okButton setAction:@selector(btnAction:)];
    [alert.okButton setTag:SYXAlertOkReturn];
    
    if (cancelTitle != nil)
    {
        [alert.cancelButton setTitle:cancelTitle];
        [alert.cancelButton setTarget:alert];
        [alert.cancelButton setAction:@selector(btnAction:)];
        [alert.cancelButton setTag:SYXAlertCancelReturn];
    }
    else
    {
        [alert.cancelButton setHidden:YES];
    }

    return alert;
}

//loadNibNamed后会执行awakeFromNib
-(void)awakeFromNib
{
    //设置按钮高亮
    [_window setDefaultButtonCell:[self.okButton cell]];
}


-(NSInteger)runModal
{
    _isSheet = NO;
    return [NSApp runModalForWindow:self.window];
}


-(void)sheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo {
    typedef void (*alertDidEnd)(id,SEL,SYXAlert *,int,void *);
    if (_sheetDidEnd) {
        alertDidEnd endFunction=(alertDidEnd)[_sheetDelegate methodForSelector:_sheetDidEnd];
        endFunction(_sheetDelegate,_sheetDidEnd,self,returnCode,contextInfo);
    }
  
}

//visible at launch选项
//xib的window属性有一个选项，就是visible at launch，默认是勾选,窗口无法附在父窗口上；勾掉，窗口才能附在父窗口上
-(void)beginSheetModalForWindow:(NSWindow *)window modalDelegate:delegate didEndSelector:(SEL)selector contextInfo:(void *)info {
    _isSheet = YES;
    _sheetDelegate=delegate;
    _sheetDidEnd=selector;
    [self retain];
    //设置按钮高亮
    [NSApp beginSheet:_window modalForWindow:window modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:info];
}

-(void)btnAction:(id)sender
{
    if(_isSheet)
        [NSApp endSheet:_window returnCode:[sender tag]];
    else
        [NSApp stopModalWithCode:[sender tag]];
    [_window close];
}




@end
