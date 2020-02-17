gen year=2011
gen year=2013
gen year=2015

gen x=substr(ID,1,9)
gen y=substr(ID,10,11)
gen z=x+"0"+y
replace ID = z
drop x y z

gen x=substr(householdID,1,9)
gen z=x+"0"
replace householdID = z
drop x z

append using "D:\charls\01\2013 ID.dta"
append using "D:\charls\01\2015 ID.dta"
sort ID year
sort ID

drop year
merge 1:1 ID using "D:\charls\01\2013 ID(2).dta",keep(3) nogen
merge 1:1 ID using "D:\charls\01\2015 ID(2).dta",keep(3) nogen

merge 1:m ID using "D:\charls\01\2011 ID(1).dta", keep(3) nogen
merge 1:m ID using "D:\charls\01\2013 ID.dta", keep(3) nogen
merge 1:m ID using "D:\charls\01\2015 ID(1).dta", keep(3) nogen  /*平衡短面板*/

append using "D:\charls\01\2013 ID(3).dta"
append using "D:\charls\01\2015 ID(3).dta"
sort ID year


merge 1:m ID "D:\charls\01\2015 ID(2).dta", nogen
sort ID year
merge 1:1 ID year using "D:\charls\01\2015 ID(1).dta", nogen
sort ID year

/*筛选变量*/
drop if age<45

/*处理控制变量*/
replace bc001=0 if bc001>1  /*是否为农业户,是=1*/
replace be001=0 if be001>1  /*已婚=1*/
gen edu_1=0
replace edu_1=1 if bd001==2
replace edu_1=1 if bd001==3  /*是否会读写（受过教育）*/
gen edu_2=0
replace edu_2=1 if bd001==4
replace edu_2=1 if bd001==5  /*是否小学毕业*/
gen edu_3=0
replace edu_3=1 if bd001==6
replace edu_3=1 if bd001==7  /*是否高中毕业*/
gen edu_4=0
replace edu_4=1 if bd001==8   
replace edu_4=1 if bd001==9
replace edu_4=1 if bd001==10
replace edu_4=1 if bd001==11   /*是否大专及以上*/

/*收入*/
gen ga002_0=ga002/12           /*2011工资*/
replace ga002_0=ga002_1 if ga002==.e
replace ga002_0=(ga002_a+ga002_b)/24 if ga002==.d
replace ga002_0=(ga002_a+ga002_b)/24 if ga002==.r  

gen ga004_0= ga004_1_1_/12
replace ga004_0= ga004_2_1_ if ga004_1_1_==.e

gen ga004_2= ga004_1_2_/12
replace ga004_2= ga004_2_2_ if ga004_1_2_==.e
gen ga004_3= ga004_1_3_/12
replace ga004_3= ga004_2_3_ if ga004_1_3_==.e
gen ga004_4= ga004_1_4_/12
replace ga004_4= ga004_2_4_ if ga004_1_4_==.e
gen ga004_5= ga004_1_5_/12
replace ga004_5= ga004_2_5_ if ga004_1_5_==.e
gen ga004_6= ga004_1_6_/12
replace ga004_6= ga004_2_6_ if ga004_1_6_==.e
gen ga004_7= ga004_1_7_/12
replace ga004_7= ga004_2_7_ if ga004_1_7_==.e
gen ga004_8= ga004_1_8_/12
replace ga004_8= ga004_2_8_ if ga004_1_8_==.e
gen ga004_9= ga004_1_9_/12
replace ga004_9= ga004_2_9_ if ga004_1_9_==.e


replace ga004_2=0 if ga004_2==.
replace ga004_3=0 if ga004_3==.
replace ga004_4=0 if ga004_4==.
replace ga004_5=0 if ga004_5==.
replace ga004_6=0 if ga004_6==.
replace ga004_7=0 if ga004_7==.
replace ga004_8=0 if ga004_8==.
replace ga004_9=0 if ga004_9==.
replace ga004_2=0 if ga004_2==.e
replace ga004_3=0 if ga004_3==.e
replace ga004_4=0 if ga004_4==.e
replace ga004_5=0 if ga004_5==.e
replace ga004_6=0 if ga004_6==.e
replace ga004_7=0 if ga004_7==.e
replace ga004_8=0 if ga004_8==.e
replace ga004_9=0 if ga004_9==.e
gen ga004_1= ga004_2+ ga004_3 + ga004_4 + ga004_5 + ga004_6 + ga004_7 + ga004_8 + ga004_9
drop ga004_2 ga004_3 ga004_4 ga004_5 ga004_6 ga004_7 ga004_8 ga004_9


