# Burnout from Overwork: Job Disutility under Industrial Labor Shortage

This repository contains the LaTeX source files, data processing scripts, and analysis outputs for revising the master's thesis into a journal article.

[Journal Submission Workflow (GitHub Project Board)](https://github.com/users/JHTomKIM/projects/1)

![Status](https://img.shields.io/badge/Status-Preparing%20for%20Submission-yellow)

## Project Structure

- `main.tex`, `reference.bib`  
    LaTeX source files for the manuscript.

- `do/`  
    STATA scripts for data preparation, panel construction, and main analysis.

- `R/`  
    R scripts for table and figure generation with clustering process.

- `data/`  
    Processed panel datasets (`.dta`) and aggregate OLFSE CSVs.  
    *(Raw KLIPS and OLFSE data not included due to license restrictions.)*

- `figure/`  
    Figures used in the article.

- `final_tables/`  
    Final CSV tables used in the article.

- `table_tex/`  
    Final LaTeX tables for direct inclusion via `\input{}` in `main.tex`.

- `raw_tables/`  
    Model estimation results (raw outputs for reproducibility).

## Scripts

- `do/data_cleaning_analysis.do`  
    Full pipeline for data preparation, panel sampling, and variable construction.

- `R/plot_clustering_process.R`  
    Generate clustering process and figures.

- `R/table_export.R`  
    Export LaTeX tables for the manuscript.

## Data License

- Raw KLIPS and OLFSE data and processed `.dta` files are not publicly available due to licensing restrictions.  
- Scripts can be used to reproduce the panel dataset if the user has access to KLIPS data.

- **KLIPS**: [https://www.kli.re.kr/board.es?mid=a40104000000&bid=0016&act=view&list_no=145316&tag=&nPage=1](https://www.kli.re.kr/board.es?mid=a40104000000&bid=0016&act=view&list_no=145316&tag=&nPage=1)

- **OLFSE**: [https://laborstat.moel.go.kr/hmp/tblInfo/TblInfoList.do?menuId=0010001100101102&leftMenuId=0010001100101&bbsId=](https://laborstat.moel.go.kr/hmp/tblInfo/TblInfoList.do?menuId=0010001100101102&leftMenuId=0010001100101&bbsId=)

## Notes

- **Weights**: Weight variables are included for consistency, but not used in the main analysis.
- Figures and tables are versioned for transparency and reproducibility.
- The repository follows best practices for reproducible research.

## Revision History

- 2025-06-24: Initial version uploaded to GitHub.
- (Add revision notes here as needed.)

---

