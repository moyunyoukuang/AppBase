//BasicUISetting 为项目UI相关默认设置,以及一些快速目录结构


//主线程
//dispatch_async(dispatch_get_main_queue(), ^{
//    // something
//});

//线程
//dispatch_queue_t glouble=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

//执行某个代码片段N次。
//
//dispatch_apply(5, globalQ, ^(size_t index) {
//    
//    // 执行5次
//    
//});

//缩小
//CATransform3DMakeScale (0.8, 0.8, 1.0);

//快速weakself 定义
//#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//文本变化事件
//[textField_shuE addTarget:self action:@selector(MoneyChnage:) forControlEvents:UIControlEventEditingChanged];

//{//符号
//¥
//}


#pragma mark- ********************基础设置********************

//时间设置
/** 提示信息持续时间*/
#define ErrorLableShowTime 1.5

//每页cell数量
#define   PageSizePre              20

//页面放大设置比例
#define BiLiH(length) ((int)((ScreenWith/414.0)*length))
//所有尺寸下保持不变的
#define SameH(length) (length)

#pragma mark- 颜色设置/字体设置

//用于主要文字,icon,边框颜色
#define color_text_main_black       HexStringColor(@"#2a2a2a")

//底部颜色
#define color_second_bg_gray        HexStringColor(@"#f8f8f8")

//面板颜色
#define color_second_view_white     HexStringColor(@"#ffffff")

////间隔线颜色
#define color_second_line_gray      HexStringColor(@"#c7c7c7")

//间隔线颜色(底色为#ffffff时,不透明度50%)
#define color_second_sep_gray       HexStringColorA(@"#c7c7c7",0.5)

//边框线颜色
#define color_second_boder_gray     HexStringColor(@"#999999")

////页面字体设置
//少数标题 如:导航栏标题
#define text_size_Navi              18

//大多数标题,及重要文字 如:客户名称、提示标题等
#define text_size_Main              16

//较为重要及大多数文字 如:事项内容具体文字等
#define text_size_content           14

//辅助说明文字 如:时间、日期、提示性文字等
#define text_size_fuzhu             12

//次要备注说明文字 如:底部导航、列表金额等
#define text_size_jinE              10


#pragma mark- 颜色

//颜色方法
#define UIColorFromRGB(rgbValue , a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define COLORFromRGB(R, G, B)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define COLOR(R, G, B)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define COLORA(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define HexStringColor(HexString) [AOColorFormat colorWithHexString:HexString]
#define HexStringColorA(HexString,alphavalue) [AOColorFormat colorWithHexString:HexString alpha:alphavalue]


#define GREEN           UIColorFromRGB(0X4BDC53,1.0)
#define GRAY_LINE       UIColorFromRGB(0XCCCCCC,1.0)
#define GRAY_TEXT       UIColorFromRGB(0X666666,1.0)
#define GRAY_BG         UIColorFromRGB(0XEEEEEE,1.0)
#define GRAY_HEADER     UIColorFromRGB(0Xeeeeee,1.0)
#define WHITE           [UIColor whiteColor]
#define BLACK           [UIColor blackColor]
#define CLEAR_COLOR     [UIColor clearColor]
#define BLUE            [UIColor blueColor]
#define DARK_ORANGE     UIColorFromRGB(0xff9126,1.0)
#define RED_TEXT        UIColorFromRGB(0XE00200,1.0)
#define DARK_YELLOW     UIColorFromRGB(0xCCD627,1.0)
#define DARK_RED        UIColorFromRGB(0xf84a4b,1.0)

#pragma mark- 宏定义

///系统版本判断
#define SYSTEM_VERSION_GREATER_THAN(V)  ([[[UIDevice currentDevice] systemVersion]floatValue]>V||[[[UIDevice currentDevice] systemVersion]floatValue]==V)
/** 系统版本*/
#define VERSION_STR     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define ScreenWith  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height


#pragma mark- ********************引用库文件********************

/** 
 
 {  Reachability   -fno-objc-arc
 
    SystemConfiguration.framework
 }

 AFNetworking:
 {
 MobileCoreServices.framework
 Security.framework
 SystemConfiguration.framework
 CoreLocation.framework
 CoreGraphics.framework
 Foundation.framework
 UIKit.framework
 }
 
 */
/*
 编译报错
 //does not contain bitcode
 Build Settings: Enable Bitcode更改为NO即可
 
 Other Linker Flags中添加-ObjC  -all_load
 
 -fno-objc-arc
 */

