library(data.table)
library(dplyr)
register_google(key = "AIzaSyCYEVJ01CZ-tJU75ZA-TII97dpuk44J2W8", write = TRUE)

# map =======================================================

c <- qmap('Chungcheongbuk-do', zoom=9, source = 'stamen', maptype = 'toner')
g <- qmap('Gyeongsangbuk-do', zoom= 9, source = 'stamen', maptype = 'toner')
j <- qmap('Jeollabuk-do', zoom= 9, source = 'stamen', maptype = 'toner')
# lat/lon =====================================================

#import site
Sys.setlocale("LC_ALL","C") # 강제 언어 삭제
cb_search =  read.csv("./data/cb_search.csv", header = T, sep=",",encoding = "UTF-8")
colnames(cb_search)<- c('ranking','name','address','type1','type2')
geongbuk_search =  read.csv("./data/geongbuk_search.csv", header = T, sep=",",encoding = "UTF-8")
colnames(geongbuk_search)<- c('ranking','name','address','type1','type2')
geonbuk_search =  read.csv("./data/geonbuk_search.csv", header = T, sep=",",encoding = "UTF-8")
colnames(geonbuk_search)<- c('ranking','name','address','type1','type2')
Sys.setlocale("LC_ALL","Korean") # 언어 다시 한글로

# Chungcheong buk-do
cb_list <- cb_search$address 
cb_station_list <- c('각계역', '감곡역', '고명역', '공전역','내수역','단양역', '달천역',' 도담역',' 도안역',' 동량역','목행역','보천역', '봉양역','삼곡역', '삼탄역', '소이역', '심천역',' 영동역',' 오근장역', '오송역',' 옥천역 ','운학신호장',' 음성역', '이원역',' 입석리역',' 제천역',' 제천조차장역','주덕역',' 증평역',' 지탄역','청주공항역',' 청주역',' 추풍령역 ','충주역 ',' 황간역')
cb_df = data.frame(cb_list, stringsAsFactors = FALSE)
cb_df$cb_list = enc2utf8(cb_df$cb_list)  
cb_latlon = mutate_geocode(cb_df, cb_list)
cb_station_df = data.frame(cb_station_list, stringsAsFactors = FALSE)
cb_station_df$cb_station_list = enc2utf8(cb_station_df$cb_station_list)  
cb_station_latlon = mutate_geocode(cb_station_df, cb_station_list)

# Geongsang buk-do
geongbuk_list <- geongbuk_search$address 
geongbuk_station_list <-  c('갑현역' ,'강구역 ','개포역',' 거촌역' ,'건천역' ,'경산역' ,'경주역' ,'괴동역', '구미역' ,'금호역' ,'김천역' ,'김천역'  ,'나원역' ,'남성현역', '녹동역', '대신역' ,'동방역', '망호신호장', '모량역', '모화역',' 문경역', '문단역', '백원역', '법전역', '봉림역', '봉성역', '봉정역', '봉화역', '부조역' ,'북영주역' ,'북영천역', '분천역', '불국사역' ,'비동역', '비봉역' ,'사곡역' ,'사방역' ,'삼성역', '상주역', '서경주역 ','석포역', '송암역', '송포역', '승문역', '승부역',' 신거역', '신경주역', '신녕역', '신동역', '신동화물역', '신암역' , '아화역' ,'안강역', '안동역' ,'약목역' ,'양원역', '양자동역', '어등역', '업동역', '연화역', '영덕역' ,'영일만항역' ,'영주역' ,'영천역', '예천역', '옥산역', '옹천역', '왜관역' ,'용궁역', '우보역', '월포역', '율동역', '의성역', '임기역', '임포역', '입실역', '장사역', '점촌역', '주평역', '죽동역', '지천역', '직지사역', '진남역', '청도역', '청령역', '청리역', '청천역', '춘양역', '탑리역' ,'평은역' ,'포항역',' 풍기역', '하양역', '함창역', '현동역',' 화본역',' 화산역', '효자역 ')
geongbuk_df = data.frame(geongbuk_list, stringsAsFactors = FALSE)
geongbuk_station_df = data.frame(geongbuk_station_list, stringsAsFactors = FALSE)
geongbuk_df$geongbuk_list = enc2utf8(geongbuk_df$geongbuk_list)  
geongbuk_latlon = mutate_geocode(geongbuk_df, geongbuk_list)
geongbuk_station_df$geongbuk_station_list = enc2utf8(geongbuk_station_df$geongbuk_station_list)  
geongbuk_station_latlon = mutate_geocode(geongbuk_station_df, geongbuk_station_list)

# Jello buk-do
geonbuk_list <- geonbuk_search$name 
geonbuk_station <- c('감곡역', '개정역', '관촌역' ,'군산역',' 군산옥산신호장', '군산항역', '군산화물역', '김제역', '남원역', '노령역','대야역', '동산역', '동익산역', '목천신호소','봉천역', '부용역', '북전주역' ,'산성역', '삼례역', '서도역' ,'신리역', '신태인역', '오수역',' 옥구역',' 옹정역', '용동역', '익산역', '임실역', '전주역',' 정읍역',' 주생역',' 죽림온천역',' 천원역',' 초강역','함열역',' 황등역')
geonbuk_df = data.frame(geonbuk_list, stringsAsFactors = FALSE)
geonbuk_station_df = data.frame(geonbuk_station, stringsAsFactors = FALSE)
geonbuk_df$geonbuk_list = enc2utf8(geonbuk_df$geonbuk_list) 
geonbuk_station_df$geonbuk_station= enc2utf8(geonbuk_station_df$geonbuk_station) 
geonbuk_latlon = mutate_geocode(geonbuk_df, geonbuk_list)
geonbuk_station_latlon = mutate_geocode(geonbuk_station_df, geonbuk_station)


# distance
cb_origin<- cb_latlon%>%
  transmute(origin= paste0(lat,'+',lon))
cb_destination<- c('36.85617320167694+127.71133939405007')

geong_origin<- geongbuk_latlon%>%
  transmute(origin= paste0(lat,'+',lon))
geong_destination<- c('36.57728220078316+128.5054098311611')

geon_origin<- geonbuk_latlon%>%
  transmute(origin= paste0(lat,'+',lon))
geon_destination<- c('35.72689090768461+127.14750960494234')

results=NULL


save.image(file="data/source")


rm(list=c('cb_df','cb_search','cb_station_df','geonbuk_df','geonbuk_search','geonbuk_station_df','geongbuk_search','geongbuk_df','geongbuk_station_df'))
