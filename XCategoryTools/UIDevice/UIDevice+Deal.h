//
//  UIDevice+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Photos/Photos.h>                   /* 相册 */
#import <Foundation/Foundation.h>           /* 摄像头 */
#import <AVFoundation/AVFoundation.h>       /* 麦克风 */
//#import <CoreLocation/CoreLocation.h>       /* 定位 */
//#import <CoreBluetooth/CoreBluetooth.h>     /* 蓝牙 */
//#import <AddressBook/AddressBook.h>         /* 通讯录 */
//#import <EventKit/EventKit.h>               /* 日历/备忘录 */
//#import <HealthKit/HealthKit.h>             /* 健康 */
#import <Speech/Speech.h>                   /* 语音 */
#import <MediaPlayer/MediaPlayer.h>         /* 媒体资料库 */
//#import <Intents/Intents.h>                 /* Siri */
//#import <PassKit/PassKit.h>                 /* 支付 */
#import <sys/utsname.h>                     /* 系统 */

#import <CoreTelephony/CTCarrier.h>         /* 运营商信息 */
#import <CoreTelephony/CTTelephonyNetworkInfo.h>


@interface UIDevice (Deal)


#pragma mark - 设备权限

/** 是否有访问相机的权限 */
+ (BOOL)isCameraPermissions;

/** 是否有访问相册的权限 */
+ (BOOL)isPhotoPermissions;

/** 是否有访问媒体资料库的权限 */
+ (BOOL)isMediaLibraryPermissions;

/** 是否有访问位置的权限 */
+ (BOOL)isLocationPermissions;

/** 是否有访问蓝牙的权限 */
+ (BOOL)isBluetoothPermissions;

/** 是否有访问日历的权限 */
+ (BOOL)isCalendarPermissions;

/** 是否有访问健康的权限 */
+ (BOOL)isHealthPermissions;

/** 是否有访问支付的权限 */
+ (BOOL)isPayPermissions;

/** 是否有访问备忘录的权限 */
+ (BOOL)isMemoPermissions;

/** 是否有访问通讯录的权限 */
+ (BOOL)isContactsPermissions;

/** 是否有访问麦克风的权限 */
+ (BOOL)isMicrophonePermissions;

/** 是否有访问语音识别的权限 */
+ (BOOL)isSpeechRecognitionPermissions;

/** 是否有访问语音控制的权限 */
+ (BOOL)isSiriPermissions;


#pragma mark - 设备信息

/** 机器标示(每次生成都不同) */
+ (id)UUIDdddd;

/** 通用唯一识别码UUID */
+ (id)getUUID;

/** 手机序列号(UUID) */
+ (id)phoneIdentifierNumber;

/** 手机别名：用户定义的名称 */
+ (id)userPhoneName;

/** 手机型号：iPhone 的各种不同机型 */
+ (id)phoneModel;

/** 系统名称名称 */
+ (id)phoneSystemName;

/** 手机系统版本 */
+ (id)phoneSystemVersion;

/** 地方型号（国际化区域名称） */
+ (id)phoneLocalModel;

/** 获取电池电量 */
+ (CGFloat)getBatteryLevel;

/** 获取手机音量 */
+ (CGFloat)getOutputVolume;

/** 获取总内存大小 */
+ (long long)getTotalMemorySize;

/** 获取当前设备IP */
+ (id)getDeviceIPAdress;

/** 获取运营商信息 */
+ (id)getTelephonyNetworkName;

/** 判断设备连接的是不是 ipv6 网络 */
+ (BOOL)isIpv6Net;

/** 获取当前可用内存 */
//+ (long long)getAvailableMemorySize;


@end
