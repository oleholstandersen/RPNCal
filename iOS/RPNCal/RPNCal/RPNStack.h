//
//  RPNStack.h
//  RPNCal
//
//  Created by Ole Holst Andersen on 07/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RPNStack : NSObject

-(NSNumber*)pop;
-(int)stackHeight;
-(NSNumber*)getAtIndex:(int)index;
-(void)push:(NSNumber*)number;

@end
