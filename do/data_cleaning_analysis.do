
***************************************************
* Burnout from Overwork: 
* Job Disutility under Industrial Labor Shortage 
* Thesis ver. - Main Analysis Script
* Author: Joonghoe Kim
* Last updated: 2025-06-24
***************************************************

* Description:
* - Load cleaned data
* - Run main regressions (Eq. 4.1 - 4.8)
* - Generate tables and figures
* - Save output for LaTeX integration
***************************************************

clear

* Set project directory
* (User should modify this path according to their local machine)

* cd "C:\your\local\path\to\project"

cd "D:\THESIS\Impact of working hours on burn-out syndrome\Data set"

// 샘플링 (한국노동패널 KLIPS 개인-가구-직업력 조사 merge) => 16개년도 임금노동자

// 개인용 자료 12~26차년도 merge [직업력 조사와 중첩되지 않는 공통 설문(전체 + 취업자 공통)]

// merge를 원하는 개인용 자료 변수의 끝 4자리 중 조사 시점 현재를 보고한 변수 (통합코드북 참조)

// [개인 인적사항, 경제활동 상태, 고용안정성, 근무시간 결정방법 및 직장 내 전일제 대비 근로시간, 근로시간 단축 영향, 기본급 및 상여금, 사회보험 수급, 복리후생 여부, 조직몰입도, 직무만족도, 혼인 상태, 건강상태, 생활만족도, 사회적 지위 및 가족 관련 변수, 성장환경(신규 조사자), 출산 경험, 키+몸무게, 종사상 지위 및 소유업장 여부]

// [개인 인적사항: 0101~0111, 0121, 경제활동 상태: 0201~0212, 취업 시기: 0301~0303, 고용안정성: 0601~0616, 근로시간: 1002~1003, 1006~1007, 1011~1013, 1015~1019 근무시간 결정방법 및 직장 내 전일제 대비 근로시간: 1155~1156, 근로시간 단축 영향: 1201~1224, 사회보험 수급: 2141~2190, 복리후생 여부 4101~4171, 조직몰입도: 4201~ 4205, 직무만족도: 4301~4322, 혼인 상태: 5501~5518, 건강상태 6101~6103, 생활만족도 6501~6508]

**************************************************************
// p**1003 : 정규근로시간 여부
// p**1006 : 주당 정규 근로시간
// p**1007 : 주당 정규 근로일수

// p**1004 : 주당 평균근로시간 (정규 근로시간이 없는 경우)
// p**1005 : 주당 평균근로일수 (정규 근로시간이 없는 경우)

// p**1011 : 초과근로여부
// p**1012 : 일주일 또는 월평균 초과근로시간
// p**1013 : 월간 또는 주당 초과근로일수
// p**1019 : 초과근로시간 구분(1=일주일평균,2=월평균)

// p**1015 : (주된일자리)초과근로수당 지급여부
// p**1018 : (주된일자리)월평균 초과근로수당(만)

** A.5. 기업-작업장 규모 및 형태 구분 **

/**기업규모(fsize)**/

// (참고) 기업형태가 정부기관인 경우(p**0211=5)는 missing이므로 주의

// jobtype: 일자리형태(1:임금근로자,2:비임금근로자)
// p**0402: 전체종업원수(명)
// p**0403: 전체종웝원수(범주)
// p**0404: 기업형태

** A.6. 비정규직/정규직 구분 **

// p**0501: 근로계약기간 유무 (1=정해져 있다)

/*비기간제 근로자 (foe112)*/ 

// 근로계약기간을 정하지는 않았으나 계약을 반복 갱신해서 일할 수 있는 근로자 또는 비자발적 사유로 계속 근무를 기대할 수 없는 근로자

// p**0501: 근로계약기간 유무 (2=정해져 있지 않다)
// p**0601: 고용안정성 (2=아니요)
// p**0602: 고용 안정성 이유 (2=계약의 반복,갱신으로 고용이 지속되고 있으므로)
// p**0605: 고용불안정 이유

/** 경활 **/

// p**0314

/**시간제근로자 (foe12)**/ 

// 근로시간이 짧은 파트타임 근로자

// p**0315: 근로시간형태(시간제/전일제)

/*파견근로자 (foe131)*/ 

// 임금을 지급하고 고용관계가 유지되는 고용주와 업무지시를 하는 사용자가 일치히자 않는 경우로 파견사업주가 근로자를 고용한 후 그 고용관계를 유지하면서 근로자 파견계약의 내용에 따라 사용사업주의 사업장에서 지휘, 명령을 받아 사용사업주를 위하여 근무하는 형태

// p**0611: 파견 및 용역근로여부 (2=파견업체) 

/*가정내근로자 (foe134)*/ 

// 재택근무, 가내하청 등과 같이 사업체에서 마련해 주 공동작업장이 아닌 강정내에서 근무가 이루어지는 근무형태

* p**0613: 가내근로여부

/*일일(단기)근로자 (foe135)*/

// 근로계약을 정하지 않고, 일거리가 생겼을 경우 며칠 또는 몇 주씩 일하는 형태의 근로자

// p**0508: 불규칙적 일자리

** A.9. 업종별/직종별 변수를  구간 변수로 변환 후 더미변수화 - 제10차 한국표준산업분류(2017) + 제 7차 직업분류(2017) **
* p**0341: 제9차 한국표준산업분류(2017)
* p**0342: 제10차 한국표준산업분류(2017)
* p**0352: 제 7차 직업분류(2017)

** p_1642 임금 (wage)
** 임금 결정~임금지급 (1601~1621)

** A.12. 4대 보험 가입 여부 **

* p**2101
* p**2103
* p**2104
* p**2105

// 경제활동 상태

// p**2801: 지난 1주일간 구직여부
// p**2802: 지난 1개월간 구직여부
// p**2806: 취업가증성여부

** B.1.1. 조직 몰입도 **

// p_4201 : 지금 근무하고 있는 직장(일자리)은 다닐만한 좋은 직장이다
// p_4202 : 나는 이 직장(일자리)에 들어온 것을 기쁘게 생각한다
// p_4203 : 직장(일자리)을 찾고 있는 친구가 있으면 나는 이 직장을 추천하고 싶다
// p_4204 : 나는 내가 다니고 있는 직장(일자리)을 다른 사람들에게 자랑할수있다
// p_4205 : 별 다른 일이 없는 한 이 직장(일자리)을 계속 다니고 싶다

** 노조

//2501 2504

** 복리후생

** 건강상태 및 기저질환

** 면접월일
//9501 9502

************************************************************************************
* Section 1: Data preparation and panel sampling
* - Convert individual-level and household-level cross-sectional data to panel format (KLIPS 09-26)
* - Apply sample selection criteria
* - Prepare analysis dataset
************************************************************************************

* 1.1 : Individual data preparation

// Set panel variable list

local pvar "0101 0102 0103 0104 0105 0106 0107 0108 0109 0110 0111 0112 0113 0114 0121 0201 0202 0203 0204 0205 0206 0211 0212 0301 0302 0303 0311 0314 0315 0341 0342 0352 0401 0601 0402 0403 0404 0501 0508 0601 0602 0603 0604 0605 0611 0612 0613 0616 0613 0614 0615 1002 1003 1004 1005 1006 1007 1011 1012 1013 1015 1018 1019 1151 1152 1153 1154 1155 1156 1201 1211 1212 1213 1214 1215 1221 1222 1223 1224 1601 1602 1603 1604 1605 1606 1607 1608 1609 1610 1611 1612 1613 1614 1615 1616 1617 1621 1642 2101 2102 2103 2104 2105 2141 2142 2143 2151 2152 2153 2154 2155 2156 2157 2158 2159 2160 2161 2162 2163 2164 2165 2166 2167 2168 2169 2170 2171 2172 2173 2174 2175 2176 2177 2178 2179 2180 2181 2182 2183 2184 2185 2186 2187 2188 2189 2501 2504 2190 2801 2802 2806 4101 4102 4103 4104 4105 4106 4107 4108 4109 4110 4111 4112 4113 4114 4115 4116 4167 4168 4170 4171 4121 4122 4123 4124 4131 4133 4135 4137 4139 4141 4143 4145 4147 4149 4151 4153 4101 4102 4103 4104 4105 4201 4202 4203 4204 4205 4301 4302 4303 4304 4305 4311 4312 4313 4314 4315 4316 4317 4318 4319 4321 4322 5501 5502 5503 5504 5505 5506 5507 5508 5509 5510 5511 5512 5513 5514 5515 5516 5517 5518 6101 6102 6103 6104 6105 6106 6107 6108 6109 6501 6502 6503 6504 6505 6506 6507 6508 9501 9502"

// Loop over KLIPS waves (09~26)

