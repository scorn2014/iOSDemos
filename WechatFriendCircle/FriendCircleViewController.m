//
//  FriendCircleViewController.m
//  WechatFriendCircle
//
//  Created by AllenHuang on 2018/8/24.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#import "FriendCircleViewController.h"
#import "UIImage+extension.h"
#import "FriendCircleModel.h"
#import "FriendCircleTableViewCell.h"
#import "PhotoBrowserViewController.h"
#import <Masonry/Masonry.h>

@interface FriendCircleViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(strong,nonatomic) NSMutableArray *mainCellModels;
@property(strong,nonatomic) UITextField *commentTextField;
@property(strong,nonatomic) UIView *keyboardCommentView;

@end

@implementation FriendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"朋友圈";
    
    [self setUpViews];
    [self setUpModels];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setUpViews{
    self.friendCircleTblView.delegate = self;
    self.friendCircleTblView.dataSource = self;
    self.friendCircleTblView.showsVerticalScrollIndicator = YES;
    [self.friendCircleTblView registerClass:[FriendCircleTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FriendCircleTableViewCell class])];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tblViewTapped:)];
    tap.cancelsTouchesInView = NO;//防止手势和tableview的点击方法冲突
    [self.friendCircleTblView addGestureRecognizer:tap];
    
    CGRect frame = self.friendCircleTblView.bounds;
    frame.size.height = 250;
    
    UIImageView *headerImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_0440"] highlightedImage:nil];
    headerImgView.frame = frame;
    headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.friendCircleTblView.tableHeaderView = headerImgView;
    self.friendCircleTblView.tableHeaderView.clipsToBounds = YES;
    
    //keyboard top view
    UIView *keyBoardTopView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 50)];
    keyBoardTopView.backgroundColor = [UIColor whiteColor];
    keyBoardTopView.layer.borderWidth = 0.7;
    keyBoardTopView.layer.borderColor = [UIColor colorWithRed:204/255.f green:204/255.f blue:204/255.f alpha:1].CGColor;
    _keyboardCommentView = keyBoardTopView;

    _commentTextField = [[UITextField alloc] init];
    _commentTextField.frame = CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width-10*2, 40);
    _commentTextField.borderStyle = UITextBorderStyleRoundedRect;
    _commentTextField.placeholder = @"评论";
    _commentTextField.delegate = self;
    _commentTextField.returnKeyType = UIReturnKeySend;
    [keyBoardTopView addSubview:_commentTextField];

    [self.view addSubview:keyBoardTopView];
}


