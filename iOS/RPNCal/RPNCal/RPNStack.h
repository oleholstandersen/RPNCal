//
//  RPNStack.h
//  RPNCal
//
//  Created by Ole Holst Andersen on 07/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>


@class RPNStack;

@interface RPNStack : NSObject {
    NSMutableArray* stack;
}

-(id)init;
-(NSNumber*)pop;
-(NSUInteger)height;
-(NSNumber*)getAtIndex:(NSUInteger)index;
-(void)push:(NSNumber*)number;

@end