gen ga002_0=ga002_1/12           /*2013工资*/
replace ga002_0=ga002_2 if ga002_2!=.
replace ga002_0=(ga002_bracket_max+ga002_bracket_min)/24 if ga002_bracket_max!=.

gen ga004_1=ga004_1_1_/12      /*退休金*/
gen ga004_2=ga004_1_2_/12
gen ga004_3=ga004_1_3_/12
gen ga004_4=ga004_1_4_/12
gen ga004_5=ga004_1_5_/12
gen ga004_6=ga004_1_6_/12
gen ga004_7=ga004_1_7_/12
gen ga004_8=ga004_1_8_/12
gen ga004_9=ga004_1_9_/12           
replace ga004_1=ga004_2_1_ if ga004_2_1_!=.
replace ga004_2=ga004_2_2_ if ga004_2_2_!=.
replace ga004_3=ga004_2_3_ if ga004_2_3_!=.
replace ga004_4=ga004_2_4_ if ga004_2_4_!=.
replace ga004_5=ga004_2_5_ if ga004_2_5_!=.
replace ga004_6=ga004_2_6_ if ga004_2_6_!=.
replace ga004_7=ga004_2_7_ if ga004_2_7_!=.
replace ga004_8=ga004_2_8_ if ga004_2_8_!=.
replace ga004_9=ga004_2_9_ if ga004_2_9_!=.

/*2015工资、补贴*/
gen ga002_0=ga002/12  
replace ga002_0=(ga002_bracket_max+ga002_bracket_min)/24 if ga002_bracket_max!=.

gen ga004_2=ga004_2_/12
gen ga004_3=ga004_3_/12
gen ga004_4=ga004_4_/12
gen ga004_5=ga004_5_/12
gen ga004_6=ga004_6_/12
gen ga004_7=ga004_7_/12
gen ga004_8=ga004_8_/12
gen ga004_9=ga004_9_/12
gen ga004_c= ga004_2+ ga004_3 + ga004_4 + ga004_5 + ga004_6 + ga004_7 + ga004_8 + ga004_9


/*2015退休金*/
gen fn005=fn005_w2_1_
replace fn005=fn005_w2_2_ if fn005_w2_2_ != .
replace fn005=fn005_w2_3_ if fn005_w2_3_ != .

gen fn068=fn068_w2_1_
replace fn068=fn068_w2_2_ if fn068_w2_2_ != .
replace fn068=fn068_w2_3_ if fn068_w2_3_ != .

gen fn079=fn079_w2_11

gen fn096=fn096_w2

replace fn005=0 if fn005==.
replace fn068=0 if fn068==.
replace fn079=0 if fn079==.
replace fn096=0 if fn096==.
gen pension=fn005+fn068+fn079+fn096
replace pension=. if pension==0
drop fn005 fn068 fn079 fn096


/**/


/*处理2015子女数目及是否一起居住*/
keep ID householdID communityID year cb051_w3_1 a001_w3_0s3

drop if alive!=1
bysort ID :gen child_N=_N  /*children计数*/
duplicates drop ID, force

merge 1:1 ID using "D:\charls\variables\children 2015_2.dta",keep(3) nogen
replace cb051_w3_1=0 if cb051_w3_1==.
replace child_N= child_N+ cb051_w3_1
drop cb051_w3_1


/*家户收入*/        
mvencode _all, mv(0) ov
gen gb005_0= gb005
replace gb005_0=( gb005_a + gb005_b )/2 if gb005_b>0
gen gb006_0= gb006
replace gb006_0=( gb006_a + gb006_b )/2 if gb006_b>0
gen gb008_0= gb008
replace gb008_0=( gb008_a + gb008_b )/2 if gb008_b>0
gen gb009_0= gb009
replace gb009_0=( gb009_a + gb009_b )/2 if gb009_b>0
gen gb011_0= gb011
replace gb011_0=( gb011_a + gb011_b )/2 if gb011_b>0
gen gb012_0= gb012
replace gb012_0=( gb012_a + gb012_b )/2 if gb012_b>0