foreach i in 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 {
	use klips`i'p, clear 
	
	/// p**0101 --> p_0101 
	foreach n of local pvar {
	
		cap noisily rename p`i'`n' p_`n' 
		cap noisily replace p_`n' = . if p_`n' == -1 
		}	
		
	// Add wave and year variables
	
	gen pwave_obs = `i'
	lab var pwave_obs "Survey wave"
	
	gen year = `i'+1997
	lab var year "Survey year"	
	
	// Household ID
	
	gen hhid = hhid`i'
	lab var hhid "Household ID"

	if `i'== 01 {
		gen wp_l=.
		gen wp_c=.
		replace wp_l = w`i'p
		replace wp_c = w`i'p
		}
		
	else {
		rename w`i'p_l wp_l
		rename w`i'p_c wp_c
		}
		
		// Apply weights (wave-specific), included for consistency, not used in analysis
		
		label var wp_l "Longitudinal weight (98 cohort)"
		label var wp_c "Cross-sectional weight (98 cohort)"
		
	if `i'== 12 {
		gen swp_l=.
		gen swp_c=.
		replace swp_l = sw`i'p
		replace swp_c = sw`i'p
		}
		
	else if `i'== 13 | `i'== 14 | `i'== 15 | `i'== 16 | `i'== 17 | `i'== 18 | `i'== 19 | `i'== 20 | `i'== 21 | `i'== 22 | `i'== 23 | `i'== 24 | `i'== 25 | `i'== 26 {
		rename sw`i'p_l swp_l
		rename sw`i'p_c swp_c
		}
	
	else {
		gen swp_l=.
		gen swp_c=.
		}
		
		label var swp_l "Longitudinal weight (09 integrated sample)"
		label var swp_c "Cross-sectional weight (09 integrated sample)"
	
	if `i'== 21 {
		gen nwp_l=.
		gen nwp_c=.
		replace nwp_l = nw`i'p
		replace nwp_c = nw`i'p
		}
		
	else if `i'== 22 | `i'== 23 | `i'== 24 | `i'== 25 | `i'== 26 {
		rename nw`i'p_l nwp_l
		rename nw`i'p_c nwp_c
		}
	
	else {
		gen nwp_l=.
		gen nwp_c=.
		}
		
		label var nwp_l "Longitudinal weight (18 integrated sample)"
		label var nwp_c "Cross-sectional weight (18 integrated sample)"
		
		
	/*Original household indicator (included for consistency, not used in analysis) */ 
	
	// sample09 variable is not available in waves 09 to 11
	if  `i'== 09 | `i'== 10 | `i'== 11 {	
		gen sample09 =.
		lab var sample09 "Original household indicator (09 integrated sample)"
		}
	
	// sample18 variable is not available in waves 06 to 20 	
	if `i'==05 | `i'== 06 | `i'== 07 | `i'== 08 | `i'== 09 | `i'== 10 | `i'== 11 | `i'== 12 | `i'== 13 | `i'== 14 | `i'== 15 | `i'== 16 | `i'== 17 | `i'== 18 | `i'== 19 | `i'== 20 {	
		gen sample18 =.
		lab var sample18 "Original household indicator (18 integrated sample)"
		}
			
	keep pid hhid year pwave_obs sample98 sample09 sample18 jobclass jobnum jobtype p_* wp_l wp_c swp_l swp_c nwp_l nwp_c
	
	save p`i'_time, replace 
	}
	
// Merge all waves into panel dataset (Individual)
	
clear

// Load first wave (wave 09)
use p09_time

// Append subsequent waves
append using p10_time p11_time p12_time p13_time p14_time p15_time p16_time p17_time p18_time p19_time p20_time p21_time p22_time p23_time p24_time p25_time p26_time

// Order variables: place p_* variables in numerical order
order p_*, sequential

// Move key variables to the front
order pid hhid year pwave_obs sample09 jobclass jobnum jobtype

// Sort observations by individual ID and year
sort pid hhid year

// Save final panel dataset
save individual_0926, replace

clear

// merge를 원하는 가구용 자료 변수의 끝 4자리 중 조사 시점 현재를 보고한 변수 (통합코드북 참조)

//가구 및 가구원 정보(15세 미만 가구원 정보), 원가구원 여부, 주거 관련 정보, 자녀교육, 보호대상 가구 여부, 지난 한 달 가구 월 소득, 자산 및 부채, 가계 경제상태, 면접관련 문항

// [가구원 수 및 정보(소멸, 분가, 합가 등): 0150~0178, 09 표본 원가구원 여부: 4201~4215, 가구원 생년월일 및 성별 + 가구주와의 관계(15세 미만의 경우 pid 없음!): 0241~0375, 동거 정보 및 추가, 사망, 분가 정보: 0381~0635, 주거 관련: 1401~1416, 자녀교육: 1501~2061, 보호대상 가구 여부: 2171~2176, 지난 한 달 가구 월 소득: 2201~2212, 자산 및 부채: 2501~2662 (*자동차 구매 정보의 경우 갚아야할 잔액과 원리금 제외하고 작년 기준이므로 제외), 가계 경제상태: 2705~2718]

* 1.2 : Household data preparation

// Set panel variable list

local hvar "0150 0151 0152 0153 0154 0155 0171 0172 0173 0174 0175 0176 0177 0178 4201 4202 4203 4204 4205 4206 4207 4208 4209 4210 4211 4212 4213 4214 4215 0241 0242 0243 0244 0245 0246 0247 0248 0249 0250 0251 0252 0253 0254 0255 0261 0262 0263 0264 0265 0266 0267 0268 0269 0270 0271 0272 0273 0274 0275 0281 0282 0283 0284 0285 0286 0287 0288 0289 0290 0291 0292 0293 0294 0295 0301 0302 0303 0304 0305 0306 0307 0308 0309 0310 0311 0312 0313 0314 0315 0321 0322 0323 0324 0325 0326 0327 0328 0329 0330 0331 0332 0333 0334 0335 0341 0342 0343 0344 0345 0346 0347 0348 0349 0350 0351 0352 0353 0354 0355 0901 0902 0903 0904 0905 0906 0907 0908 0909 0910 0911 0912 0913 0914 0915 0921 0922 0923 0924 0925 0926 0927 0928 0929 0930 0931 0932 0933 0934 0935 0941 0942 0943 0944 0945 0946 0947 0948 0949 0950 0951 0952 0953 0954 0955 0361 0362 0363 0364 0365 0366 0367 0368 0369 0370 0371 0372 0373 0374 0375 0381 0382 0383 0384 0385 0386 0387 0388 0389 0390 0391 0392 0393 0394 0395 0401 0402 0403 0404 0405 0406 0407 0408 0409 0410 0411 0412 0413 0414 0415 0421 0422 0423 0424 0425 0426 0427 0428 0429 0430 0431 0432 0433 0434 0435 0441 0442 0443 0444 0445 0446 0447 0448 0449 0450 0451 0452 0453 0454 0455 0461 0462 0463 0464 0465 0466 0467 0468 0469 0470 0471 0472 0473 0474 0475 0481 0482 0483 0484 0485 0486 0487 0488 0489 0490 0491 0492 0493 0494 0494 0495 0501 0502 0503 0504 0505 0506 0507 0508 0509 0510 0511 0512 0513 0514 0515 0521 0522 0523 0524 0525 0526 0527 0528 0529 0530 0531 0532 0533 0534 0535 0541 0542 0543 0544 0545 0546 0547 0548 0549 0550 0551 0552 0553 0554 0555 0561 0562 0563 0564 0565 0566 0567 0568 0569 0570 0571 0572 0573 0574 0575 0581 0582 0583 0584 0585 0586 0587 0588 0589 0590 0591 0592 0593 0594 0595 0601 0602 0603 0604 0605 0606 0607 0608 0609 0610 0612 0613 0614 0615 0621 0622 0623 0624 0625 0626 0627 0628 0629 0630 0631 0632 0633 0634 0635 1401 1402 1403 1404 1405 1406 1407 1408 1409 1410 1411 1412 1413 1414 1415 1416 1501 1503 1504 1502 1505 1506 1511 1512 1513 1514 1515 1563 1516 1517 1518 1519 1520 1521 1522 1523 1524 1525 1526 1527 1528 1529 1530 1531 1532 1533 1534 1535 1536 1537 1538 1539 1540 1541 1564 1565 1566 1567 1578 1579 1580 1581 1582 1551 1552 1553 1554 1555 1556 1557 1558 1559 1560 1561 1562 1611 1612 1613 1614 1615 1663 1616 1617 1618 1619 1620 1621 1622 1623 1624 1625 1626 1627 1628 1629 1630 1631 1632 1633 1634 1635 1636 1637 1638 1639 1640 1641 1664 1665 1666 1667 1678 1679 1680 1681 1682 1651 1652 1653 1654 1655 1656 1657 1658 1659 1660 1661 1662 1711 1712 1713 1714 1715 1763 1716 1717 1718 1719 1720 1721 1722 1723 1724 1725 1726 1727 1728 1729 1730 1731 1732 1733 1734 1735 1736 1737 1738 1739 1740 1741 1764 1765 1766 1767 1778 1779 1780 1781 1782 1751 1752 1753 1754 1755 1756 1757 1758 1759 1760 1761 1762 1811 1812 1813 1814 1815 1863 1816 1817 1818 1819 1820 1821 1822 1823 1824 1825 1826 1827 1828 1829 1830 1831 1832 1833 1834 1835 1836 1837 1838 1839 1840 1841 1864 1865 1866 1867 1878 1879 1880 1881 1882 1851 1852 1853 1854 1855 1856 1857 1858 1859 1860 1861 1862 1911 1912 1913 1914 1915 1963 1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1964 1965 1966 1967 1978 1979 1980 1981 1982 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1991 1992 1993 1995 1996 1997 1998 1994 2001 2002 2011 2012 2013 2014 2015 2021 2022 2023 2024 2025 2031 2032 2033 2034 2035 2041 2042 2043 2044 2045 2051 2052 2053 2054 2055 2061 2171 2172 2173 2174 2175 2176 2201 2202 2203 2204 2205 2206 2207 2208 2209 2210 2211 2212 2501 2502 2503 2504 2505 2506 2511 2512 2513 2521 2522 2523 2524 2531 2532 2533 2534 2535 2536 2541 2542 2543 2561 2562 2563 2564 2565 2566 2567 2568 2569 2570 2571 2572 2573 2574 2601 2602 2603 2604 2605 2606 2607 2608 2609 2610 2611 2612 2613 2614 2615 2616 2617 2618 2631 2632 2633 2651 2652 2653 2659 2660 2661 2662 2705 2711 2712 2713 2714 2715 2716 2717 2718"

