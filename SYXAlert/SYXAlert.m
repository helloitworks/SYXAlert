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

- (id)init
{
    self = [super init];
    if (self)
    {
        if (!_window)
        {
            [NSBundle loadNibNamed:@"SYXAlert" owner:self];
        }
    }
    return self;
}


+(SYXAlert *)alertWithMessageText:(NSString *)messageText okButton:(NSString *)okTitle cancelButton:(NSString *)cancelTitle
{
    SYXAlert *alert = [[[self alloc] init] autorelease];
    alert.messageTextField.stringValue = messageText;
    
    if (okTitle == nil)
    {
        okTitle = @"OK";
    }
    [alert.okButton setTitle:@"确定"];
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
    [self.window setDefaultButtonCell:[self.okButton cell]];
}


-(NSInteger)runModal
{
    [_window setStyleMask:NSTitledWindowMask];
    return [NSApp runModalForWindow:self.window];
}


-(void)sheetDidEnd:(NSWindow *)sheet returnCode:(int)returnCode contextInfo:(void *)contextInfo {
    typedef void (*alertDidEnd)(id,SEL,SYXAlert *,int,void *);
    if (_sheetDidEnd) {
        alertDidEnd endFunction=(alertDidEnd)[_sheetDelegate methodForSelector:_sheetDidEnd];
        endFunction(_sheetDelegate,_sheetDidEnd,self,returnCode,contextInfo);
    }
  
}

-(void)beginSheetModalForWindow:(NSWindow *)window modalDelegate:delegate didEndSelector:(SEL)selector contextInfo:(void *)info {
    [_window setStyleMask:NSDocModalWindowMask];
    _sheetDelegate=delegate;
    _sheetDidEnd=selector;
    [self retain];
    [NSApp beginSheet:_window modalForWindow:window modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:info];
}

-(void)btnAction:(id)sender
{
    if(_window.styleMask & NSDocModalWindowMask)
        [NSApp endSheet:_window returnCode:[sender tag]];
    else
        [NSApp stopModalWithCode:[sender tag]];
    [self.window close];
}




@end