#pragma mark- ********************项目快速结构模型********************
#pragma mark- 快速测试 － 滑动屏幕
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    UITouch *  touch_move = [touches anyObject];
//    CGPoint movepoint = [touch_move locationInView:self.view];
//
//    int inte = movepoint.x/(self.view.width/10) ;
//
//    int radius = movepoint.y/(self.view.height/10);
//
//    NSLog(@" inte = %d ,radius =  %d",inte,radius);
//}

#pragma mark- collectionView


//UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
//[flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//
//collection_yueDu = [[BLCollectionView alloc] initWithFrame:CGRectMake(0, switch_View.bottom, ScreenWith, ScreenHeight-switch_View.bottom-TabBarHeight) collectionViewLayout:flowLayout];
//
//collection_yueDu.dataSource = self;
//collection_yueDu.delegate   = self;
//
//
////注册Cell，必须要有
//[collection_yueDu registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
//
//
//[self.view addSubview:collection_yueDu];


//#pragma mark -- UICollectionViewDataSource
////定义展示的UICollectionViewCell的个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 30;
//}
//
////定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 1;
//}
//
////每个UICollectionView展示的内容
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString * CellIdentifier = @"UICollectionViewCell";
//    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    if(!cell)
//    {
//        cell = [[UICollectionViewCell alloc] init];
//    }
//    
//    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
//    return cell;
//}
//
//#pragma mark --UICollectionViewDelegateFlowLayout
////定义每个UICollectionView 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(96, 100);
//}
////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
//
//#pragma mark --UICollectionViewDelegate
////UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor whiteColor];
//}
////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}




#pragma mark- uitextFieldDeleagate 限制输入为数字
//#pragma mark- uitextFieldDeleagate
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    
//    if([string isEqualToString:@"\n"])
//    {
//        [textField resignFirstResponder];
//        return NO;
//    }
//    return [CommonTool validateNumber:string];
//}


#pragma mark -  talbeview   右边索引
//#pragma mark -  talbeview   右边索引
//// 右边索引 字节数(如果不实现 就不显示右侧索引)
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    return lianXiRen_paiXu_title_array;
//}
//
//// 设置分区的头部标题
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    NSString *key = [lianXiRen_paiXu_title_array objectAtIndexSafe:section];
//    return key;
//}
//
//// tableView分区数
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return lianXiRen_paiXu_title_array.count;
//}
//
//// tableView每个分区的cell数目
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray * sectionArray = (NSArray*)[lianXiRen_paiXu_content_array objectAtIndexSafe:section];
//    
//    return [sectionArray count];
//}
//
//// tableView的cell高度
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return TongXunLvTableCellHeight;
//}
//
//// 点击右侧索引表项时调用
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
//    
//    if (title.length>0) {
//        [self showtagMessage:title];
//    }
//    
//    return index;
//}



#pragma mark- table 侧滑代理
//#pragma mark- table 侧滑代理
////右滑操作事件
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(tableView == self.mainTableView)
//    {
//        return [self CanEditRowatIndexpath:indexPath];
//    }
//    return NO;
//}
//
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCellEditingStyle result = UITableViewCellEditingStyleNone;//默认没有编辑风格
//    if (tableView ==self.mainTableView) {
//        result = UITableViewCellEditingStyleDelete;//设置编辑风格为删除风格
//    }
//    return result;
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(tableView==self.mainTableView)
//    {
//        return @"删除";
//    }
//    else
//    {
//        return @"";
//    }
//}
//
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(tableView==self.mainTableView)
//    {
//        UITableViewRowAction* action1=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//            [self deleteYaopinforIndexPath:indexPath];
//        }];
//        action1.backgroundColor=MAIN_RED;
//        NSArray* returnarray=@[action1];
//        
//        UITableViewCell* cell=[self.mainTableView cellForRowAtIndexPath:indexPath];
//        if([cell isKindOfClass:[ShopCartDrugCell class]])
//        {
//            UITableViewRowAction* action2=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"收藏" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//                [self shoucangYaopinforIndexPath:indexPath];
//            }];
//            action2.backgroundColor=[UIColor colorWithRed:188/255.0 green:187/255.0 blue:193/255.0 alpha:1.0];
//            returnarray= @[action1,action2];
//        }
//        return returnarray;
//    }
//    return @[];
//}
//
//- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
//forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(tableView==self.mainTableView)
//    {
//        [self deleteYaopinforIndexPath:indexPath];
//    }
//}

#pragma mark- table delegate

//#pragma mark- table delegate
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(tableView == table_WhoSelectList)
//    {
//        NSString * reuseIdenty = @"NewTaskUserCell";
//    
//        id model = [array_whoList objectAtIndexSafe:indexPath.row];
//    
//        NewTaskUserCell *   cell = [tableView dequeueReusableCellWithIdentifier:reuseIdenty];
//        if(!cell)
//        {
//            cell = [[NewTaskUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdenty];
//        
//            
//        }
//        [cell configWithModel:model];
//    
//        return cell;
//    }
//    return [[UITableViewCell alloc] init];
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return TongXunLvTableCellHeight;
//}




