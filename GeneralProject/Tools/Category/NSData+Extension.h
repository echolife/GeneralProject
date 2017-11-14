//
//  NSData+Extension.h
//  GeneralProject
//
//  Created by Jone on 2017/4/28.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Extension)

//------------------------------Encrypt-----------------------
/*md5 加密*/
- (NSString *)md5Capital:(BOOL)copital; // 默认小写

/*base64 加密*/
- (NSString *)base64Encoded;

/*base64 解密*/
- (NSData *)base64Decoded;

@end
