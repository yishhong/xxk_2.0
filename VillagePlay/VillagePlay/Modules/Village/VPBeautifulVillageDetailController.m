//
//  VPBeautifulVillageDetailController.mController
//  VillagePlay
//
//  Created by  易述宏 on 16/11/4.
//  Copyright © 2016年 Apricot. All rights reserved.
//

#import "VPBeautifulVillageDetailController.h"
#import "VPBeautifulVillageDetailViewModel.h"
#import "TopicRecommendTableViewCell.h"
#import "TopicRelatedRecommentTableViewCell.h"
#import "VillageLookFullTextTableViewCell.h"
#import "VillageCommentTableViewCell.h"
#import "VPBlankLinesTableViewCell.h"
#import "VPAddressTableViewCell.h"
#import "VPAddressImageTableViewCell.h"
#import "UIColor+HUE.h"
#import "VPHotelHeadView.h"
#import "UINavigationBar+Custom.h"
#import "UINavigationBar+Awesome.h"
#import "VPShareManage.h"
#import "VillageTitleTableViewCell.h"
#import "VillageImageTableViewCell.h"
#import "VillageSubTitleTableViewCell.h"
#import "VPCommentHeadImageViewTableViewCell.h"
#import "VPCommentContentTableViewCell.h"
#import "VPCommentContentImageViewTableViewCell.h"
#import "VillageLookMoreCommentTableViewCell.h"
#import "UITableViewCell+DataSource.h"
#import "MBProgressHUD+Loading.h"
#import "NSError+Reason.h"
#import "VPVillageDetailModel.h"
#import "AMRatingControl.h"
#import "UIView+Frame.h"
#import "HGTagView.h"
#import "VPVillageDetailModel.h"
#import "VPMapController.h"
#import "VPCollectionRecordManager.h"
#import "VPLoginController.h"
#import "VPWantCommentController.h"
#import "VPCommentListController.h"
#import "VPGeneralWebController.h"
#import "VPDriveTableViewCell.h"
#import "VPDriveControllerController.h"
#import "VPCommentLineTableViewCell.h"
#import "VPHotelCommentNoDataTableViewCell.h"
#import "VPUserManager.h"
#import "IDMPhotoBrowser.h"


#define NAVBAR_CHANGE_POINT -(50+64*2)


@interface VPBeautifulVillageDetailController ()<UITableViewDataSource,UITableViewDelegate,VPHotelHeadViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *collectButton;

@property (strong, nonatomic) IBOutlet UIButton *commentButton;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIBarButtonItem * shareButtonItem;

@property (strong, nonatomic) HGTagView * tagView;

@property (strong ,nonatomic) VPVillageDetailModel *villageDetailModel;

@property (assign, nonatomic)BOOL isCollection;

@property (strong, nonatomic)VPCollectionRecordManager *collectionRecordManager;

/**
 评论数
 */
@property (strong, nonatomic) UILabel * commentNumLabel;

/**
 评星
 */
@property (strong, nonatomic) AMRatingControl * rateCtl;

@property (strong, nonatomic)VPHotelHeadView * hotelHeadView;

@property (nonatomic, strong) VPBeautifulVillageDetailViewModel *viewModel;

@end

@implementation VPBeautifulVillageDetailController

+ (instancetype)instantiation{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Village" bundle:[NSBundle mainBundle]];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"乡村详情";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor] lineView:[UIColor clearColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(250, 0, 0, 0);
    self.navigationItem.rightBarButtonItem =self.shareButtonItem;
    self.tableView.backgroundColor =[UIColor controllerBackgroundColor];
    self.viewModel = [[VPBeautifulVillageDetailViewModel alloc] init];
    [self.tableView addSubview:self.hotelHeadView];
    
    //标题
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageTitleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageTitleTableViewCell class])];

    //图
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageImageTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageImageTableViewCell class])];

    //文
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageSubTitleTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageSubTitleTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPDriveTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPDriveTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentLineTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentLineTableViewCell class])];
    
    //查看更多
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageLookFullTextTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageLookFullTextTableViewCell class])];
    //空行
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPBlankLinesTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPBlankLinesTableViewCell class])];

    //地址
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPAddressTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPAddressTableViewCell class])];

    //地图
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPAddressImageTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPAddressImageTableViewCell class])];
    //相关推荐
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TopicRecommendTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([TopicRecommendTableViewCell class])];
    //不同类型的推荐
    [self.tableView registerClass:[TopicRelatedRecommentTableViewCell class] forCellReuseIdentifier:NSStringFromClass([TopicRelatedRecommentTableViewCell class])];
    
    //评论数
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageCommentTableViewCell class])];

    //评论头像
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentHeadImageViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentHeadImageViewTableViewCell class])];
    //文
     [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentTableViewCell class])];
    //图
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPCommentContentImageViewTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPCommentContentImageViewTableViewCell class])];
    
    //查看更多评论
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VillageLookMoreCommentTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VillageLookMoreCommentTableViewCell class])];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([VPHotelCommentNoDataTableViewCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NSStringFromClass([VPHotelCommentNoDataTableViewCell class])];
    
    
    //修改颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self loadNewDate];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshComment) name:@"commentRefreshNotificationName" object:nil];
}

