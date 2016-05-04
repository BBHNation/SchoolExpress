//
//  XYRegisterViewController.m
//  校园快递_Online
//
//  Created by 白彬涵 on 16/4/26.
//  Copyright © 2016年 Philips. All rights reserved.
//

#import "XYRegisterViewController.h"

@interface XYRegisterViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *passwordAgainFeild;




@end

@implementation XYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)registerButtonAction:(id)sender {
    NSData *data = UIImagePNGRepresentation(_userHeadImageView.image);
    AVFile *file = [AVFile fileWithData:data];
    [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            if (_passwordTextFeild.text&&_userNameTextFeild.text&&_passwordAgainFeild.text) {
                AVUser *user = [AVUser user];
                user.username = _userNameTextFeild.text;
                user.password = _passwordTextFeild.text;
                [user setObject:file.url forKey:@"headImage"];
                [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        NSLog(@"注册成功");
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    else{
                        NSLog(@"注册失败");
                    }
                }];
            }
        }
        else{
            NSLog(@"保存头像失败，注册失败");
        }
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)endEditing:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)pickUserHeadImageAction:(id)sender {
    [self presentAlertView];
}

#pragma mark ImagePicker
- (void)presentAlertView{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选取照片"
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* takePhoto = [UIAlertAction actionWithTitle:@"拍摄" style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * action) {
                                                          NSLog(@"点击了第一个");
                                                          [self takePhoto];
                                                      }];
    UIAlertAction* choseFromAlbum= [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              NSLog(@"点击了第二个");
                                                              [self LocalPhoto];
                                                          }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                       NSLog(@"点击了取消");
                                                       
                                                   }];
    [alert addAction:takePhoto];
    [alert addAction:choseFromAlbum];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)LocalPhoto{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:nil];
        //创建一个选择后图片的小图标放在下方
        //类似微薄选择图后的效果
        //加在视图中
        [_userHeadImageView setImage:image];
    }
    
}
@end
