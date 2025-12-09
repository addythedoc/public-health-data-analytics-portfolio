/******************************************************************
Project: Timely Initiation of Breastfeeding – Ethiopia DHS 2016
Author: Aditya Kumar

NOTE:
- DHS data (ETKR71FL) are restricted and NOT included in this repo.
- To reproduce results, obtain DHS data from the DHS Program and
  place ETKR71FL.sas7bdat in a local directory.

******************************************************************/

/* Example LIBNAME used in SAS Studio
   For GitHub, you should comment this out and adjust the path locally. */

libname C "/home/u63130541/Ethiopia";
/* For GitHub version, use:
   * libname C "/path/to/local/Ethiopia";
*/


/*==================================================================
  1. CREATE ANALYSIS DATASET WITH RECODED VARIABLES
==================================================================*/

data data1;
    set C.ETKR71FL;
    sweight = v005/1000000;

    /* Mother's age: 3 groups */
    if v013 in (1, 2) then age2 = 0;     *15–24;
    else if v013 in (3, 4) then age2 = 1; *25–34;
    else if v013 in (5, 6, 7) then age2 = 2; *35–49;

    /* Marital status */
    if v501 = 0 then marital2 = 0;              /* Never married */
    else if v501 in (1, 2) then marital2 = 1;   /* Married/living together */
    else if v501 in (3, 4, 5) then marital2 = 2;/* Divorced/separated/widowed */

    /* Education */
    if v106 = 0 then edu2 = 0;              /* No education */
    else if v106 = 1 then edu2 = 1;         /* Primary */
    else if v106 in (2, 3) then edu2 = 2;   /* Secondary or higher */

    /* Parity */
    if v201 = 1 then pa2 = 0;                         /* One child */
    else if 2 <= v201 and v201 <= 4 then pa2 = 1;     /* 2–4 children */
    else if v201 >= 5 then pa2 = 2;                   /* 5+ children */

    /* Respondent currently working */
    if v714 = 0 then work2 = 0;   /* Not working */
    else if v714 = 1 then work2 = 1;   /* Working */

    /* Wealth Index Combined */
    if v190 in (1, 2) then wealth2 = 0;   /* Poor */
    else if v190 = 3 then wealth2 = 1;    /* Middle */
    else if v190 in (4, 5) then wealth2 = 2;   /* Rich */

    /* Health insurance */
    if v481 = 0 then hlthin2 = 0;  *No;
    else if v481 = 1 then hlthin2 = 1; *Yes;

    /* Type of residence */
    if v025 = 2 then residence2 = 0; /* Rural */
    else if v025 = 1 then residence2 = 1; /* Urban */

    /* Number of antenatal visits during pregnancy */
    if m14 = 0 then anc2 = 0;                     *None;
    else if 1 <= m14 and m14 <= 3 then anc2 = 1;  /* 1–3 visits */
    else if m14 >= 4 then anc2 = 2;               /* 4+ visits (recommended) */

    /* Place of delivery */
    if M15 in (21,22,23,24,25,26) then plc2 = 0;   *Public facility;
    else if M15 in (31,32,33,34,35,36) then plc2 = 1; *Private facility;
    else if M15 in (11,12) then plc2 = 2;          *Home;
    else if M15 in (41,46,96) then plc2 = 3;       *Other;

    /* Delivery by caesarean section */
    if m17 = 0 then cs2 = 0;  /* Not by C-section */
    else if m17 = 1 then cs2 = 1;  /* C-section */

    /* Child's age in months */
    cage2 = b19;

    /* Assistance during delivery – detailed provider type */
    if cage2 < 24 then do;
        if not missing(m3a) then delivery2 = 0;
        if m3n = 1 then delivery2 = 7;  *No one;
        if m3i = 1 or m3j = 1 or m3k = 1 or m3l = 1 or m3m = 1 then delivery2 = 6; *Relative/other;
        if m3h = 1 then delivery2 = 5;  *Other health worker;
        if m3g = 1 then delivery2 = 4;  *TBA;
        if m3c = 1 or m3d = 1 or m3e = 1 or m3f = 1 then delivery2 = 3; *Other professional;
        if m3b = 1 then delivery2 = 2;  *Nurse/midwife;
        if m3a = 1 then delivery2 = 1;  *Doctor;
        if m3a in (8, 9) then delivery2 = 9;
    end;

    /* Skilled provider during delivery (collapsed) */
    if cage2 < 24 then do;
        skilled = delivery2;
        if delivery2 in (1, 2) then skilled2 = 0;      *Skilled provider;
        else if delivery2 in (3, 4, 5, 6) then skilled2 = 1; *Unskilled provider;
        else if delivery2 = 7 then skilled2 = 2;       *No one;
    end;

    /* Sex of the child */
    if b4 = 2 then sex2 = 0;  /* Female */
    else if b4 = 1 then sex2 = 1;  /* Male */

    /* Nutritional counseling during antenatal care */
    if anc2 = 0 then nc2 = 0;  *No ANC and no nutritional counselling;
    else if anc2 > 0 then do;
        if s413d = 0 then nc2 = 0;  /* Did not receive nutritional counseling */
        else if s413d = 1 then nc2 = 1;  /* Received nutritional counseling */
    end;

    /* Start breastfeeding within 1 hour */
    if midx = 1 and cage2 < 24 then do;
        bfi = 0;  *No;
        if (m4 not in (94, 99)) and (m34 ge 0 and m34 le 100) then bfi = 1; *Yes;
    end;

    /* Eligible population flag */
    if bfi = . or nc2 = . or age2 = . or marital2 = . or edu2 = . or
       pa2 = . or work2 = . or wealth2 = . or hlthin2 = . or residence2 = . or
       anc2 = . or plc2 = . or cs2 = . or skilled2 = . or sex2 = . then elgpop = .;
    else elgpop = 1;

