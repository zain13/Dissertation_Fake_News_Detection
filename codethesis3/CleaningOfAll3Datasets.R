
# Step 1 <- Download dataset from https://www.kaggle.com/c/fake-news/data
# and saved it in your desktop.In our case we have saved it with Wholedataset.csv

# Step 2<- Read dataset in R and clean the entire dataset.

#follow below steps to clean the dataset:

#Cleaning Wholedataset Dataset
Wholedataset<- read.csv("C:/Users/kaasa0509/Desktop/Codes/Wholedataset.csv")
#coverting into dataset
Wholedataset<- as.data.frame(Wholedataset)
#########################################################
#Column Title
#########################################################
Wholedataset$title<- as.character(Wholedataset$title)
#Case Folding - tranforming into lower case
Wholedataset$title<-tolower(Wholedataset$title)
# Removing Stop words from the data
stopword<-c("a","i","me" ,"my" ,"myself" ,"we" ,"our" ,"ours" ,"ourselves" ,"you" ,
            "your" ,"yours" ,"yourself" ,"yourselves", "he" ,"him" ,"his" ,"himself" ,
            "she" ,"her" ,"hers" ,"herself" ,"it" ,"its" ,"itself" ,"they" ,"them" ,
            "their" ,"theirs" ,"themselves" ,"what" ,"which" ,"who" ,"whom" ,"this" ,
            "that" ,"these" ,"those" ,"am" ,"is" ,"are", "was" ,"were" ,"be" ,"been" ,
            "being" ,"have" ,"has" ,"had" ,"having" ,"do" ,"does" ,"did" ,"doing" ,
            "would" ,"should" ,"could" ,"ought" ,"i'm" ,"you're" ,"he's" ,"she's" ,
            "it's" ,"we're" ,"they're" ,"i've" ,"you've" ,"we've" ,"they've" ,"i'd" ,
            "you'd" ,"he'd" ,"she'd" ,"we'd" ,"they'd" ,"i'll" ,"you'll" ,"he'll" ,
            "she'll" ,"we'll" ,"they'll" ,"isn't" ,"aren't" ,"wasn't" ,"weren't" ,
            "hasn't" ,"haven't" ,"hadn't" ,"doesn't" ,"don't" ,"didn't" ,"won't" ,
            "wouldn't" ,"shan't" ,"shouldn't" ,"can't" ,"cannot" ,"couldn't" ,
            "mustn't" ,"let's" ,"that's" ,"who's" ,"what's" ,"here's" ,"there's" ,
            "when's" ,"where's" ,"why's" ,"how's" ,"an" ,"the" ,"and" ,"but" ,
            "if" ,"or" ,"because" ,"as" ,"until" ,"while" ,"of", "at" ,"by" ,"for" ,
            "with" ,"about" ,"against" ,"between" ,"into" ,"through" ,"during",
            "before" ,"after" ,"above" ,"below" ,"to" ,"from" ,"up" ,"down" ,"in" 
            ,"out" ,"on" ,"off" ,"over" ,"under" ,"again" ,"further" ,"then" ,"once" ,
            "here" ,"there" ,"when" ,"where" ,"why" ,"how" ,"all" ,"any" ,"both" ,
            "each" ,"few" ,"more" ,"most" ,"other" ,"some" ,"such" ,"no" , "nor" ,
            "not" ,"only" ,"own" ,"same" ,"so" ,"than" ,"too" ,"very" ,"a's" ,"able" ,
            "about" ,"above" ,"according" ,"accordingly" ,"across" ,"actually" ,
            "after" ,"afterwards" ,"again" ,"against" ,"ain't" ,"all" ,"allow" ,
            "allows" ,"almost" ,"alone" ,"along" ,"already" ,"also" ,"although" ,
            "always" ,"am" ,"among" ,"amongst" ,"an" ,"and" ,"another" ,"any" ,
            "anybody" ,"anyhow" ,"anyone" ,"anything" ,"anyway" ,"anyways" ,
            "anywhere" ,"apart" ,"appear" ,"appreciate" ,"appropriate" ,"are" ,
            "aren't" ,"around" ,"as" ,"aside" ,"ask" ,"asking" ,"associated", "at" ,
            "available" ,"away" ,"awfully" ,"be" ,"became", "because" ,"become" ,
            "becomes" ,"becoming" ,"been" ,"before" ,"beforehand" ,"behind" ,"being" ,
            "believe" ,"below" ,"beside" ,"besides" ,"best" ,"better" ,"between" ,
            "beyond" ,"both", "brief" ,"but" ,"by" ,"c'mon" ,"c's" ,"came" ,"can" ,
            "can't" ,"cannot" ,"cant" ,"cause" ,"causes" ,"certain" ,"certainly" ,
            "changes" ,"clearly" ,"come" ,"comes" ,"concerning" ,
            "consequently" ,"consider" ,"considering" ,"contain" ,"containing" ,
            "contains" ,"corresponding" ,"could" ,"couldn't" ,"course" ,"currently" ,
            "definitely" ,"described" ,"despite" ,"did" ,"didn't" ,"different" ,"do" ,
            "does" ,"doesn't" ,"doing" ,"don't", "done" ,"down" ,"downwards" ,
            "during" ,"each"  ,"eight" ,"either" ,"else" ,"elsewhere" ,
            "enough" ,"entirely" ,"especially","etc" ,"even" ,"ever" ,"every" ,
            "everybody" ,"everyone" ,"everything" ,"everywhere" ,"ex" ,"exactly" ,
            "example" ,"except", "far" ,"few" ,"fifth" ,"first" ,"five" ,"followed" ,
            "following" ,"follows", "for" ,"former" ,"formerly" ,"forth" ,"four" ,
            "from" ,"further" ,"furthermore" ,"get", "gets" ,"getting" ,"given" ,
            "gives" ,"go" ,"goes" ,"going" ,"gone" ,"got" ,"gotten" ,"greetings" ,
            "had" ,"hadn't" ,"happens" ,"hardly" ,"has" ,"hasn't" ,"have" ,"haven't" ,
            "having" ,"he" ,"he's" ,"hello" ,"help" ,"hence" ,"her" ,"here" ,
            "here's" ,"hereafter" ,"hereby" ,"herein" ,"hereupon" ,"hers" ,
            "herself", "hi" ,"him" ,"himself" ,"his" ,"hither" ,"hopefully" ,"how" ,
            "howbeit" ,"however" ,"i'd" ,"i'll" ,"i'm" ,"i've" ,"ie" ,"if" ,"ignored",
            "immediate" ,"in" ,"inasmuch"  ,"indeed" ,"indicate" ,"indicated" ,
            "indicates" ,"inner" ,"insofar" ,"instead" ,"into" ,"inward" ,"is" ,
            "isn't"  ,"it'd" , "it'll" ,"it's" ,"its" ,"itself" ,"just" ,"keep" ,
            "keeps" ,"kept" ,"know" ,"knows" ,"known" ,"last" ,"lately" ,"later" ,
            "latter" ,"latterly" ,"least" ,"less" ,"lest" ,"let" ,"let's" ,"like" ,
            "liked" ,"likely" ,"little" ,"look" ,"looking" ,"looks" ,"ltd" ,"mainly" ,
            "many" ,"may" ,"maybe"  ,"mean" ,"meanwhile" ,"merely" ,"might" ,
            "more" ,"moreover" ,"most" ,"mostly" ,"much" ,"must" ,"my" ,"myself" ,
            "name" ,"namely" ,"near", "nearly" ,"necessary" ,"need" ,"needs" 
            ,"neither" ,"never" ,"nevertheless" ,"new" ,"next" ,"nine" ,"no" ,
            "nobody" ,"non" ,"none" ,"noone" ,"nor" ,"normally" ,"not" ,"nothing",
            "novel" ,"now" ,"nowhere" ,"obviously" ,"of" ,"off" ,"often"  ,"ok" ,
            "okay" ,"old" ,"once" ,"only" ,"onto" ,"or" ,
            "other" ,"others" ,"otherwise" ,"ought" ,"our" ,"ours" ,"ourselves" ,
            "out" ,"outside" ,"over" ,"overall" ,"own" ,"particular", "particularly" ,"perhaps" ,"placed" ,"please" ,"plus" ,"possible" ,"presumably" ,
            "probably" ,"provides" ,"quite" ,"rather" ,
            "really", "reasonably" ,"regarding" ,"regardless" ,"regards" ,
            "relatively" ,"respectively" ,"right" ,"said" ,"same" ,"saw" ,"say" ,
            "saying" ,"says" ,"second" ,"secondly" ,"seeing" ,"seem" ,
            "seemed" ,"seeming" ,"seems" ,"seen" ,"self" ,"selves" ,"sensible" ,
            "sent" ,"serious" ,"seriously" ,"seven" ,"several" ,"shall" ,"she" ,
            "should", "shouldn't" ,"since" ,"six" ,"some" ,"somebody" ,
            "somehow" ,"someone" ,"something" ,"sometime" ,"sometimes" ,"somewhat" ,
            "somewhere" ,"soon" ,"sorry" ,"specified" ,"specify" ,"specifying" ,
            "still" ,"such" ,"sure"  ,"take" ,"taken" ,"tell" ,
            "tends"  ,"than", "thank" ,"thanks" ,"thanx" ,"that", "that's" ,
            "thats" ,"the" ,"their" ,"theirs" ,"them" ,"themselves" ,"then" ,
            "thence" ,"there" ,"there's" ,"thereafter" ,"thereby" ,"therefore" ,
            "therein" ,"theres" ,"thereupon" ,"these" ,"they" ,"they'd" ,"they'll" ,
            "they're" ,"they've" ,"think" ,"third" ,"this" ,"thorough", "thoroughly" ,
            "those" ,"though" ,"three" ,"through" ,"throughout" ,"thru" ,"thus" ,
            "to" ,"together" ,"too" ,"took" ,"toward" ,"towards" ,"tried" ,"tries" ,
            "truly" ,"try" ,"trying" ,"twice" ,"two"  ,"under" ,
            "unfortunately" ,"unless" ,"unlikely" ,"until" ,"unto" ,"up" ,"upon" ,"use" ,"used", "useful" ,"uses" ,"using" ,"usually" ,"uucp"
            ,"various" ,"very" ,"via" ,"viz" ,"want", "wants" ,"was" ,"wasn't" ,
            "way" , "we'd" ,"we'll" ,"we're" ,"we've" ,"welcome" ,"well" ,
            "went" ,"were" ,"weren't" ,"what" ,"what's" ,"whatever", "when" ,
            "whence" ,"whenever" ,"where" ,"where's" ,"whereafter" ,"whereas" ,
            "whereby" ,"wherein" ,"whereupon" ,"wherever" ,"whether" ,"which" ,
            "while" ,"whither" ,"who" ,"who's" ,"whoever" ,"whole" ,"whom" ,
            "whose" ,"why", "will" ,"willing" ,"wish" ,"with", "within" ,"without" ,
            "won't" ,"wonder" ,"would" ,"wouldn't" ,"yes" ,"yet" ,"you" ,"you'd" ,
            "you'll" ,"you're" ,"you've", "your", "yours", "yourself", "yourselves")

