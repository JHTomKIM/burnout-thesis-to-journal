library(knitr)
library(kableExtra)
library(readr)
library(dplyr)

# Set WD

setwd("C:/Users/joong/OneDrive/문서/GitHub/burnout-thesis-to-journal")

path1 <- read_csv("final_tables/History of working hour regulations.csv", col_names = TRUE, show_col_types = FALSE) # Table 1
ksic <- read_csv("final_tables/KSIC.csv", col_names = TRUE, show_col_types = FALSE) # Table 2
su_demo1 <- read_csv("final_tables/su_demo1.csv") # Table 3
su_work1 <- read_csv("final_tables/su_work1.csv") # Table 4
su_work3 <- read_csv("final_tables/working hour distribution.csv") # Table 5
su_desc1 <- read_csv("final_tables/su_desc1.csv") # Table 6
su_cluster <-read_csv("final_tables/cluster_work.csv") # Table 7
est00 <- read_csv("final_tables/est00.csv") # Eq.4.1 (Table 8)
est_cl <- read_csv("final_tables/est_cl.csv") # Eq. 4.2 (Table 9)
est_cl_00 <- read_csv("final_tables/est_cl_00.csv") # Eq 4.3 (Table 10)
est0 <- read_csv("final_tables/est0.csv") # Eq 4.4 & 4.5 (Table 11)
est5 <- read_csv("final_tables/est5.csv") # Eq 4.6 (Table 12)
iv_result <- read_csv("final_tables/iv_result.csv") # Eq 4.7 & 4.8  (Table 13)
variable <-read_csv("final_tables/variable.csv") # Table A1
su_desc2 <- read_csv("final_tables/su_desc2.csv") # Table A2
su_js1 <- read_csv("final_tables/summary_js.csv") # Table A3
est3 <- read_csv("final_tables/est3.csv") # Eq 4.4a (Table A4)
est2 <- read_csv("final_tables/est2.csv") # Eq 4.5a (Table A5)

path1[is.na(path1)] <- ""

note_col_index <- which(names(path1) == "Note")