// Loop over KLIPS waves (09~26)

foreach i in 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 {
	use klips`i'h, clear 

		/// p**0101 --> p_0101 
	foreach n of local hvar {
	
		cap noisily rename h`i'`n' h_`n' 
		cap noisily replace h_`n' = . if h_`n' == -1 
		}	
	
	// Add wave and year variables
	gen hwave_obs = `i'
	lab var hwave_obs "Survey wave"
	
	
	gen year = `i'+1997
	lab var year "Survey year"

	// Household ID 
	drop if hwave`i'~= 1 

	gen hhid = hhid`i'
	lab var hhid "Household ID"
	sort hhid
	

	// Apply weights (wave-specific), included for consistency, not used in analysis
	
	rename w`i'h w_h 
	
	if `i'== 01 | `i'== 02 | `i'== 03 | `i'== 04 | `i'== 05 | `i'== 06 | `i'== 07 | `i'== 08 | `i'== 09 | `i'== 10 | `i'== 11 {
		gen sw_h =.
		}
	else {
	rename sw`i'h sw_h
	}
	
	if `i' == 21 | `i' == 22 | `i' == 23 |`i' == 24 |`i' == 25 | `i'== 26 {
		rename nw`i'h nw_h
		}
	else {
		gen nw_h =.
		}
	
	lab var w_h "Household weight (98 cohort)"
	lab var sw_h "Household weight (09 integrated sample)"
	lab var nw_h "Household weight (18 integrated sample)"
	
	
	/*Original household indicator (, included for consistency, not used in analysis) */ 
	
	// sample18 variable is not available in waves 01 to 20
	if `i'== 01 | `i'== 02 | `i'== 03 | `i'== 04 | `i'== 05 | `i'== 06 | `i'== 07 | `i'== 08 | `i'== 09 | `i'== 10 | `i'== 11 | `i'== 12 | `i'== 13 | `i'== 14 | `i'== 15 | `i'== 16 | `i'== 17 | `i'== 18 | `i'== 19 | `i'== 20 {	
		gen sample18 =.
		lab var sample18 "Original household indicator (18 integrated sample)"
		}
	
	// sample09 variable is not available in waves 01 to 11 
	if `i'== 01 | `i'== 02 | `i'== 03 | `i'== 04 | `i'== 05 | `i'== 06 | `i'== 07 | `i'== 08 | `i'== 09 | `i'== 10 | `i'== 11 {
		gen sample09 =. 
		lab var sample09 "Original household indicator (09 integrated sample)"
		}
	
	keep hhid year sample98 sample09 sample18 hwaveent hwave_obs h_* w_h sw_h nw_h
	
	save h`i'_time, replace 
	}
	
// Merge all waves into panel dataset (Household)

clear

use h09_time

append using h10_time h11_time h12_time h13_time h14_time h15_time h16_time h17_time h18_time h19_time h20_time h21_time h22_time h23_time h24_time h25_time h26_time

order h_*, sequential
order hhid year hwave_obs

sort hhid year

save household_0926.dta, replace

* 1.3. Incorporate household panel on individual panel (Key: year & hhid)

use individual_0926, replace 

sort hhid pid year

merge m:1 hhid year using household_0926

tab _merge
drop if _merge == 2 
drop _merge

sort hhid year pid 

save Sample.dta, replace


************************************************************************************
* Section 2: Regression Variable Preparation
* - Construct independent and dependent variables
* - Apply necessary transformations
* - Prepare regression-ready panel dataset
************************************************************************************

// A. 각 카테고리 별 데이터 가공 //

// A. 0. 경제활동 상태 변수 //

/**임금근로자/비임금근로자/실업자/비경제활동인구**/ 

// jobclass: 일자리유형
// p**2801: 지난 1주일간 구직여부
// p**2802: 지난 1개월간 구직여부
// p**2806: 취업가능성 여부

/*OECD,경활 기준 (econ1)*/ 

gen econ1 = 4 
replace econ1 =1 if jobclass == 1 | jobclass ==5   
replace econ1 =2 if jobclass == 3 | jobclass ==7   
replace econ1 =3 if (p_2801 == 1 | p_2802==1) & p_2806==1 
tab econ1
lab var econ1 "1)임금근로자,2)비임금근로자,3)실업자(OECD,경활기준),4)비경제활동인구"

/*ILO 기준 (econ2)*/ 

gen econ2 = 4 
replace econ2 =1 if jobclass == 1 | jobclass ==5  
replace econ2 =2 if jobclass == 3 | jobclass ==7   
replace econ2 =3 if p_2801==1 & p_2806==1 
tab econ2
lab var econ2 "1)임금근로자,2)비임금근로자,3)실업자(ILO기준),4)비경제활동인구"


/**경제활동인구/비경제활동인구**/ 

// 방법1 //
recode econ1(1/3=1)(4=0), gen(econst1) 
tab econst1 
lab var econst1 "1)경제활동인구,2)비경제활동인구"

// 방법2 //
gen econst2 =(econ1 >= 1 & econ1 <=3)  
tab econst2 
lab var econst2 "1)경제활동인구,2)비경제활동인구"


/*취업자/실업자(emp)*/ 
recode econ1(1/2=1)(3=2)(4=.), gen(emp) // 경활 중 취업여부 더미 변수 만들기 
tab emp 
lab var emp "1)취업자,2)실업자"

** A.1. 가구소득과 근로자의 임금 **

/** 지난 한달간 가구 소득 **/

rename h_2201 inc_ey_mon
lab var inc_ey_mon "근로소득자 유무 (월간)"
rename h_2203 inc_my_mon
lab var inc_my_mon "금융소득 유무 (월간)"
rename h_2205 inc_py_mon
lab var inc_py_mon "부동산소득 유무 (월간)"
rename h_2207 inc_iy_mon
lab var inc_iy_mon "사회보험 수급액 유무 (월간)"
rename h_2209 inc_ty_mon
lab var inc_ty_mon "이전소득 유무 (월간)"
rename h_2211 inc_oy_mon
lab var inc_oy_mon "기타소득 유무 (월간)"

foreach i in inc_ey_mon inc_my_mon inc_py_mon inc_iy_mon inc_ty_mon inc_oy_mon {
	replace `i' = 0 if `i' == 2
}

rename h_2202 inc_e_mon
rename h_2204 inc_m_mon
rename h_2206 inc_p_mon
rename h_2208 inc_i_mon
rename h_2210 inc_t_mon
rename h_2212 inc_o_mon

lab var inc_e_mon "근로소득 (월간)"
lab var inc_m_mon "금융소득 (월간)"
lab var inc_p_mon "부동산소득 (월간)"
lab var inc_i_mon "사회보험 수급액 (월간)"
lab var inc_t_mon "이전소득 (월간)"
lab var inc_o_mon "기타소득 (월간)"

foreach i in inc_e inc_m inc_p inc_i inc_t inc_o {
	replace `i'_mon = 0 if `i'y_mon == 0
}

egen inc_mon=rowtotal(inc_e_mon inc_m_mon inc_p_mon inc_i_mon inc_t_mon inc_o_mon),mis

egen nonlaborinc_mon = rowtotal(inc_m_mon inc_p_mon inc_i_mon inc_t_mon inc_o_mon),mis

lab var inc_mon "가구 월간 총소득"
lab var nonlaborinc_mon "근로소득을 제외한 가구의 월간 총소득"

** A.2. 근로시간과 근로일수  => 총근로시간 연속형과 범주형 ** 

// p**1003 : 정규근로시간 여부
// p**1004 : 주당 평균 근로시간
// p**1005 : 주당 평균 근로일수
// p**1006 : 주당 정규 근로시간
// p**1007 : 주당 정규 근로일수
// p**1011 : 초과근로여부
// p**1012 : 일주일 또는 월평균 초과근로시간
// p**1013 : 일주일 또는 월평균 초과근로일수
// p**1019 : 초과근로시간 구분(1=일주일평균,2=월평균)

/**주당 근로시간 (worktime) 및 근로일수 (workday)**/ 

// 정규근로시간이 있고, 초과근로를 하지 않는 경우
gen worktime=p_1006 if p_1003==1 & p_1011==1 
gen workday=p_1007 if p_1003==1 & p_1011==1 

// 정규근로시간이 있고, 초과근로가 있는 경우
replace worktime=p_1006 + p_1012 if p_1003==1 & (p_1011==2 & p_1019==1) 
replace workday=p_1007 + p_1013 if p_1003==1 & (p_1011==2 & p_1019==1) 

// 정규근로시간이 있고, 초과근로가 있는 경우 (월평균인 경우 초과근로시간 및 초과근로일수는 4.3으로 나누어줌)
replace worktime=p_1006 + p_1012/4.3 if p_1003==1 & (p_1011==2 & p_1019==2)  
replace worktime=p_1007 + p_1013/4.3 if p_1003==1 & (p_1011==2 & p_1019==2)  

// 정규근로시간이 정해져있지 않은 경우 주당 평균 근로시간 및 일수 사용
replace worktime=p_1004 if p_1003==2 
replace workday=p_1005 if p_1003==2 

