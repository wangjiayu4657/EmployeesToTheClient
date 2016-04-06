//
//  Pet.h
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseObject.h"

@interface PetBreed : BaseObject

@property (nonatomic, strong) NSString *name;

@end


@interface Pet : BaseObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) PetBreed *breed;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *avatarURL;

@end