- (void)setUpModels{
    
    _mainCellModels = [NSMutableArray arrayWithCapacity:0];
    
    NSArray *contentStrings = @[
                                @"曾经有一份真诚的爱情摆在我的面前，我没有珍惜，等到失去的时候才追悔莫及，人世间最痛苦的事情莫过于此。如果上天能够给我一个重新来过的机会，我会对那个女孩子说三个字：‘我爱你’。如果非要给这份爱加上一个期限，我希望是，一万年。",
                                @"准确的说，我是一个演员。",
                                @"秉夫人，小人本住在，苏州的城边，家中有屋又有田，生活乐无边，谁知那唐伯虎，他蛮横不留情，勾结官府目无天，占我大屋夺我田，我爷爷跟他来翻脸，反被他一棍来打扁，我奶奶骂他欺善民，反被他捉进了唐府，强奸了一百遍，一百遍。最后她悬梁自尽遗恨人间。他还将我父子，逐出了家园，流浪到江边。我为求养老爹，惟有独自行乞在庙前，谁知那唐伯虎，他实在太阴险，知道此情形，竟派人来暗算，将我父子狂殴在市前，小人身壮健，残命得留全，可怜老父他魂归天，此恨更难添。我为求葬老爹，惟有卖身为奴自作贱，一边勤赚钱，一边读书篇，发誓把功名显，手刃仇人意志坚，从此唐寅诗集伴身边，我牢记此仇不共戴天。",
                                @"我最恨别人只看到我的英俊却看不到我的内涵。",
                                @"喜欢一个人需要理由吗？需要吗？不需要吗？需要吗？",
                                @"大什么大？你有没有公德心啊！又吵又闹的！街坊们不用睡觉了？人家明天还要上班呢，滚开",
                                @"从来没有试过这么清新脱俗的感觉，牛肉的鲜，撒尿虾的甜，混在一起的味道，竟然比“老鼠斑”有过之而不及，正如比我的初恋更加诗情画意，所谓举头望明月，低头思故乡，好诗！好诗啊！",
                                @"他武功的名堂呢，称之为九天十地，菩萨摇头怕怕，劈雳金光雷电掌！一掌打出，方圆百里之内，不论人畜、虾蟹、跳蚤，全部都化成了飞灰！",
                                @"善有善因，恶有恶报，天理循环，天公地道，我曾误抓龙鸡，今日皇上抓我，实在抓得有教育意义，我对皇上的景仰之心，有如滔滔江水绵绵不绝，又有如黄河泛滥，一发不可收拾。"
                                ];
    
    NSArray *commentStrings = @[
                                @"记得那是上个星期天吧，我看到你走到一堆便便前，蹲下来戳了戳，很疑惑，摸了摸还是很疑惑，闻了闻好像是便便，最后放到嘴里尝了尝，确定是便便，然后站起来高兴叫道：“哈哈，幸好没踩到！",
                                @"又看到你在发说说了，这让我不由的为你担心：你高数完成了吗？英语四六级能过吗？生活规划有了吗？你父母送你来是让你每天发说说吗？发说说能让你以后在社 会中立足吗？发说说能让你顺利找到工作吗？发说说能让你父母安心吗？发说说能报效国家报答父母吗？有没有想过，以后就靠你一个人去打拼，社会的漩涡时刻都 会把你卷进去，弱肉强食的竞争是你能承受的吗？不好好学习以后怎么会有一技之长， 怎么会突出自己，不好好学习以后怎么回报父母，发说说能解决这些问题吗？发说说能让你的人生一帆风顺吗？残酷的社会不是你这些说说能抵抗的，惟有认真努力 的去学习，丰富自己，完美自己，才能让你与众不同，才能让你有能力去团灭，懂吗？",
                                @"每天看你们发说说，我都好羡慕。你们长得又好看，还用智能手机，又有钱，朋友也多，整天讨论一些好像很厉害的东西。随便拿个东西都顶我几个月的生活费，我读书少，又是乡下来的，没见过多少世面，所以我只能默默的看着你发，时不时点个赞，这样好像可以假装和你们很熟，真的，心好累，好了不说了，别人催我把手机还给他，我要去喂猪了，唉……",
                                @"第一次回复，好紧张啊！有没有潜规则？用不用脱啊？该怎样说啊？打多少字才显的有文采啊？我写的这么好会不会太招遥？写的这么深奥别人会不会看不懂啊？好激动啊！怎样才能装成是经常回复的样貌？好紧张啊！"
                                ];
    
    NSArray *imageNames = @[@"IMG_0451",@"IMG_0452",@"IMG_0453",@"IMG_0454",@"IMG_0456",@"IMG_0458",@"IMG_0459",@"IMG_0460"];

    for (int i=0; i<contentStrings.count; i++) {
        FriendCircleModel *model = [[FriendCircleModel alloc] init];
        model.avatarString = @"IMG_0440";
        model.name = @"迷途小书童";
        model.content = contentStrings[i];
        model.createdTime = @"30分钟前";
        
        model.commentArray = [NSMutableArray arrayWithCapacity:0];
        
//       如果想调试tableView复用出现错位的问题，可以先注释这里
        NSInteger commentCount = MIN(i, commentStrings.count);
        for (int i=0; i<commentCount; i++) {
            CommentModel *comment = [[CommentModel alloc] init];
            comment.avatarString = @"bowling";
            comment.name = @"易拉罐";
            comment.content = commentStrings[i];
            comment.createdTime = @"10分钟前";
            [model.commentArray addObject:comment];
        }
        
        model.images = [NSMutableArray arrayWithCapacity:0];
        model.likeImages = [NSMutableArray arrayWithCapacity:0];

        if (i == 0) {
            for (NSString *name in imageNames) {
                UIImage *image = [UIImage imageNamed:name];
                [model.images addObject:image ];
            }
            
            [model.likeImages addObject:[UIImage imageNamed:@"medal"]];
        }
        
        [_mainCellModels addObject:model];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mainCellModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCircleModel *cellModel = self.mainCellModels[indexPath.row];
    return 10 + 20+ 10+ cellModel.contentLayout.textBoundingSize.height + 10 +cellModel.imagesHeight + 10 + 20+10 + cellModel.commentTblViewHeight +10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCircleTableViewCell *cell = (FriendCircleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FriendCircleTableViewCell class])];
    cell.cellModel = _mainCellModels[indexPath.row];
    cell.commentBtn.tag = 2000+indexPath.row;
    
    cell.actualcommentBtn.tag = 2000+indexPath.row;
    [cell.actualcommentBtn addTarget:self action:@selector(actualcommentAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.likeBtn.tag = 2000+indexPath.row;
    [cell.likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.tapImageHandler = ^(NSInteger index, NSArray *imageViews) {
        PhotoBrowserViewController *browser = [[PhotoBrowserViewController alloc] init];
        browser.imageViews = imageViews;
        browser.currentIndex = index;
        [self.navigationController.view addSubview:browser.view];
        [self.navigationController addChildViewController:browser];
        [browser didMoveToParentViewController:self.navigationController];
        [browser beginAppearanceTransition:YES animated:YES];
        [browser endAppearanceTransition];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}

- (void)tblViewTapped:(UITapGestureRecognizer *)tap{
    [self.commentTextField resignFirstResponder];
    
    for (FriendCircleTableViewCell *cell in self.friendCircleTblView.visibleCells) {
        [cell animateCommentWithOpen:NO];
    }
}

- (void)actualcommentAction:(UIButton *)btn{

    NSInteger rowIndex = btn.tag - 2000;
    FriendCircleTableViewCell *cell = (FriendCircleTableViewCell *)[self.friendCircleTblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    [cell animateCommentWithOpen:NO];
    
    self.commentTextField.tag = 2000+rowIndex;
    
    [self.commentTextField becomeFirstResponder];


}

- (void)likeAction:(UIButton *)btn{
    
    NSInteger rowIndex = btn.tag - 2000;
    FriendCircleTableViewCell *cell = (FriendCircleTableViewCell *)[self.friendCircleTblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    [cell animateCommentWithOpen:NO];
    
    FriendCircleModel *cellModel = self.mainCellModels[rowIndex];
    [cellModel.likeImages addObject:[UIImage imageNamed:@"referee"]];
    
    [self.friendCircleTblView reloadData];
}

#pragma mark TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    NSInteger rowIndex = textField.tag -2000;
    FriendCircleModel *cellModel = self.mainCellModels[rowIndex];
    
    CommentModel *comment = [[CommentModel alloc] init];
    comment.avatarString = @"stopwatch";
    comment.name = @"闹钟";
    comment.content = textField.text;
    comment.createdTime = @"1分钟前";
    [cellModel.commentArray addObject:comment];
    
    [self.friendCircleTblView reloadData];
    
    return YES;
}

#pragma mark keyBoard notification

- (void)keyBoardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:notification.userInfo];
    CGRect keyBoardBounds  = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight = keyBoardBounds.size.height;
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    void (^animation)(void) = ^void(void) {
        self.keyboardCommentView.transform = CGAffineTransformMakeTranslation(0, -(keyBoardHeight + 50));
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
    
    NSInteger rowIndex = self.commentTextField.tag - 2000;
    
    FriendCircleModel *cellModel = self.mainCellModels[rowIndex];
    CGRect frame = [self.friendCircleTblView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
    CGFloat height = 10 + 20+ 10+ cellModel.contentLayout.textBoundingSize.height + 10 +cellModel.imagesHeight + 10 + 20+10;//cell顶部到评论顶部的高度
    CGFloat offset = frame.origin.y + height  - ([UIScreen mainScreen].bounds.size.height - [self statusAndNavigationBarHeight] - (keyBoardHeight + 50));
    [self.friendCircleTblView setContentOffset:CGPointMake(0, offset) animated:YES];
    
}
- (void)keyBoardWillHide:(NSNotification *)notificaiton
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithDictionary:notificaiton.userInfo];
    CGFloat animationTime  = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    void (^animation)(void) = ^void(void) {
        self.keyboardCommentView.transform = CGAffineTransformIdentity;
    };
    
    if (animationTime > 0) {
        [UIView animateWithDuration:animationTime animations:animation];
    } else {
        animation();
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   CGFloat _lastY = scrollView.contentOffset.y;
    float alpha = _lastY / 64;
    alpha = alpha > 1 ? 1 : alpha;
    if (alpha < 0) {
        alpha = 0;
    }
    self.navigationController.navigationBar.alpha = alpha;
}

- (CGFloat)statusAndNavigationBarHeight{
    if (@available(iOS 11.0, *)) {
        return 88.f;
    }
    return 64.f;
}

- (UIColor *)navigationBarColor{
    return [UIColor colorWithRed:240/255.f green:240/255.f blue:240/255.f alpha:1];
}

- (UIColor *)navigationBarColorWithAlpha:(CGFloat)alpha{
    return [[self navigationBarColor] colorWithAlphaComponent:alpha];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
