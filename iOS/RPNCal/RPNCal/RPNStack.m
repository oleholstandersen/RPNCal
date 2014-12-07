//
//  RPNStack.m
//  RPNCal
//
//  Created by Ole Holst Andersen on 07/12/14.
//  Copyright (c) 2014 Ole Holst Andersen. All rights reserved.
//

#import "RPNStack.h"

@implementation RPNStack

int stackHeight() {
    return 0;
}

-(NSNumber*)pop{
    if (stackHeight()>0) {
        return @0.0;
    }
    return @-1.0;
}
-(int)stackHeight{
    return stackHeight();
}
-(NSNumber*)getAtIndex:(int)index{
    if (index<0 || stackHeight()<index){
        return @-1.0;
    }
    return @0.0;
}

-(void)push:(NSNumber*)number{
}

@end
