//
//  MainScreen.h
//  Project1
//
// Main screen of the game.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "LocalChar.h"
#import "IntroStory.h"
#import "Status.h"
#import "FunStats.h"

@interface MainScreen : UIViewController

@property LocalChar* mainChar;  //local character used in main screen
@property FunStats* globalStats;

@end
