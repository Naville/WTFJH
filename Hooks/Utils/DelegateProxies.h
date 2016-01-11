#import <UIKit/UIApplication.h>

@interface GenericDelegateProx : NSObject {
    id originalDelegate;        // The delegate object we're going to proxy
}

@property (retain) id originalDelegate; // Need retain or the delegate gets freed before we're done using it.


- (id) initWithOriginalDelegate:(id)origDeleg;

// Mirror the original delegate's list of implemented methods
- (BOOL)respondsToSelector:(SEL)aSelector;
- (id)forwardingTargetForSelector:(SEL)sel;
- (void)dealloc;

@end


