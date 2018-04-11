//
//  PayPlugin.m
//  GeneralProject
//
//  Created by Jone on 2017/5/6.
//  Copyright © 2017年 Jone. All rights reserved.
//

#import "PayPlugin.h"

@interface PayPlugin ()

@property (copy, nonatomic) PayResult payResult;

@end

@implementation PayPlugin

SYNTHESIZE_SINGLETON_FOR_CLASS(PayPlugin)

- (void)payWihtPayment:(Payment)payment payResult:(PayResult)payresult {
    _payResult = payresult;
    switch (payment) {
        case PaymentApipay:
            [self alipayPay];
            break;
        case PaymentWechat:
            [self wechatPay];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark - WechatPay

- (void)wechatPay {
    // 检查用户是安装照微信
    BOOL canOpen = [WXApi isWXAppInstalled];
    if (!canOpen) {
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:-1 userInfo:@{NSLocalizedFailureReasonErrorKey:@"未安装微信客户端"}];
        if (_payResult) {
            _payResult(PaymentWechat, error);
        }
        return;
    }
    
    
    NSMutableDictionary *signDic = [NSMutableDictionary dictionary];
    [signDic setObject:self.partnerId forKey:@"partnerid"];
    [signDic setObject:self.prepayId forKey:@"prepayid"];
    [signDic setObject:self.nonceStr forKey:@"noncestr"];
    [signDic setObject:self.package forKey:@"package"];
    [signDic setObject:self.appId forKey:@"appid"];
    [signDic setObject:[NSString stringWithFormat:@"%u",(unsigned int)self.timeStamp] forKey:@"timestamp"];
    
    NSString *signStr  = [self createMd5SignWithDic:signDic];
    
    PayReq *req = [[PayReq alloc] init];
    req.openID = self.appId;
    req.partnerId = self.partnerId;
    req.prepayId = self.prepayId;
    req.nonceStr = self.nonceStr;
    req.timeStamp = self.timeStamp;
    req.package = self.package;
    req.sign = signStr;
    [WXApi sendReq:req];
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess: {
                if (_payResult) {
                    _payResult(PaymentWechat, nil);
                }
                break;
            }
            case WXErrCodeUserCancel:{
                
                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:resp.errCode userInfo:@{NSLocalizedFailureReasonErrorKey:resp.errStr ? resp.errStr : @"用户取消"}];
                
                if (_payResult) {
                    _payResult(PaymentWechat, error);
                }
                break;
            }
                
            default: {
                
                NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:resp.errCode userInfo:@{NSLocalizedFailureReasonErrorKey:resp.errStr ? resp.errStr : @"支付异常"}];
                
                if (_payResult) {
                    _payResult(PaymentWechat, error);
                }
                break;
            }
        }
    }
}

- (NSString *)createMd5SignWithDic:(NSMutableDictionary *)dic {
    NSMutableString *contentString  = [NSMutableString string];
    NSArray *keys = [dic allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator: ^NSComparisonResult (id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (![[dic objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            ) {
            [contentString appendFormat:@"%@=%@&", categoryId, [dic objectForKey:categoryId]];
        }
    }
    
    //添加key字段
    [contentString appendFormat:@"key=%@", PARTNER_ID];
    //得到MD5 sign签名
    return [contentString md5Capital:NO];;
}

#pragma mark -
#pragma mark - Alipay

- (void)alipayPay {
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", self.AlipayData, self.AlipaySignData, @"RSA"];
    
    weak_self(self);
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:AlipayScheme callback: ^(NSDictionary *resultDic) {
        
        NSLog(@"支付宝信息->%@",resultDic);
        
        [weakSelf dispatchAlipayPayResult:resultDic];
    }];
}

- (void)dispatchAlipayPayResult:(NSDictionary *)resultDic {
    NSLog(@"支付宝信息->%@",resultDic);
    
    NSString *statuCode = resultDic[@"resultStatus"];
    
    if ([statuCode isEqualToString:@"9000"]) {
        if (_payResult) {
            _payResult(PaymentApipay, nil);
        }
    }else if([statuCode isEqualToString:@"6001"]){
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[statuCode integerValue] userInfo:@{NSLocalizedFailureReasonErrorKey:@"支付宝支付失败,用户取消支付"}];
        if (_payResult) {
            _payResult(PaymentApipay, error);
        }
    } else{
        NSError *error = [NSError errorWithDomain:NSCocoaErrorDomain code:[statuCode integerValue] userInfo:@{NSLocalizedFailureReasonErrorKey:@"支付宝支付失败"}];
        if (_payResult) {
            _payResult(PaymentApipay, error);
        }
    }
}

@end
