# Temporal-Dynamics-of-Surgical-Risk-An-Analysis-of-Timing-and-Outcomes-in-Elective-Surgery-project
This study explores the impact of surgical timing on elective surgery outcomes by analyzing factors such as time of day, week, month, and moon phases using SAS on the Survey Timing Study dataset, a retrospective cohort analysis.

# Project Summary: Temporal Dynamics of Surgical Risk: An Analysis of Timing and Outcomes in Elective Surgery using the Survey Timing Study dataset

### Overview

This solo project examines the impact of temporal factors on the outcomes of elective general surgeries. Utilizing a retrospective cohort study design, we explored how the timing of surgeries — including time of day, day of the week, month, and moon phases — affects in-hospital complications. The study was conducted as part of a Biostatistics II course at the University of Minnesota School of Public Health, utilizing SAS for comprehensive data analysis.

### Data

The dataset, Surgery_Timing.csv, included 32,001 observations across 25 variables. We enhanced the dataset by creating a binary variable to indicate surgeries performed during July and August, facilitating a focused analysis of these months compared to others due to the influx of new residents during this period.

### Analytical Approach

Using logistic regression, we investigated the relationships between surgical timings and in-hospital complications. The model adjusted for multiple covariates, with robust statistical tests such as the Hosmer-Lemeshow Goodness of Fit and Likelihood Ratio Tests ensuring model accuracy and reliability.

# Study Results/Findings after Data Analysis

### Introduction: 

The Surgery Timing study is a retrospective cohort study that examined the effects of time-related factors on the outcomes of elective general surgery patients. We explored the Surgery Timing dataset to answer the following research questions.

### Research Questions

1. What is the effect of time of day on surgical in-hospital complications?
   
3. What is the effect of day of week on surgical in-hospital complications?
   
5. What is the effect of the month on surgical in-hospital complications?
   
7. What is the effect of the phase of the moon on surgical in-hospital complications?
   
### Dataset: 

The data Survey_Timing.csv was provided by the instructor. It contained 32,001 observations and 25 variables. We created a new variable called month1 from the month of the year (month) variable to better analyze the results. The variable month of the year (month) which is a categorical variable (January to December) was coded into a binary variable taking July and August as “1” and the rest of the month as “0”. After creating month1 variable, we have 26 variables in the dataset: 30-day mortality, in-hospital complications, moon phase, month of the year, hour, age, gender, race, BMI, comorbidities, surgical risk indices, surgical timing predictors, and outcomes. We have the following missing frequencies in the dataset: gender = 3, race = 480, age = 2, and BMI = 3,290.

### Exploratory Data Analysis: 

Table 1 contains the demographic and baseline characteristics of the study population. The study had 17,230 (53.8%) female participants and 14,768 (46.1%) male participants, with 3 missing frequencies for gender. The overall rate of in-hospital complications was 13.3%. There was no meaningful difference in the rate of complications by gender, with females having 50.9% and males having 49.1% of the complications. Caucasians comprise 83.0%, African Americans comprise 11.2%, and others comprise 4.1% of the complications. Figures 1-4 gave a visual representation of the research questions. The patients who had complications were significantly older than those who did not, with a mean age of 59.79 years for complications and 57.33 years for no complications. There was no meaningful difference in the mean BMI of patients who had
complications and those who did not, with both groups having a mean BMI of around 29.4 kg/m2. The patients who had complications had more comorbidities than those who did not, as indicated by the higher mean Charlson Comorbidity Index of 1.59 for complications and 1.12 for no complications. The most common comorbidities among the patients who had complications were cardiovascular/cerebrovascular disease (54.5%), cancer (39.2%), and osteoarthritis (11.3%). The patients who had complications were more likely to have these comorbidities than those who did not.

### Methods: 

To answer the research questions, we created a binary variable month1 (July and August = “1” and Otherwise = “0”) from the categorical variables month (Month of Year). This helped us understand and analyze the research questions. Creating this new variable, month1 helped us avoid the interpretation of the variable month as a"1-unit" making 1-day separated by a 1-unit increase since we have twelve months in the year. This was a technical and statistical decision made. We could have left the month variable as it was in the dataset, and there would have been no issue with the interpretation of the results. The other multi-categorical variables, moonphase, and dow were left as they were given because the categoricals for each predictor were less than six making it easy to interpret. We used a single full logistic regression model to answer the four research questions and for the diagnostic and model fit test, Hosmer-Lemeshow Goodness of Fit Test. We did not include or adjust for any variable other than the four predictor variables of
interest.

**Model:** 

