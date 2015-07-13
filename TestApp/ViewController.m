//
//  ViewController.m
//  TestApp
//
//  Created by Ravi Joshi on 10/30/14.
//  Copyright (c) 2014 Ravi Joshi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    [self findTheLongestConsecutivePrimeSequenceWhichAddsUpToAPrimeNumberBelow:1000000];
    
//    [self findTheLongestConsecutivePrimeSequenceWhichAddsUpToAPrimeNumberBelow:10];
    
    
//    if ([self giveNumberSeeIfPassedInNnumberIsMirror:@(124342)]) {
//        NSLog(@"Is Mirror");
//    } else {
//        NSLog(@"Is not mirror");
//    }
    
    [self getMaximumPossibleIntegerForNumber:8799 andAllowedSwapOperations:3];
    
    [self findFactorsOfANumber:12];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Method or Problems:
- (NSInteger)reverseAnIntegerString:(NSInteger)integer {
    if (integer / 10 == 0) {
        // representing an error state that number cannot be 1 digit
        return integer;
    }
    NSInteger reverseString = 0;
    while (integer % 10 != 0) {
        reverseString = reverseString *10 + integer %10;
        integer = integer/10;
    }
    return reverseString;
}

// Given an array find if the sum pair exists in the arrar

- (BOOL) givenArray:(NSArray *)integerArray checkToSeeIfSumPairExistsForNumber:(NSInteger) givenNumber {
    BOOL exists = NO;
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    for (NSInteger index = 0; index < integerArray.count; index ++) {
        NSInteger currentDifference = givenNumber - [(NSNumber *)integerArray[index] integerValue];
        if ([mutableDictionary objectForKey:@(currentDifference)]) {
            exists = YES;
            return exists;
        } else {
            NSNumber *currentNumber = (NSNumber *)integerArray[index];
            [mutableDictionary setObject:@(currentDifference) forKey:currentNumber];
        }
    }

    NSLog(@"Mutabel Dict %@",mutableDictionary);
    return exists;
}

// Given a String Find out the longest substring with unique characters
- (NSString *)longestSubstringWithUniqueCharsForString:(NSString *)mainString {
    NSString *longestString;
    
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionary];
    
    NSInteger currentMaximumLength =0;
    NSInteger startIndex = 0;
    NSInteger endIndex =0;
    
    NSInteger maxStartIndex = 0;
    NSInteger maxEndIndex = 0;
    
    while (endIndex < mainString.length) {
        NSString *currentChar = [mainString substringWithRange:NSMakeRange(endIndex, 1)];
        if (![mutableDictionary objectForKey:currentChar]) {
            [mutableDictionary setObject:@(endIndex) forKey:currentChar];
            if (endIndex - startIndex +1 > currentMaximumLength) {
                currentMaximumLength = endIndex - startIndex +1;
                maxStartIndex = startIndex;
                maxEndIndex = endIndex;
            }
            endIndex ++;
        } else {
            NSString *charToBeRemoved = [mainString substringWithRange:NSMakeRange(startIndex, 1)];
            [mutableDictionary removeObjectForKey:[mainString substringWithRange:NSMakeRange(startIndex, 1)]];
            startIndex ++;
            if (currentChar == charToBeRemoved) {
                if (endIndex - startIndex +1 > currentMaximumLength) {
                    currentMaximumLength = endIndex - startIndex +1;
                    maxStartIndex = startIndex;
                    maxEndIndex = endIndex;
                }
            }
        }
    }
    longestString = [mainString substringWithRange:NSMakeRange(maxStartIndex, maxEndIndex-maxStartIndex+1)];
    return longestString;
}


// find the longest common subsequence between 2 strings

