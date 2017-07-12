#import "PageHistoryResultCell.h"
#import "UIFont+WMFStyle.h"
#import "Wikipedia-Swift.h"
@import WMF.Swift;

@interface PageHistoryResultCell ()

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deltaLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end

@implementation PageHistoryResultCell

- (void)setName:(NSString *)name
           date:(NSDate *)date
          delta:(NSNumber *)delta
         isAnon:(BOOL)isAnon
        summary:(NSString *)summary
      separator:(BOOL)separator
          theme:(WMFTheme *)theme {

    self.nameLabel.text = name;
    self.timeLabel.text = [[NSDateFormatter wmf_shortTimeFormatter] stringFromDate:date];
    self.deltaLabel.text = [NSString stringWithFormat:@"%@%@", (delta.integerValue > 0) ? @"+" : @"", delta.stringValue];
    self.userImageView.image = [[UIImage imageNamed:isAnon ? @"user-sleep" : @"user-smile"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

    if (delta.integerValue == 0) {
        self.deltaLabel.textColor = theme.colors.link;
    } else if (delta.integerValue > 0) {
        self.deltaLabel.textColor = theme.colors.accent;
    } else {
        self.deltaLabel.textColor = theme.colors.destructive;
    }

    self.userImageView.tintColor = theme.colors.midBackground;
    self.summaryLabel.text = [summary wmf_stringByRemovingHTML];

    self.separatorHeightConstraint.constant =
        (separator) ? (1.0f / [UIScreen mainScreen].scale) : 0.0f;
    
    self.backgroundView.backgroundColor = theme.colors.paperBackground;
    self.selectedBackgroundView.backgroundColor = theme.colors.midBackground;
    
    self.nameLabel.textColor = theme.colors.secondaryText;
    self.timeLabel.textColor = theme.colors.primaryText;
    self.summaryLabel.textColor = theme.colors.secondaryText;
    self.userImageView.tintColor = theme.colors.paperBackground;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundView = [UIView new];
    self.selectedBackgroundView = [UIView new];
    [self wmf_configureSubviewsForDynamicType];
}

@end