gen income_c=(gb005_0 - gb006_0)/2   /*农作*/
gen income_l=(gb011_0 + gb012_0 - gb010 - gb013)/2    /*养殖*/

gen gc005_1=gc005_1_
replace gc005_1=(gc005_a_1_+gc005_b_1_)/2 if gc005_b_1_>0
gen gc005_2=gc005_2_
replace gc005_2=(gc005_a_2_+gc005_b_2_)/2 if gc005_b_2_>0
gen self_em=(gc005_1+gc005_2)/2     /*个体经营*/

gen gd002= gd001_c+ gd002_1+ gd002_2+ gd002_3+ gd002_4+ gd002_5+ gd002_6+ gd002_7

merge m:1 householdID using "D:\charls\variables\household income 2011.dta",keep(3) nogen



/*是否工作*/
replace fa001=0 if fa001==.
replace fa001=0 if fa001==2
replace fa002=0 if fa002==.
replace fa002=0 if fa002==2

/*2011 savings*/
replace hc001=(hc002_a+hc002_b)/2 if hc001==.d
replace hc001=(hc002_a+hc002_b)/2 if hc001==.r
replace hc003_1=0 if hc003_1==.
replace hc003_1=0 if hc003_1==.e
replace hc003_1=0 if hc003_1==.d
replace hc003_1=0 if hc003_1==.r
replace hc003_2=. if hc003_2==.e
replace hc003_2=. if hc003_2==.d
replace hc003_2=. if hc003_2==.r

replace hc001=hc003_1 if hc003_1!=0
replace hc001=hc001*hc003_2/100 if hc003_2!=.

replace hc005=0 if hc004!=1

gen x=.
replace x=1000 if hc006_1 ==1
replace x=2000 if hc006_1 ==2
replace x=3500 if hc006_2 ==1
replace x=5000 if hc006_2 ==2
replace x=7500 if hc006_3 ==1
replace x=10000 if hc006_3 ==2
replace x=30000 if hc006_4 ==1
replace x=50000 if hc006_4 ==2
replace x=75000 if hc006_5 ==1
replace x=100000 if hc006_5 ==2
replace x=150000 if hc006_6 ==1
replace x=200000 if hc006_6 ==2
replace x=350000 if hc006_7 ==1
replace x=500000 if hc006_7 ==2
replace x=500000 if hc006_7 ==3

replace hc005=x if x!=.

replace hc005=0 if hc005==.
replace hc005=0 if hc005==.e
replace hc005=0 if hc005==.d
replace hc005=0 if hc005==.r

mvencode _all, mv(0) ov

gen savings= hc001+ hc005


/*2013 savings*/
replace hc002_bracket_max=0 if hc002_bracket_max==.
replace hc002_bracket_min=0 if hc002_bracket_min==.
replace hc001=( hc002_bracket_max + hc002_bracket_min )/2 if hc002_bracket_max>0

replace hc001=hc003_1 if hc003_1!=.
replace hc001=hc001*hc003_2/100 if hc003_2!=.

replace hc006_bracket_max=0 if hc006_bracket_max==.
replace hc006_bracket_min=0 if hc006_bracket_min==.
replace hc005=( hc006_bracket_max + hc006_bracket_min )/2 if hc006_bracket_max>0



/*保险参与2013*/
gen insurance01=.
replace insurance01=1 if ea001s1!=.
gen insurance02=.
replace insurance02=1 if ea001s2 !=.
gen insurance03=.
replace insurance03=1 if ea001s3 !=.
gen insurance04=.
replace insurance04=1 if ea001s4 !=.
gen insurance05=.
replace insurance05=1 if ea001s5 !=.
gen insurance06=.
replace insurance06=1 if ea001s6 !=.
gen insurance07=.
replace insurance07=1 if ea001s7 !=.
gen insurance08=.
replace insurance08=1 if ea001s8 !=.
gen insurance09=.
replace insurance09=1 if ea001s9 !=.
gen insurance10=.
replace insurance10=1 if ea001s10 !=.
gen insurance11=.
replace insurance11=1 if ea001s11 !=.