run;


/*==================================================================
  2. DESCRIPTIVE STATISTICS
==================================================================*/

*Descriptive statistics;
proc surveyfreq data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    tables elgpop *
           (age2 marital2 edu2 pa2 work2 wealth2
            hlthin2 residence2 anc2 plc2 cs2 skilled2 sex2 nc2 bfi);
run;


/*==================================================================
  3. BIVARIATE ANALYSES
==================================================================*/

*Bivariate analyses;
proc surveyfreq data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    tables elgpop *
           (age2 marital2 edu2 pa2 work2 wealth2
            hlthin2 residence2 anc2 plc2 cs2 skilled2 sex2 nc2)
           * bfi / row chisq;
run;


/*==================================================================
  4. UNADJUSTED LOGISTIC REGRESSION
==================================================================*/

*Unadjusted regression analyses;
proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class age2 (ref="0") / param=ref;
    model bfi(event="1") = age2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class marital2 (ref="0") / param=ref;
    model bfi(event="1") = marital2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class edu2 (ref="0") / param=ref;
    model bfi(event="1") = edu2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class pa2 (ref="0") / param=ref;
    model bfi(event="1") = pa2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class work2 (ref="0") / param=ref;
    model bfi(event="1") = work2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class wealth2 (ref="0") / param=ref;
    model bfi(event="1") = wealth2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class residence2 (ref="0") / param=ref;
    model bfi(event="1") = residence2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class anc2 (ref="0") / param=ref;
    model bfi(event="1") = anc2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class plc2 (ref="0") / param=ref;
    model bfi(event="1") = plc2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class cs2 (ref="0") / param=ref;
    model bfi(event="1") = cs2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class skilled2 (ref="0") / param=ref;
    model bfi(event="1") = skilled2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class sex2 (ref="0") / param=ref;
    model bfi(event="1") = sex2;
run;

proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class nc2 (ref="0") / param=ref;
    model bfi(event="1") = nc2;
run;


/*==================================================================
  5. MULTIVARIABLE-ADJUSTED LOGISTIC REGRESSION
==================================================================*/

*Multivariable-adjusted regression;
proc surveylogistic data = data1;
    cluster v021;
    strata  v023;
    weight  sweight;
    domain elgpop;
    class age2 (ref="0")
          marital2 (ref="0")
          edu2 (ref="0")
          pa2 (ref="0")
          work2 (ref="0")
          wealth2 (ref="0")
          hlthin2 (ref="0")
          residence2 (ref="0")
          anc2 (ref="0")
          plc2 (ref="0")
          cs2 (ref="0")
          skilled2 (ref="0")
          sex2 (ref="0")
          nc2 (ref="0") / param=ref;
    model bfi(event="1") =
          age2 marital2 edu2 pa2 work2 wealth2
          hlthin2 residence2 anc2 plc2 cs2 skilled2 sex2 nc2;
run;