- (void)printLongestCommenSubsequenceBetweenString1:(NSString *)string1 andString:(NSString *)string2 {
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionary];

    for (NSInteger currentIndex =0; currentIndex < string1.length; currentIndex ++) {
        NSString *currentChar = [string1 substringWithRange:NSMakeRange(currentIndex, 1)];
        if (![mutableDictionary objectForKey:currentChar]) {
            [mutableDictionary setObject:@(1) forKey:currentChar];
        } else {
            NSNumber *currentCharCount = [mutableDictionary objectForKey:currentChar];
            [mutableDictionary setObject:@(currentCharCount.integerValue +1) forKey:currentChar];
        }
    }
    
    for (NSInteger currentIndex = 0; currentIndex < string2.length ; currentIndex ++) {
        NSString *currentChar = [string2 substringWithRange:NSMakeRange(currentIndex, 1)];
        if ([mutableDictionary objectForKey:currentChar]) {
            NSNumber *currentCharCount = [mutableDictionary objectForKey:currentChar];
            [mutableDictionary setObject:@(currentCharCount.integerValue -1 ) forKey:currentChar];
        }
    }

    for (NSString *key in [mutableDictionary allKeys]) {
        if ([[mutableDictionary objectForKey:key ] isEqualToNumber:@(0)]) {
            NSLog(@"Print char %@",key);
        }
    }
}



// Given two strings check to see if they are anagrams

- (BOOL)anagramCheckWith:(NSString *)string1 andString:(NSString *)string2 {
    BOOL isAnagram = NO;
    
    if (string1.length != string2.length) {
        isAnagram = false;
        return isAnagram;
    }
    
    NSMutableDictionary * mutableDictionary = [NSMutableDictionary dictionary];
    
    for (NSInteger currentIndex =0; currentIndex < string1.length; currentIndex ++) {
        NSString *currentChar = [string1 substringWithRange:NSMakeRange(currentIndex, 1)];
        if (![mutableDictionary objectForKey:currentChar]) {
            [mutableDictionary setObject:@(1) forKey:currentChar];
        } else {
            NSNumber *currentCharCount = [mutableDictionary objectForKey:currentChar];
            [mutableDictionary setObject:@(currentCharCount.integerValue +1) forKey:currentChar];
        }
    }

    for (NSInteger currentIndex = 0; currentIndex < string2.length ; currentIndex ++) {
        NSString *currentChar = [string2 substringWithRange:NSMakeRange(currentIndex, 1)];
        if (![mutableDictionary objectForKey:currentChar]) {
            // This means that the string 2 is no longer an anagram
            isAnagram = NO;
            return isAnagram;
        } else {
            NSNumber *currentCharCount = [mutableDictionary objectForKey:currentChar];
            [mutableDictionary setObject:@(currentCharCount.integerValue -1 ) forKey:currentChar];
        }
    }
    
    for (NSString *key in [mutableDictionary allKeys]) {
        if (![[mutableDictionary objectForKey:key ] isEqualToNumber:@(0)]) {
            isAnagram = NO;
            break;
        }
        isAnagram = YES;
    }
    
    return isAnagram;
}

// Check to see if the string is rotation of the other string
- (BOOL) checkToSeeIfString:(NSString *)testString isRotationOfGivenString:(NSString *)givenString {
    BOOL isRotation = NO;
    NSMutableString *combinedString = [NSMutableString stringWithFormat:@"%@%@",givenString,givenString];
    if ([combinedString containsString:testString]) {
        isRotation = YES;
    }
    return isRotation;
}

// Find the maximum sum of subarray
- (NSDictionary *)findMaximumSubArrayFromArray:(NSArray *)array {
    
    NSDictionary *subArrayDetailsDictionary;
    
    if (!array) {
        return nil;
    }
    
    NSNumber *currentSum = @(0);
    
    NSNumber *maximumSum = @(0);
    
    NSInteger startIndex = 0;
    NSInteger endIndex = 0;
    
    NSInteger maxStartIndex = 0;
    NSInteger maxEndIndex = 0;
    
    for (NSInteger currentIndex = 0; currentIndex < array.count; currentIndex++) {
        
        NSNumber *currentNumber  =array[currentIndex];
        currentSum = @(currentSum.integerValue + currentNumber.integerValue);
        
        if (currentSum.integerValue > maximumSum.integerValue) {
            maximumSum = currentSum;
            maxStartIndex = startIndex;
            maxEndIndex = endIndex;
        }
        if (currentSum <= 0) {
            startIndex = endIndex +1;
            currentSum = 0;
        }
        endIndex ++;
    }
    
    subArrayDetailsDictionary = @{@"loweerSubarrayIndex":@(maxStartIndex),
                                  @"HigerIndex" : @(maxEndIndex), @"Subarrya" : @"Invoke Subarray Utility"};
    
    return subArrayDetailsDictionary;
}

