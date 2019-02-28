#include "WechatSettingsRootListController.h"
#import "NactroHeaderView.h"
#import "NactroCreditService.h"
#import "NactroCreditOption.h"
#import "NactroCreditCell.h"
#import "UIColor+Hex.h"
#import "UIFont+Extension.h"
#include <spawn.h>
#import <UIKit/UIKit.h>

static NSString *tweakName = @"微信步数修改助手 v3.1.0";
#define TINT_COLOR		[UIColor colorWithRed:40/255.0 green:206/255.0 blue:81/255.0 alpha:1]
#define HEADER_HEIGHT 120.0f
#define kWidth  [UIScreen mainScreen].bounds.size.width

@interface WechatSettingsRootListController()
@property (nonatomic, strong)NactroHeaderView *headerView;
@end

@implementation WechatSettingsRootListController

static float headerHeight = 140.0f;

-(void)save
{
    [self.view endEditing:YES];
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"操作提示：保存成功！" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
		[alert show];
		[NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", @"dismiss ", @"key" ,nil]  repeats:NO];
}

//alert 自动消失
-(void) dismissAlert:(NSTimer *)timer{
    UIAlertView *alert = [[timer userInfo]objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
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
- (id)tableView:(id)tableView viewForHeaderInSection:(NSInteger)section {
	if (section == 0){
	  return self.headerView;
	}else{
		return [super tableView:tableView viewForHeaderInSection:section];
	}
}

- (CGFloat)tableView:(id)tableView heightForHeaderInSection:(NSInteger)section {
	if (section == 0) {
		return headerHeight;
	} else {
		return [super tableView:tableView heightForHeaderInSection:section];
	}
}

//  void in Prefs---------------------------------------------------------------

- (void)openDonate {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"alipayqr://platformapi/startapp?saId=10000007&qrcode=https://qr.alipay.com/tsx09384ad5mkh65g1irre0"]];
}

- (void)killSpringBoard{
		pid_t pid;
    const char* args[] = {"killall", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

#pragma mark - setter & getter
- (id)readPreferenceValue:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	return (settings[specifier.properties[@"key"]]) ?: specifier.properties[@"default"];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
}

#pragma mark - lazyload
- (NactroHeaderView *)headerView{
	if (!_headerView) {
			_headerView = [[NactroHeaderView alloc]initWithFrame:CGRectMake(0,0,kWidth,HEADER_HEIGHT) tweakName:tweakName devTeamName:@"Nactro Dev." backgroundColor:TINT_COLOR];
	}
	return _headerView;
}

@end
