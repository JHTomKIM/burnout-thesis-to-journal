# Burnout from Overwork: Job Disutility under Industrial Labor Shortage

This repository contains the LaTeX source files, data processing scripts, and analysis outputs for revising the master's thesis into a journal article.

## Project Structure

- `do/`  
    STATA scripts for data preparation, panel construction, and main analysis.
    
- `R/`  
    R scripts for table and figure generation.
    
- `tables/`  
    Exported tables (CSV/LaTeX) for integration into the article.

- `png/`  
    Figures used in the article.

- `data/`  
    - `raw/`: raw KLIPS data (not included due to data license).  
    - `processed/`: processed panel dataset (`individual_0926.dta`, not uploaded).

## Scripts

- `do/data_cleaning_analysis.do`: Full pipeline for data preparation, panel sampling, and variable construction.

- `R/plot_clustering_process.R`: Generate clustering process figures.

## Notes

- **Data License**: Raw KLIPS & OLFSE data and processed `.dta` files are not publicly available due to licensing restrictions. Scripts can be used to reproduce the panel dataset if the user has access to KLIPS data.

- *KLIPS* : https://www.kli.re.kr/board.es?mid=a40104000000&bid=0016&act=view&list_no=145316&tag=&nPage=1
- *OLFSE* : https://laborstat.moel.go.kr/hmp/tblInfo/TblInfoList.do?menuId=0010001100101102&leftMenuId=0010001100101&bbsId=

- **Weights**: Weight variables are included for consistency, but not used in the analysis.

## Revision History

- 2025-06-24: Initial version uploaded to GitHub.
- (Add revision notes here as needed)

---