gen insurance_1= insurance01
gen insurance_2= insurance02
replace insurance_2= insurance04 if insurance_2==.
gen insurance_s=.
replace insurance_s=1 if ea002_1_==1
replace insurance_s=1 if ea002_2_==1
replace insurance_s=1 if ea002_3_==1
replace insurance_s=1 if ea002_4_==1
replace insurance_s=1 if ea002_5_==1
replace insurance_s=1 if ea002_6_==1
replace insurance_s=1 if ea002_7_==1
replace insurance_s=1 if ea002_8_==1
replace insurance_s=1 if ea002_9_==1
replace insurance_s=1 if ea002_10_==1


gen insurance01=.
replace insurance01=1 if ea001s1 ==1
gen insurance02=.
replace insurance02=1 if ea001s2 ==2
gen insurance03=.
replace insurance03=1 if ea001s3 ==3
gen insurance04=.
replace insurance04=1 if ea001s4 ==4
gen insurance05=.
replace insurance05=1 if ea001s5 ==5
gen insurance06=.
replace insurance06=1 if ea001s6 ==6
gen insurance07=.
replace insurance07=1 if ea001s7 ==7
gen insurance08=.
replace insurance08=1 if ea001s8 ==8
gen insurance09=.
replace insurance09=1 if ea001s9 ==9
gen insurance10=.
replace insurance10=1 if ea001s10 ==10

/*2015 insurance*/

gen insurance01=1
replace insurance01=0 if ea001_w3_3_1_==2
gen insurance02=1
replace insurance02=0 if ea001_w3_3_2_==2
gen insurance03=1
replace insurance03=0 if ea001_w3_3_3_==2
gen insurance04=1
replace insurance04=0 if ea001_w3_3_4_==2
gen insurance05=1
replace insurance05=0 if ea001_w3_3_5_==2
gen insurance06=1
replace insurance06=0 if ea001_w3_3_6_==2
gen insurance07=1
replace insurance07=0 if ea001_w3_3_7_==2
gen insurance08=1
replace insurance08=0 if ea001_w3_3_8_==2
gen insurance09=1
replace insurance09=0 if ea001_w3_3_9_==2
gen insurance10=1
replace insurance10=0 if ea001_w3_3_10_==2


 
 
/*保费缴纳2011*/
replace ea006_5_=160 if ea006_5_==.d
replace ea006_6_=46 if ea006_6_==.d
replace ea006_7_=880 if ea006_7_==.d
replace ea006_8_=2000 if ea006_8_==.d
replace ea006_9_=30 if ea006_9_==.d
mvencode _all, mv(0) ov

gen insurance_premium= ea006_1_+ ea006_2_+ ea006_3_+ ea006_4_+ ea006_5_+ ea006_6_+ ea006_7_+ ea006_8_+ ea006_9_

replace ea006__= if ea006__==.d


/*是否生病、门诊次数、费用*/
gen if_visit=ed001
replace if_visit=0 if ed001!=1
gen if_ill=ed002
replace if_ill=0 if ed002==2
replace if_ill=1 if if_ill==.

/*medical facility type*/
gen medical_facility_1=0   /*general hospital*/
replace medical_facility_1=1 if ed004s1==1
gen medical_facility_2=0   /*township hospital*/
replace medical_facility_2=1 if ed004s5==5
gen medical_facility_3=0   /*villige clinic*/
replace medical_facility_3=1 if ed004s7==7

mvencode _all, mv(0) ov
gen n_visit= ed005_1_+ ed005_2_+ ed005_3_+ ed005_4_+ ed005_5_+ ed005_6_+ ed005_7_
gen total_cost01= ed006_1_1_+ ed006_1_2_+ ed006_1_3_+ ed006_1_4_+ ed006_1_5_+ ed006_1_6_+ ed006_1_7_+ ed006_1_8_+ ed006_1_9_
gen self_paid01= ed007_1_1_+ ed007_1_2_+ ed007_1_3_+ ed007_1_4_+ ed007_1_5_+ ed007_1_6_+ ed007_1_7_+ ed007_1_8_+ ed007_1_9_
gen distance01=ed013 /*km*/