lab var worktime "주당 근로시간"
lab var workday "주당 근로일수"

// 불가능한 주당 근로시간 확인 //

replace worktime = . if worktime > 168

replace workday = . if workday > 7

/* 일간 근로시간 */

gen workhour = worktime/workday

** 일일 불가능한 근로시간 결측치화 및 과도한 근로시간(21.5)-> 대법원 기준 합법 최대 일일 근로시간 초과 (21.5) 제외**

replace workhour = . if workhour > 21.5

** 초과근로 더미 생성 **

gen worktime_40 = (worktime > 40)

replace worktime_40 = . if worktime == .

lab var worktime_40 "초과근로 여부 (주당 40시간 근로)"

** A.3 임금 **

// (시간당 임금이 있는 경우 있는 데이터 활용하여 시간당 급여 변수 생성)
// (나머지의 경우 월평균 임금 변수 활용하여 시간당 급여 변수 생성)

// p**1642

gen wage_mon = p_1642

lab var wage_mon "월 평균 임금 (만원)"

* 월 평균 임금 변수 활용하여 실질적으로 받는 시간당 임금률 계산

gen wage_week = (wage_mon/4.3)

gen wage_h = (wage_week/worktime)

** 관측의 편의를 위해 반올림

replace wage_h = wage_h*10

replace wage_h = round(wage_h, 0.0001)

lab var wage_h "근로시간당 평균 임금"

* 사업체 소재지

rename p_0311 address 

** A.5. 기업-작업장 규모 및 형태 구분 **

/**기업규모(fsize)**/

// (참고) 기업형태가 정부기관인 경우(p**0401=5)는 missing이므로 주의

// jobtype: 일자리형태(1:임금근로자,2:비임금근로자)
// p**0402: 전체종업원수(명)
// p**0403: 전체종웝원수(범주)

gen fsize = p_0403  if p_0403 ~=. 
	
// 연속형변수->범주화 
gen temp = p_0402 if p_0211==1
replace fsize = 1 if  temp >=   1 & temp  <  5
replace fsize = 2 if  temp >=   5 & temp  <  10
replace fsize = 3 if  temp >=  10 & temp  <  30
replace fsize = 4 if  temp >=  30 & temp  <  50
replace fsize = 5 if  temp >=  50 & temp  <  70
replace fsize = 6 if  temp >=  70 & temp  <  100
replace fsize = 7 if  temp >= 100 & temp  <  300
replace fsize = 8 if  temp >= 300 & temp  <  500
replace fsize = 9 if  temp >= 500 & temp  < 1000
replace fsize =10 if  temp >=1000 & temp  <100000
drop temp

// 사업체노동력조사에 맞춰 사업장 규모 구간 재설정

replace fsize = 4 if fsize == 5 | fsize == 6
replace fsize = 5 if fsize == 7 
replace fsize = 6 if fsize == 8 | fsize == 9 | fsize == 10

drop if fsize == 11 | fsize == 1

tab fsize 

** A. 24. 기업 형태 (공기업, 공공기관, 정부 == 1)

gen pub_soc=.

replace pub_soc = 0 if p_0401 == 1
replace pub_soc = 1 if p_0401 == 3
replace pub_soc = 1 if p_0401 == 5
replace pub_soc = 0 if p_0401 == 2
replace pub_soc = 0 if p_0401 == 4
replace pub_soc = 0 if p_0401 == 6
replace pub_soc = 0 if p_0401 == 7
replace pub_soc = 0 if p_0401 == 8

** A.6. 비정규직/정규직 구분 **

/**한시적근로자 (foe11)**/ 


* 근로계약기간을 정한 근로자 또는 정하지는 않았으나 계약을 반복 갱신해서 계속 일할 수 있는 근로자(기간제근로자)와 비자발적 사유로 계속 근무를 기대할 수 없는 근로자(비기간제근로자)를 포함


/*기간제 근로자 (foe111)*/ 

* 근로계약기간을 정한 근로자 계약직, 임시직, 촉탁징 등 근로의 명칭과 관계없이 근로계약 기간이 정해져 있는 경우

* p**0501: 근로계약기간 유무 (1=정해져 있다)

qui gen foe111=0 if jobtype==1
qui replace foe111=1 if p_0501==1 & jobtype==1
tab foe111
label var foe111 "기간제근로자"

/*비기간제 근로자 (foe112)*/ 

// 근로계약기간을 정하지는 않았으나 계약을 반복 갱신해서 일할 수 있는 근로자 또는 비자발적 사유로 계속 근무를 기대할 수 없는 근로자

// p**0501: 근로계약기간 유무 (2=정해져 있지 않다)
// p**0601: 고용안정성 (2=아니요)
// p**0602: 고용 안정성 이유 (2=계약의 반복,갱신으로 고용이 지속되고 있으므로)
// p**0605: 고용불안정 이유

qui gen foe112=0 if jobtype==1
qui replace foe112=1 if p_0501==2 & p_0601==1 & p_0602==2 & jobtype==1
qui replace foe112=1 if p_0501==2 & p_0601==2 & (p_0605==1 | p_0605==2 | p_0605==3 | p_0605==4 | p_0605==5 | p_0605==6) & jobtype==1
tab foe112
label var foe112 "비기간제근로자"

qui gen foe11 = 0 if jobtype==1
qui replace foe11 = 1 if foe111+foe112 > 0 & jobtype==1
tab foe11
label var foe11 "한시적근로자"


/**비전형 근로자 (foe13)**/

// 파견근로자, 용역근로자, 특수형태근로종사자, 가정내(재택, 가내)근로자, 일일(단기) 근로자 등


/*파견근로자 (foe131)*/ 

// 임금을 지급하고 고용관계가 유지되는 고용주와 업무지시를 하는 사용자가 일치히자 않는 경우로 파견사업주가 근로자를 고용한 후 그 고용관계를 유지하면서 근로자 파견계약의 내용에 따라 사용사업주의 사업장에서 지휘, 명령을 받아 사용사업주를 위하여 근무하는 형태

// p**0611: 파견 및 용역근로여부 (2=파견업체) 

qui gen foe131=0 if jobtype==1
qui replace foe131=1 if p_0611==2 & jobtype==1
tab foe131
label var foe131 "파견근로자"

/*용역근로자 (foe132)*/

// 용역업체에 고용되어 이 업체의 지휘하에 이 업체와 용역계약을 맺은 다른 업체에서 근무하는 형태

// p**0611: 파견 및 용역근로여부 (3=용역업체)

qui gen foe132=0 if jobtype==1
qui replace foe132=1 if p_0611==3 & jobtype==1
tab foe132
label var foe132 "용역근로자"

/*특수형태노동종사자 (foe133)*/ 

// 독자적인 사무실, 점포 또는 작업장을 보유하지 않았으면서 비독립적인 형태로 업무를 수행하면서도, 다만 근로제공의 방법, 근로시간 등은 독자적으로 결정하면서, 개인적으로 모집, 배달, 운송 등의 업무를 통해 고객을 찾거나 맞이하여 상품이나 서비스를 제공하고 그 일을 한만큼 소득을 얻는 근무형태

// p**0612: 독립도급여부

qui gen foe133=0 if jobtype==1
qui replace foe133=1 if p_0612==1 & jobtype==1
tab foe133
label var foe133 "특수형태근로종사자"

/*가정내근로자 (foe134)*/ 

// 재택근무, 가내하청 등과 같이 사업체에서 마련해 주 공동작업장이 아닌 강정내에서 근무가 이루어지는 근무형태

* p**0613: 가내근로여부

qui gen foe134=0 if jobtype==1
qui replace foe134=1 if p_0613==1 & jobtype==1
tab foe134
label var foe134 "가정내근로자"

/*일일(단기)근로자 (foe135)*/

// 근로계약을 정하지 않고, 일거리가 생겼을 경우 며칠 또는 몇 주씩 일하는 형태의 근로자

// p**0508: 불규칙적 일자리

qui gen foe135=0 if jobtype==1
qui replace foe135=1 if p_0508==1 & jobtype==1
tab foe135
label var foe135 "일일단기근로자"

qui gen foe13=0 if jobtype==1
qui replace foe13 = 1 if foe131+foe132+foe133+foe134+foe135 > 0 & jobtype==1
tab foe13
label var foe13 "비전형근로자"

** A.7. 학력 및 교육년수 **

/**학력 더미변수 만들기 (edu)**/ 

// (참고) 개인용 자료에 있는 학력 자료는 가구용 자료에서 가져오는 자료임

// p**0110 : 학력(학교)
// h**0661-h**0675: 학력(학교)
// p**0111: 학력(이수여부)
// h**0681-h**0695: 학력(이수여부)


recode p_0110(1/4=1)(5=2)(6=3)(7=4)(8/9=5), gen(edu) // 1)미취학,2)무학,3)초등학교,4)중학교,5)고등학교,6)2년제대학,전문대학,7)4년제대학,8)대학원석사,9)대학원박사 
mvdecode edu, mv(-1) // -1값을 결측치로 전환

recode p_0111(1=1)(2/5=2), gen(degree) //1)졸업,2)수료,3)중퇴,4)재학중,5)휴학중
mvdecode degree, mv(-1) // -1값을 결측치로 전환
replace edu =1 if edu==2 & degree!=1 // 졸업을 제외한 나머지는 하위학력코딩
replace edu =2 if edu==3 & degree!=1 // "~"를 사용해도 됨
replace edu =3 if edu==4 & degree!=1
replace edu =4 if edu==5 & degree!=1