- (void)refreshComment{

    [self loadNewDate];
}

- (void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)loadNewDate{

    [MBProgressHUD showLoading];
    [self.viewModel villageDetailID:self.villageID success:^{
        self.villageDetailModel =[self.viewModel detailModel];
        [self.tableView reloadData];
        [MBProgressHUD hide];
    } failure:^(NSError *error) {
        [MBProgressHUD showTip:[error errorMessage]];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    UIColor * color = [UIColor navigationBarTintColor];
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha] lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:alpha]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        //设置按钮的颜色
        [self.navigationController.navigationBar setTintColor:[[UIColor navigationTintColor] colorWithAlphaComponent:alpha]];
        //设置标题的颜色
        [self.navigationController.navigationBar xx_titleStyleWithColor:[[UIColor navigationTitleColor] colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor whiteColor]];
        
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0] lineView:[[UIColor navigationBottonLineView] colorWithAlphaComponent:0]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.isCollection =[self.collectionRecordManager isCollectionWithType:VPChannelTypeTravel key:self.villageID];

    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setTranslucent:YES];
    self.tableView.delegate = self;
    [self.tableView reloadData];

    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationController.navigationBar lt_reset];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController.navigationBar setTintColor:[UIColor navigationTintColor]];
    //还原系统的标题颜色
    [self.navigationController.navigationBar xx_titleStyleWithColor:[UIColor navigationTitleColor]];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:cellModel.identifier];
    [cell xx_configCellWithEntity:cellModel];
    return cell;
}


#pragma mark - Action respond
/**
 *  分享
 */
-(void)shareAction{
    //    显示分享面板
    [VPShareManage getShareWebPageToPlatform:VPChannelTypeVillage title:self.villageDetailModel.name  descr:nil shareUrl:self.villageDetailModel.vid thumImage:self.villageDetailModel.headImageUrl];
}

//收藏
- (IBAction)collectAction:(UIButton *)sender {
    
    __weak VPBeautifulVillageDetailController *weakSelf =self;
    if (self.collectButton.selected==NO) {
        [self.collectionRecordManager addCollectionRecordWithType:VPChannelTypeTravel key:self.villageID model:self.villageDetailModel block:^(NSError *error, BOOL isSucceed) {
            if (isSucceed==NO) {
                UIViewController * loginController =[VPLoginController instantiation];
                [weakSelf presentViewController:loginController animated:YES completion:nil];
            }
        }];
        weakSelf.collectButton.selected=YES;
        
    }else{
        [self.collectionRecordManager removeCollectionRecordWithType:VPChannelTypeTravel key:self.villageID block:^(NSError *error, BOOL isSucceed) {
            if (isSucceed==NO) {
                UIViewController * loginController =[VPLoginController instantiation];
                [weakSelf presentViewController:loginController animated:YES completion:nil];
            }
        }];
        weakSelf.collectButton.selected=NO;
    }
}
//评论
- (IBAction)commentAction:(id)sender {

    if([VPUserManager sharedInstance].xx_userinfoID.length<1){
        UIViewController * loginController =[VPLoginController instantiation];
        [self presentViewController:loginController animated:YES completion:nil];
        return;
    }
    VPWantCommentController *wantCommentController =[VPWantCommentController instantiation];
    wantCommentController.channelType = VPChannelTypeVillage;
    wantCommentController.objeID = [self.villageID integerValue];
    wantCommentController.title =@"我要评论";
    [self.navigationController pushViewController:wantCommentController animated:YES];
}

- (void)tableView:(UITableView *)tableView clickCell:(UITableViewCell *)clickCell indexPath:(NSIndexPath *)indexPath atView:(UIView *)view{

    if (view.tag==58) {
        if([VPUserManager sharedInstance].xx_userinfoID.length<1){
            UIViewController * loginController =[VPLoginController instantiation];
            [self presentViewController:loginController animated:YES completion:nil];
            return;
        }
        VPWantCommentController *wantCommentController =[VPWantCommentController instantiation];
        wantCommentController.channelType = VPChannelTypeVillage;
        wantCommentController.objeID = [self.villageID integerValue];
        wantCommentController.title =@"我要评论";
        [self.navigationController pushViewController:wantCommentController animated:YES];
    }
}