library(qdap)
removed_title <- rm_stopwords(text.var = Wholedataset$title, stopwords = stopword, ignore.case = F, strip = TRUE)
Wholedataset$title <- NULL
Wholedataset[["title"]] <- removed_title
# Removing special characters, punctuation,numeric and alphanumeric terms
Wholedataset$title<- gsub("ג???T", "",Wholedataset$title)
Wholedataset$title<- gsub("ג???", "",Wholedataset$title)
Wholedataset$title<- gsub("Ã", "",Wholedataset$title)
Wholedataset$title<- gsub(" ~", "",Wholedataset$title)
Wholedataset$title<- gsub("©", "",Wholedataset$title)
Wholedataset$title<- gsub("#", "",Wholedataset$title)
Wholedataset$title<- gsub("~", "",Wholedataset$title)
Wholedataset$title<- gsub("[[:digit:]]", "",Wholedataset$title)
Wholedataset$title<- gsub("[[:punct:]]", " ",Wholedataset$title)
Wholedataset$title<- gsub("[[:punct:]]", " ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\b(a-z)\\b(1)", replace= " ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\W",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\d",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub("^[c]", "", Wholedataset$title)
Wholedataset$title<- gsub("נ", "", Wholedataset$title)
Wholedataset$title<- gsub("ס", "", Wholedataset$title)
Wholedataset$title<- gsub("ג", "", Wholedataset$title)
Wholedataset$title<- gsub("ב", "", Wholedataset$title)
Wholedataset$title<- gsub("ב", "", Wholedataset$title)
Wholedataset$title<- gsub("ב", "", Wholedataset$title)
Wholedataset$title<- gsub("ב", "", Wholedataset$title)
Wholedataset$title<- gsub("ננ", "", Wholedataset$title)
Wholedataset$title<- gsub("ש", "", Wholedataset$title)
Wholedataset$title<- gsub("ר", "", Wholedataset$title)
Wholedataset$title<- gsub("רש", "", Wholedataset$title)
Wholedataset$title<- gsub("'", "", Wholedataset$title)
Wholedataset$title<- gsub("ה", "", Wholedataset$title)
Wholedataset$title<- gsub(" ר", "", Wholedataset$title)
Wholedataset$title<- gsub("[^[:alnum:]]", " ",Wholedataset$title)
Wholedataset$title<- gsub("ו", "", Wholedataset$title)
Wholedataset$title<- gsub("ד", "", Wholedataset$title)
Wholedataset$title<- gsub("ממ", "", Wholedataset$title)
Wholedataset$title<- gsub("מ", "", Wholedataset$title)
Wholedataset$title<- gsub("iii", "", Wholedataset$title)
Wholedataset$title<- gsub("ן", "", Wholedataset$title)
Wholedataset$title<- gsub("one", "", Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\W",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\d",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub("the", "", Wholedataset$title)
Wholedataset$title<- gsub("you", "", Wholedataset$title)
#Removing all non-english words from data
Wholedataset$title <- iconv(Wholedataset$title, "utf-8", "ASCII")
#Removing blank and omit articles from data
Wholedataset$title[Wholedataset$title==""]<- "Unknown"
Wholedataset$title<- na.omit(Wholedataset$title)
################################################################
#column Author
##############################################################
#Case Folding - tranforming into lower case
Wholedataset$author<-tolower(Wholedataset$author)
# Removing Stop words from the data
stopword<-c("a","i","me" ,"my" ,"myself" ,"we" ,"our" ,"ours" ,"ourselves" ,"you" ,
            "your" ,"yours" ,"yourself" ,"yourselves", "he" ,"him" ,"his" ,"himself" ,
            "she" ,"her" ,"hers" ,"herself" ,"it" ,"its" ,"itself" ,"they" ,"them" ,
            "their" ,"theirs" ,"themselves" ,"what" ,"which" ,"who" ,"whom" ,"this" ,
            "that" ,"these" ,"those" ,"am" ,"is" ,"are", "was" ,"were" ,"be" ,"been" ,
            "being" ,"have" ,"has" ,"had" ,"having" ,"do" ,"does" ,"did" ,"doing" ,
            "would" ,"should" ,"could" ,"ought" ,"i'm" ,"you're" ,"he's" ,"she's" ,
            "it's" ,"we're" ,"they're" ,"i've" ,"you've" ,"we've" ,"they've" ,"i'd" ,
            "you'd" ,"he'd" ,"she'd" ,"we'd" ,"they'd" ,"i'll" ,"you'll" ,"he'll" ,
            "she'll" ,"we'll" ,"they'll" ,"isn't" ,"aren't" ,"wasn't" ,"weren't" ,
            "hasn't" ,"haven't" ,"hadn't" ,"doesn't" ,"don't" ,"didn't" ,"won't" ,
            "wouldn't" ,"shan't" ,"shouldn't" ,"can't" ,"cannot" ,"couldn't" ,
            "mustn't" ,"let's" ,"that's" ,"who's" ,"what's" ,"here's" ,"there's" ,
            "when's" ,"where's" ,"why's" ,"how's" ,"an" ,"the" ,"and" ,"but" ,
            "if" ,"or" ,"because" ,"as" ,"until" ,"while" ,"of", "at" ,"by" ,"for" ,
            "with" ,"about" ,"against" ,"between" ,"into" ,"through" ,"during",
            "before" ,"after" ,"above" ,"below" ,"to" ,"from" ,"up" ,"down" ,"in" 
            ,"out" ,"on" ,"off" ,"over" ,"under" ,"again" ,"further" ,"then" ,"once" ,
            "here" ,"there" ,"when" ,"where" ,"why" ,"how" ,"all" ,"any" ,"both" ,
            "each" ,"few" ,"more" ,"most" ,"other" ,"some" ,"such" ,"no" , "nor" ,
            "not" ,"only" ,"own" ,"same" ,"so" ,"than" ,"too" ,"very" ,"a's" ,"able" ,
            "about" ,"above" ,"according" ,"accordingly" ,"across" ,"actually" ,
            "after" ,"afterwards" ,"again" ,"against" ,"ain't" ,"all" ,"allow" ,
            "allows" ,"almost" ,"alone" ,"along" ,"already" ,"also" ,"although" ,
            "always" ,"am" ,"among" ,"amongst" ,"an" ,"and" ,"another" ,"any" ,
            "anybody" ,"anyhow" ,"anyone" ,"anything" ,"anyway" ,"anyways" ,
            "anywhere" ,"apart" ,"appear" ,"appreciate" ,"appropriate" ,"are" ,
            "aren't" ,"around" ,"as" ,"aside" ,"ask" ,"asking" ,"associated", "at" ,
            "available" ,"away" ,"awfully" ,"be" ,"became", "because" ,"become" ,
            "becomes" ,"becoming" ,"been" ,"before" ,"beforehand" ,"behind" ,"being" ,
            "believe" ,"below" ,"beside" ,"besides" ,"best" ,"better" ,"between" ,
            "beyond" ,"both", "brief" ,"but" ,"by" ,"c'mon" ,"c's" ,"came" ,"can" ,
            "can't" ,"cannot" ,"cant" ,"cause" ,"causes" ,"certain" ,"certainly" ,
            "changes" ,"clearly" ,"come" ,"comes" ,"concerning" ,
            "consequently" ,"consider" ,"considering" ,"contain" ,"containing" ,
            "contains" ,"corresponding" ,"could" ,"couldn't" ,"course" ,"currently" ,
            "definitely" ,"described" ,"despite" ,"did" ,"didn't" ,"different" ,"do" ,
            "does" ,"doesn't" ,"doing" ,"don't", "done" ,"down" ,"downwards" ,
            "during" ,"each"  ,"eight" ,"either" ,"else" ,"elsewhere" ,
            "enough" ,"entirely" ,"especially","etc" ,"even" ,"ever" ,"every" ,
            "everybody" ,"everyone" ,"everything" ,"everywhere" ,"ex" ,"exactly" ,
            "example" ,"except", "far" ,"few" ,"fifth" ,"first" ,"five" ,"followed" ,
            "following" ,"follows", "for" ,"former" ,"formerly" ,"forth" ,"four" ,
            "from" ,"further" ,"furthermore" ,"get", "gets" ,"getting" ,"given" ,
            "gives" ,"go" ,"goes" ,"going" ,"gone" ,"got" ,"gotten" ,"greetings" ,
            "had" ,"hadn't" ,"happens" ,"hardly" ,"has" ,"hasn't" ,"have" ,"haven't" ,
            "having" ,"he" ,"he's" ,"hello" ,"help" ,"hence" ,"her" ,"here" ,
            "here's" ,"hereafter" ,"hereby" ,"herein" ,"hereupon" ,"hers" ,
            "herself", "hi" ,"him" ,"himself" ,"his" ,"hither" ,"hopefully" ,"how" ,
            "howbeit" ,"however" ,"i'd" ,"i'll" ,"i'm" ,"i've" ,"ie" ,"if" ,"ignored",
            "immediate" ,"in" ,"inasmuch"  ,"indeed" ,"indicate" ,"indicated" ,
            "indicates" ,"inner" ,"insofar" ,"instead" ,"into" ,"inward" ,"is" ,
            "isn't"  ,"it'd" , "it'll" ,"it's" ,"its" ,"itself" ,"just" ,"keep" ,
            "keeps" ,"kept" ,"know" ,"knows" ,"known" ,"last" ,"lately" ,"later" ,
            "latter" ,"latterly" ,"least" ,"less" ,"lest" ,"let" ,"let's" ,"like" ,
            "liked" ,"likely" ,"little" ,"look" ,"looking" ,"looks" ,"ltd" ,"mainly" ,
            "many" ,"may" ,"maybe"  ,"mean" ,"meanwhile" ,"merely" ,"might" ,
            "more" ,"moreover" ,"most" ,"mostly" ,"much" ,"must" ,"my" ,"myself" ,
            "name" ,"namely" ,"near", "nearly" ,"necessary" ,"need" ,"needs" 
            ,"neither" ,"never" ,"nevertheless" ,"new" ,"next" ,"nine" ,"no" ,
            "nobody" ,"non" ,"none" ,"noone" ,"nor" ,"normally" ,"not" ,"nothing",
            "novel" ,"now" ,"nowhere" ,"obviously" ,"of" ,"off" ,"often"  ,"ok" ,
            "okay" ,"old" ,"once" ,"only" ,"onto" ,"or" ,
            "other" ,"others" ,"otherwise" ,"ought" ,"our" ,"ours" ,"ourselves" ,
            "out" ,"outside" ,"over" ,"overall" ,"own" ,"particular", "particularly" ,"perhaps" ,"placed" ,"please" ,"plus" ,"possible" ,"presumably" ,
            "probably" ,"provides" ,"quite" ,"rather" ,
            "really", "reasonably" ,"regarding" ,"regardless" ,"regards" ,
            "relatively" ,"respectively" ,"right" ,"said" ,"same" ,"saw" ,"say" ,
            "saying" ,"says" ,"second" ,"secondly" ,"seeing" ,"seem" ,
            "seemed" ,"seeming" ,"seems" ,"seen" ,"self" ,"selves" ,"sensible" ,
            "sent" ,"serious" ,"seriously" ,"seven" ,"several" ,"shall" ,"she" ,
            "should", "shouldn't" ,"since" ,"six" ,"some" ,"somebody" ,
            "somehow" ,"someone" ,"something" ,"sometime" ,"sometimes" ,"somewhat" ,
            "somewhere" ,"soon" ,"sorry" ,"specified" ,"specify" ,"specifying" ,
            "still" ,"such" ,"sure"  ,"take" ,"taken" ,"tell" ,
            "tends"  ,"than", "thank" ,"thanks" ,"thanx" ,"that", "that's" ,
            "thats" ,"the" ,"their" ,"theirs" ,"them" ,"themselves" ,"then" ,
            "thence" ,"there" ,"there's" ,"thereafter" ,"thereby" ,"therefore" ,
            "therein" ,"theres" ,"thereupon" ,"these" ,"they" ,"they'd" ,"they'll" ,
            "they're" ,"they've" ,"think" ,"third" ,"this" ,"thorough", "thoroughly" ,
            "those" ,"though" ,"three" ,"through" ,"throughout" ,"thru" ,"thus" ,
            "to" ,"together" ,"too" ,"took" ,"toward" ,"towards" ,"tried" ,"tries" ,
            "truly" ,"try" ,"trying" ,"twice" ,"two"  ,"under" ,
            "unfortunately" ,"unless" ,"unlikely" ,"until" ,"unto" ,"up" ,"upon" ,"use" ,"used", "useful" ,"uses" ,"using" ,"usually" ,"uucp"
            ,"various" ,"very" ,"via" ,"viz" ,"want", "wants" ,"was" ,"wasn't" ,
            "way" , "we'd" ,"we'll" ,"we're" ,"we've" ,"welcome" ,"well" ,
            "went" ,"were" ,"weren't" ,"what" ,"what's" ,"whatever", "when" ,
            "whence" ,"whenever" ,"where" ,"where's" ,"whereafter" ,"whereas" ,
            "whereby" ,"wherein" ,"whereupon" ,"wherever" ,"whether" ,"which" ,
            "while" ,"whither" ,"who" ,"who's" ,"whoever" ,"whole" ,"whom" ,
            "whose" ,"why", "will" ,"willing" ,"wish" ,"with", "within" ,"without" ,
            "won't" ,"wonder" ,"would" ,"wouldn't" ,"yes" ,"yet" ,"you" ,"you'd" ,
            "you'll" ,"you're" ,"you've", "your", "yours", "yourself", "yourselves")

library(qdap)
removed_author <- rm_stopwords(text.var = Wholedataset$author, stopwords = stopword, ignore.case = F, strip = TRUE)
Wholedataset$author <- NULL
Wholedataset[["author"]] <- removed_author
# Removing special characters, punctuation,numeric and alphanumeric terms
Wholedataset$author<- gsub("ג???T", "",Wholedataset$author)
Wholedataset$author<- gsub("ג???", "",Wholedataset$author)
Wholedataset$author<- gsub("Ã", "",Wholedataset$author)
Wholedataset$author<- gsub(" ~", "",Wholedataset$author)
Wholedataset$author<- gsub("©", "",Wholedataset$author)
Wholedataset$author<- gsub("#", "",Wholedataset$author)
Wholedataset$author<- gsub("~", "",Wholedataset$author)
Wholedataset$author<- gsub("[[:digit:]]", "",Wholedataset$author)
Wholedataset$author<- gsub("[[:punct:]]", " ",Wholedataset$author)
Wholedataset$author<- gsub("[[:punct:]]", " ",Wholedataset$author)
Wholedataset$author<- gsub(pattern = "\\b(a-z)\\b(1)", replace= " ",Wholedataset$author)
Wholedataset$author<- gsub(pattern = "\\W",replace=" ",Wholedataset$author)
Wholedataset$author<- gsub(pattern = "\\d",replace=" ",Wholedataset$author)
Wholedataset$author<- gsub("^[c]", "", Wholedataset$author)
Wholedataset$author<- gsub("נ", "", Wholedataset$author)
Wholedataset$author<- gsub("ס", "", Wholedataset$author)
Wholedataset$author<- gsub("ג", "", Wholedataset$author)
Wholedataset$author<- gsub("ב", "", Wholedataset$author)
Wholedataset$author<- gsub("ב", "", Wholedataset$author)
Wholedataset$author<- gsub("ב", "", Wholedataset$author)
Wholedataset$author<- gsub("ב", "", Wholedataset$author)
Wholedataset$author<- gsub("ננ", "", Wholedataset$author)
Wholedataset$author<- gsub("ש", "", Wholedataset$author)
Wholedataset$author<- gsub("ר", "", Wholedataset$author)
Wholedataset$author<- gsub("רש", "", Wholedataset$author)
Wholedataset$author<- gsub("'", "", Wholedataset$author)
Wholedataset$author<- gsub("ה", "", Wholedataset$author)
Wholedataset$author<- gsub(" ר", "", Wholedataset$author)
Wholedataset$author<- gsub("[^[:alnum:]]", " ",Wholedataset$author)
Wholedataset$author<- gsub("ו", "", Wholedataset$author)
Wholedataset$author<- gsub("ד", "", Wholedataset$author)
Wholedataset$author<- gsub("ממ", "", Wholedataset$author)
Wholedataset$author<- gsub("מ", "", Wholedataset$author)
Wholedataset$author<- gsub("iii", "", Wholedataset$author)
Wholedataset$author<- gsub("ן", "", Wholedataset$author)
Wholedataset$author<- gsub("one", "", Wholedataset$author)
Wholedataset$author<- gsub(pattern = "\\W",replace=" ",Wholedataset$author)
Wholedataset$author<- gsub(pattern = "\\d",replace=" ",Wholedataset$author)
Wholedataset$author<- gsub("the", "", Wholedataset$author)
Wholedataset$author<- gsub("you", "", Wholedataset$author)
#Removing all non-english words from data
Wholedataset$author <- iconv(Wholedataset$author, "utf-8", "ASCII")
#Removing blank and omit articles from data
Wholedataset$author[Wholedataset$author==""]<- "Unknown"
Wholedataset$author<- na.omit(Wholedataset$author)
########################################################################
#column Text
###################################################################################
Wholedataset$text<- as.character(Wholedataset$text)
#Case Folding - tranforming into lower case
Wholedataset$text<-tolower(Wholedataset$text)
# Removing Stop words from the data
stopword<-c("a","i","me" ,"my" ,"myself" ,"we" ,"our" ,"ours" ,"ourselves" ,"you" ,
            "your" ,"yours" ,"yourself" ,"yourselves", "he" ,"him" ,"his" ,"himself" ,
            "she" ,"her" ,"hers" ,"herself" ,"it" ,"its" ,"itself" ,"they" ,"them" ,
            "their" ,"theirs" ,"themselves" ,"what" ,"which" ,"who" ,"whom" ,"this" ,
            "that" ,"these" ,"those" ,"am" ,"is" ,"are", "was" ,"were" ,"be" ,"been" ,
            "being" ,"have" ,"has" ,"had" ,"having" ,"do" ,"does" ,"did" ,"doing" ,
            "would" ,"should" ,"could" ,"ought" ,"i'm" ,"you're" ,"he's" ,"she's" ,
            "it's" ,"we're" ,"they're" ,"i've" ,"you've" ,"we've" ,"they've" ,"i'd" ,
            "you'd" ,"he'd" ,"she'd" ,"we'd" ,"they'd" ,"i'll" ,"you'll" ,"he'll" ,
            "she'll" ,"we'll" ,"they'll" ,"isn't" ,"aren't" ,"wasn't" ,"weren't" ,
            "hasn't" ,"haven't" ,"hadn't" ,"doesn't" ,"don't" ,"didn't" ,"won't" ,
            "wouldn't" ,"shan't" ,"shouldn't" ,"can't" ,"cannot" ,"couldn't" ,
            "mustn't" ,"let's" ,"that's" ,"who's" ,"what's" ,"here's" ,"there's" ,
            "when's" ,"where's" ,"why's" ,"how's" ,"an" ,"the" ,"and" ,"but" ,
            "if" ,"or" ,"because" ,"as" ,"until" ,"while" ,"of", "at" ,"by" ,"for" ,
            "with" ,"about" ,"against" ,"between" ,"into" ,"through" ,"during",
            "before" ,"after" ,"above" ,"below" ,"to" ,"from" ,"up" ,"down" ,"in" 
            ,"out" ,"on" ,"off" ,"over" ,"under" ,"again" ,"further" ,"then" ,"once" ,
            "here" ,"there" ,"when" ,"where" ,"why" ,"how" ,"all" ,"any" ,"both" ,
            "each" ,"few" ,"more" ,"most" ,"other" ,"some" ,"such" ,"no" , "nor" ,
            "not" ,"only" ,"own" ,"same" ,"so" ,"than" ,"too" ,"very" ,"a's" ,"able" ,
            "about" ,"above" ,"according" ,"accordingly" ,"across" ,"actually" ,
            "after" ,"afterwards" ,"again" ,"against" ,"ain't" ,"all" ,"allow" ,
            "allows" ,"almost" ,"alone" ,"along" ,"already" ,"also" ,"although" ,
            "always" ,"am" ,"among" ,"amongst" ,"an" ,"and" ,"another" ,"any" ,
            "anybody" ,"anyhow" ,"anyone" ,"anything" ,"anyway" ,"anyways" ,
            "anywhere" ,"apart" ,"appear" ,"appreciate" ,"appropriate" ,"are" ,
            "aren't" ,"around" ,"as" ,"aside" ,"ask" ,"asking" ,"associated", "at" ,
            "available" ,"away" ,"awfully" ,"be" ,"became", "because" ,"become" ,
            "becomes" ,"becoming" ,"been" ,"before" ,"beforehand" ,"behind" ,"being" ,
            "believe" ,"below" ,"beside" ,"besides" ,"best" ,"better" ,"between" ,
            "beyond" ,"both", "brief" ,"but" ,"by" ,"c'mon" ,"c's" ,"came" ,"can" ,
            "can't" ,"cannot" ,"cant" ,"cause" ,"causes" ,"certain" ,"certainly" ,
            "changes" ,"clearly" ,"come" ,"comes" ,"concerning" ,
            "consequently" ,"consider" ,"considering" ,"contain" ,"containing" ,
            "contains" ,"corresponding" ,"could" ,"couldn't" ,"course" ,"currently" ,
            "definitely" ,"described" ,"despite" ,"did" ,"didn't" ,"different" ,"do" ,
            "does" ,"doesn't" ,"doing" ,"don't", "done" ,"down" ,"downwards" ,
            "during" ,"each"  ,"eight" ,"either" ,"else" ,"elsewhere" ,
            "enough" ,"entirely" ,"especially","etc" ,"even" ,"ever" ,"every" ,
            "everybody" ,"everyone" ,"everything" ,"everywhere" ,"ex" ,"exactly" ,
            "example" ,"except", "far" ,"few" ,"fifth" ,"first" ,"five" ,"followed" ,
            "following" ,"follows", "for" ,"former" ,"formerly" ,"forth" ,"four" ,
            "from" ,"further" ,"furthermore" ,"get", "gets" ,"getting" ,"given" ,
            "gives" ,"go" ,"goes" ,"going" ,"gone" ,"got" ,"gotten" ,"greetings" ,
            "had" ,"hadn't" ,"happens" ,"hardly" ,"has" ,"hasn't" ,"have" ,"haven't" ,
            "having" ,"he" ,"he's" ,"hello" ,"help" ,"hence" ,"her" ,"here" ,
            "here's" ,"hereafter" ,"hereby" ,"herein" ,"hereupon" ,"hers" ,
            "herself", "hi" ,"him" ,"himself" ,"his" ,"hither" ,"hopefully" ,"how" ,
            "howbeit" ,"however" ,"i'd" ,"i'll" ,"i'm" ,"i've" ,"ie" ,"if" ,"ignored",
            "immediate" ,"in" ,"inasmuch"  ,"indeed" ,"indicate" ,"indicated" ,
            "indicates" ,"inner" ,"insofar" ,"instead" ,"into" ,"inward" ,"is" ,
            "isn't"  ,"it'd" , "it'll" ,"it's" ,"its" ,"itself" ,"just" ,"keep" ,
            "keeps" ,"kept" ,"know" ,"knows" ,"known" ,"last" ,"lately" ,"later" ,
            "latter" ,"latterly" ,"least" ,"less" ,"lest" ,"let" ,"let's" ,"like" ,
            "liked" ,"likely" ,"little" ,"look" ,"looking" ,"looks" ,"ltd" ,"mainly" ,
            "many" ,"may" ,"maybe"  ,"mean" ,"meanwhile" ,"merely" ,"might" ,
            "more" ,"moreover" ,"most" ,"mostly" ,"much" ,"must" ,"my" ,"myself" ,
            "name" ,"namely" ,"near", "nearly" ,"necessary" ,"need" ,"needs" 
            ,"neither" ,"never" ,"nevertheless" ,"new" ,"next" ,"nine" ,"no" ,
            "nobody" ,"non" ,"none" ,"noone" ,"nor" ,"normally" ,"not" ,"nothing",
            "novel" ,"now" ,"nowhere" ,"obviously" ,"of" ,"off" ,"often"  ,"ok" ,
            "okay" ,"old" ,"once" ,"only" ,"onto" ,"or" ,
            "other" ,"others" ,"otherwise" ,"ought" ,"our" ,"ours" ,"ourselves" ,
            "out" ,"outside" ,"over" ,"overall" ,"own" ,"particular", "particularly" ,"perhaps" ,"placed" ,"please" ,"plus" ,"possible" ,"presumably" ,
            "probably" ,"provides" ,"quite" ,"rather" ,
            "really", "reasonably" ,"regarding" ,"regardless" ,"regards" ,
            "relatively" ,"respectively" ,"right" ,"said" ,"same" ,"saw" ,"say" ,
            "saying" ,"says" ,"second" ,"secondly" ,"seeing" ,"seem" ,
            "seemed" ,"seeming" ,"seems" ,"seen" ,"self" ,"selves" ,"sensible" ,
            "sent" ,"serious" ,"seriously" ,"seven" ,"several" ,"shall" ,"she" ,
            "should", "shouldn't" ,"since" ,"six" ,"some" ,"somebody" ,
            "somehow" ,"someone" ,"something" ,"sometime" ,"sometimes" ,"somewhat" ,
            "somewhere" ,"soon" ,"sorry" ,"specified" ,"specify" ,"specifying" ,
            "still" ,"such" ,"sure"  ,"take" ,"taken" ,"tell" ,
            "tends"  ,"than", "thank" ,"thanks" ,"thanx" ,"that", "that's" ,
            "thats" ,"the" ,"their" ,"theirs" ,"them" ,"themselves" ,"then" ,
            "thence" ,"there" ,"there's" ,"thereafter" ,"thereby" ,"therefore" ,
            "therein" ,"theres" ,"thereupon" ,"these" ,"they" ,"they'd" ,"they'll" ,
            "they're" ,"they've" ,"think" ,"third" ,"this" ,"thorough", "thoroughly" ,
            "those" ,"though" ,"three" ,"through" ,"throughout" ,"thru" ,"thus" ,
            "to" ,"together" ,"too" ,"took" ,"toward" ,"towards" ,"tried" ,"tries" ,
            "truly" ,"try" ,"trying" ,"twice" ,"two"  ,"under" ,
            "unfortunately" ,"unless" ,"unlikely" ,"until" ,"unto" ,"up" ,"upon" ,"use" ,"used", "useful" ,"uses" ,"using" ,"usually" ,"uucp"
            ,"various" ,"very" ,"via" ,"viz" ,"want", "wants" ,"was" ,"wasn't" ,
            "way" , "we'd" ,"we'll" ,"we're" ,"we've" ,"welcome" ,"well" ,
            "went" ,"were" ,"weren't" ,"what" ,"what's" ,"whatever", "when" ,
            "whence" ,"whenever" ,"where" ,"where's" ,"whereafter" ,"whereas" ,
            "whereby" ,"wherein" ,"whereupon" ,"wherever" ,"whether" ,"which" ,
            "while" ,"whither" ,"who" ,"who's" ,"whoever" ,"whole" ,"whom" ,
            "whose" ,"why", "will" ,"willing" ,"wish" ,"with", "within" ,"without" ,
            "won't" ,"wonder" ,"would" ,"wouldn't" ,"yes" ,"yet" ,"you" ,"you'd" ,
            "you'll" ,"you're" ,"you've", "your", "yours", "yourself", "yourselves")

library(qdap)
removed_text <- rm_stopwords(text.var = Wholedataset$text, stopwords = stopword, ignore.case = F, strip = TRUE)
Wholedataset$text <- NULL
Wholedataset[["text"]] <- removed_text
# Removing special characters, punctuation,numeric and alphanumeric terms
Wholedataset$text<- gsub("ג???T", "",Wholedataset$text)
Wholedataset$text<- gsub("ג???", "",Wholedataset$text)
Wholedataset$text<- gsub("Ã", "",Wholedataset$text)
Wholedataset$text<- gsub(" ~", "",Wholedataset$text)
Wholedataset$text<- gsub("©", "",Wholedataset$text)
Wholedataset$text<- gsub("#", "",Wholedataset$text)
Wholedataset$text<- gsub("~", "",Wholedataset$text)
Wholedataset$text<- gsub("[[:digit:]]", "",Wholedataset$text)
Wholedataset$text<- gsub("[[:punct:]]", " ",Wholedataset$text)
Wholedataset$text<- gsub("[[:punct:]]", " ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\b(a-z)\\b(1)", replace= " ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\W",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\d",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub("^[c]", "", Wholedataset$text)
Wholedataset$text<- gsub("נ", "", Wholedataset$text)
Wholedataset$text<- gsub("ס", "", Wholedataset$text)
Wholedataset$text<- gsub("ג", "", Wholedataset$text)
Wholedataset$text<- gsub("ב", "", Wholedataset$text)
Wholedataset$text<- gsub("ב", "", Wholedataset$text)
Wholedataset$text<- gsub("ב", "", Wholedataset$text)
Wholedataset$text<- gsub("ב", "", Wholedataset$text)
Wholedataset$text<- gsub("ננ", "", Wholedataset$text)
Wholedataset$text<- gsub("ש", "", Wholedataset$text)
Wholedataset$text<- gsub("ר", "", Wholedataset$text)
Wholedataset$text<- gsub("רש", "", Wholedataset$text)
Wholedataset$text<- gsub("'", "", Wholedataset$text)
Wholedataset$text<- gsub("ה", "", Wholedataset$text)
Wholedataset$text<- gsub(" ר", "", Wholedataset$text)
Wholedataset$text<- gsub("[^[:alnum:]]", " ",Wholedataset$text)
Wholedataset$text<- gsub("ו", "", Wholedataset$text)
Wholedataset$text<- gsub("ד", "", Wholedataset$text)
Wholedataset$text<- gsub("ממ", "", Wholedataset$text)
Wholedataset$text<- gsub("מ", "", Wholedataset$text)
Wholedataset$text<- gsub("iii", "", Wholedataset$text)
Wholedataset$text<- gsub("ן", "", Wholedataset$text)
Wholedataset$text<- gsub("one", "", Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\W",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\d",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub("the", "", Wholedataset$text)
Wholedataset$text<- gsub("you", "", Wholedataset$text)
#Removing all non-english words from data
Wholedataset$text <- iconv(Wholedataset$text, "utf-8", "ASCII")
#Removing blank and omit articles from data
Wholedataset$text[Wholedataset$text==""]<- "Unknown"
Wholedataset$text<- na.omit(Wholedataset$text)
##############################################################
# Step 3<- Save the cleaned dataset in your folder
##############################################################
write.csv(Wholedataset,file = "CleanedWholedataset1.csv", row.names = F)





