//
//  language.m
//  cumbari
//
//  Created by Shephertz Technology on 11/12/10.
//  Copyright 2010 ShephertzTechnology PVT LTD. All rights reserved.
//

#import "language.h"
#import "cumbariAppDelegate.h"
#import "DetailedSettings.h"
#import <QuartzCore/QuartzCore.h>
#import "CouponsInSelectedCategory.h"
#import "FilteredCoupons.h"
#import "LanguageManager.h"
#import "Locale.h"

@implementation language

@synthesize myTableView,choiceIndex,choices;


//NSString *string1;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	detailObj = [[DetailedCoupon alloc]init];	
	
	UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];//customizing done button.
	
	but1.bounds = CGRectMake(0, 0, 50.0, 30.0);//locating button.
	
	[but1 setImage:[UIImage imageNamed:@"LeftBack.png"] forState:UIControlStateNormal];//setting image on button.
	
	[but1 addTarget:self action:@selector(backToSetting) forControlEvents:UIControlEventTouchUpInside];//calling cancel method on clicking done button.
	
	UIBarButtonItem *buttonLeft = [[UIBarButtonItem alloc]initWithCustomView:but1];//customizing right button.
	
	self.navigationItem.leftBarButtonItem = buttonLeft;//setting on R.H.S. of navigation item.
	
	[buttonLeft release];
    
	myTableView.backgroundColor = [UIColor clearColor];//clear back ground color
    
	array =[[NSMutableArray alloc]init];//array
	
	[array addObject:@"English"];//adding english in array
	
	[array addObject:@"Svenska"];//adding svenska in array
    
    [array addObject:@"Deutsch"];//adding Deutsch in array
	
	prefs = [NSUserDefaults standardUserDefaults];//object of NSUserDefault
}

-(void)doneClicked
{
	
}



-(void)backToSetting
{
    
	HotDeals *hotDealObj = [[HotDeals alloc]init];
	
	[hotDealObj setBatchValue];
	
	CouponsInSelectedCategory *couponObj = [[CouponsInSelectedCategory alloc]init];
	
	[couponObj setBatchValue];
	
	FilteredCoupons *filteredObj = [[FilteredCoupons alloc]init];
	
	[filteredObj setBatchValue];
	
	[hotDealObj release];
	
	[couponObj release];
	
	[filteredObj release];	

	[NSThread detachNewThreadSelector:@selector(reload) toTarget:self withObject:nil];
	
	[NSThread sleepForTimeInterval:2.0];
	
	[self dismissModalViewControllerAnimated:YES];
	
	[self.navigationController popViewControllerAnimated:YES];//back to setting
	
}

-(void)reload
{
		
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication]delegate];
	
	[appDel reloadJsonData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        UIImage *backgroundImage = [UIImage imageNamed:@"navBar.png"];
        [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    }
    
    else
    {
        [self.navigationController.navigationBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navBar.png"]] autorelease] atIndex:0];
    }
    
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication] delegate];//object of cumbari delegate
	
    backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
    backLabel.backgroundColor = [UIColor clearColor];
    backLabel.textColor = [UIColor whiteColor];
    
    navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
    navigationLabel.backgroundColor = [UIColor clearColor];
    navigationLabel.textAlignment = UITextAlignmentCenter;
    navigationLabel.font = [UIFont boldSystemFontOfSize:20];
    navigationLabel.textColor = [UIColor blackColor];
    
	//labels according language selected
	if([storedLanguage isEqualToString:@"English" ])
	{
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
	}
	
	else {
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0];
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
	}
    
    backLabel.text = CustomLocalisedString(@"Back", @"");
    navigationLabel.text = CustomLocalisedString(@"Language", @"");
    
    [self.navigationController.navigationBar addSubview:navigationLabel];
    [self.navigationController.navigationBar addSubview:backLabel];
    [navigationLabel release];
    [backLabel release];
    
    [appDel setTabBarTitles];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	//removing all labels from superview
	[backLabel removeFromSuperview];
	
	
}
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */
/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [array count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	
	cell.backgroundColor = [UIColor whiteColor];//white background color
	
	cell.textLabel.text = [array objectAtIndex:indexPath.row];//cell text label
	
	prefs = [NSUserDefaults standardUserDefaults];
	
	NSString *storedLanguage = [prefs objectForKey:@"language"];//stored language
	
    if ([[array objectAtIndex:indexPath.row] isEqualToString:storedLanguage]) {
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;//checkmarks 
        self.choiceIndex = indexPath.row;
        cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
    }
	
	if (storedLanguage.length == 0) {
		if ([[array objectAtIndex:indexPath.row] isEqualToString:@"English"]) {
			
			cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
            self.choiceIndex = indexPath.row;
			cell.accessoryType = UITableViewCellAccessoryCheckmark;
			
		}
	}
    
    return cell;//returning cell
}