Complication as the outcome and hour, dow, month1, and moonphas as predictors. Using a full model helped us understand the behavior of each predictor variable in the model holding other variables constant. We
used the Likelihood Ratio Test to conduct the overall test for multicategorical predictors in our model and to determine if the multi-category predictor variables were significant. To test for the Likelihood Ratio Test, we used a procedure called *proc genmod*. This gave us the **“LR Statistics For Type 3 Analysis” table**, which can be seen in Table 3. We also created four plots to visualize the behavior of the four research questions. All analyses were performed using *SAS® Studio*.

### Interpretation of the Findings/Results: 

Keeping all other variables constant, the effect of time of day on surgical in-hospital complications is positive and significant (p-value = 0.0006) with a coefficient of 0.0193. This means that the later the surgery is performed, the higher the probability of having a complication. The odds ratio estimate for hour is 1.020, which implies that for each hour increase, the odds of complication increase by 2% (95% CI: 0.00833, 0.0303). For example, if the odds of complication at 8 a.m. are 0.1, then the odds of complication at 9 a.m. are 0.102, and the odds of complication at 10 a.m. are 0.104. This suggests that surgeries
performed later in the day have a higher risk of complication than surgeries performed earlier in the day.

The effect of day of week on surgical in-hospital complications is measured by the dow covariate in the logistic model. Keeping all other variables constant, the day of week has a significant effect on the probability of complication, with a p-value of <0.0001 and different odds ratios for different levels of dow. This means that the odds of complication vary depending on the day of the week that the surgery is performed. For example, the odds of complication are 12% lower for surgeries performed on Tuesday (with a coefficient of -0.1250) compared to Monday, and 15% higher for surgeries performed on Wednesday compared to Monday. The other days of the week have no significant difference from Monday in terms of complication risk. This suggests that there is some variation in the quality or safety of surgical care across different days of the week. Keeping all other variables constant, the month1 covariate has no significant effect on the probability of complication with a coefficient of 0.0531, a p-value of 0.2179, and an odds ratio of 1.054. The 95% confidence interval for the odds ratio (0.969, 1.147). This means that the odds of complication are not different for surgeries performed in January compared to other months.
This suggests that there is no seasonal variation in the risk of complication.

Keeping all other variables constant, the moonphase covariate has no significant effect on the probability of complication, with a coefficient of -0.00974, a p-value of 0.5100, an odds ratio of 0.990, and a 95% confidence interval of (0.962, 1.019). This means that the odds of complication are not different for surgeries performed during different phases of the moon. This suggests that there is no lunar influence on the risk of complication. The Hosmer-Lemeshow test tests the goodness-of-fit of the model. We fail to reject the null hypothesis that the model fits the data well, with a chi-square statistic of 11.0585 and a p-value of 0.1984, which suggests that the model fits the data adequately. The *c-statistic* is 0.533, which indicates a moderate predictive ability of the model. The residual plots show no obvious patterns
or outliers that indicate model misspecification or influential observations. Based on the **Likelihood Ratio Test in Table 3** for the overall test of effect for multicategorical predictors, hour is statistically significant at the 0.05 level, with a p-value of 0.0006 and Chi-Square of 11.86. This means that there is strong evidence that the response variable depends on the hour of the day, after adjusting for the other predictors. The predictor dow is also statistically significant at the 0.05 level, with a p-value of <.0001 and a Chi-Square of 31.39. However, month1 (p-value = 0.2168, Chi-Square = 1.53) and moonphase (p-value = 0.5080, Chi-Square = 0.44) are not significant predictors, as their p-values are greater than 0.05. This means that the outcome variable does not depend on the month or the moon phase.

**Time of Day:** Later surgeries were associated with a higher risk of complications. For each hour delay, the odds of complications increased by 2%.

**Day of the Week:** Significant variations in complications were observed depending on the day of the surgery. For instance, surgeries on Wednesdays had a 15% higher risk compared to Mondays.

**Month and Moon Phase:** Neither the month of the year nor the lunar phase showed a significant impact on surgical outcomes, indicating no seasonal or lunar effect on complication rates.

### Tools Used

**SAS Software:** Data manipulation, statistical modeling, and visualization.

**Visual Representation:** Box plots and bar charts to analyze the relationship between timing and surgical complications.

### Implications

This project highlights the importance of considering surgical timing in hospital operations management and potentially guiding policies to mitigate risks associated with elective surgeries.

### Repository & Contribution

The complete SAS code and dataset are available for further exploration and development on GitHub. Interested parties can contribute to refining the analysis or extending the study to include additional variables.