tab edu, gen(edu_dum_) // 한 변수를 가지고 다수의 더미변수를 만드는 명령문

lab var edu "학력:1)고졸,2)전문대졸,3)대졸,4)석사이상" 
lab var degree "이수여부:1)졸업,2)수료,중퇴,재학중,휴학중" 	

tab edu
tab degree

/**교육년수 변수 (edu_scale)**/	
	
// (참고) 졸업인 경우(p**0111=1), 학년(p**0112)은 . 처리 되어 있음 

// p**0112: 학력(학년)	
	
gen level = p_0112 	
recode p_0110(1/2=0)(3=6)(4=9)(5=12)(6=14)(7=16)(8=18)(9=21), gen(edu_scale)

// 초등학교
replace edu_scale=1 if p_0110==3 & p_0112==1 
replace edu_scale=2 if p_0110==3 & p_0112==2
replace edu_scale=3 if p_0110==3 & p_0112==3
replace edu_scale=4 if p_0110==3 & p_0112==4
replace edu_scale=5 if p_0110==3 & p_0112==5
replace edu_scale=6 if p_0110==3 & p_0112==6

// 중학교
replace edu_scale=7 if p_0110==4 & p_0112==1
replace edu_scale=8 if p_0110==4 & p_0112==2
replace edu_scale=9 if p_0110==4 & p_0112==3

// 고등학교
replace edu_scale=10 if p_0110==5 & p_0112==1
replace edu_scale=11 if p_0110==5 & p_0112==2
replace edu_scale=12 if p_0110==5 & p_0112==3

// 2년제대학,전문대학
replace edu_scale=13 if p_0110==6 & p_0112==1
replace edu_scale=14 if p_0110==6 & p_0112==2

// 4년제대학
replace edu_scale=13 if p_0110==7 & p_0112==1
replace edu_scale=14 if p_0110==7 & p_0112==2
replace edu_scale=15 if p_0110==7 & p_0112==3
replace edu_scale=16 if p_0110==7 & p_0112==4

// 대학원석사
replace edu_scale=17 if p_0110==8 & p_0112==1
replace edu_scale=18 if p_0110==8 & p_0112==2

// 대학원박사
replace edu_scale=19 if p_0110==9 & p_0112==1
replace edu_scale=20 if p_0110==9 & p_0112==2
replace edu_scale=21 if p_0110==9 & p_0112==3

mvdecode edu_scale, mv(-1) // 결측치 처리 

lab var edu_scale "교육년수"
tab edu_scale 

// (참고) 대학/대학원의 정규 교육년수가 넘어서는 경우, 비이상적인 학년(예: 초등학교 7학년) 등은 edu_scale변수의 교육년수 계산에 있어 반영하지 않음

count if p_0110==3 & (p_0112 >=7 & p_0112 !=.) // stata에서 .는 결측값(.)을 무한대 처리함. 
count if p_0110==4 & (p_0112 >=4 & p_0112 !=.) 
count if p_0110==5 & (p_0112 >=4 & p_0112 !=.) 
count if p_0110==6 & (p_0112 >=3 & p_0112 !=.)
count if p_0110==7 & (p_0112 >=4 & p_0112 !=.)
count if p_0110==8 & (p_0112 >=3 & p_0112 !=.)
count if p_0110==9 & (p_0112 >=4 & p_0112 !=.) 

** A.9. 업종별/직종별 변수를  구간 변수로 변환 후 더미변수화 - 제9차 한국표준산업분류(2007) **

drop if p_0341 <= 99

rename p_0341 indcode

egen industry = cut(indcode), at(100, 330, 350, 370, 410, 450, 490, 550, 580, 640, 680, 700, 740, 840, 850, 860, 900, 940, 970, 990, 1000)

drop if industry == 970 | industry == 990


*** 각 업종 더미변수화 완료
*/

* 근로시간 특례제도 적용업종 (2018년 7월 1일 적용)
**# Bookmark #1

/*
현행 근로기준법 상 특례업종 12개는 한국 표준산업분류표의 중분류 또는소분류 기준에 따라 26개 업종으로 구분되는데,  개정 근로기준법은 이를 5개 업종으로 축소하였다. 개정법 상 특례업종 5개는 육상운송업(단, 노선여객자동차운송사업은제외), 수상운송업, 항공운송업, 기타 운송관련 서비스업, 보건업이고, 특례제외업종 21개는 자동차및 부품판매업, 도매및상품중개업, 소매업, 보관및창고업, 금융업, 보험및연금업, 금융및보험관련서비스업, 우편업, 교육서비스업, 연구개발업, 숙박업, 음식점및주점업, 광고업, 시장조사및여론조사업, 사업시설관리및조경서비스업, 미용, 욕탕및유사서비스업, 영상.오디오및기록물제작 및 배급업,  방송업,  전기통신업,  하수.폐수 및 분뇨처리업,  사회복지서비스업
(근로시간 특례업종 관련 쟁점 및향후 논의 방향, 박귀천)
*/

* 1. 관리자 (job_cat1)
* 2. 전문가 및 관련종사자 (job_cat2)
* 3. 사무종사자 (job_cat3)
* 4. 서비스종사자 (job_cat4)
* 5. 판매종사자 (job_cat5)
* 6. 농림어업종사자 (job_cat6)
* 7. 기능원 및 관련 기능 종사자 (job_cat7)
* 8. 장치·기계 조작 및 조립 종사자 (job_cat8)
* 9. 단순노무 종사자 (job_cat9)

egen job_cat = cut(p_0352), at (100,200,300,400,500,600,700,800,900,1000)

tab job_cat, gen(job_cat)

rename (job_cat1 job_cat2 job_cat3 job_cat4 job_cat5 job_cat6 job_cat7 job_cat8 job_cat9) (job_manager job_professional job_clerk job_service job_sale job_skilledagr job_skilledcraft job_assembler job_unskilled)

lab var job_manager "관리자 (Manager)"
lab var job_professional "전문가 및 관련종사자 (Professionals and Related Workers)" 
lab var job_clerk "사무종사자 (Clerk)"
lab var job_service "서비스종사자 (Service Workers)"
lab var job_sale "판매종사자 (Sales Workers)"
lab var job_skilledagr "농림어업종사자 (Skilled Agricultural, Forestry and Fishery Workers)" 
lab var job_skilledcraft "기능원 및 관련 기능 종사자 (Craft and Related Trades Workers)" 
lab var job_assembler "장치·기계 조작 및 조립 종사자 (Equipment, Machine Operating and Assembling Workers)"
lab var job_unskilled "단순노무 종사자 (Elementary Workers)"

gen job = 3 if job_cat == 100
replace job = 3 if job_cat == 200
replace job = 2 if job_cat == 300
replace job = 1 if job_cat == 400
replace job = 2 if job_cat == 500
replace job = 1 if job_cat == 600
replace job = 2 if job_cat == 900
replace job = 2 if job_cat == 700
replace job = 1 if job_cat == 800

lab define lbl_job 1 "Low-Skilled" 2 "Middle-Skilled" 3 "High-Skilled"

tab job, gen(job_d)

lab var job lbl_job

rename p_0352 jobcode

***각 직종 더미변수화 완료

lab var job_cat "한국표준직업분류(7차)"

** A.10. 성별 더미변수 **

qui gen female = 0 if p_0101== 1
qui replace female = 1 if p_0101==2
tab female
lab var female "성별 0)남성, 1)여성"

** A.11. 나이 => 연속형 변수와 범주형 변수화(세대)/ 생년 **

rename p_0107 age

egen generation = cut(age), at (10,20,30,40,50,60,70,90)

rename p_0114 birth_year

lab var birth_year "출생 연도"

lab var generation "세대 1)20세 미만, 2)20대, 3)30대, 4)40대, 5)50대, 6)60대, 7)70세 이상"

tab generation


** A.15. 가구원 수 **

rename h_0150 number_household

** A.21. 배우자 여부 **

// 배우자 있는 사람과 별거, 사망, 이혼 등으로 배우자가 없는 사람(미혼 포함)으로 나눔 //

gen spouse_exist=1 if p_5501 == 2
replace spouse_exist=0 if p_5501 != 2

lab var spouse_exist "배우자 유무 (생존)"

** A.23.1. 복리 후생 수 **

foreach var in p_4105 {
	replace `var' =. if `var' == 3
	replace `var' = 0 if `var' == 2
}

rename p_4105 paid_vac

** A. 26. 조사시점 당시 기준 근속연수 변수 **

gen entrance_date = mdy(p_0302, p_0303, p_0301)
gen observation_date = mdy(p_9501, p_9502, year)

rename p_0301 entrance_year
gen tenured_years = (year+1)-entrance_year

// B. # 종속변수 모델링 # //

** B.1.1. 조직 몰입도 **

// p_4201 : 지금 근무하고 있는 직장(일자리)은 다닐만한 좋은 직장이다
// p_4202 : 나는 이 직장(일자리)에 들어온 것을 기쁘게 생각한다
// p_4203 : 직장(일자리)을 찾고 있는 친구가 있으면 나는 이 직장을 추천하고 싶다
// p_4204 : 나는 내가 다니고 있는 직장(일자리)을 다른 사람들에게 자랑할수있다
// p_4205 : 별 다른 일이 없는 한 이 직장(일자리)을 계속 다니고 싶다

** B.2.1. 직무 만족도 (종합+요인별) **

