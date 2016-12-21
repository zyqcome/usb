//
//  UITextField+TextFieldRange.m
//  TinyShop
//
//  Created by 韩舟昱 on 2016/12/21.
//  Copyright © 2016年 Hzy. All rights reserved.
//

#import "UITextField+TextFieldRange.h"

@implementation UITextField (TextFieldRange)
-(NSRange)selectedRange{
    UITextPosition * beginning = self.beginningOfDocument;
    UITextRange * selectedRange = self.selectedTextRange;
    UITextPosition * selectionEnd = selectedRange.end;
    UITextPosition * selectionStart = selectedRange.start;

    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
    //
}

-(void)setSelectedRange:(NSRange)range{
    
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

@end
