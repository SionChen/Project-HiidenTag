//
//  DebugTool.h
//  Framework-iOS
//
//  Created by cztv on 12-11-1.
//  Copyright (c) 2012年 cztv. All rights reserved.
//

#ifdef DEBUG

//#define DBLOG(...)		       NSLog(__VA_ARGS__)
#define DBLOG(...) printf("%f %s\n",[[NSDate date]timeIntervalSince1970],[[NSString stringWithFormat:__VA_ARGS__]UTF8String])
#define DBLOG_RECT(rect)       DBLOG(@"x:%f  y:%f  width:%f  height:%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height)
#define DBLOG_SIZE(size)       DBLOG(@"%@", NSStringFromCGSize(size))
#define DBLOG_INSETS(insets)   DBLOG(@"%@", NSStringFromUIEdgeInsets(insets))
#define DBLOG_POINT(point)     DBLOG(@"%@", NSStringFromCGPoint(point))
#define DBLOG_RANGE(range)     DBLOG(@"%@", NSStringFromRange(range))
#define DBLOG_FUNNAME          DBLOG(@"%@", NSStringFromSelector(_cmd))
#define DBLOG_FUN		       DBLOG(@"%s", __FUNCTION__)
//#define DBLOG_OBJ(obj)	       NSLog(@"%@", obj)
#define DBLOG_OBJ(obj)	       DBLOG(@"%@", obj)

#else

#define DBLOG(...)		       
#define DBLOG_RECT(rect)       
#define DBLOG_SIZE(size)       
#define DBLOG_INSETS(insets)   
#define DBLOG_POINT(point)     
#define DBLOG_RANGE(range)     
#define DBLOG_FUNNAME          
#define DBLOG_FUN		       
#define DBLOG_OBJ(obj)	       

#endif