// p_4301 : 나는 현재 하고(맡고) 있는 일에 만족하고 있다
// p_4302 : 나는 현재 하고(맡고) 있는 일을 열정적으로 하고있다
// p_4303 : 나는 현재 하고(맡고) 있는 일을 즐겁게 하고 있다
// p_4304 : 나는 현재 하고(맡고) 있는 일을 보람을 느끼면서 하고 있다
// p_4305 : 별 다른 일이 없는 한 현재하고(맡고) 있는 일을 계속 하고 싶다

** B.1.6. 생활 만족도 (6508) **

// p_6508 : 전반적 생활 만족도 ==> 이용

// p_6501~p_6506 : 요인별 생활만족도

** B.2.2. 현재 건강상태 (p_6101) **

** B.2.3. 1년 전 대비 건강 상태 (p_6102) **

** B.2.4. 보통 사람 대비 건강 상태 (p_6103) **

*## 종속변수 모델링 ##*

*** 모든 변수는 (1~5의 scale로 구성되어 있음. 매우 불만족(1) ~ 매우 만족(5)으로 통일) (e.g.요인별 직무만족도)
*** 조직만족도와 생활만족도의 경우 질문지 스케일 모두 합침 

* 요인별 직무만족도의 복합변수 (9개 문항) => 각 문항이 번아웃과 연관성이 있음

*1. 임금 또는 보수 (Area of Reward) p_4311
*2. 의사소통 및 인간관계 (Area of Community) p_4317
*3. 인사고과의 공정성 (Area of fairness) p_4318 => 전체 포괄 X
*4. 일의 내용 (Area of value) p_4313
*5. 근무환경 (Area of workload) p_4314
*6. 근로시간 (Area of workload) p_4315
*7. 복지후생 (Area of Reward) p_4319 => 전체 포괄 X

** 조직몰입도 (5개 문항)

**************************************************************

foreach x in 4311 4312 4313 4314 4315 4316 4317 4318 4319 {
	recode p_`x' (1=5) (2=4) (3=3) (4=2) (5=1)
	}

*******************************************************************

** B.1.2. 직무 만족도 **

// p_4301 : 나는 현재 하고(맡고) 있는 일에 만족하고 있다
// p_4302 : 나는 현재 하고(맡고) 있는 일을 열정적으로 하고있다
// p_4303 : 나는 현재 하고(맡고) 있는 일을 즐겁게 하고 있다
// p_4304 : 나는 현재 하고(맡고) 있는 일을 보람을 느끼면서 하고 있다
// p_4305 : 별 다른 일이 없는 한 현재하고(맡고) 있는 일을 계속 하고 싶다
// p_4311 : 임금
// p_4312 : 취업 안정성
// p_4313 : 일의 내용
// p_4314 : 근무환경
// p_4315 : 근로시간
// p_4316 : 개인의 발전 가능성
// p_4317 : 의사소통 및 인간관계
// p_4318 : 인사고과의 공정성
// p_4321 : 일자리만족도
// p_4322 : 일 만족도

lab var p_4301 "나는 현재 하고(맡고) 있는 일에 만족하고 있다"
lab var p_4302 "나는 현재 하고(맡고) 있는 일을 열정적으로 하고 있다"
lab var p_4303 "나는 현재 하고(맡고) 있는 일을 즐겁게 하고 있다"
lab var p_4304 "나는 현재 하고(맡고) 있는 일을 보람을 느끼면서 하고 있다"
lab var p_4305 "별 다른 일이 없는 한 현재하고(맡고) 있는 일을 계속 하고 싶다"

lab var p_4311 "직무만족도 - 임금"
lab var p_4312 "직무만족도 - 취업 안정성"
lab var p_4313 "직무만족도 - 일의 내용"
lab var p_4314 "직무만족도 - 근무환경"
lab var p_4315 "직무만족도 - 근로시간"
lab var p_4316 "직무만족도 - 개인의 발전 가능성"
lab var p_4317 "직무만족도 - 의사소통 및 인간관계"
lab var p_4318 "직무만족도 - 인사고과의 공정성"
lab var p_4321 "직무만족도 - 일자리만족도"
lab var p_4322 "직무만족도 - 일 만족도"

rename p_4301 js1
rename p_4302 js2
rename p_4303 js3
rename p_4304 js4
rename p_4305 js5

egen js = rowmean(js1 js2 js3 js4 js5)
egen nonmissing_js = rownonmiss(js1 js2 js3 js4 js5)
replace js = . if nonmissing_js ~= 5
drop nonmissing_js

replace js =. if js1 ==.
replace js =. if js2 ==.
replace js =. if js3 ==.
replace js =. if js4 ==.
replace js =. if js5 ==.

lab var js "Job Satisfaction"

rename p_4311 js_reward
rename p_4313 js_value
rename p_4314 js_workenvironment
rename p_4317 js_community
rename p_4318 js_fairness
rename p_4315 js_worktime
rename p_4319 js_welfare

egen js_composite = rowmean(js_reward js_value js_workenvironment js_community js_worktime)
egen nonmissing_jsc = rownonmiss(js_reward js_value js_workenvironment js_community js_worktime)
replace js_composite = . if nonmissing_jsc ~= 5
drop nonmissing_jsc

*## 데이터 클리닝 완료 ! ##*

save cleaned_sample.dta, replace

*************************************************************

foreach var in age number_household spouse_exist edu_scale foe11 foe13 paid_vac tenured_years pub_soc fsize job industry js_composite worktime_40 female nonlaborinc_mon workday workhour address wage_h js_reward js_value js_workenvironment js_community js_worktime {
	
	drop if missing(`var')
	
}

drop if age < 18

drop if age > 65

xtset pid year, yearly

keep worktime workday workhour wage_h wage_mon age number_household spouse_exist edu_scale nonlaborinc_mon foe11 foe13 paid_vac tenured_years pub_soc worktime_40 pid year industry job js_composite female fsize indcode jobcode address js_reward js_value js_workenvironment js_community js_worktime

* 종속변수 근로시간, 근로조건, 가구 특성 등으로 순서 배열하고 라벨링

// (Dependent Variable Index)
lab var js_composite "Job Satisfaction"
lab var js_reward "Job Satisfaction (Wage)"
lab var js_value "Job Satisfaction (Value of Work)"
lab var js_workenvironment "Job Satisfaction (Working Environment)"
lab var js_community "Job Satisfaction (Quality of Communication)"
lab var js_worktime "Job Satisfaction (Working Hours)"

// (Working Environments)
lab var worktime "Weekly Working Hours"
lab var workday "Weekly Working Days"
lab var workhour "Daily Working Hours"
lab var worktime_40 "Overtime Worker"
lab var wage_h "Hourly Wage"
lab var wage_mon "Monthly Wage"
lab var job "Level of Job Skill"
lab var foe11 "Temporary Contract"
lab var foe13 "Atypical Contract"
lab var pub_soc "Public employee (=1 for Public Worker)"
lab var tenured_years "Year of Tenure"
lab var address "Region of Workplace"
lab define lbl_fsize 1 "Less than 5 Employees" 2 "5 ~ 9 Employees" 3 "10 ~ 29 Employees" 4 "30 ~ 99 Employees" 5 "100 ~ 299 Employees" 6 "More or Equal to 300 Employees"
lab var fsize lbl_fsize

lab var paid_vac "Paid Vacation Provided"

// (Demographic Characteristics)
lab var age "Age"
lab var female "Female"
lab var edu_scale "Years of Education"

// (Household Characteristics)
lab var number_household "Household Size"
lab var spouse_exist "Marital Status"
lab var nonlaborinc_mon "Household Income"

save final_data, replace

clear

import delimited "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\Labor_Shortage_Data.csv"

drop if fsize == .

replace industry = industry*10

lab var labor_shortage "Labor Shortage Rate by Industry"

lab var address "Region Code"

lab var industry "Industry Category"

lab var fsize "Size of Firm"

merge 1:m year fsize address industry using final_data

keep if _merge==3

drop _merge

save final_data_lsr.dta, replace

drop labor_shortage

merge m:1 year fsize address industry using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\lbs.dta"

drop if _merge == 2

drop _merge

*cluster의 서수화 (노동력 부족율 기준)

recode cluster (1=3) (2=1) (3=4) (4=2), gen(cluster_ord)

drop cluster

rename cluster_ord cluster

lab var cluster "Clustered Classfication of industies based on LSR"

save "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", replace

* 98표본, 09표본, 18표본 Classfication

cd "C:\Users\joong\OneDrive\문서\GitHub\burnout-thesis-to-journal\data"

merge 1:1 pid year using "sample_origin.dta"

keep if _merge == 3

save "final_data_lsr.dta", replace

* 09표본 기준 원가구, 분가가구, 조사대상 아님 (+18년도에 추가 표본 구축)

eststo clear

table year sample09

collect export "sample09_year.tex", replace

eststo clear

table year sample18

collect export using "sample18_year.tex", replace