replace total_cost01 = ed023_1 if total_cost01==0
replace self_paid01 = ed024_1 if self_paid01 ==0
gen reimbursment_rate01= (total_cost01- self_paid01)/ total_cost01

gen if_visit=0
replace if_visit=1 if ed001==1
gen if_ill=ed002
replace if_ill=1 if ed001==1
replace if_ill=0 if if_ill!=1

mvencode _all, mv(0) ov

replace max=0 if max==.
replace min=0 if min==.
gen x=(max + min )/2
replace x= min if max==0
gen cost=  
replace cost=x if cost==0
replace    =cost if   ==0
drop max min x cost

replace max=0 if max==.
replace min=0 if min==.
gen x=(max + min )/2
replace x= min if max==0
replace =x if ==0
drop max min x
drop x


/*住院费用、天数*/
gen if_not_inpatient=0
replace if_not_inpatient=1 if ee001==1
gen if_inpatient=0
replace if_inpatient=1 if ee003==1

gen n_inpatient=ee004
gen total_cost02= ee005_1
gen self_paid02= ee006_1

replace medical_facility_1 =0 if ee007!=1
replace medical_facility_2 =0 if ee007!=1
replace medical_facility_3 =0 if ee007!=1
replace medical_facility_1 =1 if ee008==1
replace medical_facility_2 =1 if ee008==5
replace medical_facility_3 =1 if ee008==7

mvencode _all, mv(0) ov
replace total_cost02= ee024_1 if total_cost02==0
replace self_paid02= ee027_1 if self_paid02==0

gen nurse_cost= ee025_1
gen trans_cost= ee026_1
gen reimbursment_rate02= (total_cost02- self_paid02)/ total_cost02

/*其他医疗支出*/


drop x
/*frailty index*/
gen x= da001-1
replace x=da002 if x==.
gen self_comment=0
replace self_comment=1 if x==5
replace self_comment=0.75 if x==4
replace self_comment=0.5 if x==3
replace self_comment=0.25 if x==2

replace =0 if  !=1

replace da007_1_ =0 if  da007_1_ !=1
replace da007_2_ =0 if  da007_2_ !=1
replace da007_3_ =0 if  da007_3_ !=1
replace da007_4_ =0 if  da007_4_ !=1
replace da007_5_ =0 if  da007_5_ !=1
replace da007_6_ =0 if  da007_6_ !=1
replace da007_7_ =0 if  da007_7_ !=1
replace da007_8_ =0 if  da007_8_ !=1
replace da007_9_ =0 if  da007_9_ !=1
replace da007_10_ =0 if  da007_10_ !=1
replace da007_11_ =0 if  da007_11_ !=1
replace da007_12_ =0 if  da007_12_ !=1
replace da007_13_ =0 if  da007_13_ !=1
replace da007_14_ =0 if  da007_14_ !=1

replace da041=0 if da041!=1  /*...*/

replace da047=0 if da047!=2
replace da047=1 if da047==2

replace db002=1 if db001==1
replace db003=1 if db002==1
replace db003=4 if db002==4

gen db01=0
replace db01=0.33 if db001==2
replace db01=0.66 if db001==3
replace db01=1 if db001==4

gen db0=0
replace db0=0.33 if db00==2
replace db0=0.66 if db00==3
replace db0=1 if db00==4

