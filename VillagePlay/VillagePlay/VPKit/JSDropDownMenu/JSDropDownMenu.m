//
//  JSDropDownMenu.m
//  JSDropDownMenu
//
//  Created by Jsfu on 15-1-12.
//  Copyright (c) 2015年 jsfu. All rights reserved.
//

#import "JSDropDownMenu.h"
#import "VPSelectPriceCell.h"

//#define BackColor [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0]
//#define BackColor [UIColor colorWithRed:189.0f/255.0f green:241.2f/255.0f blue:26.9f/255.0f alpha:1.0]
#define BackColor [UIColor whiteColor]
//#define TitleColor [UIColor colorWithRed:62.3f/255.0f green:186.6f/255.0f blue:207.3f/255.0f alpha:1.0]
#define IndicatorColor [UIColor blackColor]
// 选中颜色加深
//#define SelectColor [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0]
#define SelectColor [UIColor colorWithRed:62.3f/255.0f green:186.6f/255.0f blue:207.3f/255.0f alpha:1.0]

//右边选中的颜色
#define RightTableViewCellSelectColor [UIColor colorWithRed:238.7f/255.0f green:238.7f/255.0f blue:238.7f/255.0f alpha:1.0]
#define TableViewCellColor [UIColor whiteColor]
#define SelectLabelColor [UIColor colorWithRed:62.3f/255.0f green:186.6f/255.0f blue:207.3f/255.0f alpha:1.0]



@interface NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode{
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

@end

@interface JSCollectionViewCell:UICollectionViewCell

@property(nonatomic,strong) UILabel *textLabel;
@property(nonatomic,strong) UIImageView *accessoryView;

-(void)removeAccessoryView;

@end

@implementation JSCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textLabel];
    }
    return self;
}

-(void)setAccessoryView:(UIImageView *)accessoryView{
    
    [self removeAccessoryView];
    
    _accessoryView = accessoryView;
    
    _accessoryView.frame = CGRectMake(self.frame.size.width-10-16, (self.frame.size.height-12)/2, 16, 12);
    
    [self addSubview:_accessoryView];
}

-(void)removeAccessoryView{
    
    if(_accessoryView){
        
        [_accessoryView removeFromSuperview];
    }
}

@end



@interface JSTableViewCell : UITableViewCell

@property(nonatomic,readonly) UILabel *cellTextLabel;
@property(nonatomic,strong) UIImageView *cellAccessoryView;

-(void)setCellText:(NSString *)text align:(NSString*)align;

@end

@implementation JSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _cellTextLabel = [[UILabel alloc] init];
        _cellTextLabel.textAlignment = NSTextAlignmentCenter;
        _cellTextLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_cellTextLabel];
    }
    return self;
}

-(void)setCellText:(NSString *)text align:(NSString*)align{
    
    _cellTextLabel.text = text;
    // 只取宽度
    CGSize textSize = [text textSizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 14) lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 14)];
    
    CGFloat marginX = 20;
    
    if (![@"left" isEqualToString:align]) {
        marginX = (self.frame.size.width-textSize.width)/2;
    }
    
    _cellTextLabel.frame = CGRectMake(marginX, 0, textSize.width, self.frame.size.height);
    
    if(_cellAccessoryView){
        _cellAccessoryView.frame = CGRectMake(_cellTextLabel.frame.origin.x+_cellTextLabel.frame.size.width+10, (self.frame.size.height-12)/2, 16, 12);
    }
}

-(void)setCellAccessoryView:(UIImageView *)accessoryView{
    
    if (_cellAccessoryView) {
        [_cellAccessoryView removeFromSuperview];
    }
    
    _cellAccessoryView = accessoryView;
    
    _cellAccessoryView.frame = CGRectMake(_cellTextLabel.frame.origin.x+_cellTextLabel.frame.size.width+10, (self.frame.size.height-12)/2, 16, 12);
    
    [self addSubview:_cellAccessoryView];
}

@end

@implementation JSIndexPath
- (instancetype)initWithColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight  leftRow:(NSInteger)leftRow row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _leftOrRight = leftOrRight;
        _leftRow = leftRow;
        _row = row;
    }
    return self;
}

