# T_yunMap
this is a map just copy Amap

####1.`CLGeocoder`地理编码反编码之后的语言于模拟器系统的语言一致


####2.鉴于个人所在城市经常用到 在高德的`MAUserLocation`类添加分类，实现对`city`定义成`@property`。 设置为`readonly`属性并重写上其`getter`方法 用`CLGeocoder`反地理编码求出其所在`city`.
  上述操作在实践之时，由于用的系统`GeoCoder`反地理编码为异步处理，不能正确返回理想中的值。解Bug思路目前有二：（1.将设计模式换为city为用户可选值 选择定值或者 用户手动定位。（2.通过一定方法将本来异步的俩个方法 放到一个串行队列中 实现先进先出 。 暂时采取方法1，有时间可以尝试方法2.
  
####3.使用`UIAlertController`时 当该alert所添加的视图控制器prensent了其他控件时  不会present alert出来。 正好我主视图用`UINavigationController`导航到一个 包含了`UISearcherController`的视图控制器中。完成我想要的结果后pop回来时该searbar没有消失而是出现在了主页。当时直接将其hidden，固造成了alert不出现的错误 
`Warning: Attempt to present <UIAlertController: 0x15ce86c10>  on <HomepageViewController: 0x15ce7fe80> which is already presenting (null)`

####4.实现对搜索过的`AMapTip`类写入数组就行归档  
 首先将需要归档的自定义的对象实现<NSCoding>协议
 ```
 - (void)encodeWithCoder:(NSCoder *)aCoder {

//    @property (nonatomic, copy) NSString     *uid; //!< poi的id
//    @property (nonatomic, copy) NSString     *name; //!< 名称
//    @property (nonatomic, copy) NSString     *adcode; //!< 区域编码
//    @property (nonatomic, copy) NSString     *district; //!< 所属区域
//    @property (nonatomic, copy) AMapGeoPoint *location; //!< 位置
    
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.adcode forKey:@"adcode"];
    [aCoder encodeObject:self.district forKey:@"district"];
    [aCoder encodeObject:self.latitude forKey:@"latitude"];
    [aCoder encodeObject:self.longitude forKey:@"longitude"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.adcode = [aDecoder decodeObjectForKey:@"adcod"];
        self.district = [aDecoder decodeObjectForKey:@"district"];
        self.latitude = [aDecoder decodeObjectForKey:@"latitude"];
        self.longitude = [aDecoder decodeObjectForKey:@"longitude"];
    }
    
    return self;
	}
（2.然后对其对象里面属性自定义对象也同样操作。

（3.写了一个类专门对其实现归档读档和删档操作 部分代码
```
  //mutabeData用来存储归档完成以后的数据
        NSMutableData *data = [NSMutableData data];
        
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        
        //归档
        [archiver encodeObject:obj forKey:key];
        
        //完成归档
        [archiver finishEncoding];
        
        //写入文件
        [data writeToFile:[self searchFilePath] atomically:YES];
        
        //删档
         [manager removeItemAtPath:[self searchFilePath] error:nil];
         
          NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        
        arr = [unArchiver decodeObjectForKey:key];
        
        //完成归档
        [unArchiver finishDecoding];

（4.对解档出来的数据经过判断显示 

####5.使用`UICollectionView`类，cell 和组头组尾都必须复用。且对于组头组尾 要设置 headerReferenceSize
    `flowLayout.headerReferenceSize = CGSizeMake(200, 50);`