gen db02=0
replace db02=0.33 if db002==2
replace db02=0.66 if db002==3
replace db02=1 if db002==4
gen db03=0
replace db03=0.33 if db003==2
replace db03=0.66 if db003==3
replace db03=1 if db003==4
gen db04=0
replace db04=0.33 if db004==2
replace db04=0.66 if db004==3
replace db04=1 if db004==4
gen db05=0
replace db05=0.33 if db005==2
replace db05=0.66 if db005==3
replace db05=1 if db005==4
gen db06=0
replace db06=0.33 if db006==2
replace db06=0.66 if db006==3
replace db06=1 if db006==4
gen db07=0
replace db07=0.33 if db007==2
replace db07=0.66 if db007==3
replace db07=1 if db007==4
gen db08=0
replace db08=0.33 if db008==2
replace db08=0.66 if db008==3
replace db08=1 if db008==4
gen db09=0
replace db09=0.33 if db009==2
replace db09=0.66 if db009==3
replace db09=1 if db009==4
gen db10=0
replace db10=0.33 if db010==2
replace db10=0.66 if db010==3
replace db10=1 if db010==4
gen db11=0
replace db11=0.33 if db011==2
replace db11=0.66 if db011==3
replace db11=1 if db011==4
gen db12=0
replace db12=0.33 if db012==2
replace db12=0.66 if db012==3
replace db12=1 if db012==4
gen db13=0
replace db13=0.33 if db013==2
replace db13=0.66 if db013==3
replace db13=1 if db013==4
gen db14=0
replace db14=0.33 if db014==2
replace db14=0.66 if db014==3
replace db14=1 if db014==4
gen db15=0
replace db15=0.33 if db015==2
replace db15=0.66 if db015==3
replace db15=1 if db015==4
gen db16=0
replace db16=0.33 if db016==2
replace db16=0.66 if db016==3
replace db16=1 if db016==4
gen db17=0
replace db17=0.33 if db017==2
replace db17=0.66 if db017==3
replace db17=1 if db017==4
gen db18=0
replace db18=0.33 if db018==2
replace db18=0.66 if db018==3
replace db18=1 if db018==4
gen db19=0
replace db19=0.33 if db019==2
replace db19=0.66 if db019==3
replace db19=1 if db019==4
gen db20=0
replace db20=0.33 if db020==2
replace db20=0.66 if db020==3
replace db20=1 if db020==4

gen dc10=0
replace dc10=0.5 if dc010==3
replace dc10=1 if dc010==4
gen dc11=0
replace dc11=0.5 if dc011==3
replace dc11=1 if dc011==4
gen dc12=0
replace dc12=0.5 if dc012==3
replace dc12=1 if dc012==4
gen dc13=0
replace dc13=0.5 if dc013==2
replace dc13=1 if dc013==1
gen dc14=0
replace dc14=0.5 if dc014==3
replace dc14=1 if dc014==4
gen dc15=0
replace db15=0.5 if db015==3
replace db15=1 if db015==4
gen dc16=0
replace dc16=0.5 if dc016==2
replace dc16=1 if dc016==1
gen dc17=0
replace dc17=0.5 if dc017==3
replace dc17=1 if dc017==4
gen dc18=0
replace dc18=0.5 if dc018==3
replace dc18=1 if dc018==4

gen w1=.
replace w1=1 if da007_w2_2_1_==1
gen w2=.
replace w2=1 if da007_w2_2_2_==1
gen w3=.
replace w3=1 if da007_w2_2_3_==1
gen w4=.
replace w4=1 if da007_w2_2_4_==1
gen w5=.
replace w5=1 if da007_w2_2_5_==1
gen w6=.
replace w6=1 if da007_w2_2_6_==1
gen w7=.
replace w7=1 if da007_w2_2_7_==1
gen w8=.
replace w8=1 if da007_w2_2_8_==1
gen w9=.
replace w9=1 if da007_w2_2_9_==1
gen w10=.
replace w10=1 if da007_w2_2_10_==1
gen w11=.
replace w11=1 if da007_w2_2_11_==1
gen w12=.
replace w12=1 if da007_w2_2_12_==1
gen w13=.
replace w13=1 if da007_w2_2_13_==1
gen w14=.
replace w14=1 if da007_w2_2_14_==1

replace da007_1_=1 if w1==1
replace da007_2_=1 if w2==1
replace da007_3_=1 if w3==1
replace da007_4_=1 if w4==1
replace da007_5_=1 if w5==1
replace da007_6_=1 if w6==1
replace da007_7_=1 if w7==1
replace da007_8_=1 if w8==1
replace da007_9_=1 if w9==1
replace da007_10_=1 if w10==1
replace da007_11_=1 if w11==1
replace da007_12_=1 if w12==1
replace da007_13_=1 if w13==1
replace da007_14_=1 if w14==1

mvencode _all, mv(0) ov