// - 09통합표본은 2009년 조사 당시 추가표집된 1,415가구를 포함하여, 당해연도 응답 가구(6,721가구) 전체를 원가구로 하는 표본을 의미한다.
// - 09통합표본은 2009년(12차년도)에 기존 조사대상가구 중 당해연도 응답가구인
// - 5,306가구(98표본 원가구(3,658가구) + 98표본 분가가구(1,648가구))와 추가 표집된 가구인 1,415가구를 더한 6,721가구를 원가구로 하는 표본이다.
// - 18통합표본가구에는 98원표본과 09통합패널이 다수 포함되어 있지만, 2018년 당시 응답하지 않고, 2019년 이후 다시 응답한 98표본, 09통합표본은 포함되지 않으므로, 사용에 주의가 요구된다.
// - 18통합패널 원년인 2018년도 당시 응답하지 않고, 이후에 응답하여 18통합표본에는 포함되지 않지만, 98표본에는 포함되는 가구를 찾는 방법은 다음과 같다.
// (sample98=1 or sample98=2) and sample18=3
// - 이들 가구는 기본적으로 98표본이지만, 18통합표본은 아니므로, 98표본 가중치는 있지만, 18통합표본 가중치는 주어지지 않는다.
// 18통합패널 원년인 2018년도 당시 응답하지 않고, 이후에 응답하여 18통합표본에는 포함되지 않지만, 09통합표본에는 포함되는 가구를 찾는 방법은 다음과 같다.
// (sample09=1 or sample09=2) and sample18=3, 이들 가구는 기본적으로 09통합표본이지만, 18통합표본은 아니므로, 09통합표본 가중치는 있지만, 18통합표본 가중치는 주어지지 않는다.

* Aggregated Job Satisfaction by Weekly Working Hours (Figure 4)

twoway (fpfitci js_composite worktime, xtitle(Total Working Hours per a Week) ytitle(Level of Job Satisfaction) legend(pos(12) row(1)) xline(40) estopts(vce(cl pid)))

eststo clear

* Summary Statistics of Demographic Characteristics (Table 3)

estpost tabstat age female edu_scale number_household spouse_exist nonlaborinc_mon, by(worktime_40) statistics(mean sd) column(statistics) listwise

esttab using "C:\Users\joong\OneDrive\바탕 화면\THESIS\Impact of working hours on burn-out syndrome\summary_demo.csv", main(mean) aux(sd) unstack nonumber brackets label replace

eststo clear

* Summary Statistics of Labor Characteristics (Table 4)

eststo clear

estpost tabstat js_composite worktime workday workhour wage_h wage_mon paid_vac pub_soc foe11 foe13 tenured_years, by(worktime_40) statistics(mean sd) column(statistics) listwise

esttab using "C:\Users\joong\OneDrive\바탕 화면\THESIS\Impact of working hours on burn-out syndrome\summary_work.csv", main(mean) aux(sd) unstack nonumber brackets label replace

* Descriptive Statistics of Working Schedules (Table 5)

table workday worktime_40, stat(sd workhour) nformat(%5.4f)

* Descriptive Statistics of Working Environment (Table 6)

eststo clear

estpost tab job worktime_40

esttab using "C:\Users\joong\OneDrive\바탕 화면\THESIS\Impact of working hours on burn-out syndrome\summary_descr.csv", main(b) aux(colpct) unstack nonumber brackets label replace noobs nomtitle nonotes

estpost tab fsize worktime_40

esttab using "C:\Users\joong\OneDrive\바탕 화면\THESIS\Impact of working hours on burn-out syndrome\summary_descr.csv", main(b) aux(colpct) unstack nonumber brackets label append noobs nonotes

estpost tab region worktime_40

esttab using "C:\Users\joong\OneDrive\바탕 화면\THESIS\Impact of working hours on burn-out syndrome\summary_region.csv", main(b) aux(colpct) unstack nonumber brackets label append noobs nonotes

* Summary Statistics on Each Domain of Job Satisfaction (Table A3)

eststo clear

estpost tabstat js_*, by(worktime_40) statistics(mean sd) column(statistics) listwise

esttab using "C:\Users\joong\OneDrive\바탕 화면\THESIS\Impact of working hours on burn-out syndrome\summary_js.csv", main(mean) aux(sd) unstack nonumber brackets label replace

* Effects of Industrial Labor Shortage on Working Hour Decisions (Equation 4.1) (Table 8)

reghdfe worktime labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.industry i.fsize i.address) vce(cl pid)

eststo reghdfe1

reghdfe workhour labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.industry i.fsize i.address) vce(cl pid)

eststo reghdfe2

reghdfe workday labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.industry i.fsize i.address) vce(cl pid)

eststo reghdfe3

reghdfe worktime_40 labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.industry i.fsize i.address) vce(cl pid)

eststo reghdfe4

esttab reghdfe1 reghdfe2 reghdfe3 reghdfe4 using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\stage1_comparison.csv", replace se scalars(N_group r2 F) unstack b(%5.4f) se(%5.4f) nomtitle label

* Effects of Labor Shortage Cluster Group on Working Hour Decisions (Equation 4.2) (Table 9)

reghdfe worktime i.cluster wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel1

reghdfe workhour i.cluster wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel2

reghdfe workday i.cluster wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel3

reghdfe worktime_40 i.cluster wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel4

esttab cmodel1 cmodel2 cmodel3 cmodel4 using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\stage1_cluster.csv", replace se scalars(N_group r2 F) unstack b(%5.4f) se(%5.4f) nomtitle label

* Effects of Labor Shortage Cluster Group on Working Hour Decisions (Equation 4.3) (Table 10)

reghdfe worktime i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel1_int

reghdfe workhour i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel2_int

reghdfe workday i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel3_int

reghdfe worktime_40 i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)

eststo cmodel4_int

esttab cmodel1_int cmodel2_int cmodel3_int cmodel4_int using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\stage1_cluster_int.csv", replace se scalars(N_group r2 F) unstack b(%5.4f) se(%5.4f) nomtitle label

* Estimation Results (Stage 2)

eststo clear

* Relationship between Weekly Working Hours and Job Satisfaction (Equation 4.4 and 4.5) (Table 11)

*(1) 주간 근로시간-직무만족 비선형, 초과근로 더미 교차항 관계  (feologit500)

feologit js_composite worktime c.worktime#c.worktime i.worktime_40#c.worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit500

*(2) 주간 근로시간-직무만족 선형, 초과근로 더미 교차항 관계  (feologit6)

feologit js_composite worktime i.worktime_40#c.worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit6

*(3) 주간 근로시간-직무만족 비선형 (feologit11)

feologit js_composite worktime c.worktime#c.worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit11

*(4) 주간 근로시간-직무만족 선형 (feologit12)

feologit js_composite worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit12

esttab feologit12 feologit11 feologit6 feologit500 using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\comparison.csv", replace se scalars(N_true N_group r2_p ll) order(1.worktime_40#c.worktime worktime c.worktime#c.worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years) drop(0.worktime_40#c.worktime *.fsize *.job *.industry *.address cut1 cut2 cut3 cut4 cut5 cut6 cut7 cut8 cut9 cut10 cut11 cut12 cut13 cut14 cut15 cut16 cut17 cut18 cut19 cut20) unstack b(%5.4f) se(%5.4f) nomtitle label

* Decomposition of Working Hours into Daily Hours and Workdays (Equation 4.4a) (Table A4)

*(3) 주간 근로시간-직무만족 선형 관계  (feologit13)

feologit js_composite c.workhour c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit13

*(4) 주간 근로시간-직무만족 비선형 관계  (feologit14)

feologit js_composite c.workhour#c.workhour workhour c.workday#c.workday workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit14

*(5) 일수 근로시간-직무만족 비선형 일일 선형 관계  (feologit15)

feologit js_composite workhour c.workday#c.workday workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit15

*(6) 일수 근로시간-직무만족 선형 일일 비선형 관계  (feologit16)

feologit js_composite workhour c.workhour#c.workhour workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit16

esttab feologit13 feologit14 feologit16 feologit15 using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\detailed_comparison.csv", se scalars(N_true N_group r2_p ll) order(workhour c.workhour#c.workhour workday c.workday#c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years) drop( *.fsize *.job *.industry *.address cut1 cut2 cut3 cut4 cut5 cut6 cut7 cut8 cut9 cut10 cut11 cut12 cut13 cut14 cut15 cut16 cut17 cut18 cut19 cut20) unstack b(%5.4f) se(%5.4f) label nomtitle replace

* Decomposition of Working Hours into Daily Hours and Workdays (Equation 4.5a) (Table A5)

*(3) 주간 근로시간-직무만족 선형, 초과근로 더미 교차항(일간, 근로일수) 관계  (feologit7)

feologit js_composite c.workhour c.workday i.worktime_40#c.workhour i.worktime_40#c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry, group(pid) vce(cl pid) threshold

eststo feologit7

*(4) 주간 근로시간-직무만족 비선형, 초과근로 더미 교차항(일간, 근로일수) 관계  (feologit8)

feologit js_composite c.workhour#c.workhour workhour c.workday#c.workday workday i.worktime_40#c.workhour i.worktime_40#c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit8

*(5) 일수 근로시간-직무만족 비선형 일일 선형, 초과근로 더미 교차항(일간, 근로일수) 관계  (feologit9)

feologit js_composite workhour c.workday#c.workday workday i.worktime_40#c.workhour i.worktime_40#c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit9

*(6) 일수 근로시간-직무만족 선형 일일 비선형, 초과근로 더미 교차항(일간, 근로일수) 관계  (feologit10)

feologit js_composite workhour c.workhour#c.workhour workday i.worktime_40#c.workhour i.worktime_40#c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.industry i.address, group(pid) vce(cl pid) threshold

eststo feologit10

esttab feologit7 feologit8 feologit10 feologit9 using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\detailed_dummy_comparison_1.csv", se scalars(N_true N_group r2_p ll) order(1.worktime_40#c.workhour 1.worktime_40#c.workday workhour c.workhour#c.workhour workday c.workday#c.workday wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years) drop(0.worktime_40#c.workday 0.worktime_40#c.workhour *.fsize *.job *.industry *.address cut1 cut2 cut3 cut4 cut5 cut6 cut7 cut8 cut9 cut10 cut11 cut12 cut13 cut14 cut15 cut16 cut17 cut18 cut19 cut20) unstack label nomtitle replace

