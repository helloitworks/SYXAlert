//
//  AppDelegate.m
//  SYXAlert
//
//  Created by shenyixin on 14-6-6.
//  Copyright (c) 2014年 shenyixin. All rights reserved.
//

#import "AppDelegate.h"
#import "SYXAlert.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
- (IBAction)ShowSYXAlertWindow:(id)sender
{
    SYXAlert *alert = [SYXAlert alertWithMessageText:@"SYXAlertWindow" okButton:@"Ok" cancelButton:@"Cancel"]; //[[SYXAlert alloc] init];
    
    NSInteger action = [alert runModal];
    if(action == SYXAlertOkReturn)
    {
        NSLog(@"SYXAlertOkButton clicked!");
    }
    else if(action == SYXAlertCancelReturn )
    {
        NSLog(@"SYXAlertCancelButton clicked!");
    }
    
}
- (IBAction)ShowSYXAlertSheet:(id)sender
{
    NSMutableDictionary * extrasDict = [[NSMutableDictionary alloc] init];
    [extrasDict setObject:@"http://www.baidu.com" forKey:@"link"];
    
    SYXAlert *alert = [SYXAlert alertWithMessageText:@"SYXAlertSheet" okButton:@"Ok" cancelButton:@"Cancel"];
    [alert beginSheetModalForWindow:self.window
                      modalDelegate:self
                     didEndSelector:@selector(alertSheetDidEnd:returnCode:contextInfo:)
                        contextInfo:(__bridge void*)extrasDict];
}

- (void)alertSheetDidEnd:(NSAlert *)alert
              returnCode:(NSInteger)returnCode
             contextInfo:(void *)contextInfo {
    if (returnCode == SYXAlertOkReturn)
    {
        NSLog(@"SYXAlertOkButton clicked!");
        //__bridge_transfer for arc
        NSString *url = [(__bridge NSDictionary*)contextInfo objectForKey:@"link"];
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
    }
    else if(returnCode == SYXAlertCancelReturn )
    {
        NSLog(@"SYXAlertCancelButton clicked!");
    }

}

@end