#pragma mark -UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    return cellModel.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XXCellModel * cellModel =[self.viewModel cellForRow:indexPath.row inSection:indexPath.section];
    if ([cellModel.identifier isEqualToString:@"VPAddressTableViewCell"]||[cellModel.identifier isEqualToString:@"VPAddressImageTableViewCell"]) {
        VPMapController * mapController =[VPMapController instantiation];
        mapController.mapTitle =self.villageDetailModel.name;
        mapController.location =self.villageDetailModel.location;
        [self.navigationController pushViewController:mapController animated:YES];
    }
    if ([cellModel.identifier isEqualToString:@"VPDriveTableViewCell"]) {
        VPDriveControllerController * driveControllerController =[VPDriveControllerController instantiation];
        driveControllerController.driveLineString =self.villageDetailModel.journey;
        driveControllerController.ohterLineString =self.villageDetailModel.hiking;
        [self.navigationController pushViewController:driveControllerController animated:YES];
    }
    if ([cellModel.identifier isEqualToString:@"VillageLookMoreCommentTableViewCell"]) {
        VPCommentListController * commentListController =[VPCommentListController instantiation];
        commentListController.villageID =self.villageID;
        commentListController.channelType = VPChannelTypeVillage;
        commentListController.title =@"评论列表";
        [self.navigationController pushViewController:commentListController animated:YES];
    }
    if ([cellModel.identifier isEqualToString:@"VillageLookFullTextTableViewCell"]) {
     
        VPGeneralWebController * generalWebController =[VPGeneralWebController instantiation];
        generalWebController.title =@"乡村特色";
        generalWebController.url =self.villageDetailModel.characteristicURL;
        [self.navigationController pushViewController:generalWebController animated:YES];
    }
}

#pragma mark -VPHotelHeadViewDelegate
- (void)VPHotelHeadViewSelectImage:(NSInteger)selectImage imageList:(NSArray *)imageList{
    
    NSMutableArray *photos = [NSMutableArray array];
    
    for (VPVillageImagesModel*villageImagesModel in self.villageDetailModel.images) {
        NSURL * urlImage =[NSURL URLWithString:villageImagesModel.imageUrl];
        IDMPhoto *photo = [IDMPhoto photoWithURL:urlImage];
        [photos addObject:photo];
    }
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos];
    browser.displayActionButton =NO;
    [browser setInitialPageIndex:selectImage];
    [self presentViewController:browser animated:YES completion:nil];
}

#pragma mark -setter or getter
- (void)setVillageDetailModel:(VPVillageDetailModel *)villageDetailModel{

    _villageDetailModel =villageDetailModel;
    [self.hotelHeadView focusImageItemsArray:villageDetailModel.images isRight:YES];
    self.commentNumLabel.text =[NSString stringWithFormat:@"%ld条评论",(long)[villageDetailModel.commentaryCount integerValue]];
    self.rateCtl.rating =[villageDetailModel.rating integerValue];
    
    NSMutableArray * tagArr =[NSMutableArray array];
    if (villageDetailModel.tags) {
        for (VPTagModel *tagModel in villageDetailModel.tags) {
            
            [tagArr addObject:tagModel.tagName];
        }
    }
    [self.tagView setTags:tagArr];

}

-(VPHotelHeadView *)hotelHeadView{
    
    if (!_hotelHeadView) {
        _hotelHeadView=[[VPHotelHeadView alloc]initWithFrame:CGRectMake(0, -250, self.view.bounds.size.width, 250)];
        _hotelHeadView.delegate =self;
#warning 暂时隐藏
//        [_hotelHeadView addSubview:self.commentNumLabel];
        [_hotelHeadView addSubview:self.rateCtl];
        [_hotelHeadView addSubview:self.tagView];
    }
    return _hotelHeadView;
}

-(UIBarButtonItem*)shareButtonItem{
    
    if (!_shareButtonItem) {
        _shareButtonItem =[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_share_white"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    }
    return _shareButtonItem;
}

-(UILabel *)commentNumLabel{

    if (!_commentNumLabel) {
        _commentNumLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.rateCtl.right, self.tagView.top-21, self.hotelHeadView.width-(self.rateCtl.width+12+12), 11)];
        _commentNumLabel.textColor =[UIColor whiteColor];
        _commentNumLabel.font =[UIFont systemFontOfSize:11];
    }
    return _commentNumLabel;
}

-(AMRatingControl *)rateCtl{

    if (!_rateCtl) { 
        _rateCtl =[[AMRatingControl alloc]initWithLocation:CGPointMake(0, 0) emptyImage:[UIImage imageNamed:@"tab_white_star_nor"] solidImage:[UIImage imageNamed:@"tab_white_star_sel"] andMaxRating:5];
        _rateCtl.frame =CGRectMake(12, self.tagView.top-21, 20*5, 15);
        _rateCtl.userInteractionEnabled = NO;
    }
    return _rateCtl;
}

-(HGTagView *)tagView{

    if (!_tagView) {
        _tagView =[[HGTagView alloc]initWithFrame:CGRectMake(12, self.hotelHeadView.height-27, self.hotelHeadView.width-80, 20)];
        _tagView.backgroundColor =[UIColor clearColor];
    }
    return _tagView;
}

@end
