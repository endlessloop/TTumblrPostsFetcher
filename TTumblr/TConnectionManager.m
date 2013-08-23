//
//  TConnectionManager.m
//  TTumblr
//
//  Created by Praveen on 8/22/13.
//  Copyright (c) 2013 Praveen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  1. The above copyright notice and this permission notice shall be included
//     in all copies or substantial portions of the Software.
//
//  2. This Software cannot be used to archive or collect data such as (but not
//     limited to) that of events, news, experiences and activities, for the
//     purpose of any concept relating to diary/journal keeping.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "TConnectionManager.h"
#import "TTumblrPostsModel.h"

@implementation TConnectionManager

// Fetch Tumblr Posts 
+(void)fetchTumblrPosts:(void(^)(NSArray *statuses))successBlock
             errorBlock:(void(^)(NSError *error))errorBlock{
    dispatch_queue_t lDownloadTumblrFeedslQueue = dispatch_queue_create("Get Tumblr Feeds", NULL);
    dispatch_async(lDownloadTumblrFeedslQueue, ^{
        NSMutableArray *lTumblrPostsCollection;
        // Send request
        NSData *lFeedsData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@",TUMBLR_PART1_URL,TUMBLR_BLOG_NAME,TUMBLR_PART2_URL,TUMBLR_API_KEY]]];
        NSError* lError;
        // Get Json Object from response
        NSDictionary *lTumblrJsonObject = [NSJSONSerialization JSONObjectWithData:lFeedsData options:kNilOptions error:&lError];
        
        if(lTumblrJsonObject!=nil){
            // Get Array of posts from response
            NSArray *lTumblrPosts = [[lTumblrJsonObject objectForKey:TAG_RESPONSE] objectForKey:TAG_POSTS];
            lTumblrPostsCollection = [[NSMutableArray alloc]initWithCapacity:[lTumblrJsonObject count]];
            // Loop through the posts and get title , body and date
            for(NSDictionary *lTumblrPost in lTumblrPosts){
                // get all posts of type text
                // you could also get other types, get tumblr api docs
                if([[lTumblrPost objectForKey:TAG_TYPE] isEqualToString:TAG_TEXT]){
                    TTumblrPostsModel *lTumblrModel = [[TTumblrPostsModel alloc]init];
                    lTumblrModel.mTitle = [lTumblrPost objectForKey:TAG_TITLE];
                    lTumblrModel.mBody = [lTumblrPost objectForKey:TAG_BODY];
                    lTumblrModel.mDate = [lTumblrPost objectForKey:TAG_DATE];
                    [lTumblrPostsCollection addObject:lTumblrModel];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                successBlock(lTumblrPostsCollection);
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                errorBlock(lError);
            });
        }
    });
}

@end