+ (instancetype)indexPathWithCol:(NSInteger)col leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row {
    JSIndexPath *indexPath = [[self alloc] initWithColumn:col leftOrRight:leftOrRight leftRow:leftRow row:row];
    return indexPath;
}
@end

#pragma mark - menu implementation

@interface JSDropDownMenu ()<VPSelectPriceCellDelegete>
@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UIView *bottomShadow;
@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UICollectionView *collectionView;
//data source
@property (nonatomic, copy) NSArray *array;
//layers array
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;
@property (nonatomic, assign) NSInteger leftSelectedRow;
@property (nonatomic, assign) BOOL hadSelected;

@end


@implementation JSDropDownMenu

- (void)startPrice:(double)startPrice endPrice:(double)endPrice{
    if([self.delegate respondsToSelector:@selector(startPrice:endPrice:)]){
        [self.delegate startPrice:startPrice endPrice:endPrice];
    }
    [self confiMenuWithSelectRow:0 leftOrRight:0];

//    [self confiMenuWithSelectRow:indexPath.row leftOrRight:leftOrRight];
}

- (void)awakeFromNib{
    
}

#pragma mark - getter
- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor colorWithRed:33.1f/255.0f green:34.0f/225.0f blue:33.9f/225.0f alpha:1.0f];
    }
    return _indicatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor colorWithRed:33.1f/255.0f green:34.0f/225.0f blue:33.9f/225.0f alpha:1.0f];
    }
    return _textColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor colorWithRed:226.4f/255.0f green:199.7f/225.0f blue:200.8f/225.0f alpha:1.0f];
    }
    return _separatorColor;
}

- (NSString *)titleForRowAtIndexPath:(JSIndexPath *)indexPath {
    return [self.dataSource menu:self titleForRowAtIndexPath:indexPath];
}

#pragma mark - setter
- (void)setDataSource:(id<JSDropDownMenuDataSource>)dataSource {
    _dataSource = dataSource;
    
    //configure view
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numOfMenu = [_dataSource numberOfColumnsInMenu:self];
    } else {
        _numOfMenu = 1;
    }
    
    CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
    
    CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
    
    CGFloat bgLayerInterval = self.frame.size.width / _numOfMenu;
    
    NSMutableArray *tempTitles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempIndicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    NSMutableArray *tempBgLayers = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
    
    for (int i = 0; i < _numOfMenu; i++) {
        //bgLayer
        CGPoint bgLayerPosition = CGPointMake((i+0.5)*bgLayerInterval, self.frame.size.height/2);
        CALayer *bgLayer = [self createBgLayerWithColor:BackColor andPosition:bgLayerPosition];
        [self.layer addSublayer:bgLayer];
        [tempBgLayers addObject:bgLayer];
        //title
        CGPoint titlePosition = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
        NSString *titleString = [_dataSource menu:self titleForColumn:i];
        CATextLayer *title = [self createTextLayerWithNSString:titleString withColor:self.textColor andPosition:titlePosition];
        [self.layer addSublayer:title];
        [tempTitles addObject:title];
        //indicator
        CAShapeLayer *indicator = [self createIndicatorWithColor:self.indicatorColor andPosition:CGPointMake(titlePosition.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
        [self.layer addSublayer:indicator];
        [tempIndicators addObject:indicator];
        
        //separator
         if (i != _numOfMenu - 1) {
             CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height/2);
             CAShapeLayer *separator = [self createSeparatorLineWithColor:self.separatorColor andPosition:separatorPosition];
             [self.layer addSublayer:separator];
         }
    }
    
    _bottomShadow.backgroundColor = self.separatorColor;
    
    _titles = [tempTitles copy];
    _indicators = [tempIndicators copy];
    _bgLayers = [tempBgLayers copy];
}

#pragma mark - init method
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _origin = origin;
        _currentSelectedMenudIndex = -1;
        _show = NO;
        
        _hadSelected = NO;
        
        //tableView init
        _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, 0, 0) style:UITableViewStyleGrouped];