// Given an Array find the maximum length subarray with equal # of 0's and1's

- (void)findMaxLengthSubarrayWithEqual0and1:(NSArray *)array {
    if (array.count == 0 ) {
        return ;
    }
    
    NSInteger currentSum = 0; // Difference between number of 1 and 0's
    NSInteger startIndex = 0;
    NSInteger endIndex = 0;
    
    NSInteger maxStartIndex=0;
    NSInteger maxEndIndex=0;
    
    NSInteger previousDiff = 0;
    
    for (NSInteger currentIndex = 0; currentIndex < array.count; currentIndex ++) {
        NSNumber *currentNumber = (NSNumber *)array[currentIndex];
        if ([currentNumber isEqualToNumber:@(0)]) {
            currentSum --;
        } else {
            currentSum++;
        }
        
        if (currentSum > previousDiff) {
            startIndex ++;
        } else {
            startIndex --;
        }
        previousDiff = currentSum;
        endIndex ++;
    }

    maxStartIndex = startIndex < 0 ? -startIndex : startIndex;
    maxEndIndex = endIndex -1 ;
}


NSArray * (^findUniqueSubsetsForArray) (NSArray *) = ^ NSArray * (NSArray *inputArray) {
    NSArray *outputArray ;
    NSInteger subsetCount = 2^(inputArray.count);

    for (NSInteger index =0; index < subsetCount; index++) {
    
        for (int bitIndex = 0; bitIndex < inputArray.count; bitIndex++) {
    
//            if  [weakSelf getBitStateForValue:index andPosition:bitIndex] == 1
//            {
//                // Add this to the subset
//            subset.Add(itemset[bitIndex]);
//            }
        }
        // add this subset to the subset arrray
    }
    return outputArray;
}
;

- (NSInteger)getBitStateForValue:(NSInteger)value andPosition:(NSInteger)bitIndex {
    NSInteger bitState = value & 2^(bitIndex) ;
    return bitState > 0 ? 1 : 0 ;
}


- (NSMutableDictionary *)findMissingNumbersInArray:(NSArray *)inputArray {
    NSMutableDictionary *missingNumbersDictionary = [NSMutableDictionary dictionaryWithCapacity:2];
    NSInteger n = inputArray.count+2;
    NSInteger expectedSum = n*(n+1)/2;
    NSInteger expectedSquaredSum = n*(n+1)*(2*n+1)/6;
    
    NSInteger sum = 0;
    NSInteger squaredSum =0;
    
    for (int i = 0; i < inputArray.count; i++) {
        NSInteger currentNum = [inputArray[i] integerValue];
        sum = sum + currentNum;
        squaredSum = squaredSum*squaredSum + currentNum*currentNum;
    }
    
    // Give that two numbers could be a and b .
    NSInteger aplusb = expectedSum - sum ;
    NSInteger asquareplusbsquare = expectedSquaredSum - squaredSum;
    NSInteger twoab = (aplusb)*aplusb - asquareplusbsquare;
    
    
    NSInteger aminusb =sqrt(asquareplusbsquare - twoab);
    
    NSInteger a = aplusb + aminusb;
    
    NSInteger b = aplusb - aminusb;
    
    missingNumbersDictionary[@"a"] = @(a);
    missingNumbersDictionary[@"b"] = @(b);
    
    return missingNumbersDictionary;
}


