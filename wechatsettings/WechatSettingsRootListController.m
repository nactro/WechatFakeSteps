#include "WechatSettingsRootListController.h"

#define VERSION_COLOR		[UIColor colorWithRed:56/255.0 green:56/255.0 blue:58/255.0 alpha:1] // systemGrayColor
#define TINT_COLOR		[UIColor colorWithRed:40/255.0 green:206/255.0 blue:81/255.0 alpha:1] // systemGreenColor
#define BG_COLOR	 	[UIColor colorWithRed:23/255.0 green:23/255.0 blue:23/255.0 alpha:1.0] // black

@implementation WechatSettingsRootListController

static float headerHeight = 140.0f;
#define VERSION_STRING	@"Alpha 0.1"

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
	[super viewDidLoad];

	//use icon instead of title text
	UIImage *icon = [UIImage imageWithContentsOfFile:@"/Library/PreferenceBundles/WechatSettings.bundle/icon.png"];
	//init
	self.navigationItem.titleView = [[UIImageView alloc] initWithImage:icon];
}
/* over-write class method */
-(id)tableView:(id)tableView viewForHeaderInSection:(NSInteger)section{
	if(section !=0){
		return [super tableView:tableView viewForHeaderInSection:section];
	}
	if (!self.headerView) {
		/* initlize headerView */
		UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0,0,320,headerHeight)];
		headerView.backgroundColor = BG_COLOR;
		headerView.opaque = YES;

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
@end
