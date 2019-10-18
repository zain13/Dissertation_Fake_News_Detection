setwd("~/Desktop/Research_Project/codethesis3")

#dataset download link https://www.kaggle.com/jruvika/fake-news-detection


# Import libraries
library(tm) # for NLP
library(plyr) #  for pre-processing 
library(tidyverse) # for pre-processing and visualisation


data<- read.csv("data.csv", stringsAsFactors = FALSE)

#coverting into dataset
data<- as.data.frame(data)
data$id <- seq.int(nrow(data))

#changing names forsimplicity
colnames(data)[colnames(data)=="Headline"] <- "title"
colnames(data)[colnames(data)=="Label"] <- "label"
colnames(data)[colnames(data)=="Body"] <- "text"
colnames(data)[colnames(data)=="URLs"] <- "url"

#custom function to clean
clean_text <- function(x){ 
  gsub("…|⋆|–|‹|”|“|‘|’", " ", x) 
}

####################################################################################
#working with text column
######################################################################################
all_text <- as.vector(data$text)
length (all_text)

corpus_text <- VCorpus(VectorSource(all_text))

# Check 1st Review
inspect(corpus_text[1])
as.character(corpus_text[[1]]) 

STOP_ADD <- c("a","i","me","f" ,"my" ,"myself" ,"we" ,"our" ,"ours" ,"ourselves" ,"you" ,
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

# Combine Domain & General Stopwords
STOP_TOTAL <- unique (c(STOP_ADD, stopwords('SMART')))

# Check Running Time for Cleanning
system.time (
  clean_text_corpus <- corpus_text %>% 
    tm_map (tolower) %>%
    tm_map (removeWords, STOP_TOTAL) %>% 
    tm_map( removeWords, stopwords("english")) %>%
    tm_map (removePunctuation) %>%
    tm_map (removeNumbers)  %>%
    tm_map (stripWhitespace) %>% 
    tm_map(clean_text) %>%
    tm_map (PlainTextDocument) 
)

#df_corpus_text <- as.data.frame (clean_text_corpus)
#head (df_corpus_text)

df_corpus_text <- data.frame(text=unlist(sapply(clean_text_corpus, `[`, "content")), 
                        stringsAsFactors=F)
head(df_corpus_text)

text_clean <- data %>% 
  mutate (cleaned_text = df_corpus_text$text)

names(text_clean)
text_clean$cleaned_text <- gsub("[[:punct:]]", " ", text_clean$cleaned_text)
#text_clean$cleaned_text <- gsub("\\s+","",text_clean$cleaned_text)

####################################################################################
#working with title column
######################################################################################
all_title <- as.vector (data$title)
length (all_title)

corpus_title <- VCorpus(VectorSource(all_title))

# Check 1st Review
inspect(corpus_title[1])
as.character(corpus_title[[1]]) 

STOP_ADD <- c("a","i","me","f" ,"my" ,"myself" ,"we" ,"our" ,"ours" ,"ourselves" ,"you" ,
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

# Combine Domain & General Stopwords
STOP_TOTAL <- unique (c(STOP_ADD, stopwords('SMART')))

# Check Running Time for Cleanning
system.time (
  clean_title_corpus <- corpus_title %>% 
    tm_map (tolower) %>%
    tm_map (removeWords, STOP_TOTAL) %>% 
    tm_map( removeWords, stopwords("english")) %>%
    tm_map (removePunctuation) %>%
    tm_map (removeNumbers)  %>%
    tm_map (stripWhitespace) %>% 
    tm_map(clean_text) %>%
    tm_map(stemDocument)  %>%
    tm_map (PlainTextDocument) 
)

#df_corpus_title <- as.data.frame (clean_title_corpus)
#head (df_corpus_title)

df_corpus_title <- data.frame(title=unlist(sapply(clean_title_corpus, `[`, "content")), 
                             stringsAsFactors=F)
head(df_corpus_title)


cleaned_dataset <- text_clean %>% 
  mutate(cleaned_title = df_corpus_title$title)

names(cleaned_dataset)
cleaned_dataset$cleaned_title <- gsub("[[:punct:]]", " ", cleaned_dataset$cleaned_title)
#cleaned_dataset$cleaned_title <- gsub("\\s+","",cleaned_dataset$cleaned_title)


write.csv(cleaned_dataset,file = "cleaned_dataset_tfidf.csv", row.names = F)
