/*import data from CSV file called Surgery Timing.csv*/
proc import out=SurgeryTiming
	datafile="/home/u62189146/Biostatistics2/Surgery Timing.csv"
    dbms=csv
    replace;
    getnames=YES;
run;


/* Check if the month coded data work by printing the first 12 observations of the data*/
proc print data=SurgeryTiming (obs=10); run;


/* See the contents in the dataset*/
proc contents data=SurgeryTiming; run;

/*Creating table*/
proc format;
	value genderf 0 = "Female"
1 = "Male";
	value racef 1 = "Caucasian"
2 = " African American"
3 = "Other";
	value baseline_cancerf 0 = "No"
1 = "Yes";
	value baseline_cvdf 0 = "No"
1 = "Yes";
	value baseline_dementiaf 0 = "No"
1 = " Yes";
	value baseline_diabetesf 0 = "No"
1 = "Yes";
	value baseline_digestivef 0 = "No"
1 = "Yes";
	value baseline_osteoartf 0 = "No"
1 = "Yes";
	value baseline_psychf 0 = "No"
1 = "Yes";
	value baseline_pulmonaryf 0 = "No"
1 = "Yes";
	value complicationf 0 = "No" 
1 = "Yes";
PICTURE pctfmt (round) other = "009.9%";
run;

/*Another helpful step prior to creating Table 1 is relabeling the variable names to the words or phrases you
want displayed in the table.*/
data SurgeryTiming;
	set SurgeryTiming;
	label complication = "In-Hospital Complication";
	label gender = "Gender";
	label race = "Race";
	label age = "Age";
	label bmi = " Body Mass Index (kg/m2)";
	label baseline_cancer = " Cancer";
	label baseline_cvd = "Cardiovascular/Cerebrovascular Disease";
	label baseline_dementia = "Dementia";
	label baseline_diabetes = "Diabetes";
	label baseline_digestive = "Digestive Disease";
	label baseline_osteoart = "Osteoarthritis";
	label baseline_psych = "Psychiatric Disorder";
	label baseline_pulmonary = "Pulmonary Disease";
	label baseline_charlson = "Charlson Comorbidity Index";
run;

proc tabulate data = SurgeryTiming order=formatted;
	class gender race baseline_cancer baseline_cvd baseline_digestive baseline_diabetes baseline_dementia baseline_osteoart baseline_psych baseline_pulmonary complication /missing ; /*In the class format only include categorical variables*/
	classlev gender race baseline_cancer baseline_cvd baseline_digestive baseline_diabetes baseline_dementia baseline_osteoart baseline_psych baseline_pulmonary complication / style = [asis=on];
	var bmi age baseline_charlson; /*In the var only include continuous variables*/

table gender*(n="N" colpctn = "%"*f=pctfmt.)
race*(n="N" colpctn = "%"*f=pctfmt.)
age*(n mean std = "SD")
bmi*(n mean std = "SD") 
	/*bmi*(n median qrange = "IQR")*/
baseline_cancer*(n="N" colpctn = "%"*f=pctfmt.)
baseline_cvd*(n="N" colpctn = "%"*f=pctfmt.)  
baseline_dementia*(n="N" colpctn = "%"*f=pctfmt.) 
baseline_diabetes*(n="N" colpctn = "%"*f=pctfmt.) 
baseline_digestive*(n="N" colpctn = "%"*f=pctfmt.) 
baseline_osteoart*(n="N" colpctn = "%"*f=pctfmt.) 
baseline_psych*(n="N" colpctn = "%"*f=pctfmt.)
baseline_pulmonary*(n="N" colpctn = "%"*f=pctfmt.)
baseline_charlson*(n mean std = "SD"), 
	/*baseline_charlson*(n median qrange = "IQR")*/
(All complication) / misstext = "0"; /*All and complication contain the column of the table*/

FORMAT complication complicationf. gender genderf. race racef. baseline_cancer baseline_cancerf. baseline_cvd baseline_cvdf. baseline_dementia baseline_dementiaf. baseline_diabetes baseline_diabetesf. baseline_digestive baseline_digestivef. baseline_osteoart baseline_osteoartf. baseline_psych baseline_psychf. baseline_pulmonary baseline_pulmonaryf.;
run;

/* Recoding the 12 months into binary variables, "0" and "1"*/
/* might influence clinician performance that most new residents enter 
teaching hospitals in July and August. July and August="1" while the rest of the months="0"*/
data SurgeryTiming1;
	set SurgeryTiming;
	select (month);
	when (7) month1="1";
	when (8) month1="1";
	otherwise month1="0";
	end;
run;


/* Full model to answer the four research questions*/
/*1. What is the effect of time of day on surgical in-hospital complications?
2. What is the effect of day of week on surgical in-hospital complications?
3. What is the effect of month on surgical in-hospital complications?
4. What is the effect of phase of the moon on surgical in-hospital complications?*/
/* Assessing the model fit: Hosmer-Lemeshow Goodness of Fit Test*/
/* Complication as the outcome and hour, dow, month1, & moonphase as predictors*/
proc logistic data=SurgeryTiming1 plots(maxpoints=none);
	class dow(ref="1") month1(ref="0") / param=ref;
	model complication(event="1") = hour dow month1 moonphase / cl lackfit;
run;

/* Likelihood Ratio Test (LRT) on the full model*/
/* Conduct the overall test for multicategorical predictors using LRT*/
ods select modelfit ModelANOVA;
proc genmod data = SurgeryTiming1;
	class dow(ref="1") month1(ref="0") / param=ref;
	model complication(event="1") = hour dow month1 moonphase / type3;
run;

/* Plots:*/
/* Box plot complication vs. hour*/
proc sgplot data=SurgeryTiming1;
	vbox hour / group=complication;
	title "Effet of time of day on Surgical In-hospital Complications";
	keylegend/title = "In-Hospital Complication";
run;

/* Barplot: Effect of day of week on surgical in-hospital complications?*/
/* Do bar plot instead of boxplot or do a table between dow and complication. Do the same for month1 and moonphase*/
proc sgplot data=SurgeryTiming1;
	vbar dow / group=complication;
	title "Effect Day of Week on Surgical In-hospital Complications";
	xaxis label = "Day of Week";
	keylegend/title = "In-Hospital Complication";
run;

/* Bar plot: complication vs. month1*/
proc sgplot data=SurgeryTiming1;
	vbar month1 / group=complication;
	title "Effet of Month of Year on Surgical In-hospital Complications";
	xaxis label = "Month of Year";
	keylegend/title = "In-Hospital Complication";
run;

/* Bar plot: complication vs. moonphase*/
proc sgplot data=SurgeryTiming1;
	vbar moonphase / group=complication;
	title "Effect of Phase of Moon on surgical In-hospital Complications";
	xaxis label = "Phase of Moon";
	keylegend/title = "In-Hospital Complication";
run;