path1 %>%
  kable("latex", booktabs = TRUE, caption = "History of Working Hours Regulations in Korea",
        align = c("c", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("hold_position", "bordered"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("This table summarizes the key legislative changes on working hours reform (Lee, 2018).", "The reform in 2003 gradually implemented from 2004 to 2008, starting with large firms and yearly expanding to smaller businesses. Additionally, gradual implementation toward enterprises with less than 20 emplyees was postponed until 2011 while leaving an autority for presidential decree."), threeparttable = TRUE) %>%
  kable_classic() %>%
  save_kable("table_tex/Table1.tex")

ksic[is.na(ksic)] <- ""

ksic %>%
  kable("latex", booktabs = TRUE, caption = "List of Industries with KSIC",
        align = c("c", "c", "l"), longtable = TRUE) %>%
  kable_styling(latex_options = c("hold_position", "bordered", "scale_down", "striped"), font_size = 11, full_width = FALSE) %>%
  column_spec(3, width = "10cm", latex_valign = "m") %>%
  footnote(number = c("Categories of industries follow Korean Standard Industrial Classification (KSIC-11), sorted as the largest groups of industrial activities with identical or similar economic characteristics."), threeparttable = TRUE) %>%
  kable_classic() %>%
  save_kable("table_tex/Table2.tex")

su_demo1[is.na(su_demo1)] <- ""

su_demo1 %>%
  kable("latex", booktabs = TRUE, caption = "Summary Statistics of Demographic Characteristics",
        align = c("l", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = "Standard deviations in brakets.", threeparttable = TRUE) %>%
  row_spec(12, extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table3.tex")

su_work1[is.na(su_work1)] <- ""

su_work1 %>%
  kable("latex", booktabs = TRUE, caption = "Summary Statistics of Labor Characteristics",
        align = c("l", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("Standard deviations in brakets.", "Level of job satisfaction is calculated as an average value of 5 domains in job satisfaction. Detailed information is provided in Appendix (see Table A3."), threeparttable = TRUE) %>%
  row_spec(c(1,3,4,10,11,15,16,28), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table4.tex")

su_work3[is.na(su_work3)] <- ""

su_work3 %>%
  kable("latex", booktabs = TRUE, caption = "Descriptive Statistics of Working Schedules",
        align = c("l", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("Standard deviations in brakets.", "Percentage by column variable in parentheses"), threeparttable = TRUE) %>%
  row_spec(c(21), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table5.tex")

su_desc1[is.na(su_desc1)] <- ""

su_desc1 %>%
  kable("latex", booktabs = TRUE, caption = "Descriptive Statistics of Working Environment",
        align = c("l", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = "Percentage by column variable in brakets.", threeparttable = TRUE) %>%
  row_spec(c(1,7,8,18,19,25), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table6.tex")

su_cluster[is.na(su_cluster)] <- ""

su_cluster %>%
  kable("latex", booktabs = TRUE, caption = "Overtime Worker and Working Hour Distribution by Cluster",
        align = c("l", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered"), font_size = 11, full_width = FALSE) %>%
  footnote(number = "Standard deviations in brakets. The number below each cell indicates the frequency (sample size) of the respective subgroup.", threeparttable = TRUE) %>%
  row_spec(c(12), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table7.tex")

est00[is.na(est00)] <- ""

est00 %>%
  kable("latex", booktabs = TRUE, caption = "Effects of Industrial Labor Shortage on Working Hour Decisions (Equation 4.1)",
        align = c("l", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("Robust standard errors clustered at the individual level are reported in parentheses.", "All models control for industry, job skill level, firm size, and region.","Each column corresponds to a different dependent variable: (1) weekly working hours, (2) average daily working hours, (3) working days per week, and (4) binary indicator of overtime participation (Linear Probability Model).","F-statistics refer to robust Wald tests clustered at the individual level.", "Labor shortage rates are measured as percentages ranging from 0 to 100.", "* p<0.05, ** p<0.01, *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,3,4,28), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table8.tex")

est_cl[is.na(est_cl)] <- ""

est_cl %>%
  kable("latex", booktabs = TRUE, caption = "Effects of Labor Shortage Cluster Group on Working Hour Decisions (Equation 4.2)",
        align = c("l", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 10.5, full_width = FALSE) %>%
  footnote(number = c("Robust standard errors clustered at the individual level are reported in parentheses.", "All models control for industry, job skill level, firm size, and region.","Each column corresponds to a different dependent variable: (1) weekly working hours, (2) average daily working hours, (3) working days per week, and (4) binary indicator of overtime participation (Linear Probability Model).","F-statistics refer to robust Wald tests clustered at the individual level.", "* p<0.05, ** p<0.01, *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,2,8,9,33), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table9.tex")

est_cl_00[is.na(est_cl_00)] <- ""

est_cl_00 %>%
  kable("latex", booktabs = TRUE, caption = "Effects of Labor Shortage Cluster Group on Working Hour Decisions (Equation 4.3)",
        align = c("l", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("Robust standard errors clustered at the individual level are reported in parentheses.", "All models control for industry, job skill level, firm size, and region.","Each column corresponds to a different dependent variable: (1) weekly working hours, (2) average daily working hours, (3) working days per week, and (4) binary indicator of overtime participation (Linear Probability Model).","F-statistics refer to robust Wald tests clustered at the individual level.", "* p<0.05, ** p<0.01, *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,2,10,11,35), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table10.tex")

est0[is.na(est0)] <- ""

est0 %>%
  kable("latex", booktabs = TRUE, caption = "Relationship between Weekly Working Hours and Job Satisfaction (Equation 4.4 and 4.5)",
        align = c("l", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("All coefficients are expressed in log-odds. Standard errors clustered at the individual level are reported in parentheses.", "Expanded through BUC-OLOGIT estimation (Baetschmann et al., 2020).", "Observations with multiple positive outcomes within groups are excluded due to identification constraints.", "All models control for industry, occupational category, firm region, and firm size.", "* p<0.05, ** p<0.01,  *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,7,8,30), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table11.tex")

est5[is.na(est5)] <- ""

est5 %>%
  kable("latex", booktabs = TRUE, caption = "Preliminary Test on Exclusion Restriction (Equation 4.6)",
        align = c("l", "c", "c", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number =  c("All coefficients are expressed in log-odds. Standard errors clustered at the individual level are reported in parentheses.", "Expanded through BUC-OLOGIT estimation (Baetschmann et al., 2020).", "Observations with multiple positive outcomes within groups are excluded due to identification constraints.", "All models control for industry, occupational category, firm region, and firm size.", "* p<0.05, ** p<0.01,  *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,2,10,11,33,36), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table12.tex")

iv_result[is.na(iv_result)] <- ""

iv_result %>%
  kable("latex", booktabs = TRUE, caption = "2SPS-IV Estimates of Overtime Effects on Job Satisfaction (Equation 4.7 and 4.8)",
        align = c("l", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered","scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number =  c("All coefficients are expressed in log-odds. Standard errors clustered at the individual level are reported in parentheses.", "Expanded through BUC-OLOGIT estimation (Baetschmann et al., 2020).", "Observations with multiple positive outcomes within groups are excluded due to identification constraints.", "All models control for industry, occupational category, firm region, and firm size.", "* p<0.05, ** p<0.01,  *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,7,8,30), extra_latex_after = "\\hline") %>%
  kable_classic_2() %>%
  save_kable("table_tex/Table13.tex")

variable[is.na(variable)] <- ""

variable %>%
  kable("latex", booktabs = TRUE, caption = "Definition of Variables (KLIPS)",
        align = c("l", "l", "l"), longtable = TRUE) %>%
  kable_styling(latex_options = c("hold_position", "bordered", "scale_down","landscape", "repeat_header","striped"), font_size = 11, full_width = FALSE) %>%
  column_spec(3, width = "12.5cm", latex_valign = "m") %>%
  row_spec(c(1,2,3), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  footnote(number = "In the description column, the code of original variables from raw data below each cell is inscribed to specify how variables are defined in this study.", threeparttable = TRUE) %>%
  kable_classic_2() %>%
  landscape() %>%
  save_kable("table_tex/TableA1.tex")

su_desc2[is.na(su_desc2)] <- ""

su_desc2 %>%
  kable("latex", booktabs = TRUE, caption = "Descriptive Statistics of Labor Shortage Rate",
        align = c("l", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c", "c","c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down", "landscape"), font_size = 11, full_width = FALSE) %>%
  footnote(number = c("Standard deviation is in brackets.", "Average value in labor shortage rate is calculated as national level by industries from 2009 to 2023.", "Descriptive results is from the information seprately calculated by industries, province level and size of firm."), threeparttable = TRUE) %>%
  row_spec(c(2,3,13,14), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  landscape() %>%
  save_kable("table_tex/TableA2.tex")

su_js1[is.na(su_js1)] <- ""

su_js1 %>%
  kable("latex", booktabs = TRUE, caption = "Summary Statistics on Each Domain of Job Satisfaction",
        align = c("l", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 11, full_width = FALSE) %>%
  footnote(number = "Standard deviations in brakets.", threeparttable = TRUE) %>%
  row_spec(c(2,12), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/TableA3.tex")

est3[is.na(est3)] <- ""

est3 %>%
  kable("latex", booktabs = TRUE, caption = "Decomposition of Working Hours into Daily Hours and Workdays (Equation 4.4a)",
        align = c("l", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered", "scale_down"), font_size = 10.5, full_width = FALSE) %>%
  footnote(number = c("All coefficients are expressed in log-odds. Standard errors clustered at the individual level are reported in parentheses.", "Expanded through BUC-OLOGIT estimation (Baetschmann et al., 2020).", "Observations with multiple positive outcomes within groups are excluded due to identification constraints.", "All models control for industry, occupational category, firm region, and firm size.", "* p<0.05, ** p<0.01,  *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,9,10,32), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/TableA4.tex")

est2[is.na(est2)] <- ""

est2 %>%
  kable("latex", booktabs = TRUE, caption = "Decomposition of Working Hours into Daily Hours and Workdays (Equation 4.5a)",
        align = c("l", "c", "c", "c", "c"), longtable = FALSE) %>%
  kable_styling(latex_options = c("repeat_header", "hold_position", "bordered","scale_down"), font_size = 10, full_width = FALSE) %>%
  footnote(number =  c("All coefficients are expressed in log-odds. Standard errors clustered at the individual level are reported in parentheses.", "Expanded through BUC-OLOGIT estimation (Baetschmann et al., 2020).", "Observations with multiple positive outcomes within groups are excluded due to identification constraints.", "All models control for industry, occupational category, firm region, and firm size.", "* p<0.05, ** p<0.01,  *** p<0.001"), threeparttable = TRUE) %>%
  row_spec(c(1,13,14,36), extra_latex_after = "\\hline\\noalign{\\vskip -0.1ex}") %>%
  kable_classic_2() %>%
  save_kable("table_tex/TableA5.tex")
