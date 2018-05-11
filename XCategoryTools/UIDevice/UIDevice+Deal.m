//
//  UIDevice+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIDevice+Deal.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4" //
#define IP_ADDR_IPv6    @"ipv6"

@implementation UIDevice (Deal)


#pragma mark - 设备权限

/** 是否有访问相机的权限 */
+ (BOOL)isCameraPermissions {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied) {
        return NO;
    }
    else {
        return YES;
    }
    
}

/** 是否有访问相册的权限 */
+ (BOOL)isPhotoPermissions {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
        return NO;
    }
    else {
        return YES;
    }
    
}

/** 是否有访问媒体资料库的权限 */
+ (BOOL)isMediaLibraryPermissions {
    if (@available(iOS 9.3, *)) {
        MPMediaLibraryAuthorizationStatus status = [MPMediaLibrary authorizationStatus];
        
        if (status == MPMediaLibraryAuthorizationStatusRestricted || status == MPMediaLibraryAuthorizationStatusDenied) {
            return NO;
        }
        else {
            return YES;
        }
    } else {
        // Fallback on earlier versions
        
        return YES;
    }
    
}

/** 是否有访问位置的权限 */
+ (BOOL)isLocationPermissions {
//    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
//
//    if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied){
//        return NO;
//    }
//    else {
//        return YES;
//    }
    
    return YES;
}

/** 是否有访问蓝牙的权限 */
+ (BOOL)isBluetoothPermissions {
//    CBPeripheralManagerAuthorizationStatus status = [CBPeripheralManager authorizationStatus];
//
//    if (status == CBPeripheralManagerAuthorizationStatusRestricted || status == CBPeripheralManagerAuthorizationStatusDenied){
//        return NO;
//    }
//    else {
//        return YES;
//    }

    return YES;
}

/** 是否有访问日历的权限 */
+ (BOOL)isCalendarPermissions {
//    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
//
//    if (status == EKAuthorizationStatusRestricted || status == EKAuthorizationStatusDenied){
//        return NO;
//    }
//    else {
//        return YES;
//    }
    return YES;
}

/** 是否有访问健康的权限 */
+ (BOOL)isHealthPermissions {
//    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
//    HKObjectType *hkObjectType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
//    HKAuthorizationStatus status = [healthStore authorizationStatusForType:hkObjectType];
//
//    if (status == HKAuthorizationStatusNotDetermined || status == HKAuthorizationStatusSharingDenied){
//        return NO;
//    }
//    else {
//        return YES;
//    }
    
    return YES;
    
}

/** 是否有访问支付的权限 */
+ (BOOL)isPayPermissions {
    
    return YES;
}

/** 是否有访问备忘录的权限 */
+ (BOOL)isMemoPermissions {
//    EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
//
//    if (status == EKAuthorizationStatusRestricted || status == EKAuthorizationStatusDenied){
//        return NO;
//    }
//    else {
//        return YES;
//    }
    return YES;
}

/** 是否有访问通讯录的权限 */
+ (BOOL)isContactsPermissions {
//    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
//
//    if (status == kABAuthorizationStatusRestricted || status == kABAuthorizationStatusDenied){
//        return NO;
//    }
//    else {
//        return YES;
//    }

    return YES;
}

/** 是否有访问麦克风的权限 */
+ (BOOL)isMicrophonePermissions {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied){
        return NO;
    }
    else {
        return YES;
    }
    
}

/** 是否有访问语音识别的权限 */
+ (BOOL)isSpeechRecognitionPermissions {
    if (@available(iOS 10.0, *)) {
        SFSpeechRecognizerAuthorizationStatus status = [SFSpeechRecognizer authorizationStatus];
        
        if (status == SFSpeechRecognizerAuthorizationStatusRestricted || status == SFSpeechRecognizerAuthorizationStatusDenied) {
            return NO;
        }
        else {
            return YES;
        }
    } else {
        // Fallback on earlier versions
        NSLog(@"小于 iOS 10.0");
        
        return NO;
    }
}

/** 是否有访问语音控制的权限 */
+ (BOOL)isSiriPermissions {
//    if (@available(iOS 10.0, *)) {
//        INSiriAuthorizationStatus status = [INPreferences siriAuthorizationStatus];
//
//        if (status == INSiriAuthorizationStatusRestricted || status == INSiriAuthorizationStatusDenied) {
//            return NO;
//        }
//        else {
//            return YES;
//        }
//    } else {
//        // Fallback on earlier versions
//        NSLog(@"小于 iOS 10.0");
//
//        return YES;
//    }
    
    return YES;
    
}



#pragma mark - 设备信息

