#include "WechatSettingsRootListController.h"
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSSwitchTableCell.h>




#define VERSION_COLOR		[UIColor colorWithRed:56/255.0 green:56/255.0 blue:58/255.0 alpha:1] // systemGrayColor
#define TINT_COLOR		[UIColor colorWithRed:40/255.0 green:206/255.0 blue:81/255.0 alpha:1] // systemGreenColor
#define BG_COLOR	 	[UIColor colorWithRed:23/255.0 green:23/255.0 blue:23/255.0 alpha:1.0] // black





@implementation WechatSettingsRootListController

static float headerHeight = 140.0f;
#define VERSION_STRING	@"v2.0.0 - Remember to respring !"


- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

/* Tint navbar items. */
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	// tint navbar
	self.navigationController.navigationController.navigationBar.tintColor = TINT_COLOR;
}
- (void)viewWillDisappear:(BOOL)animated {
	// un-tint navbar
	self.navigationController.navigationController.navigationBar.tintColor = nil;

	[super viewWillDisappear:animated];
}


-(void)viewDidLoad {

	//use icon instead of title text
	UIImage *icon = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/WechatSettings.bundle/icon.png"];
	//init
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:icon];
	[super viewDidLoad];

}
/* over-write class method */
-(id)tableView:(id)tableView viewForHeaderInSection:(NSInteger)section{
	if(section !=0){
		return [super tableView:tableView viewForHeaderInSection:section];
	}
	if (!self.headerView) {
		/* initlize headerView */
		UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,headerHeight)];
		headerView.opaque = NO;
		headerView.backgroundColor = UIColor.whiteColor;


		CGRect frame = CGRectMake(15,47,headerView.bounds.size.width,50);
		UILabel *tweakTitle = [[UILabel alloc] initWithFrame:frame];
		tweakTitle.text = @"FakeSteps";
		tweakTitle.font = [UIFont systemFontOfSize:40 weight:UIFontWeightThin];
		tweakTitle.textColor = UIColor.blackColor;
		tweakTitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
		[headerView addSubview:tweakTitle];

		CGRect subtitleFrame = CGRectMake(15, 94, headerView.bounds.size.width, 20);
		UILabel *tweakSubtitle = [[UILabel alloc] initWithFrame:subtitleFrame];
		tweakSubtitle.text = VERSION_STRING;
		tweakSubtitle.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
		tweakSubtitle.textColor = VERSION_COLOR;
		tweakSubtitle.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
		[headerView addSubview:tweakSubtitle];
		/*
		修复BUG - 忘记实例化
		*/
		self.headerView = headerView;
	}
	return self.headerView;
}
- (CGFloat)tableView:(id)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return headerHeight;
	} else {
		return [super tableView:tableView heightForHeaderInSection:section];
	}
}

//  void in Prefs---------------------------------------------------------------
- (void)kill
{
	system("killall -9 SpringBoard");
}
- (void)openTwitter {
	NSURL *url;

	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetbot:"]]) {
		url = [NSURL URLWithString:@"tweetbot:///user_profile/ryaneddisford"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitterrific:"]]) {
		url = [NSURL URLWithString:@"twitterrific:///profile?screen_name=ryaneddisford"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"tweetings:"]]) {
		url = [NSURL URLWithString:@"tweetings:///user?screen_name=ryaneddisford"];
	} else if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter:"]]) {
		url = [NSURL URLWithString:@"twitter://user?screen_name=ryaneddisford"];
	} else {
		url = [NSURL URLWithString:@"https://twitter.com/ryaneddisford"];
	}

	[[UIApplication sharedApplication] openURL:url];
}

- (void)openDonate {
	NSString *url = @"https://www.paypal.me/ECallan";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end

@interface PYButtonCell : PSTableCell
@end

@implementation PYButtonCell
- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.textLabel setTextColor:[UIColor grayColor]];
}
@end

