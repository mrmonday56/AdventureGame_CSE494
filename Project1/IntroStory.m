//
//  IntroStory.m
//  Project1
//
// Introduction story based on what character you choose.
//

#import "IntroStory.h"

@interface IntroStory ()
@property (weak, nonatomic) IBOutlet UIImageView *introImage;       //story image
@property (weak, nonatomic) IBOutlet UITextView *introText;         //intro story, appears in scroll view

@property (weak, nonatomic) IBOutlet UILabel *typeTest;   //shows name and character type at bottom of screen
@property (weak, nonatomic) IBOutlet UILabel *nameTest;


- (IBAction)goButton:(id)sender;

@end

@implementation IntroStory

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.typeTest.text = self.chosenChar.charType;    //shows name and character type at bottom of screen
    self.nameTest.text = self.chosenChar.charName;
    
    //each of these following if/if else statements take the type and name of the character, and based on the type choose a different picture to appear up top. The picture is a image related to the backstory of each character, which also depends on what char you pick. Your character name is used in the backstory. Different stats are set for each character; Warrior has 5 more strength, Archer has 5 more agility, and Mage 5 more intellect.

    
    if ([self.chosenChar.charType isEqualToString:@"Warrior"]) {
        self.introImage.image = [UIImage imageNamed:@"warStory.png"];
        
        self.introText.text = [NSString stringWithFormat: @"%@ was shaped into a Warrior from the time he turned 8 within the barbarian city known as Zeltheme, located at the southern edge of Yondolore. It was there he aged with his peers, molded into a soldier built of stone from daily spars, harsh battle training, and meals consisting only of meat. At the age of 25, he was cast out of Zeltheme, as all young adults are, to find a quest and prove himself as a true barbarian. Not long after %@ began the trek, he approached a small cottage with a strange aura. Not keen on knocking, he burst open the door with his ridged axe, and found someone waiting inside...",self.chosenChar.charName,self.chosenChar.charName];
        self.chosenChar.health = 30;
        self.chosenChar.strength = 15;
        self.chosenChar.agility = 10;
        self.chosenChar.intellect = 10;
    }
    else if ([self.chosenChar.charType isEqualToString:@"Archer"])
    {
        self.introImage.image = [UIImage imageNamed:@"archerStory.png"];
        
        self.introText.text = [NSString stringWithFormat: @"For the past 3 years, %@ had been quite the bandit. She had stolen riches from passing caravans throughout the winding roads of Yondolore armed with her trusty wooden bow. One day %@ came across a small caravan with a mother and child. As she began to empty out the family's pockets while they were bound in rope, she noticed the fear in child's eyes. Disgusted with herself, she cut the ropes with her old rusted knife, and gave back not only all the family's coin, but her weekly catchings as well. As %@ sprinted off, behind her she heard the child whisper 'The wooden cottage to the north.'. %@ looked behind her, and the mysterious caravan and the woman and child had dissapeared. The thievous archer swiftly made off to the north, and to her surpise, saw a small cottage. Curious about the reward or trap for her good deed, she opened the door to the cottage and walked inside. A figure stood waiting...",self.chosenChar.charName,self.chosenChar.charName,self.chosenChar.charName,self.chosenChar.charName];
        self.chosenChar.health = 30;
        self.chosenChar.strength = 10;
        self.chosenChar.agility = 15;
        self.chosenChar.intellect = 10;
    }
    else
    {
        self.introImage.image = [UIImage imageNamed:@"mageStory.png"];
        
        self.introText.text = [NSString stringWithFormat: @"%@ was the name of this mighty Mage. For years he had brushed up on his magic skills, perfecting the light arts, the dark arts, even the gray arts. After rigorous practice and studying, he had become top of his class, and talented enough to persue his own journey. %@ had not come from Yondolore, but heard there was evil amuck through whispers heard from his crystal ball. The whispers told him about a cottage near the North of Yondolore that might aid him on his quest. Not long after that he arrived in the region, ready for more action, ready to refine his skills. He spotted the cottage, and could feel a presence beyond the door. An old powerful one, but not an evil one. He gently opened the door, and found someone waiting inside...",self.chosenChar.charName,self.chosenChar.charName];
        self.chosenChar.health = 30;
        self.chosenChar.strength = 10;
        self.chosenChar.agility = 10;
        self.chosenChar.intellect = 15;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender    //save Character, sends local character to next screen.
{
    MainScreen *dest = segue.destinationViewController;
    
    [self saveItems];

    dest.mainChar = self.chosenChar;
    dest.globalStats = self.globalStats;
}


- (IBAction)goButton:(id)sender {
}




- (NSString *)documentsDirectory
{
    
    return [@"~/Documents" stringByExpandingTildeInPath];
}
- (NSString *)dataFilePath
{
    //COMMENT IN FOR DIRECTORY VIEW
    
    //NSLog(@"%@",[self documentsDirectory]);
    return [[self documentsDirectory] stringByAppendingPathComponent:@"Character.plist"];
    
}





- (void)saveItems
{
    
    //create a generic data storage object
    
    Character *persistantChar = [[Character alloc] init];   //allocates data for NSCoding object, Character
    
    
    persistantChar.charName = self.chosenChar.charName;     //fills Character up with local character stats.
    persistantChar.charType = self.chosenChar.charType;
    persistantChar.gridProgress= self.chosenChar.gridProgress;
    persistantChar.health = self.chosenChar.health;
    persistantChar.strength = self.chosenChar.strength;
    persistantChar.agility = self.chosenChar.agility;
    persistantChar.intellect = self.chosenChar.intellect;
    persistantChar.itemCount = self.chosenChar.itemCount;
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    
    [archiver encodeObject:persistantChar forKey:@"dataChar"];   //archives it for persistant storage
    [archiver encodeObject:self.globalStats forKey:@"globalStats"];
    
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
    
}

@end