- (NSDictionary *)findestMaximumProductSubarray:(NSArray *)array {
    
    if(!array) return nil;
    
    NSMutableDictionary *indicesDictionary = [NSMutableDictionary  dictionary];
    NSInteger maximumProduct = 1;
    NSInteger startIndex = 0;
    
    for (int i =0; i < array.count; i++) {
        
        if (array[i] == 0 && startIndex <= i ) {
    
            // Split the array in 2
            NSDictionary *dict = [self findMaxProductWithoutZeroInArray:array startIndex:startIndex endIndex:i];
            NSInteger product = [dict[@"product"] integerValue];
            
            if (product > maximumProduct) {
                maximumProduct = product;
            }
            startIndex = i + 1;
            
        } else if (i == array.count -1) {
            NSDictionary *dict = [self findMaxProductWithoutZeroInArray:array startIndex:startIndex endIndex:i];
            NSInteger product = [dict[@"product"] integerValue];
            
            if (product > maximumProduct) {
                maximumProduct = product;
            }
        }
    }
    
    // Sme way to updte the indices
    return indicesDictionary;
}



- (NSDictionary *) findMaxProductWithoutZeroInArray:(NSArray *)array startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (startIndex > endIndex || array.count == 0) {
        return nil;
    }
    
    NSInteger numberOfNegativeElements = 0;
    NSInteger firstNegativeElementIndex = -1;
    NSInteger lastNegativeElementIndex = -1;
    for (NSInteger i = 0; i < endIndex; i++) {
        if (array[i] < 0) {
            numberOfNegativeElements ++;
            if (firstNegativeElementIndex == -1) {
                firstNegativeElementIndex = i;
            }
            lastNegativeElementIndex = i;
        }
    }
    
    BOOL hasEvenNumberOfNegatives = NO;
    
    if (numberOfNegativeElements % 2 == 0) {
        hasEvenNumberOfNegatives = YES;
    }
    
    // Find the product by ignoring the first negative element and then the last negative element and then the max of the two will be the max product from the subarray:
    if (hasEvenNumberOfNegatives) {
        dictionary = (NSMutableDictionary *)[self maxProductForArray:array withStartIndex:startIndex andEndIndex:endIndex];
    } else {

        NSDictionary * dict = [self maxProductForArray:array withStartIndex:firstNegativeElementIndex + 1 andEndIndex:endIndex];
        NSDictionary *dict2 = [self maxProductForArray:array withStartIndex:lastNegativeElementIndex - 1 andEndIndex:endIndex];

        NSInteger maxProd1 = [dict [@"prod"] integerValue];
        NSInteger maxProd2 = [dict2 [@"prod"] integerValue];
        
        if (maxProd1   > maxProd2) {
            dictionary[@"prod"] = @(maxProd1);
        }
    }
    return  dictionary;
}


- (NSDictionary *)maxProductForArray:(NSArray *)array withStartIndex:(NSInteger)startIndex andEndIndex:(NSInteger)endIndex {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (startIndex > endIndex || endIndex > array.count || !array) {
        return nil;
    }
    long product = 1;
    for (NSInteger i = startIndex; i < endIndex; i++) {
        product = product * [array[i] integerValue];
    }
    return dictionary;
}




- (void)findFactorsOfANumber:(NSInteger)key {
    NSMutableString *mutableString = [NSMutableString string];
    NSInteger num = key;
    for (int n = 2; n <= key ; n++) {
        while (num % n == 0 && num /n >=1) {
            num = num / n;
            [mutableString appendString:[NSString stringWithFormat:@"%ld,", (long)n]];
        }
    }
    NSLog(@"Factor String %@",mutableString);
}

// Roman Numeral
//function arabic2roman(num:Number):String {
//    var lookup:Object = {M:1000, CM:900, D:500, CD:400, C:100, XC:90, L:50, XL:40, X:10, IX:9, V:5, IV:4, I:1};
//    var roman:String = "", i:String;
//    for (i in lookup) {
//        while (num >= lookup[i]) {
//            roman += i;
//            num -= lookup[i];
//        }
//    }
//    return roman;
//}
//trace("1990 in roman is " + arabic2roman(1990));
//trace("2008 in roman is " + arabic2roman(2008));
//trace("1666 in roman is " + arabic2roman(1666));