gen frailty_index=( self_comment + db01 + db02 + db03 + db04 + db05+ db06+ db07+ db08+ db09+ db10+ db11+ db12+ db13+ db14+ db15+ db16+ db17+ db18+ db19+ db20+ dc10+ dc11+ dc12+ dc13+ dc14+ dc15+ dc16+ dc17+ dc18+ da007_1_+ da007_2_+ da007_3_+ da007_4_+ da007_5_+ da007_6_+ da007_7_+ da007_8_+ da007_9_+ da007_10_+ da007_11_+ da007_12_+ da007_13_+ da007_14_ )/44

xtile age_4q=age, nquantile(4) /*四分位*/
xtile frailty_index_4q= frailty_index , nquantile(4)
merge 1:1 ID using , nogen





xtreg ln_total_cost01 reimbursment_rate01 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index insurance_1 insurance_3 insurance_5 insurance_s insurance_premium gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work ln_income ln_subsidy ln_savings,re r theta

xtreg ln_total_cost01 reimbursment_rate01 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index insurance_1 insurance_3 insurance_5 insurance_s ln_premium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work ln_income ln_subsidy ln_savings,re r theta

nbreg n_visit frailty_index medical_facility_1 medical_facility_2 medical_facility_3 insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s ln_premium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work ln_income ln_subsidy ln_savings

xtreg ln_total_cost01 reimbursment_rate01 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index insurance_1 insurance_3 insurance_5 insurance_s ln_premium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work ln_income ln_subsidy ln_savings,re r theta

/*main city*/
reg ln_total_cost01 reimbursment_rate01 frailty_index insurance_1 insurance_3 insurance_5 insurance_s insurance_premium gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work ln_income ln_subsidy ln_savings medical_facility_1


gen lnincome=ln( income +1)
gen lnsavings =ln( savings +1)
gen lnsubsidy =ln( subsidy +1)
gen lnpremium =ln( insurance_premium +1)
/*门诊指出的分位数回归*/
sqreg ln_total_cost01 reimbursment_rate01 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index child_N insurance_1 insurance_3 insurance_5 insurance_s lnpremium gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings,q(.10 .5 .90)reps(500)

sqreg ln_total_cost01 reimbursment_rate01 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings,q(.10 .5 .90)reps(500)

gen age_1=0
gen age_2=1
gen age_3=0
replace age_1=1 if age<=60
replace age_3=1 if age>75
replace age_2=0 if age_1==1|age_3==1



/*论文第一部分*/
/*a01.是否就诊*/
xtlogit if_visit if_ill frailty_index insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings
/*b01.门诊费用支出*/
xtreg ln_total_cost01 reimbursment_rate01 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings,re r theta
/*b02.门诊次数*/

/*b03.住院医疗支出*/
xtreg ln_total_cost02 reimbursment_rate02 medical_facility_1 medical_facility_2 medical_facility_3 frailty_index insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings,re r theta
xtreg ln_total_cost02 reimbursment_rate02 frailty_index insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings,re r theta
/*b04.住院天数*/
/*b05.自我治疗支出*/
xtreg ln_total_cost03 reimbursment_rate03 frailty_index insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium child_N gender age edu_1 edu_2 edu_3 edu_4 marriage if_agri_work if_work lnincome lnsubsidy lnsavings,re r theta



est store m1
est store m2
est store m3
est store m4

outreg2 a01 using a01.doc, replace ctitle(a01)
outreg2 b01 using reg001.xls, append ctitle(b01) addtext(Country FE, YES)
xtreg y x1 x2 x3 i.year, fe robust
outreg2 using myreg.doc, append ctitle(Fixed Effects) keep(x1 x2 x3) addtext(Country FE, YES, Year FE, YES)


/*倾向匹配*/
set seed 10101
gen ranorder=runiform()
sort ranorder

psmatch2 income00 age gender edu_2 edu_3 hukou marriage child_N insurance_1 insurance_2 insurance_3 frailty_index,outcome( ln_total_cost01 ) n(4) ate logit common
pstest age gender edu_2 edu_3 hukou marriage child_N insurance_1 insurance_2 insurance_3 frailty_index,both graph
psgraph

