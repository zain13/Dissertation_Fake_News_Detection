setwd("~/Desktop/Research_Project/codethesis3")

#Cleaning Wholedataset Dataset
Wholedataset<- read.csv("final_dataset.csv")

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
Wholedataset$title<- gsub("????T", "",Wholedataset$title)
Wholedataset$title<- gsub("????", "",Wholedataset$title)
Wholedataset$title<- gsub("?", "",Wholedataset$title)
Wholedataset$title<- gsub(" ~", "",Wholedataset$title)
Wholedataset$title<- gsub("?", "",Wholedataset$title)
Wholedataset$title<- gsub("#", "",Wholedataset$title)
Wholedataset$title<- gsub("~", "",Wholedataset$title)
Wholedataset$title<- gsub("[[:digit:]]", "",Wholedataset$title)
Wholedataset$title<- gsub("[[:punct:]]", " ",Wholedataset$title)
Wholedataset$title<- gsub("[[:punct:]]", " ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\b(a-z)\\b(1)", replace= " ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\W",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\d",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub("^[c]", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("??", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("??", "", Wholedataset$title)

#Wholedataset$title<- gsub("'", "", Wholedataset$title)

Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub(" ?", "", Wholedataset$title)
Wholedataset$title<- gsub("[^[:alnum:]]", " ",Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("??", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("iii", "", Wholedataset$title)
Wholedataset$title<- gsub("?", "", Wholedataset$title)
Wholedataset$title<- gsub("one", "", Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\W",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub(pattern = "\\d",replace=" ",Wholedataset$title)
Wholedataset$title<- gsub("the", "", Wholedataset$title)
Wholedataset$title<- gsub("you", "", Wholedataset$title)
Wholedataset$title<- gsub("haracter", "", Wholedataset$title)
Wholedataset$title<- gsub("character", "", Wholedataset$title)
Wholedataset$title<- gsub("character0", "", Wholedataset$title)
#Removing all non-english words from data
Wholedataset$title <- iconv(Wholedataset$title, "utf-8", "ASCII")
#Removing blank and omit articles from data
Wholedataset$title[Wholedataset$title==""]<- NA
#Wholedataset$title<- na.omit(Wholedataset$title)

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
Wholedataset$text<- gsub("????T", "",Wholedataset$text)
Wholedataset$text<- gsub("????", "",Wholedataset$text)
Wholedataset$text<- gsub("?", "",Wholedataset$text)
Wholedataset$text<- gsub(" ~", "",Wholedataset$text)
Wholedataset$text<- gsub("?", "",Wholedataset$text)
Wholedataset$text<- gsub("#", "",Wholedataset$text)
Wholedataset$text<- gsub("~", "",Wholedataset$text)
Wholedataset$text<- gsub("[[:digit:]]", "",Wholedataset$text)
Wholedataset$text<- gsub("[[:punct:]]", " ",Wholedataset$text)
Wholedataset$text<- gsub("[[:punct:]]", " ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\b(a-z)\\b(1)", replace= " ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\W",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\d",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub("^[c]", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("??", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("??", "", Wholedataset$text)
Wholedataset$text<- gsub("'", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
#Wholedataset$text<- gsub(" ?", "", Wholedataset$text)
Wholedataset$text<- gsub("[^[:alnum:]]", " ",Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("??", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("iii", "", Wholedataset$text)
Wholedataset$text<- gsub("?", "", Wholedataset$text)
Wholedataset$text<- gsub("one", "", Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\W",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub(pattern = "\\d",replace=" ",Wholedataset$text)
Wholedataset$text<- gsub("the", "", Wholedataset$text)
Wholedataset$text<- gsub("you", "", Wholedataset$text)
#Removing all non-english words from data
Wholedataset$text <- iconv(Wholedataset$text, "utf-8", "ASCII")
#Removing blank and omit articles from data
Wholedataset$text[Wholedataset$text==""]<- NA
Wholedataset$text<- gsub("haracter", "", Wholedataset$text)
Wholedataset$text<- gsub("character", "", Wholedataset$text)
Wholedataset$text<- gsub("character0", "", Wholedataset$text)
Wholedataset$text[Wholedataset$text==""]<- NA
#Wholedataset$text<- na.omit(Wholedataset$text)
##############################################################
# Step 3<- Save the cleaned dataset in your folder
##############################################################
Wholedataset<- na.omit(Wholedataset)
Wholedataset$url <- NULL

write.csv(Wholedataset,file = "CleanedWholedataset14000.csv", row.names = F)
#################################################################################

#####################################################################
# Benchmark Model Naive Bayes Classifier
############################################################
#Step 4<- From the "CleanedWholedataset1.csv" we created sub-sample of dataset
#Picking first 2000 articles and stored with named "CleanedWholedataset1 - Copy.csv"
#####################################################################
# Installing all required packages.
library(naivebayes)
library(e1071)
library(dplyr)
library(ggplot2)
library(psych)
library(caret)

#Reading dataset and appling Standard Naive Bayes classifier
Data<- read.csv("CleanedWholedataset1copy4000.csv")
Data<- na.omit(Data)
str(Data)
# Checking data imbalance
table(mydata$label)
Data$label<- as.factor(Data$label)
Data$text<-as.character(Data$text)
str(Data)
#Data
#Splitting dataset into training and testing data
#set.seed(12345)
ind_NB<- sample(2, nrow(Data), replace=T, prob = c(0.8,0.2))
train_NB<- Data[ind_NB==1,]
test_NB<- Data[ind_NB==2,]
#View(train)
#View(test)
#memory.limit()
#memory.limit(size=20000)
gc()
# Applying classifier only on news articles i.e. text columns
model_NB<- naiveBayes(label~text, data = train_NB)
#View(model)
#model

#Comparing training dataset with testing dataset
pred_NB<- predict(model_NB, test_NB)
tab_NB<- table(Predicted= pred_NB, Actual= test_NB$label)
tab_NB
#Evaluating results with the help of confusion matrix
library(caret)
confusionMatrix(pred_NB,test_NB$label, positive = '1')

# precision value for untuned Naive Bayes 
precision <- posPredValue(pred_NB, test_NB$label, positive="1")

# recall value for untuned Naive Bayes 
recall <- sensitivity(pred_NB, test_NB$label, positive="1")

# F1 score for untuned svm
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")


###################################################

################################################################
#Step 5<- Peforming LDA on "CleanedWholedataset1.csv"
#####################################################################
#Refered from : https://www.tidytextmining.com/topicmodeling.html

# Required packages were installed
library(tidyverse)
library(tidytext)
library(topicmodels)
library(tm)
library(SnowballC)

# Reading csv file 
texts <- read_csv("CleanedWholedataset14000.csv")
#Removing empty rows to avoid error while creating document term matrix
texts<- na.omit(texts)
#Deleting unwanted columns and focusing only on news articles to improve accuracy of the model
texts$X1<-NULL
texts$id<-NULL
texts$title<- NULL
texts$author<- NULL

# Taking sub sample of the dataset. considering first 2000 articles only

set.seed(123) #for k=2
#set.seed(1234) #for k=4
#set.seed(12346) #for k=6
#set.seed(12348) #for k=8


str(texts)
#Changing target variable into factor for execution
texts$label <- as.factor(texts$label)
gc()
texts_subsample <- texts[1:2000,] # taking first 2000 indexes
texts_subsample["document"] <- seq.int(nrow(texts_subsample))

#Creating Document term matrix and corpus
corpus <- Corpus(VectorSource(texts_subsample$text)) # make a corpus object
DTM <- DocumentTermMatrix(corpus) # get the count of words/document


unique_indexes <- unique(DTM$i)
DTM <- DTM[unique_indexes,]

#Implement LDA with specified number of topics

#Step 6<- Mention number of topics(k). In our case we took k=2, k=4, k=6,
# k=8, k=10 and k=12

lda <- LDA(DTM, k = 2, control = list(seed = 123))
#Coverting output of LDA to a tidy
topics <- tidy(lda, matrix = "beta") 
gammaDF <- as.data.frame(lda@gamma) 

k=2
names(gammaDF) <- c(1:k)
gammaDF
toptopics <- as.data.frame(cbind(document = row.names(gammaDF), 
                                 topic = apply(gammaDF,1,function(x) names(gammaDF)[which(x==max(x))])))

# We considered only top 10 words from the document

top_terms <- topics  %>% 
  group_by(topic) %>%  
  top_n(10, beta) %>% 
  ungroup() %>% #
  arrange(topic, -beta)


t1 <- merge(toptopics, top_terms, by = "topic", all.x = TRUE, all.y = TRUE)
t1$topic <- NULL


library(plyr)
top_terms$beta <- NULL
top_terms$term <- as.factor(top_terms$term)

top_terms_merged <- ddply(t1, .(document), summarize, toString(term))
colnames(top_terms_merged)[2] <- "term"
top_terms_merged$term <- as.factor(top_terms_merged$term)

library(data.table)
top_terms_merged <- as.data.table(top_terms_merged)
data_sep<-separate_rows(top_terms_merged, term, sep = ",")
table1<- data.table::dcast.data.table(data_sep, document ~ term)
table2<-sapply(table1[,-1],function(x){x<-ifelse(is.na(x),0,1)})
colnames(table2)<-paste0("term_",colnames(table2))
table<-cbind(table1[,1],table2)
MergedData<-merge(texts_subsample,table, by ="document", all.x = TRUE, all.y = TRUE)
MergedData$text <- NULL

#save the file
write.csv(MergedData, "one_hot_encoded2.csv", row.names = F)

#Step 7<- Similarly,we repeated the procedure for k=4, k=6, k=8, k=10 and k=12
# for k=4, csv named as "one_hot_encoded4.csv"
# for k=6, csv named as "one_hot_encoded6.csv"
# for k=8, csv named as "one_hot_encoded8.csv"
# for k=10, csv named as "one_hot_encoded10.csv"
# for k=12, csv named as "one_hot_encoded12.csv"
#############################################################################

#######################################################################
#Step8<- Perform Naive Bayes Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages
library(mlbench)
library(caret)
library(PRROC)
library(e1071)
library(klaR)

# Read the dataset
mydata <- read.csv("one_hot_encoded2.csv")
mydata<- na.omit(mydata)
str(mydata)
mydata$term_.news <- NULL
#Deleting unwanted column from dataset
mydata$document<-NULL
mydata$url <- NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

################################################### Naive Bayes ###################################################

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
Naive_Bayes_model <- train(label ~., 
                           data=train, 
                           trControl=train_control,
                           method="nb")
Naive_Bayes_model

# Creating predictive model
predicted <- predict(Naive_Bayes_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for Naive Bayes LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for Naive Bayes LDA 
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score  for Naive Bayes LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")

#Step 9<- Repeat the procedure for different topics and evaluate the results.
#############################################################################
#######################################################################
#Step10<- Perform Support Vector Machines- Linear Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages

library(mlbench)
library(caret)
library(PRROC)
library(e1071)

# Read the dataset
mydata <- read.csv("one_hot_encoded2.csv")
mydata<- na.omit(mydata)
#Deleting unwanted column from dataset
mydata$document<-NULL
mydata$term_.news <- NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

################################################### LSVM ###################################################

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
Linear_SVM_model <- train(label ~., 
                          data=train, 
                          trControl=train_control,
                          method="svmLinear")
Linear_SVM_model

# Creating predictive model
predicted <- predict(Linear_SVM_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for LSVM LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for LSVM LDA 
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score  for LSVM LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")

#Step 11<- Repeat the procedure for different topics and evaluate the results.
#############################################################################

#######################################################################
#Step12<- Perform Support Vector Machines- Radial Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages

library(mlbench)
library(caret)
library(PRROC)
library(e1071)

# Read the dataset
mydata <- read.csv("one_hot_encoded2.csv")
mydata<- na.omit(mydata)
mydata$term_.news <- NULL

#Deleting unwanted column from dataset
mydata$document<-NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]


################################################### SVM Radial ###################################################

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
SVM_Radial_model <- train(label ~., 
                          data=train, 
                          trControl=train_control,
                          method="svmRadial")
SVM_Radial_model

# Creating predictive model
predicted <- predict(SVM_Radial_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for SVM-R LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for SVM-R LDA 
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score for SVM-R LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")


#Step 13<- Repeat the procedure for different topics and evaluate the results.
#############################################################################

#######################################################################
#Step14<- Perform Random forest Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages

library(randomForest)
library(mlbench)
library(caret)
library(PRROC)

# Read the dataset
mydata <- read.csv("one_hot_encoded2.csv")
mydata<- na.omit(mydata)
mydata$term_.news <- NULL

#Deleting unwanted column from dataset
mydata$document<-NULL
#Coverting variables in factor
mydata[sapply(mydata, is.integer)] <- lapply(mydata[sapply(mydata, is.integer)], 
                                             as.factor)

str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

# converting target variable as factor
train$label <- ifelse(train$label == 1, "Y", "N")
test$label <- ifelse(test$label == 1, "Y", "N")
train$label <- factor(train$label)
test$label <- factor(test$label)
################################################### Random Forest ###################################################
gc()
# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
Random_Forest_model <- train(label ~., 
                             data=train, 
                             trControl=train_control,
                             method="rf",
                             TuneLength=5)
Random_Forest_model

# Creating predictive model
predicted <- predict(Random_Forest_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

#Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label)

#precision value for Random Forest LDA 
precision <- posPredValue(predicted, test$label)

#recall value for Random Forest LDA 
recall <- sensitivity(predicted, test$label)

#F1 score for Randon Forest LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")

#Step 15<- Repeat the procedure for different topics and evaluate the results.
#############################################################################

#######################################################################
#Step16<- Perform XG Boost Classifier on Featured Extracted from LDA
#######################################################################
#Installed Required packages
library(mlbench)
library(caret)
library(PRROC)
library(e1071)
library(klaR)

# Read the dataset
mydata <- read.csv("one_hot_encoded2.csv")
mydata<- na.omit(mydata)
mydata$term_.news <- NULL
#Deleting unwanted column from datase
mydata$document<-NULL
#Coverting target variable in factor
mydata$label<-as.factor(mydata$label)
str(mydata)
# Splitting data into training and testing dataset
splitdata <- createDataPartition(y = mydata$label, p= 0.80, list = FALSE)
train <- mydata[splitdata,]
test <- mydata[-splitdata,]

################################################### XGBoost ###################################################
#Tuning parameters of XG Boost
#https://xgboost.readthedocs.io/en/latest/parameter.html

tune_grid_x <- expand.grid(eta = c(0.5), 
                           nrounds = c(20),
                           max_depth = 6:20,
                           min_child_weight = c(2.0, 2.25, 22.5),
                           colsample_bytree = c(0.3, 0.4, 0.5),
                           gamma = 0,
                           subsample = 1)

# Performing 5-fold cross validation to avoid over fitting of the model and definin control
train_control <- trainControl(method="cv", 
                              number=5)

# Training the model
XG_Boost_model <- train(label ~., 
                        data=train, 
                        trControl=train_control,
                        method = "xgbTree",
                        tuneGrid = tune_grid_x)
XG_Boost_model

# Creating predictive model
predicted <- predict(XG_Boost_model, newdata = test)
predictedVsActualTable<- table(predicted, test$label)
predictedVsActualTable

# Evaluating results with the help of confusion matrix
confusionMatrix(predicted, test$label, positive = "1")

#precision value for XG Boost LDA 
precision <- posPredValue(predicted, test$label, positive="1")

#recall value for XG Boost LDA
recall <- sensitivity(predicted, test$label, positive="1")

#F1 score  for XG Boost LDA
F1 <- (2 * precision * recall) / (precision + recall)

print(paste(precision, recall, F1), sep=" ")

#Step 17<- Repeat the procedure for different topics and evaluate the results.
#############################################################################





# mod_results <- cbind(
#   SVM_Radial_model$results, 
#   Linear_SVM_model$results,
#   Naive_Bayes_model$results,
#   Random_Forest_model$results) %>%
#   as.data.frame() %>%
#   mutate(model = c("SVM Radial","SVM Linear", "Naive-Bayes", "Random forest"))
# 
# mod_results1 %>%
#   ggplot(aes(model, Accuracy)) +
#   geom_point() +
#   ylim(0, 1) +
#   geom_hline(yintercept = mod_results1$AccuracyNull[1],
#              color = "red")
# 
# results_by_class1 <- rbind(
#   SVM_Radial_model$byClass, Linear_SVM_model$byClass, Naive_Bayes_model$byClass,Random_Forest_model$byClass
# ) %>%
#   as.data.frame() %>% 
#   mutate(model = c("SVM Radial","SVM Linear", "Naive-Bayes", "Random forest"))




############################