- (NSInteger)findthe10001PrimeNumber {
    NSInteger requiredNumber;
    NSInteger position = 0;
    NSInteger currentNumber = 2;
    while (position != 10001) {
        BOOL isPrime = [self isNUmberPrimeImprovedMethod:currentNumber];
        if (isPrime) {
            position++;
        }
        currentNumber++;
    }
    
    NSLog(@"The %ld number is %ld", (long)position, (long)currentNumber-1);
    return requiredNumber;
}


// Division Trial all numbers
- (BOOL)isNumberPrime:(NSInteger)number {
    BOOL isPrime = NO;
    
    for (int i = 2; i <= number; i++) {
        if (number % i == 0) {
            if (i!=number) {
                return NO;
            } else if (i == number) {
                return YES;
            }
        }
    }
    return isPrime;
}

// Division trial but numbers only upto sqrt
- (BOOL)isNUmberPrimeImprovedMethod:(NSInteger)number {
    BOOL isPrime = YES;
    for (int i = 2; i <=sqrt(number); i++) {
        if (number % i ==0) {
            isPrime = NO;
        }
    }
    return isPrime;
}


// find a prime number which is a sum of consecutive prime number for the various. Find such longest consecutive sequence.


- (void)findTheLongestConsecutivePrimeSequenceWhichAddsUpToAPrimeNumberBelow:(long)value {
    
    long currentSumOfPrimeNumbers = 0;
    long maximumSumOfPrimeNumbers = 0;
    
    long currentNumber = 2;
    
    while (currentNumber != value) {
        BOOL isCurrentPrime = [self isNUmberPrimeImprovedMethod:currentNumber];
        if (isCurrentPrime) {
            currentSumOfPrimeNumbers = currentSumOfPrimeNumbers + currentNumber;
            // Also make sure that the currentSumOfPrime is also a prime and its greater
            if ([self isNUmberPrimeImprovedMethod:currentSumOfPrimeNumbers] && maximumSumOfPrimeNumbers < currentSumOfPrimeNumbers) {
                maximumSumOfPrimeNumbers = currentSumOfPrimeNumbers;
            }
        }
        currentNumber ++;
    }
    
    NSLog(@"The maximum prime sum is %ld", (long)maximumSumOfPrimeNumbers);
}




- (BOOL)giveNumberSeeIfPassedInNnumberIsMirror:(NSNumber *)number {
    BOOL isReverse = NO;
    // for now consider only odd number of chars in the input number
    
    NSString *inputString = [number stringValue];
    if (inputString.length % 2 == 0 ) {
        return NO;
    }
    
    NSInteger midPoint = inputString.length / 2;
    NSInteger index = midPoint - 1;
    
    NSInteger counter = 1;
    for (NSInteger i = index; i >=0; i--) {
        NSString *lChar = [inputString substringWithRange:NSMakeRange(midPoint - counter, 1)];
        NSString *rChar = [inputString substringWithRange:NSMakeRange(midPoint + counter, 1)];
        if (![lChar isEqualToString:rChar]) {
            isReverse = NO;
            return isReverse;
        }
        isReverse = YES;
        counter ++;
    }
    return isReverse;
}




//Given a number M (N-digit integer) and K-swap operations(a swap
//                                                         operation can swap 2 digits), devise an algorithm to get the maximum possible integer?
//Examples:
//M = 132 K = 1 output = 312
//M = 132 K = 2 output = 321
//M = 7899 k = 2 output = 9987
//M = 8799 and K = 2 output = 9987