//        _leftTableView.rowHeight = 38;
        //修改左边TableView的颜色
        _leftTableView.separatorColor = [UIColor colorWithRed:0.8877 green:0.8876 blue:0.8877 alpha:1.0];
        _leftTableView.backgroundColor = [UIColor whiteColor];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        
        _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width, self.frame.origin.y + self.frame.size.height, 0, 0) style:UITableViewStyleGrouped];
//        _rightTableView.rowHeight = 38;
        //修改右边tableView颜色
        _rightTableView.separatorColor = _leftTableView.separatorColor;
        _rightTableView.backgroundColor = [UIColor whiteColor];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0) collectionViewLayout:flowLayout];
        
        [_collectionView registerClass:[JSCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
        _collectionView.backgroundColor = [UIColor colorWithRed:220.f/255.0f green:220.f/255.0f blue:220.f/255.0f alpha:1.0];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        
        self.autoresizesSubviews = YES;
        _leftTableView.autoresizesSubviews = YES;
        _rightTableView.autoresizesSubviews = YES;
        _collectionView.autoresizesSubviews = YES;
        
        //self tapped
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        //background init and tapped
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, screenSize.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        //add bottom shadow
        _bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, screenSize.width, 0.5)];
        [self addSubview:_bottomShadow];
    }
    return self;
}

#pragma mark - init support
- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
    layer.backgroundColor = color.CGColor;
    
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, self.frame.size.height)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;

    return layer;
}

- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark - gesture handle
- (void)menuTapped:(UITapGestureRecognizer *)paramSender {
    CGPoint touchPoint = [paramSender locationInView:self];
    //calculate index
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
            [(CALayer *)self.bgLayers[i] setBackgroundColor:BackColor.CGColor];
            [(CAShapeLayer *)self.indicators[i]setFillColor:IndicatorColor.CGColor];
            [(CATextLayer *)self.titles[i]setForegroundColor:IndicatorColor.CGColor];
        }
    }
    
    BOOL displayByCollectionView = NO;
    
    if ([_dataSource respondsToSelector:@selector(displayByCollectionViewInColumn:)]) {
        
        displayByCollectionView = [_dataSource displayByCollectionViewInColumn:tapIndex];
    }
    
    if (displayByCollectionView) {
        
        UICollectionView *collectionView = _collectionView;
        
        if (tapIndex == _currentSelectedMenudIndex && _show) {
            [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView collectionView:collectionView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
                _currentSelectedMenudIndex = tapIndex;
                _show = NO;
            }];
            
            [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:BackColor.CGColor];
            [(CAShapeLayer *)self.indicators[tapIndex]setFillColor:IndicatorColor.CGColor];
            [(CATextLayer *)self.titles[tapIndex]setForegroundColor:IndicatorColor.CGColor];
        } else {
            
            _currentSelectedMenudIndex = tapIndex;
            
            [_collectionView reloadData];
            
            if (_currentSelectedMenudIndex!=-1) {
                // 需要隐藏tableview
                [self animateLeftTableView:_leftTableView rightTableView:_rightTableView show:NO complete:^{
                    
                    [self animateIdicator:_indicators[tapIndex] background:_backGroundView collectionView:collectionView title:_titles[tapIndex] forward:YES complecte:^{
                        _show = YES;
                    }];
                }];
            } else{
                [self animateIdicator:_indicators[tapIndex] background:_backGroundView collectionView:collectionView title:_titles[tapIndex] forward:YES complecte:^{
                    _show = YES;
                }];
            }
//            [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:SelectColor.CGColor];
            [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:BackColor.CGColor];

            [(CAShapeLayer *)self.indicators[tapIndex]setFillColor:SelectColor.CGColor];
            [(CATextLayer *)self.titles[tapIndex]setForegroundColor:SelectColor.CGColor];
        }
        
    } else{
        
        BOOL haveRightTableView = [_dataSource haveRightTableViewInColumn:tapIndex];
//        UITableView *leftTableView = _leftTableView;
        UITableView *rightTableView = nil;
        
        if (haveRightTableView) {
            rightTableView = _rightTableView;
            // 修改左右tableview显示比例
            
        }
        
        if (tapIndex == _currentSelectedMenudIndex && _show) {
            
            [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView leftTableView:_leftTableView rightTableView:_rightTableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
                _currentSelectedMenudIndex = tapIndex;
                _show = NO;
            }];
            
            [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:BackColor.CGColor];
            [(CAShapeLayer *)self.indicators[tapIndex]setFillColor:IndicatorColor.CGColor];
            [(CATextLayer *)self.titles[tapIndex]setForegroundColor:IndicatorColor.CGColor];
        } else {
            
            _hadSelected = NO;
            
            _currentSelectedMenudIndex = tapIndex;
            
            if ([_dataSource respondsToSelector:@selector(currentLeftSelectedRow:)]) {
                
                _leftSelectedRow = [_dataSource currentLeftSelectedRow:_currentSelectedMenudIndex];
            }
            
            if (rightTableView) {
                [rightTableView reloadData];
            }
            [_leftTableView reloadData];
            
            CGFloat ratio = [_dataSource widthRatioOfLeftColumn:_currentSelectedMenudIndex];
            if (_leftTableView) {
                
                _leftTableView.frame = CGRectMake(_leftTableView.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width*ratio, 0);
            }
            
            if (_rightTableView) {
                
                _rightTableView.frame = CGRectMake(_origin.x+_leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width*(1-ratio), 0);
            }
            
            if (_currentSelectedMenudIndex!=-1) {
                // 需要隐藏collectionview
                [self animateCollectionView:_collectionView show:NO complete:^{
//                    [(CAShapeLayer *)self.indicators[tapIndex]setFillColor:SelectColor.CGColor];
//                    [(CATextLayer *)self.titles[tapIndex]setForegroundColor:SelectColor.CGColor];
//                    [(CAShapeLayer *)self.indicators[tapIndex]setFillColor:IndicatorColor.CGColor];
//                    [(CATextLayer *)self.titles[tapIndex]setForegroundColor:IndicatorColor.CGColor];

                    [self animateIdicator:_indicators[tapIndex] background:_backGroundView leftTableView:_leftTableView rightTableView:_rightTableView title:_titles[tapIndex] forward:YES complecte:^{
                        _show = YES;
                    }];
                }];
                
            } else{
                [self animateIdicator:_indicators[tapIndex] background:_backGroundView leftTableView:_leftTableView rightTableView:_rightTableView title:_titles[tapIndex] forward:YES complecte:^{
                    _show = YES;
                }];
            }
            [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:BackColor.CGColor];
//            [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:SelectColor.CGColor];
            [(CAShapeLayer *)self.indicators[tapIndex]setFillColor:SelectColor.CGColor];
            [(CATextLayer *)self.titles[tapIndex]setForegroundColor:SelectColor.CGColor];
        }
    }
}

- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender
{
    BOOL displayByCollectionView = NO;
    
    if ([_dataSource respondsToSelector:@selector(displayByCollectionViewInColumn:)]) {
        
        displayByCollectionView = [_dataSource displayByCollectionViewInColumn:_currentSelectedMenudIndex];
    }
    if (displayByCollectionView) {
        
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView collectionView:_collectionView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _show = NO;
        }];
        
    } else{
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView leftTableView:_leftTableView rightTableView:_rightTableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _show = NO;
        }];
    }
    
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:BackColor.CGColor];
    [(CAShapeLayer *)self.indicators[_currentSelectedMenudIndex]setFillColor:IndicatorColor.CGColor];
    [(CATextLayer *)self.titles[_currentSelectedMenudIndex]setForegroundColor:IndicatorColor.CGColor];
}

#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {

    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

/**
 *动画显示下拉菜单
 */
- (void)animateLeftTableView:(UITableView *)leftTableView rightTableView:(UITableView *)rightTableView show:(BOOL)show complete:(void(^)())complete {
    
    CGFloat ratio = [_dataSource widthRatioOfLeftColumn:_currentSelectedMenudIndex];
    
    if (show) {
        
        CGFloat leftTableViewHeight = 0;
        
        CGFloat rightTableViewHeight = 0;
        NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndexes:0 length:0];

        if (leftTableView) {
            
            leftTableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width*ratio, 0);
            [self.superview addSubview:leftTableView];
            leftTableViewHeight = ([leftTableView numberOfRowsInSection:0] > 5) ? (5 * [self tableView:leftTableView heightForRowAtIndexPath:indexPath]) : ([leftTableView numberOfRowsInSection:0] * [self tableView:leftTableView heightForRowAtIndexPath:indexPath]);

        }
        
        if([self.dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex]){
            if (rightTableView) {
                
                rightTableView.frame = CGRectMake(_origin.x+leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width*(1-ratio), 0);
                
                [self.superview addSubview:rightTableView];
                
                rightTableViewHeight = ([rightTableView numberOfRowsInSection:0] > 5) ? (5 * [self tableView:rightTableView heightForRowAtIndexPath:indexPath]) : ([rightTableView numberOfRowsInSection:0] * [self tableView:rightTableView heightForRowAtIndexPath:indexPath]);
            }
        }
        
        CGFloat tableViewHeight = MAX(leftTableViewHeight, rightTableViewHeight);
        
        [UIView animateWithDuration:0.2 animations:^{
            if (leftTableView) {
                leftTableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width*ratio, tableViewHeight);
            }
            if (rightTableView) {
                rightTableView.frame = CGRectMake(_origin.x+leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width*(1-ratio), tableViewHeight);
            }
        }];
    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            if (leftTableView) {
                leftTableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width*ratio, 0);
            }
            if (rightTableView) {
                rightTableView.frame = CGRectMake(_origin.x+leftTableView.frame.size.width, self.frame.origin.y + self.frame.size.height, self.frame.size.width*(1-ratio), 0);
            }
            
        } completion:^(BOOL finished) {
            
            if (leftTableView) {
                [leftTableView removeFromSuperview];
            }
            if (rightTableView) {
                [rightTableView removeFromSuperview];
            }
        }];
    }
    complete();
}