- (void)chooseRow:(NSUInteger)row
// Choose the specified row.  This updates both the UI (that is, the checkmark 
// accessory view) and our choiceIndex property.
{
    UITableViewCell *   cell;//cell
	
    
    // Uncheck the currently checked cell, change the choice, and then recheck the newly checked cell.
    //int valueForRemovingCheckmark = self.choiceIndex;
	//self.choiceIndex = row;//cell choice index
	
	
    cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.choiceIndex inSection:0]];
    if (cell != nil) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    self.choiceIndex = row;
    cell = [self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.choiceIndex inSection:0]];
    if (cell != nil) {
        cell.textLabel.textColor = [detailObj getColor:@"3F609C"];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	
	[self chooseRow:indexPath.row];//choosing row
	
	NSString *language = [array objectAtIndex:indexPath.row];//language of string type
	
	//removing back label from superview
	[backLabel removeFromSuperview];
	[navigationLabel removeFromSuperview];
	
	cumbariAppDelegate *appDel = (cumbariAppDelegate *)[[UIApplication sharedApplication] delegate];//object of cumbari app delegate
	
	prefs = [NSUserDefaults standardUserDefaults];
	
    backLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 8, 40, 25)];
    backLabel.backgroundColor = [UIColor clearColor];
    backLabel.textColor = [UIColor whiteColor];
    
    navigationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 8, 150, 25)];
    navigationLabel.backgroundColor = [UIColor clearColor];
    navigationLabel.textAlignment = UITextAlignmentCenter;
    navigationLabel.font = [UIFont boldSystemFontOfSize:20];
    navigationLabel.textColor = [UIColor blackColor];
    
    [prefs setObject:language forKey:@"language"];
    //[prefs setObject:[NSArray arrayWithObjects:[self getLanguageCodeForLang:language], nil] forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    LanguageManager *languageManager = [LanguageManager sharedLanguageManager];
    Locale *localeForRow = languageManager.availableLocales[indexPath.row];
    NSLog(@"Language selected: %@   code:%@", localeForRow.name,localeForRow.languageCode);
    [languageManager setLanguageWithLocale:localeForRow];
    
	//labels according selected language
	if([language isEqualToString:@"English"]){
		backLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0];
		//[appDel englishTabBar];//calling english tab bar
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0];
	}
	else {
		backLabel.font = [UIFont boldSystemFontOfSize:10.0];
		//[appDel SvenskaTabBar];//calling svenska tab bar
		navigationLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
	}
    backLabel.text = CustomLocalisedString(@"Back", @"");
    navigationLabel.text = CustomLocalisedString(@"Language", @"");

    [self.navigationController.navigationBar addSubview:navigationLabel];
    [self.navigationController.navigationBar addSubview:backLabel];
    [navigationLabel release];

    [appDel setTabBarTitles];

	[self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

-(NSString*)getLanguageCodeForLang:(NSString*)lang
{
    NSString *code = @"en";
    
    if ([lang isEqualToString:@"English"]) {
        
    }
    else if ([lang isEqualToString:@"Svenska"]) {
        code = @"swe";
    }
    else if ([lang isEqualToString:@"Deutsch"]) {
        code = @"de";
    }
    
    return code;
}

- (void)dealloc {
    [super dealloc];
	
	
	[myTableView release];
	
	[choices release];
	
	
	[array release];
	
	//[detailObj release];
	
}

//end of definition
@end

