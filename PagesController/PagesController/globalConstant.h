//
//  globalConstant.h
//  PagesController
//
//  Created by AllenHuang on 2018/8/16.
//  Copyright © 2018 AllenHuang. All rights reserved.
//

#ifndef globalConstant_h
#define globalConstant_h

#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* globalConstant_h */