/** 机器标示(每次生成都不同) */
+ (id)UUIDdddd{
    
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    return result;
}

/** 通用唯一识别码UUID */
+ (id)getUUID {
    NSString *UUIDString = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    return UUIDString;
}

/** 手机序列号(UUID) */
+ (id)phoneIdentifierNumber {
    NSString *identifierNumber = [[UIDevice currentDevice] identifierForVendor].UUIDString;
    
    return identifierNumber;
}

/** 手机别名：用户定义的名称 */
+ (id)userPhoneName {
    NSString *userPhoneName = [[UIDevice currentDevice] name];
    
    return userPhoneName;
}

/** 手机型号：iPhone 5 - iPhone X 的各种不同机型 */
+ (id)phoneModel {
//    NSString *phoneModel = [[UIDevice currentDevice] model];
    NSString *phoneModel = [self iPhoneType];
    
    return phoneModel;
}

/** 系统名称名称 */
+ (id)phoneSystemName {
    NSString *deviceName = [[UIDevice currentDevice] systemName];
    
    return deviceName;
}

/** 手机系统版本 */
+ (id)phoneSystemVersion {
    NSString *phoneVersion = [[UIDevice currentDevice] systemVersion];
    
    return phoneVersion;
}

/** 地方型号（国际化区域名称） */
+ (id)phoneLocalModel {
    NSString *localPhoneModel = [[UIDevice currentDevice] localizedModel];
    
    return localPhoneModel;
}

/** 获取电池电量 */
+ (CGFloat)getBatteryLevel {
    CGFloat batteryLevel = [UIDevice currentDevice].batteryLevel;
    
    return batteryLevel;
}

/** 获取手机音量 */
+ (CGFloat)getOutputVolume {
    CGFloat volume = [[AVAudioSession sharedInstance] outputVolume];
    
    return volume;
}

/** 获取总内存大小 */
+ (long long)getTotalMemorySize {
    long long physicalMemory = [NSProcessInfo processInfo].physicalMemory;
    
    return physicalMemory;
}


/** 获取当前设备IP */
+ (id)getDeviceIPAdress {
    NSString *ip = [self getIPAddress:NO];
    
    return ip;
}

/** 获取运营商信息 */
+ (id)getTelephonyNetworkName {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    
    NSString *telephony = [NSString stringWithFormat:@"%@",[carrier carrierName]];

    if ([STRING(telephony) isNil]) {
        
        return @"未知运营商";
    }

    return telephony;
}

/** 判断设备连接的是不是 ipv6 网络 */
+ (BOOL)isIpv6Net {
    NSArray *searchArray =
    @[ IOS_VPN @"/" IP_ADDR_IPv6,
       IOS_VPN @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4 ];
    NSDictionary *addresses = [self getIPAddresses];
    __block BOOL isIpv6 = NO;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         if ([key rangeOfString:@"ipv6"].length > 0  && ![[NSString stringWithFormat:@"%@",addresses[key]] hasPrefix:@"(null)"] ) {
             
             if ( ![addresses[key] hasPrefix:@"fe80"]) {
                 isIpv6 = YES;
             }
         }
     } ];
    
    
    return isIpv6;
}


/** 获取手机型号 */
+ (NSString *)iPhoneType {
    
    //需要导入头文件：#import <sys/utsname.h>
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"])  return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"])  return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"])  return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"])  return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"])  return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"])  return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"])  return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"])  return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"])  return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"])  return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"])  return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"])  return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"])  return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"])  return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"])  return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"])  return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"])  return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"])  return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"])  return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"])  return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"])  return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"])  return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"])  return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"])  return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"])  return@"iPhone Simulator";
    
    return platform;
    
}


#pragma mark - 获取设备当前网络IP地址
/** 获取当前设备IP */
+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4,
       IOS_VPN @"/" IP_ADDR_IPv6,
       IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    
    @[ IOS_VPN @"/" IP_ADDR_IPv6,
       IOS_VPN @"/" IP_ADDR_IPv4,
       IOS_WIFI @"/" IP_ADDR_IPv6,
       IOS_WIFI @"/" IP_ADDR_IPv4,
       IOS_CELLULAR @"/" IP_ADDR_IPv6,
       IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
//    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        
        address = addresses[key];
        //筛选出IP地址格式
        if([self isValidatIP:address]) *stop = YES;
    } ];
    
    
    return address ? address : @"0.0.0.0";
}



+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
//            NSRange resultRange = [firstMatch rangeAtIndex:0];
//            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
//            NSLog(@"输出结果%@",result);
            
            return YES;
        }
    }
    
    
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                }
                else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    
    
    return [addresses count] ? addresses : nil;
}



    



@end
