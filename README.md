# T_yunMap
this is a map just copy Amap

####1.`CLGeocoder`地理编码反编码之后的语言于模拟器系统的语言一致


####2.鉴于个人所在城市经常用到 在高德的`MAUserLocation`类添加分类，实现对`city`定义成`@property`。 设置为`readonly`属性并重写上其`getter`方法 用`CLGeocoder`反地理编码求出其所在`city`.
  上述操作在实践之时，由于用的系统`GeoCoder`反地理编码为异步处理，不能正确返回理想中的值。解Bug思路目前有二：（1.将设计模式换为city为用户可选值 选择定值或者 用户手动定位。（2.通过一定方法将本来异步的俩个方法 放到一个串行队列中 实现先进先出 。 暂时采取方法1，有时间可以尝试方法2.
  
####3.使用`UIAlertController`时 当该alert所添加的视图控制器prensent了其他控件时  不会present alert出来。 正好我主视图用`UINavigationController`导航到一个 包含了`UISearcherController`的视图控制器中。完成我想要的结果后pop回来时该searbar没有消失而是出现在了主页。当时直接将其hidden，固造成了alert不出现的错误 
`Warning: Attempt to present <UIAlertController: 0x15ce86c10>  on <HomepageViewController: 0x15ce7fe80> which is already presenting (null)`