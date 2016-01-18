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
    
    NSArray *macao = @[@"澳门特区"];
    
    NSArray *liaoning = @[@"本溪",
                          @"铁岭",
                          @"鞍山",
                          @"朝阳",
                          @"丹东",
                          @"抚顺",
                          @"辽阳",
                          @"大连",
                          @"沈阳",
                          @"营口",
                          @"葫芦岛",
                          @"阜新",
                          @"锦州",
                          @"盘锦"];
    
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
    
    NSArray *qinghai = @[@"黄南藏族自治州",//:0973
                         @"西宁",//:0971
                         @"海东地区",//:0972
                         @"海北藏族自治州",//:0970
                         @"玉树藏族自治州",//:0976
                         @"果洛藏族自治州",//:0975
                         @"海南藏族自治州"];//:0974
    
    NSArray *hainan = @[@"西沙群岛",//:1895
                        @"儋州",//:0805
                        @"白沙黎族自治县",//:30898
                        @"保亭黎族苗族自治县",//:10898
                        @"昌江黎族自治县",//:20898
                        @"中沙群岛的岛礁及其海域",//:2801
                        @"屯昌县",//:1892
                        @"海口",//:0898
                        @"琼海",//:1894
                        @"东沙群岛",//:0808
                        @"临高县",//:1896
                        @"东方",//:0807
                        @"南沙群岛",//:1891
                        @"五指山",//:1897
                        @"文昌",//:1893
                        @"琼中黎族苗族自治县",//:1899
                        @"三亚",//:0899
                        @"乐东黎族自治县",//:2802
                        @"万宁",//:1898
                        @"陵水黎族自治县",//:0809
                        @"澄迈县"];//:0804
    
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
    
    NSArray *
    
    
    return provinces;
}

@end