set seed 10101
bootstrap r(att) r(atu) r(ate),reps(500):psmatch2 income00 age gender edu_2 edu_3 hukou marriage child_N insurance_1 insurance_2 insurance_3 frailty_index,outcome( ln_total_cost01 ) n(4) ate logit common


gen edu00=0
replace edu00=1 if edu_1==1
replace edu00=2 if edu_2==1
replace edu00=3 if edu_3==1
replace edu00=4 if edu_4==1

gen income00=.
replace income00=income if income>0
gen savings00=.
replace savings00=savings if savings>0

gen lnincome00=ln(income00)

gen income01=0
replace income01=1 if income00>5000
gen income02=0
replace income02=1 if income00>50000
replace income01=. if income00==.
replace income02=. if income00==.

gen savings01=0
replace savings01=1 if savings00>1000
gen savings02=0
replace savings02=1 if savings00>30000
replace savings01=. if savings00==.
replace savings02=. if savings00==.

gen income03=.
replace income03=1 if income00>50000
replace income03=0 if income00<=5000
replace income03=. if income00==.

gen savings03=.
replace savings03=1 if savings00>30000
replace savings03=0 if savings00<=1000
replace savings03=. if savings00==.

psmatch2 income01, outcome( ln_total_cost01 ) mahal(age gender edu00 hukou marriage child_N reimbursment_rate01 insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s insurance_premium frailty_index lnsavings lnsubsidy) n(4) ai(4) ate

bootstrap r(att)r(atu)r(ate),reps(500):
bootstrap r(att)r(atu)r(ate),reps(500):psmatch2 income01 age gender edu00 hukou marriage child_N insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium frailty_index lnsavings lnsubsidy ,outcome( ln_total_cost01 ) n(4) ate logit common


psmatch2 income01 ,outcome( ln_total_cost01 ) mahal(age gender edu00 hukou marriage child_N if_agri_work insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium frailty_index lnsubsidy lnsavings) n(5) ai(4) ate

/*income01 income02*/
nnmatch ln_total_cost01 income01 age gender edu00 hukou marriage child_N insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium frailty_index lnsavings lnsubsidy ,tc(att)m(6)robust(6)bias(bias)

nnmatch ln_total_cost01 income01 age gender edu00 hukou marriage child_N insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium frailty_index lnsubsidy ,tc(att)m(6)robust(6)bias(bias)
/*savings03*/
nnmatch ln_total_cost01 savings03 age gender edu00 hukou marriage child_N insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s lnpremium frailty_index lnincome lnsubsidy ,tc(att)m(6)robust(6)bias(bias)


gen f2= frailty_index* frailty_index
gen age_f= age* frailty_index
gen reimbursment_rate= reimbursment_rate01


xtlogit if_visit if_ill insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s frailty_index f2 age_f age gender marriage child_N edu_1 edu_2 edu_3 edu_4  if_agri_work if_work lnincome lnsubsidy lnsavings
xtreg ln_total_cost01 reimbursment_rate  insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s medical_facility_1 medical_facility_2 medical_facility_3 frailty_index f2 age_f age gender marriage child_N edu_1 edu_2 edu_3 edu_4  if_agri_work if_work lnincome lnsubsidy lnsavings ,re r theta


qreg2 ln_total_cost01 reimbursment_rate  insurance_1 insurance_2 insurance_3 insurance_4 insurance_5 insurance_s medical_facility_1 medical_facility_2 medical_facility_3 frailty_index f2 age_f age gender marriage child_N edu_1 edu_2 edu_3 edu_4  if_agri_work if_work lnincome lnsubsidy lnsavings ,cluster(id) q(.25)
outreg2 using statistic02.doc,replace sum(log)


replace medical_facility_1=. if reimbursment_rate01==.
replace medical_facility_2=. if reimbursment_rate01==.
replace medical_facility_3=. if reimbursment_rate01==.











gen  d = 1
bys householdID: egen x = total(d)


gen x=substr(ID,1,11)
gen y=substr(ID,12,12)
gen spouse_ID=x
replace spouse_ID=x+"2" if y=="1"
replace spouse_ID=x+"1" if y=="2"



bys  communityID: egen x = sum( total_cost01 )


