- (NSInteger)getMaximumPossibleIntegerForNumber:(NSInteger)number andAllowedSwapOperations:(NSInteger)numberOfSwapsAllowed {
    NSInteger maxNumber = number;
    NSInteger numberOfDigits = 0;
    
    while (maxNumber % 10) {
        numberOfDigits++;
        maxNumber = maxNumber/10;
    }
    
    if (numberOfSwapsAllowed > numberOfDigits -1) {
        NSLog(@"Error Please reduc the number of swaps");
    }
    
    if (numberOfSwapsAllowed == 0) {
        NSLog(@"Error: please pass the number of swaps");
    }
    
    NSInteger loopMax = number;
    
    while (numberOfSwapsAllowed) {
        
        loopMax = [self largestPositionAndNumberForInput:loopMax];
        
        NSLog(@"Before Loop max is %ld", (long)loopMax);

        
        NSInteger loopNUmber = loopMax;
        
        NSInteger currentMaxPositionNumber = 0;
        numberOfDigits = 0;
        while (loopNUmber % 10) {
            currentMaxPositionNumber = loopNUmber % 10;
            numberOfDigits++;
            loopNUmber = loopNUmber/10;
        }
        
        
        loopMax = loopMax - currentMaxPositionNumber * pow(10, numberOfDigits-1);
        
        NSLog(@"Loop max is %ld", (long)loopMax);
        
        maxNumber = maxNumber + currentMaxPositionNumber * pow(10, numberOfDigits-1);
        
        if (numberOfSwapsAllowed == 1) {
            maxNumber = loopMax + maxNumber;
        }
        
        numberOfSwapsAllowed --;
    }
    
    NSLog(@"max number is %ld", (long)maxNumber);
    
    return maxNumber;
}


- (NSInteger)largestPositionAndNumberForInput:(NSInteger)number{

    NSInteger swappedMax = 0;
    // Identify the largest number and its position by scanning all the digit positions
    NSInteger loopNumber = number;
    NSInteger maxDigit = 0;
    NSInteger maxDigitPosition = -1;
    
    NSInteger numberOfDigits = 0;
    
    // This is the number at the highest position
    NSInteger currentMaxPositionNumber =0;
    
    NSMutableArray *digitsArray = [NSMutableArray array];
    
    while (loopNumber % 10) {
        NSInteger remainder = loopNumber % 10 ;
        currentMaxPositionNumber = remainder;
        if (remainder > maxDigit) {
            maxDigit = remainder;
            maxDigitPosition ++;
        }
        [digitsArray addObject:@(remainder)];
        numberOfDigits ++;
        loopNumber = loopNumber / 10;
    }
    
    for (int i = 0; i < digitsArray.count; i ++) {
        
        if (i == numberOfDigits -1) {
            swappedMax = swappedMax + pow(10, (numberOfDigits - 1)) * maxDigit;
        } else if (i == maxDigitPosition) {
           swappedMax = swappedMax + (pow(10, maxDigitPosition))*currentMaxPositionNumber;
        } else {
            swappedMax = swappedMax + (pow(10, i) * [digitsArray[i] integerValue]);
        }
    }
    return swappedMax;
}

//I have an array stock_prices_yesterday where:
//The indices are the time, as a number of minutes past trade opening time, which was 9:30am local time.
//The values are the price of Apple stock at that time, in dollars.
//For example, the stock cost $500 at 10:30am, so stock_prices_yesterday[60] = 500.
//Write an efficient algorithm for computing the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday. For this problem, we won't allow "shorting"—you must buy before you sell.

- (NSNumber *)findMaxProfit:(NSArray *)prices {
    NSNumber *max_profit = @0;
    NSNumber *minPrice = prices[0];
    for (NSNumber *currentPrice in prices) {
        minPrice = @(MIN(minPrice.integerValue, currentPrice.integerValue));
        max_profit = @(MAX(max_profit.integerValue, currentPrice.integerValue - minPrice.integerValue));
    }
    return max_profit;
}

// Fiboncacci with using recursion, linear time and in o(1) space.

- (NSInteger)findFib:(NSInteger)n {
    NSInteger back1 = 1;
    NSInteger back2 = 0;
    NSInteger next = 0;
    for (int i =2; i <n; i++) {
        next = back1 + back2;
        back2 = back1;
        back1 = next;
    }
    return back1+back2;
}

// Fibonacci using recusrion

- (NSInteger)findFibR:(NSInteger)n {
    if (n  == 0 || n == 1) {
        return 1;
    }
    return [self findFibR:n-1] + [self findFibR:n-2];
}


@end
