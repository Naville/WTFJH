#Signature Database
>This is a simple Anti-Obfuscation Method Based On Properties Of A Class (And Some Other Stuff)

>>We Use A Mark Based Algorithm To Measure Confidence 

>>Super Class:10%

>>Protocals:10%

>>Methods:25%:

>>Properties:20%

>>IVARS:20%

>>String Match:10% (Because Although We Know That Class Exists,We Can't Be Sure It's This One. Unless We Implement Capstone Engine,Which Will Be Hell Of A Pain In Ass)

>>Scoring Rule When Matching:

>>>TotalScoreForThisPart / NumberOfThisPart's Properties ==Full Mark For A Complete Match

>>>>e.g: Methods Take 35%. Testing Sample Class Has 9 Methods.

>>>>For Each Complete Match. 35%/9 is rewarded. Please Note That The Number Of Subject is Used instead of number in database.

>>>>TypeCoding Match:40% ReturnTypeMatch:40% SEL Name Match:20%

>>>>>So if this method has matching TC and SEL Name,but wrong RT, it will gain (35%/9)*(40%+20%)Point