* Preliminary Test on Exclusion Restriction (Equation 4.6) (Table 12)

feologit js_composite i.cluster#c.labor_shortage_rate, group(pid) vce(cl pid) threshold

eststo feologit_er1

feologit js_composite i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, group(pid) vce(cl pid) threshold

eststo feologit_er2

feologit js_composite i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job, group(pid) vce(cl pid) threshold

eststo feologit_er3

feologit js_composite i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize, group(pid) vce(cl pid) threshold

eststo feologit_er4

feologit js_composite i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.fsize i.address, group(pid) vce(cl pid) threshold

eststo feologit_er5

esttab feologit_er1 feologit_er2 feologit_er3 feologit_er4 feologit_er5 using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\lbsresultcluster.csv", se scalars(N_true N_group r2_p ll) order(*.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years) drop(*.address *.fsize *.job cut1 cut2 cut3 cut4 cut5 cut6 cut7 cut8 cut9 cut10 cut11 cut12 cut13 cut14 cut15 cut16 cut17 cut18 cut19 cut20) unstack label nomtitle replace b(%5.4f) se(%5.4f)

* 2 Stages Predictors Substitution 기반 IV Estimation을 위한 근로시간 벡터 1단계 추정 후 예측 근로시간 추출 (Eq.4.2& 4.3만) => Therefore, causal inference

foreach dependent in worktime worktime_sq {
	
	reghdfe `dependent' i.cluster#c.labor_shortage_rate wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years, absorb(i.pid i.job i.fsize i.address) vce(cl pid)
	
	predict double xb_`dependent', xb
	
	gen xb_`dependent'_clean = xb_`dependent' if e(sample)
	
	drop xb_`dependent'
	
	rename xb_`dependent'_clean xb_`dependent'
}

* 강건성 검증 1 : OLS Fitted Value vs Real Observation

foreach h_vector in worktime worktime_sq {
	
	reg `h_vector' xb_`h_vector', cluster(pid)
	
}

* 강건성 검증 2 : T-Test (1단계 추정모형의 적합성 검증)

foreach h_vector in worktime worktime_sq {
	
	ttest `h_vector' = xb_`h_vector'
	
}

gen worktime_40_xb = (xb_worktime > 40) if xb_worktime ~=.

* Average Causal Response & Compliance Visualization using CDF (각 클러스터별 쿼터 Low IV vs High IV weight 비교) (Figure 8)

save "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", replace

* Step 1. Low IV CDF 저장
forvalues c = 1/4 {
    use "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", clear
    keep if cluster == `c'
    gen bin = round(xb_worktime, 0.1)
    xtile lsr_q = labor_shortage_rate, nq(4)
    gen low_IV = lsr_q == 1
    keep if low_IV == 1
    gen one = 1
    collapse (sum) N=one, by(bin)
    gen cum_low = sum(N)
    gen total_low = cum_low[_N]
    gen cdf_low = cum_low / total_low
    tempfile low`c'
    save `low`c'', replace
}

* Step 2. High IV CDF 저장
forvalues c = 1/4 {
    use "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", clear
    keep if cluster == `c'
    gen bin = round(xb_worktime, 0.1)
    xtile lsr_q = labor_shortage_rate, nq(4)
    gen high_IV = lsr_q == 4
    keep if high_IV == 1
    gen one = 1
    collapse (sum) N=one, by(bin)
    gen cum_high = sum(N)
    gen total_high = cum_high[_N]
    gen cdf_high = cum_high / total_high
    tempfile high`c'
    save `high`c'', replace
}

* Step 3. Merge 후 CDF gap 계산
forvalues c = 1/4 {
    use `low`c'', clear
    merge 1:1 bin using `high`c'', nogenerate
    gen gap = cdf_low - cdf_high
    gen cluster = `c'
    tempfile temp`c'
    save `temp`c'', replace

}

* 합치기
use `temp1', clear
foreach c in 2 3 4 {
    append using `temp`c''
}

* 정규화해서 weight function 생성
gen weight = .
levelsof cluster, local(clus)
foreach c of local clus {
    gen gap_`c' = gap if cluster == `c'
    egen total_`c' = total(gap_`c')
    replace weight = gap / total_`c' if cluster == `c'
    drop gap_`c' total_`c'
}

* 시각화
twoway ///
    (line gap bin if cluster==1 & bin > 25, lcolor(blue) lpattern(dot)) ///
    (line gap bin if cluster==2 & bin > 25, lcolor(green) lpattern(dash)) ///
    (line gap bin if cluster==3 & bin > 25, lcolor(orange) lpattern(dash)) ///
    (line gap bin if cluster==4 & bin > 25, lcolor(red) lpattern(dash)), ///
    xlabel(25(5)55, labsize(small)) ///
    xscale(range(25 55)) ///
    ytitle("CDF(Low LSR) − CDF(High LSR)", size(small)) ///
    xtitle("Fitted Working Hours (Rounded at 0.5 hours)", size(small)) ///
    legend(order(1 "Cluster 1 (Placebo)" 2 "Cluster 2" 3 "Cluster 3" 4 "Cluster 4") ///
           row(1) position(12) size(small) region(lstyle(none)))
		   
twoway ///
    (line weight bin if cluster==1 & bin > 25, lcolor(blue) lpattern(dot)) ///
    (line weight bin if cluster==2 & bin > 25, lcolor(green) lpattern(dash)) ///
    (line weight bin if cluster==3 & bin > 25, lcolor(orange) lpattern(dash)) ///
    (line weight bin if cluster==4 & bin > 25, lcolor(red) lpattern(dash)), ///
    xlabel(25(5)55, labsize(small)) ///
    xscale(range(25 55)) ///
    ytitle("CDF(Low LSR) − CDF(High LSR)", size(small)) ///
    xtitle("Fitted Working Hours (Rounded at 0.5 hours)", size(small)) ///
    legend(order(1 "Cluster 1 (Placebo)" 2 "Cluster 2" 3 "Cluster 3" 4 "Cluster 4") ///
           row(1) position(12) size(small) region(lstyle(none)))
		   
save "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\acr.dta", replace

* Average Causal Response & Compliance Visualization using CDF (클러스터 1 기준 Low IV vs 2,3,4 High IV weight 비교)

* 클러스터별 CDF 계산
forvalues c = 1/4 {
    use "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", clear
    keep if cluster == `c'
    gen bin = round(xb_worktime, 0.1)
    gen one = 1
    collapse (sum) N=one, by(bin)
    gen cum = sum(N)
    gen total = cum[_N]
    gen cdf = cum / total
    tempfile clus`c'
    save `clus`c'', replace
}

* Cluster 1 기준으로 병합 후 갭 계산
use `clus1', clear
rename cdf cdf1

forvalues c = 2/4 {
    merge 1:1 bin using `clus`c'', nogenerate
    rename cdf cdf`c'
}

gen gap_2 = cdf1 - cdf2
gen gap_3 = cdf1 - cdf3
gen gap_4 = cdf1 - cdf4

twoway ///
    (line gap_2 bin if bin > 25, lcolor(green) lpattern(dash)) ///
    (line gap_3 bin if bin > 25, lcolor(orange) lpattern(dot)) ///
    (line gap_4 bin if bin > 25, lcolor(red) lpattern(longdash)), ///
    xlabel(25(5)55, labsize(small)) ///
    xscale(range(25 55)) ///
    ytitle("CDF(Cluster 1) − CDF(Cluster c)", size(small)) ///
    xtitle("Fitted Working Hours (Rounded)", size(small)) ///
    legend(order(1 "Gap: C1 − C2" 2 "Gap: C1 − C3" 3 "Gap: C1 − C4") ///
           row(1) position(12) size(small) region(lstyle(none))) ///
    title("Relative ACR Weights: Cluster 1 vs Others")

save "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\acr_intra.dta", replace

use "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", replace

* 2SPS-IV Estimates of Overtime Effects on Job Satisfaction (Equation 4.7 and 4.8) (Table 13)

**Equation 4.7

feologit js_composite xb_worktime xb_worktime_sq wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.industry i.fsize i.address, threshold group(pid) vce(cl pid)

eststo feologit_iv1_simple

**Equation 4.8

feologit js_composite xb_worktime xb_worktime_sq i.worktime_40_xb#c.xb_worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years i.job i.industry i.fsize i.address, group(pid) vce(cl pid) threshold

eststo feologit_iv2_simple

esttab feologit_iv1_simple feologit_iv2_simple using "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\simple2SPS.csv", se scalars(N_true N_group r2_p ll) order(xb_worktime xb_worktime_sq 1.worktime_40_xb#c.xb_worktime wage_h age edu_scale number_household spouse_exist nonlaborinc_mon foe11 foe13 paid_vac pub_soc tenured_years) drop(0.worktime_40_xb#c.xb_worktime *.address *.fsize *.job cut1 cut2 cut3 cut4 cut5 cut6 cut7 cut8 cut9 cut10 cut11 cut12 cut13 cut14 cut15 cut16 cut17 cut18 cut19 cut20) unstack label nomtitle replace b(%5.4f) se(%5.4f)

save "D:\THESIS\Impact of working hours on burn-out syndrome\Data set\final_data_lsr.dta", replace