/**
 *动画显示下拉菜单
 */
- (void)animateCollectionView:(UICollectionView *)collectionView show:(BOOL)show complete:(void(^)())complete {
    
    if (show) {
        
        CGFloat collectionViewHeight = 0;
        
        if (collectionView) {
            
            collectionView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            [self.superview addSubview:collectionView];
            
            collectionViewHeight = ([collectionView numberOfItemsInSection:0] > 10) ? (5 * 38) : (ceil([collectionView numberOfItemsInSection:0]/2.0) * 38);
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            if (collectionView) {
                collectionView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, collectionViewHeight);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            
            if (collectionView) {
                collectionView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            }
        } completion:^(BOOL finished) {
            
            if (collectionView) {
                [collectionView removeFromSuperview];
            }
        }];
    }
    complete();
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background leftTableView:(UITableView *)leftTableView rightTableView:(UITableView *)rightTableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{

    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateLeftTableView:leftTableView rightTableView:rightTableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background collectionView:(UICollectionView *)collectionView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateCollectionView:collectionView show:forward complete:^{
                    
                }];
                
            }];
        }];
    }];
    
    complete();
}

#pragma mark - table datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 0 左边   1 右边
    NSInteger leftOrRight = 0;
    if (_rightTableView==tableView) {
        leftOrRight = 1;
    }
    
    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:leftOrRight: leftRow:)]) {
        return [self.dataSource menu:self numberOfRowsInColumn:self.currentSelectedMenudIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow];
    } else {
        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataSource respondsToSelector:@selector(tableViewCellIdentifierInColumn:indexPath:)]){
        NSString * identifier = [self.dataSource tableViewCellIdentifierInColumn:_currentSelectedMenudIndex indexPath:indexPath];
        if(![identifier isEqualToString:@"DropDownMenuCell"]){
            return 185;
        }
    }
    return 38;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"";
    if([self.dataSource respondsToSelector:@selector(tableViewCellIdentifierInColumn:indexPath:)]){
        identifier = [self.dataSource tableViewCellIdentifierInColumn:_currentSelectedMenudIndex indexPath:indexPath];
        [tableView registerClass:NSClassFromString(identifier) forCellReuseIdentifier:identifier];
    }else{
        identifier = @"DropDownMenuCell";
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];

    
    if(![identifier isEqualToString:@"DropDownMenuCell"]){
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        if([identifier isEqualToString:@"VPSelectPriceCell"]){
            VPSelectPriceCell *selectPriceCell = (VPSelectPriceCell *)cell;
            selectPriceCell.selectionStyle = UITableViewCellSelectionStyleNone;
            tableView.bounces = NO;
            selectPriceCell.delegate = self;
        }
        
    }else{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];

        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = RightTableViewCellSelectColor;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = self.textColor;
        titleLabel.tag = 1;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:14.0];
        
        [cell addSubview:titleLabel];
        
        
        NSInteger leftOrRight = 0;
        
        if (_rightTableView==tableView) {
            
            leftOrRight = 1;
        }
        
        //    UILabel *titleLabel = (UILabel*)[cell viewWithTag:1];
        
        CGSize textSize;
        
        if ([self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)]) {
            
            titleLabel.text = [self.dataSource menu:self titleForRowAtIndexPath:[JSIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow row:indexPath.row]];
            // 只取宽度
            textSize = [titleLabel.text textSizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 14) lineBreakMode:NSLineBreakByWordWrapping];
            
        }
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.separatorInset = UIEdgeInsetsZero;
        
        
        if (leftOrRight == 1) {
            
            CGFloat marginX = 20;
            
            titleLabel.frame = CGRectMake(marginX, 0, textSize.width, cell.frame.size.height);
            //右边tableview 强制设置颜色为灰色
            cell.backgroundColor = RightTableViewCellSelectColor;
            
            if ([titleLabel.text isEqualToString:[(CATextLayer *)[_titles objectAtIndex:_currentSelectedMenudIndex] string]]) {
                titleLabel.textColor = SelectLabelColor;
                UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_make"]];
                
                accessoryImageView.frame = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+10, (self.frame.size.height-12)/2, 16, 12);
                
                [cell addSubview:accessoryImageView];
            } else{
                
                
            }
        } else{
            
            CGFloat ratio = [_dataSource widthRatioOfLeftColumn:_currentSelectedMenudIndex];
            
            CGFloat marginX = (self.frame.size.width*ratio-textSize.width)/2;
            titleLabel.frame = CGRectMake(marginX, 0, textSize.width, cell.frame.size.height);
            
            if (![_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex]){
                //如果没有两个tableView的时候cell的文本切换
                titleLabel.frame = CGRectMake(14, 0, textSize.width, cell.frame.size.height);
            }
            
            //由于项目修改 需要处理颜色
            if([_dataSource currentLeftSelectedRow:_currentSelectedMenudIndex] == indexPath.row&&[_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex]){
                //分左右文本时
                cell.backgroundColor = RightTableViewCellSelectColor;
                titleLabel.textColor = SelectLabelColor;
                
            }else if([_dataSource currentLeftSelectedRow:_currentSelectedMenudIndex] == indexPath.row && ![_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex]){
                //不分左右时的文本样式
                titleLabel.textColor = SelectLabelColor;
                
//                titleLabel.frame = CGRectMake(14, 0, textSize.width, cell.frame.size.height);
            }
            if (!_hadSelected && _leftSelectedRow == indexPath.row) {
                //由于项目修改 需要处理颜色
                if([_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex]){
                    cell.backgroundColor = RightTableViewCellSelectColor;
                }
                BOOL haveRightTableView = [_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex];
                if(!haveRightTableView){
                    UIImageView *accessoryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_make"]];
                    //                titleLabel.textColor = SelectLabelColor;
                    
                    accessoryImageView.bounds = CGRectMake(titleLabel.frame.origin.x+titleLabel.frame.size.width+10, (self.frame.size.height-12)/2, 16, 12);
                    accessoryImageView.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds)-8-6, cell.contentView.center.y);
                    [cell addSubview:accessoryImageView];
                }
            } else{
                
            }
        }
    }
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger leftOrRight = 0;
    if (_rightTableView==tableView) {
        leftOrRight = 1;
    } else {
        _leftSelectedRow = indexPath.row;
    }
    
    if([self.dataSource respondsToSelector:@selector(tableViewCellIdentifierInColumn:indexPath:)]){
        NSString * identifier = [self.dataSource tableViewCellIdentifierInColumn:_currentSelectedMenudIndex indexPath:indexPath];
        if([identifier isEqualToString:@"VPSelectPriceCell"]){
//            BOOL haveRightTableView = [_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex];
//
//            if ((leftOrRight==0 && !haveRightTableView) || leftOrRight==1) {
//                [self confiMenuWithSelectRow:indexPath.row leftOrRight:leftOrRight];
//            }
            return;
        }
    }
    
    if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        
        BOOL haveRightTableView = [_dataSource haveRightTableViewInColumn:_currentSelectedMenudIndex];
        
        if ((leftOrRight==0 && !haveRightTableView) || leftOrRight==1) {
            [self confiMenuWithSelectRow:indexPath.row leftOrRight:leftOrRight];
        }
        
        [self.delegate menu:self didSelectRowAtIndexPath:[JSIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow row:indexPath.row]];
        
        if (leftOrRight==0 && haveRightTableView) {
            if (!_hadSelected) {
                _hadSelected = YES;
                [_leftTableView reloadData];
                NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:_leftSelectedRow inSection:0];
                
                [_leftTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            }else{
                //避免左边的tableView 多次刷新
                [_leftTableView reloadData];
            }

            [_rightTableView reloadData];
        }
        
    } else {
        //TODO: delegate is nil
    }
}

