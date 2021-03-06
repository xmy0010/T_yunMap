//
//  ChoseCitys.m
//  T_yunMap
//
//  Created by T_yun on 16/1/18.
//  Copyright © 2016年 T_yun. All rights reserved.
//

#import "ChoseCitys.h"

@implementation ChoseCitys

+ (NSArray *)choseCitysWithName:(NSString *)name {
   NSArray *hotCitys = @[@"定位",
                         @"北京",
                         @"上海",
                         @"杭州",
                         @"广州",
                         @"深圳",
                         @"武汉",
                         @"南京"];
    
    NSArray *provinces =@[@"北京",
                          @"澳门",
                          @"辽宁省",
                          @"陕西省",
                          @"安徽省",
                          @"青海省",
                          @"海南省",
                          @"山西省",
                          @"吉林省",
                          @"四川省",
                          @"江西省",
                          @"天津",
                          @"贵州省",
                          @"甘肃省",
                          @"内蒙古",
                          @"香港",
                          @"湖北省",
                          @"宁夏",
                          @"西藏",
                          @"重庆",
                          @"广东省",
                          @"新疆",
                          @"湖南省",
                          @"江苏省",
                          @"浙江省",
                          @"黑龙江省",
                          @"云南省",
                          @"河南省",
                          @"福建省",
                          @"广西",
                          @"湖北省",
                          @"上海",
                          @"山东省"];
    
    NSArray *beijing = @[@"北京"];
    
    NSArray *macao = @[@"澳门"];
    
    NSArray *liaoning = @[@"沈阳",
                          @"大连",
                          @"鞍山",
                          @"丹东",
                          @"抚顺",
                          @"锦州",
                          @"营口",
                          @"本溪",
                          @"朝阳",
                          @"阜新",
                          @"葫芦岛",
                          @"辽阳",
                          @"盘锦",
                          @"铁岭"];
    
    NSArray *shanxiS = @[@"西安",
                         @"延安",
                         @"汉中",
                         @"宝鸡",
                         @"商洛",
                         @"铜川",
                         @"渭南",
                         @"榆林",
                         @"咸阳",
                         @"安康"];
    
    NSArray *anhui = @[@"马鞍山",
                       @"六安",
                       @"黄山",
                       @"蚌埠",
                       @"滁州",
                       @"淮北",
                       @"淮南",
                       @"巢湖",
                       @"安庆",
                       @"铜陵",
                       @"亳州",
                       @"宿州",
                       @"合肥",
                       @"宣城",
                       @"池州",
                       @"阜阳",
                       @"芜湖"];
    
    NSArray *qinghai = @[@"黄南",//:0973
                         @"西宁",//:0971
                         @"海东",//:0972
                         @"海北",//:0970
                         @"玉树",//:0976
                         @"果洛",//:0975
                         @"海南"];//:0974
    
    NSArray *hainan = @[@"海口",
                        @"三亚",
                        @"澄迈县",
                        @"定安县",
                        @"东方",
                        @"乐东县",
                        @"临高县",
                        @"陵水县",
                        @"琼海",
                        @"琼中县",
                        @"屯昌县",
                        @"万宁",
                        @"文昌",
                        @"五指山",
                        @"儋州"];
    
    NSArray *shanxiY = @[@"运城",//:0359
                         @"晋城",//:0356
                         @"大同",//:0352
                         @"长治",//:0355
                         @"吕梁",//:0358
                         @"朔州",//:0349
                         @"晋中",//:0354
                         @"太原",//:0351
                         @"阳泉",//:0353
                         @"临汾",//:0357
                         @"忻州"];//:0350
    
    NSArray *jilin = @[@"白城",//:0436
                       @"延边朝鲜族自治州",//:01433
                       @"长春",//:0431
                       @"通化",//:0435
                       @"白山",//:0439
                       @"四平",//:0434
                       @"吉林",//:0432
                       @"松原",//:0438
                       @"辽源"];//:0437
    
    NSArray *sichuan = @[@"广元",//:0839
                         @"雅安",//:0835
                         @"成都",//:0028
                         @"德阳",//:0838
                         @"巴中",//:0827
                         @"凉山彝族自治州",//:0834
                         @"广安",//:0826
                         @"达州",//:0818
                         @"眉山",//:01833
                         @"攀枝花",//:0812
                         @"绵阳",//:0816
                         @"泸州",//:0830
                         @"南充",//:0817
                         @"宜宾",//:0831
                         @"遂宁",//:0825
                         @"自贡",//:0813
                         @"乐山",//:0833
                         @"甘孜藏族自治州",//:0836
                         @"内江",//:01832
                         @"阿坝藏族羌族自治州",//:0837
                         @"资阳"];//:0832
    
    NSArray *jiangxi = @[@"鹰潭",//:0701
                         @"抚州",//:0794
                         @"宜春",//:0795
                         @"萍乡",//:0799
                         @"上饶",//:0793
                         @"新余",//:0790
                         @"九江",//:0792
                         @"景德镇",//:0798
                         @"南昌",//:0791
                         @"赣州",//:0797
                         @"吉安"];//:0796
    
    NSArray *tianjin = @[@"天津"];
    
    NSArray *guizhou = @[@"黔南布依族苗族自治州",//:0854
                         @"安顺",//:0853
                         @"毕节地区",//:0857
                         @"遵义",//:0852
                         @"铜仁地区",//:0856
                         @"黔东南苗族侗族自治州",//:0855
                         @"贵阳",//:0851
                         @"六盘水",//:0858
                         @"黔西南布依族苗族自治州"];//:0859
    
    NSArray *gansu = @[@"嘉峪关",//:1937
                       @"定西",//:0932
                       @"白银",//:0943
                       @"庆阳",//:0934
                       @"平凉",//:0933
                       @"张掖",//:0936
                       @"酒泉",//:0937
                       @"甘南藏族自治州",//:0941
                       @"临夏回族自治州",//:0930
                       @"金昌",//:0935
                       @"陇南",//:02935
                       @"武威",//:01935
                       @"天水",//:0938
                       @"兰州"];//:0931
    
    NSArray *innerMongolia = @[@"巴彦淖尔",//:0478
                               @"鄂尔多斯",//:0477
                               @"兴安盟",//:0482
                               @"包头",//:0472
                               @"乌海",//:0473
                               @"呼伦贝尔",//:0470
                               @"呼和浩特",//:0471
                               @"通辽",//:0475
                               @"阿拉善盟",//:0483
                               @"赤峰",//:0476
                               @"乌兰察布",//:0474
                               @"锡林郭勒盟"];//:0479
    
    NSArray *hongKong = @[@"香港特区"];//1852
    
    NSArray *hubei = @[@"黄石",//:0714
                       @"鄂州",//:0711
                       @"恩施土家族苗族自治州",//:0718
                       @"荆州",//:0716
                       @"孝感",//:0712
                       @"仙桃",//:0728
                       @"咸宁",//:0715
                       @"天门",//:01728
                       @"潜江",//:02728
                       @"黄冈",//:0713
                       @"十堰",//:0719
                       @"随州",//:0722
                       @"武汉",//:0027
                       @"荆门",//:0724
                       @"宜昌",//:0717
                       @"襄樊",//:0710
                       @"神农架林区"];//:01719
    
    NSArray *ningxia = @[@"石嘴山",//:0952
                         @"中卫",//:01953
                         @"银川",//:0951
                         @"固原",//:0954
                         @"吴忠"];//:0953
    
    NSArray *tibet = @[@"山南地区",//:0893
                       @"林芝地区",//:0894
                       @"拉萨",//:0891
                       @"那曲地区",//:0896
                       @"昌都地区",//:0895
                       @"日喀则地区",//:0892
                       @"阿里地区"];//:0897
    
    NSArray *chongqing = @[@"重庆"];
    
    NSArray *guangdong = @[@"肇庆",//:0758
                           @"梅州",//:0753
                           @"阳江",//:0662
                           @"揭阳",//:0663
                           @"湛江",//:0759
                           @"韶关",//:0751
                           @"惠州",//:0752
                           @"珠海",//:0756
                           @"茂名",//:0668
                           @"佛山",//:0757
                           @"汕头",//:0754
                           @"江门",//:0750
                           @"中山",//:0760
                           @"深圳",//:0755
                           @"东莞",//:0769
                           @"潮州",//:0768
                           @"清远",//:0763
                           @"河源",//:0762
                           @"云浮",//:0766
                           @"汕尾",//:0660
                           @"广州"];//:0020]
    
    NSArray *xinjiang = @[@"哈密地区",//:0902
                          @"克拉玛依",//:0990
                          @"阿勒泰地区",//:0906
                          @"克孜勒苏柯尔克孜自治州",//:0908
                          @"吐鲁番地区",//:0995
                          @"阿克苏地区",//:0997
                          @"伊犁哈萨克自治州",//:0999
                          @"巴音郭楞蒙古自治州",//:0996
                          @"昌吉回族自治州",//:0994
                          @"石河子",//:0993
                          @"博尔塔拉蒙古自治州",//:0909
                          @"喀什地区",//:0998
                          @"塔城地区",//:0901
                          @"和田地区",//:0903
                          @"乌鲁木齐"];//:0991
    
    NSArray *hunan = @[@"郴州",//:0735
                       @"株洲",//:0733
                       @"湘潭",//:0732
                       @"永州",//:0746
                       @"岳阳",//:0730
                       @"常德",//:0736
                       @"怀化",//:0745
                       @"益阳",//:0737
                       @"湘西土家族苗族自治州",//:0743
                       @"邵阳",//:0739
                       @"张家界",//:0744
                       @"长沙",//:0731
                       @"衡阳",//:0734
                       @"娄底"];//:0738
    
    NSArray *jiangsu = @[@"盐城",//:0515
                         @"无锡",//:0510
                         @"扬州",//:0514
                         @"泰州",//:0523
                         @"镇江",//:0511
                         @"南通",//:0513
                         @"宿迁",//:0527
                         @"常州",//:0519
                         @"苏州",//:0512
                         @"徐州",//:0516
                         @"淮安",//:0517
                         @"连云港",//:0518
                         @"南京"];//:0025
    
    NSArray *zhejiang = @[@"宁波",//:0574
                          @"绍兴",//:0575
                          @"湖州",//:0572
                          @"金华",//:0579
                          @"杭州",//:0571
                          @"嘉兴",//:0573
                          @"舟山",//:0580
                          @"台州",//:0576
                          @"丽水",//:0578
                          @"衢州",//:0570
                          @"温州"];//:0577
    
    NSArray *heilongjiang = @[@"大兴安岭地区",//:0457
                              @"哈尔滨",//:0451
                              @"牡丹江",//:0453
                              @"佳木斯",//:0454
                              @"黑河",//:0456
                              @"双鸭山",//:0469
                              @"绥化",//:0455
                              @"伊春",//:0458
                              @"齐齐哈尔",//:0452
                              @"鹤岗",//:0468
                              @"鸡西",//:0467
                              @"七台河",//:0464
                              @"大庆"];//:0459
    
    NSArray *yunnan = @[@"大理白族自治州",//:0872
                        @"玉溪",//:0877
                        @"迪庆藏族自治州",//:0887
                        @"楚雄彝族自治州",//:0878
                        @"文山壮族苗族自治州",//:0876
                        @"红河哈尼族彝族自治州",//:0873
                        @"临沧",//:0883
                        @"普洱",//:0879
                        @"丽江",//:0888
                        @"西双版纳傣族自治州",//:0691
                        @"昭通",//:0870
                        @"保山",//:0875
                        @"昆明",//:0871
                        @"德宏傣族景颇族自治州",//:0692
                        @"怒江傈僳族自治州",//:0886
                        @"曲靖"];//:0874
    
    NSArray *henan = @[@"安阳",//:0372
                       @"周口",//:0394
                       @"南阳",//:0377
                       @"开封",//:0378
                       @"洛阳",//:0379
                       @"信阳",//:0376
                       @"商丘",//:0370
                       @"驻马店",//:0396
                       @"平顶山",//:0375
                       @"新乡",//:0373
                       @"焦作",//:0391
                       @"漯河",//:0395
                       @"濮阳",//:0393
                       @"郑州",//:0371
                       @"许昌",//:0374
                       @"鹤壁",//:0392
                       @"三门峡",//:0398
                       @"济源"];//:01391
    
    NSArray *fujian = @[@"龙岩",//:0597
                        @"福州",//:0591
                        @"南平",//:0599
                        @"漳州",//:0596
                        @"三明",//:0598
                        @"泉州",//:0595
                        @"莆田",//:0594
                        @"宁德",//:0593
                        @"厦门"];//:0592
    
    NSArray *guangxi = @[@"桂林",//:0773
                         @"贺州",//:01774
                         @"北海",//:0779
                         @"钦州",//:0777
                         @"崇左",//:01771
                         @"来宾",//:01772
                         @"百色",//:0776
                         @"防城港",//:0770
                         @"贵港",//:01755
                         @"河池",//:0778
                         @"柳州",//:0772
                         @"玉林",//:0775
                         @"南宁",//:0771
                         @"梧州"];//:0774
    
    NSArray *hebei = @[@"承德",//:0314
                       @"张家口",//:0313
                       @"唐山",//:0315
                       @"保定",//:0312
                       @"邯郸",//:0310
                       @"沧州",//:0317
                       @"秦皇岛",//:0335
                       @"衡水",//:0318
                       @"廊坊",//:0316
                       @"石家庄",//:0311
                       @"邢台"];//:0319
    
    NSArray *shanghai = @[@"上海"];//0021
    
    NSArray *shangdong = @[@"东营",//:0546
                           @"烟台",//:0535
                           @"威海",//:0631
                           @"聊城",//:0635
                           @"日照",//:0633
                           @"济南",//:0531
                           @"济宁",//:0537
                           @"临沂",//:0539
                           @"枣庄",//:0632
                           @"菏泽",//:0530
                           @"泰安",//:0538
                           @"青岛",//:0532
                           @"德州",//:0534
                           @"莱芜",//:0634
                           @"滨州",//:0543
                           @"潍坊",//:0536
                           @"淄博"];//:0533
    
    NSDictionary *dict = @{@"hotCitys" : hotCitys,
                           @"provinces": provinces,
                           @"北京" : beijing,
                           @"澳门" : macao,
                           @"辽宁省" : liaoning,
                           @"陕西省" : shanxiS,
                           @"安徽省" : anhui,
                           @"青海省" : qinghai,
                           @"海南省" : hainan,
                           @"山西省" : shanxiY,
                           @"吉林省" : jilin,
                           @"四川省" : sichuan,
                           @"江西省" : jiangxi,
                           @"天津" : tianjin,
                           @"贵州省" : guizhou,
                           @"甘肃省" : gansu,
                           @"内蒙古" : innerMongolia,
                           @"香港" : hongKong,
                           @"湖北省" : hubei,
                           @"宁夏" : ningxia,
                           @"西藏" : tibet,
                           @"重庆" : chongqing,
                           @"广东省" : guangdong,
                           @"新疆" : xinjiang,
                           @"湖南省" : hunan,
                           @"江苏省" : jiangsu,
                           @"浙江省" : zhejiang,
                           @"黑龙江省" : heilongjiang,
                           @"云南省" : yunnan,
                           @"河南省" : henan,
                           @"福建省" : fujian,
                           @"广西" : guangxi,
                           @"河北省" : hebei,
                           @"上海" : shanghai,
                           @"山东省" : shangdong};
    
    return dict[name];
}

@end
