//
//  RPNStack.m
//  RPNCal
//
//  Created by Ole Holst Andersen on 07/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import "RPNStack.h"

@implementation RPNStack

-(id) init{
    if (self = [super init]) {
        stack = [[NSMutableArray alloc] init];
        return self;
    }
    else{
        return nil;
    }
}

-(NSNumber*)pop{
    NSNumber* result = nil;
    if ([self height]>0) {
        result = [stack objectAtIndex:0];
        [stack removeObjectAtIndex:0];
    }
    return result;
}

-(NSUInteger)height{
    return [stack count];
}
-(NSNumber*)getAtIndex:(NSUInteger)index{
    if (index<[self height]){
        return [stack objectAtIndex:index];
    }
    return nil;
}

-(void)push:(NSNumber*)number{
    [stack insertObject:number atIndex:0];
}

@end