#pragma mark- tableviewcell
//#define TaskTableCellHeight SameH(133)
//-(void)configWithModel:(id)Model;

//#pragma mark- —————————————————————— 数据模型——————————————————————
/////宏命令
/////自定义属性
//
///***************数据控制***************/
//id      currentModel;
///***************视图***************/
//
//
//#pragma mark- ——————————————————————调用层——————————————————————
//#pragma mark- ********************生命周期********************
////dealloc 放最上面
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//
//    if(self)
//    {
//        [self chuShiHua];
//        [self setUpViews];
//    }
//    return self;
//}
//
//-(void)chuShiHua
//{
//
//}
//
//
//-(void)setUpViews
//{
//
//    [self createAllView];
//
//}
//#pragma mark- ********************调用事件********************
//-(void)configWithModel:(id)Model
//{
//    currentModel = Model;
//}
//
//
//#pragma mark- ********************点击事件********************
//#pragma mark- ********************代理方法********************
//#pragma mark- ——————————————————————实现层——————————————————————
//#pragma mark- ********************数据获取********************
////网络请求 数据获取
//#pragma mark- ********************获得数据********************
//#pragma mark- ********************视图创建********************
///** 创建所有视图*/
//-(void)createAllView
//{
//
//}
//#pragma mark- ********************界面样式控制********************
////更改界面数据显示 视图样式 动态视图
//#pragma mark- ********************功能实现********************
////不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
//#pragma mark- ********************跳转其他页面********************





#pragma mark- view  structure
//#pragma mark- —————————————————————— 数据模型——————————————————————
/////宏命令
/////自定义属性

///***************数据控制***************/

///***************视图***************/

//#pragma mark- ——————————————————————调用层——————————————————————
//#pragma mark- ********************生命周期********************
////dealloc 放最上面
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//
//    if(self)
//    {
//        [self chuShiHua];
//        [self setUpViews];
//    }
//    return self;
//}
//-(void)chuShiHua
//{
//
//}
//
//-(void)setUpViews
//{
//
//    [self createAllView];
//
//}
//#pragma mark- ********************调用事件********************
////外界调用 或者调用外界的事件
//#pragma mark- ********************点击事件********************
//#pragma mark- ********************继承方法********************
//#pragma mark- ********************代理方法********************
//#pragma mark- ——————————————————————实现层——————————————————————
//#pragma mark- ********************数据获取********************
////网络请求 数据获取
//#pragma mark- ********************数据操作********************
//#pragma mark- ********************视图创建********************
///** 创建所有视图*/
//-(void)createAllView
//{
//
//}
//#pragma mark- ********************界面样式控制********************
////更改界面数据显示 视图样式 动态视图
//#pragma mark- ********************功能实现********************
////不想拆开放的功能集合 数据处理 跳转其他页面方法 放最下面
//#pragma mark- ********************跳转其他页面********************



#pragma mark- view Controller structure

//#pragma mark- —————————————————————— 数据模型——————————————————————
/////宏命令
/////自定义属性

///***************数据控制***************/

///***************视图***************/

//#pragma mark- ——————————————————————调用层——————————————————————
//#pragma mark- ********************生命周期********************
////dealloc 放最上面
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    [self chuShiHua];
//    
//    [self setUpViews];
//    
//}
//
//-(void)chuShiHua
//{
//    
//}
//
//-(void)setUpViews
//{
//    [self setTitle:@""];
//    
//    [self createNavi];
//    
//    [self createAllView];
//    
//}
//
//
//
//#pragma mark- ********************调用事件********************
//#pragma mark- ********************点击事件********************
//#pragma mark- ********************继承方法********************
//#pragma mark- ********************代理方法********************
//#pragma mark- ——————————————————————实现层——————————————————————
//#pragma mark- ********************数据获取********************
////网络请求 数据获取
//#pragma mark- ********************数据操作********************
//#pragma mark- ********************视图创建********************
///** 创建navi*/
//-(void)createNavi
//{
//    
//}
//
///** 创建所有视图*/
//-(void)createAllView
//{
//
//    
//}
//
//#pragma mark- ********************界面样式控制********************
////更改界面数据显示 视图样式 动态视图
//#pragma mark- ********************功能实现********************
////不想拆开放的功能集合 数据处理 被调用的功能
//
//
//
//#pragma mark- ********************跳转其他页面********************


////
/**
 测试：

 mycontrol
 commontool
 pull refresh
 
 */




