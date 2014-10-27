//
//  Interface.m
//  MemorySwipe
//
//  Created by Rehan Anwar on 6/20/2014.
//  Copyright (c) 2014 Rehan Anwar. All rights reserved.
//

#import "Interface.h"
#import "math.h"

#import <QuartzCore/QuartzCore.h>

@implementation Interface


-(IBAction) begin:(id) sender {
    Begin.hidden=YES;
    [self drawLine];
    Back.hidden=NO;
}


-(void)drawLine {
    int numberOfLines=0;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    CGPoint currentPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);

    [path moveToPoint:currentPoint];
    
    CGPoint NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);

    while ([self lengthWithFirstValue:currentPoint SecondValue:NextPoint] < 30) {
        NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
    }
    
    CGPoint PreviousPoint;
    
    [path addLineToPoint:NextPoint];
    numberOfLines++;
    
    while (numberOfLines<5) {
        PreviousPoint=currentPoint;
        currentPoint=NextPoint;
        NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);

        
        while ((![self isAngleValidWithFirstPoint:PreviousPoint SecondPoint:currentPoint ThirdPoint:NextPoint]) || [self lengthWithFirstValue:currentPoint SecondValue:NextPoint] < 30) {
            NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
        }
        
        [path addLineToPoint:NextPoint];
        numberOfLines++;
    }
   
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.view.bounds;
    pathLayer.path = path.CGPath;
    
    pathLayer.strokeColor = [[UIColor greenColor] CGColor];
    //pathLayer.fillColor = [[UIColor blueColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 15.0f;
    
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.view.layer addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat: 1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

/*
-(void)drawLine2 {
    int numberOfLines=0;
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    
    CGPoint currentPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
    
    [path2 moveToPoint:currentPoint];
    
    CGPoint NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
    
    while ([self lengthWithFirstValue:currentPoint SecondValue:NextPoint] < 30) {
        NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
    }
    
    CGPoint PreviousPoint;
    
    [path2 addLineToPoint:NextPoint];
    numberOfLines++;
    
    while (numberOfLines<5) {
        PreviousPoint=currentPoint;
        currentPoint=NextPoint;
        NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
        
        
        while ((![self isAngleValidWithFirstPoint:PreviousPoint SecondPoint:currentPoint ThirdPoint:NextPoint]) || [self lengthWithFirstValue:currentPoint SecondValue:NextPoint] < 30) {
            NextPoint = CGPointMake(arc4random()%300+10, arc4random()%548+10);
        }
        
        [path2 addLineToPoint:NextPoint];
        numberOfLines++;
    }
    
    CAShapeLayer *pathLayer = [CAShapeLayer layer];
    pathLayer.frame = self.view.bounds;
    pathLayer.path = path2.CGPath;
    
    pathLayer.strokeColor = [[UIColor greenColor] CGColor];
    //pathLayer.fillColor = [[UIColor blueColor] CGColor];
    pathLayer.fillColor = nil;
    pathLayer.lineWidth = 30.0f;
    
    pathLayer.lineJoin = kCALineJoinRound;
    
    [self.view.layer addSublayer:pathLayer];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat: 1.0f];
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}
 */

- (double) lengthWithFirstValue: (CGPoint)PointOne SecondValue: (CGPoint) PointTwo {
       NSLog(@"lenthfr%f", sqrt(pow(PointTwo.x - PointOne.x, 2) + pow(PointTwo.y - PointOne.y, 2)));
    return sqrt(pow(PointTwo.x - PointOne.x, 2) + pow(PointTwo.y - PointOne.y, 2));
}

-(BOOL) isAngleValidWithFirstPoint: (CGPoint)PointOne SecondPoint: (CGPoint)PointTwo ThirdPoint: (CGPoint)PointThree {
    
    double L1= [self lengthWithFirstValue:PointOne SecondValue:PointTwo];
    double L2= [self lengthWithFirstValue:PointTwo SecondValue:PointThree];
    double L3= [self lengthWithFirstValue:PointOne SecondValue:PointThree];
    
    double angle=acos((pow(L1,2) + pow(L2,2) - pow(L3,2)) / (2 * L1 * L2));
    angle=angle*180/M_PI;
    NSLog(@"angle %f\n\n", angle);

    return (angle>=30 && angle<=330);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}

- (void)viewDidLoad {
    Back.hidden=YES;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

//-(void)drawrectangle
//{
//    
//    UIBezierPath *path2 = [UIBezierPath bezierPath];
//    [path2 moveToPoint:CGPointMake(10.0, 10.0)];
//    // # Entry Point with 10px white frame
//    [path2 moveToPoint:CGPointMake(10.0, 10.0)];
//    // # Keeping 10px frame with iPhone's 450 on y-axis
//    [path2 addLineToPoint:CGPointMake(10.0, 450.0)];
//    // # Substracting 10px for frame on x-axis, and moving 450 in y-axis
//    [path2 addLineToPoint:CGPointMake(310.0, 450.0)];
//    // # Moving up to 1st step 10px line, 310px on the x-axis
//    [path2 addLineToPoint:CGPointMake(310.0, 10.0)];
//    // # Back to entry point
//    [path2 addLineToPoint:CGPointMake(10.0, 10.0)];
//    
//    // 4th Create a CAShapeLayer that uses that UIBezierPath:
//    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
//    shapeLayer2.path = [path2 CGPath];
//    shapeLayer2.strokeColor = [[UIColor redColor] CGColor];
//    shapeLayer2.lineWidth = 3.0;
//    shapeLayer2.fillColor = [[UIColor redColor] CGColor];
//    //Add that CAShapeLayer to your view's layer:
//    
//    // 5th add shapeLayer as sublayer inside layer view
//    [self.view.layer addSublayer:shapeLayer2];
//    
//    
//}
