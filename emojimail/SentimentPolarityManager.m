//
//  SentimentPolarityManager.m
//  emojimail
//
//  Created by Aram Sargsyan on 9/21/17.
//  Copyright © 2017 Aram Sargsyan. All rights reserved.
//

#import "SentimentPolarityManager.h"
#import "SentimentPolarity.h"


@interface SentimentPolarityManager()

@property (nonatomic) SentimentPolarity *model;
@property (nonatomic) NSLinguisticTagger *tagger;
@property (nonatomic) NSLinguisticTaggerOptions taggerOptions;

@end


@implementation SentimentPolarityManager

#pragma mark - Lifecycle


- (instancetype)init {
    self = [super init];
    if (self) {
        _model = [[SentimentPolarity alloc] init];
        _taggerOptions = NSLinguisticTaggerOmitWhitespace | NSLinguisticTaggerOmitPunctuation | NSLinguisticTaggerOmitOther;
        _tagger = [[NSLinguisticTagger alloc] initWithTagSchemes:[NSLinguisticTagger availableTagSchemesForLanguage:@"en"] options:_taggerOptions];
    }
    return self;
}


#pragma mark - Public


+ (instancetype)sharedManager {
    static SentimentPolarityManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[[self class] alloc] init];
    });
    return sharedManager;
}


- (NSString *)sentimentEmojiForText:(NSString *)text {
    SentimentPolarityInput *input = [self inputForText:text];
    
    NSError *error;
    SentimentPolarityOutput *output = [self.model predictionFromFeatures:input error:&error];
    
    if (error) {
        NSLog(@"[SentimentPolarityManager] failed to determine sentiment");
        return nil;
    }
    
    return [self emojiForClassProbability:output.classProbability];
}


#pragma mark - Private


- (SentimentPolarityInput *)inputForText:(NSString *)text {
    NSMutableDictionary <NSString *, NSNumber *> *wordCounts = [NSMutableDictionary dictionary];
    
    self.tagger.string = text;
    NSRange range = NSMakeRange(0, text.length);
    
    [self.tagger enumerateTagsInRange:range scheme:NSLinguisticTagSchemeNameType options:self.taggerOptions usingBlock:^(NSLinguisticTag  _Nullable tag, NSRange tokenRange, NSRange sentenceRange, BOOL * _Nonnull stop) {
        NSString *token = [[text substringWithRange:tokenRange] lowercaseString];
        
        // No need for words like a, to, on, in, or any other word with letter count < 3 ...
        if (token.length < 3) {
            return;
        }
        
        if (wordCounts[token]) {
            wordCounts[token] = [NSNumber numberWithInt:wordCounts[token].intValue + 1];
        } else {
            wordCounts[token] = [NSNumber numberWithInt:1];
        }
        
    }];
    
    return [[SentimentPolarityInput alloc] initWithInput:wordCounts];
}


- (NSString *)emojiForClassProbability:(NSDictionary<NSString *, NSNumber *> *)classProbability {
    double positiveProbability = classProbability[@"Pos"].doubleValue;
    if (positiveProbability < 0.2) {
        return @"😡";
    } else if (positiveProbability < 0.3) {
        return @"😠";
    } else if (positiveProbability < 0.5) {
        return @"😐";
    } else if (positiveProbability < 0.8) {
        return @"😀";
    } else {
        return @"😁";
    }
}


@end