- (void)confiMenuWithSelectRow:(NSInteger)row leftOrRight:(NSInteger)leftOrRight{
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    title.string = [self.dataSource menu:self titleForRowAtIndexPath:[JSIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:leftOrRight leftRow:_leftSelectedRow row:row]];
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView leftTableView:_leftTableView rightTableView:_rightTableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:BackColor.CGColor];
    [(CAShapeLayer *)self.indicators[_currentSelectedMenudIndex] setFillColor:IndicatorColor.CGColor];
    [(CATextLayer *)self.titles[_currentSelectedMenudIndex] setForegroundColor:IndicatorColor.CGColor];
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    // 为collectionview时 leftOrRight 为-1
    if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:leftOrRight: leftRow:)]) {
        return [self.dataSource menu:self numberOfRowsInColumn:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1];
    } else {
        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionCell = @"CollectionCell";
    JSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    
    if ([self.dataSource respondsToSelector:@selector(menu:titleForRowAtIndexPath:)]) {
        cell.textLabel.text = [self.dataSource menu:self titleForRowAtIndexPath:[JSIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:indexPath.row]];
    } else {
        NSAssert(0 == 1, @"dataSource method needs to be implemented");
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView.backgroundColor = RightTableViewCellSelectColor;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.textColor = self.textColor;
    
    if ([cell.textLabel.text isEqualToString:[(CATextLayer *)[_titles objectAtIndex:_currentSelectedMenudIndex] string]]) {
        cell.backgroundColor = TableViewCellColor;
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_make"]];
    } else{
        
        [cell removeAccessoryView];
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((collectionView.frame.size.width-1)/2, 38);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 1, 0.5);
}

#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        
        [self confiMenuWithSelectRow:indexPath.row];
        
        [self.delegate menu:self didSelectRowAtIndexPath:[JSIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:indexPath.row]];
    } else {
        //TODO: delegate is nil
    }
}

- (void)confiMenuWithSelectRow:(NSInteger)row{
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    title.string = [self.dataSource menu:self titleForRowAtIndexPath:[JSIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:row]];
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView collectionView:_collectionView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];

    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:BackColor.CGColor];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.5;
}
void dynamicMethodIMP(id self, SEL _cmd)
{
    printf("SEL %s did not exist\n",sel_getName(_cmd));
}

+ (BOOL) resolveInstanceMethod:(SEL)aSEL{
    NSLog(@"%@",NSStringFromSelector(aSEL));
    return  [super resolveInstanceMethod:aSEL];
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"%@",NSStringFromSelector(aSelector));
    return [super forwardingTargetForSelector:aSelector];
}

@end
