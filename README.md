read and plot SBE CTD cnv-files
================
Marko Lipka, David Kaiser
2021-03-21

`read.cnv.file()` function takes a filename of a .cnv file as argument
and returns a data.frame.

`plot.CTD.data()` function

-   takes the output of `read.cnv.file()` and returns a facetted ggplot.
-   optional arguments:
    -   depvar: character (vector) of parameter(s) that should be used
        as depth axis. First match in parameter names will be used if
        multiple parameters are defined.
    -   not2plot: character (vector) of parameter(s) that should not be
        plotted. default is a list of common metadata parameters like
        “*scan*”, “*nbin*”, “*flag*”, “*latitude*”, …

# Examples

## V0001F01.cnv

``` r
Ex1 <- read.cnv.file("example data/V0001F01.cnv")

knitr::kable(head(Ex1$data))
```

| depSM |    prDM |  c0mS.cm |  c1mS.cm |  t090C |  t190C |   sal00 |   sal11 | sbeox0ML.L | sbeox1ML.L |    svCM | oxsatML.L |     altM |    par |   spar | flECO.AFL | turbWETntu0 | nbf |  upoly0 |  upoly1 |  timeS | scan | sigma.é00 | flag | nbin |
|------:|--------:|---------:|---------:|-------:|-------:|--------:|--------:|-----------:|-----------:|--------:|----------:|---------:|-------:|-------:|----------:|------------:|----:|--------:|--------:|-------:|-----:|----------:|-----:|-----:|
|  1.50 | 1.36001 | 14.16115 | 14.16036 | 6.1272 | 6.1251 | 13.2087 | 13.2088 |    8.65394 |    8.74601 | 1447.91 |   7.95670 | 17.55465 | 402.87 | 1012.2 |    1.4015 |     0.29254 |   0 | 0.04206 | 0.04201 | -3.638 |  -86 |   10.3704 |    0 |   92 |
|  1.75 | 1.61264 | 14.16280 | 14.16364 | 6.1245 | 6.1219 | 13.2115 | 13.2133 |    8.65493 |    8.72731 | 1447.90 |   7.95708 | 16.83636 | 386.34 | 1241.7 |    1.2540 |     0.29134 |   0 | 0.04205 | 0.04213 | 14.117 |  340 |   10.3727 |    0 |   95 |
|  2.00 | 1.86478 | 14.16379 | 14.16305 | 6.1236 | 6.1211 | 13.2128 | 13.2130 |    8.65435 |    8.73503 | 1447.91 |   7.95719 | 16.97811 | 365.78 | 1247.6 |    1.3204 |     0.29062 |   0 | 0.04192 | 0.04212 | 17.178 |  413 |   10.3738 |    0 |   68 |
|  2.25 | 2.11683 | 14.16334 | 14.16383 | 6.1227 | 6.1207 | 13.2126 | 13.2138 |    8.65487 |    8.74630 | 1447.91 |   7.95737 | 16.75866 | 336.83 | 1246.8 |    1.3079 |     0.29237 |   0 | 0.04172 | 0.04213 | 18.940 |  456 |   10.3737 |    0 |   34 |
|  2.50 | 2.36962 | 14.16532 | 14.16366 | 6.1229 | 6.1206 | 13.2145 | 13.2137 |    8.65615 |    8.72256 | 1447.91 |   7.95724 | 16.53253 | 306.92 | 1250.1 |    1.3161 |     0.29388 |   0 | 0.04189 | 0.04196 | 20.410 |  491 |   10.3752 |    0 |   31 |
|  2.75 | 2.62119 | 14.16302 | 14.16275 | 6.1224 | 6.1208 | 13.2122 | 13.2126 |    8.65235 |    8.73113 | 1447.91 |   7.95746 | 16.25545 | 282.55 | 1245.4 |    1.3918 |     0.28734 |   0 | 0.04177 | 0.04188 | 21.853 |  525 |   10.3735 |    0 |   41 |

``` r
pander(Ex1$meta)
```

*ReiseNr = EMB-100*, *StationNr= 0001*, *EinsatzNr= 0001*, *SerieNr = 01
Operator= Kiki*, *StatBez = STOL aus .eMission.*, *Startzeit= 09:18:13
09-APR-15*, *GPS\_Posn = 54 15.3678N 11 56.7485E*, *Echolote = 18.54 m*,
*Luftdruck= 1028.6 hPa*, *ThermoSal= 6.274 grdC 13.02 ppth* and
*WsStartID= 1*

``` r
plot.CTD.data(Ex1)
```

![](README_files/figure-gfm/Example1-1.png)<!-- -->

## P0009F01.cnv

``` r
Ex2 <- read.cnv.file("example data/P0009F01.cnv")

knitr::kable(head(Ex2$data))
```

| depSM |    prDM |  c0mS.cm |   t090C |   sal00 | sbeox0ML.L |    svCM | oxsatML.L |     altM | spar | flECO.AFL | turbWETntu0 | nbf | latitude | longitude |  timeS | scan | sigma.é00 | flag | nbin |
|------:|--------:|---------:|--------:|--------:|-----------:|--------:|----------:|---------:|-----:|----------:|------------:|----:|---------:|----------:|-------:|-----:|----------:|-----:|-----:|
|  6.00 | 5.94454 | 23.47002 | 14.4042 | 18.2368 |    6.44049 | 1485.34 |   6.38187 | 120.4128 |    0 |   0.28637 |     0.46429 |   0 |   44.697 |   31.4564 | 15.945 |  384 |   13.2020 |    0 |  710 |
|  6.25 | 6.19658 | 23.47004 | 14.4042 | 18.2368 |    6.44113 | 1485.34 |   6.38188 | 123.2926 |    0 |   0.28241 |     0.46385 |   0 |   44.697 |   31.4564 | 29.884 |  718 |   13.2019 |    0 |   17 |
|  6.50 | 6.44872 | 23.47012 | 14.4042 | 18.2368 |    6.44125 | 1485.35 |   6.38188 | 131.2332 |    0 |   0.27295 |     0.46274 |   0 |   44.697 |   31.4564 | 30.678 |  737 |   13.2020 |    0 |   19 |
|  6.75 | 6.70098 | 23.47121 | 14.4062 | 18.2367 |    6.44137 | 1485.36 |   6.38161 | 129.1096 |    0 |   0.27584 |     0.46556 |   0 |   44.697 |   31.4564 | 31.517 |  757 |   13.2016 |    0 |   23 |
|  7.00 | 6.95274 | 23.47125 | 14.4059 | 18.2369 |    6.44155 | 1485.36 |   6.38165 | 126.9133 |    0 |   0.28945 |     0.46188 |   0 |   44.697 |   31.4564 | 32.671 |  785 |   13.2017 |    0 |   34 |
|  7.25 | 7.20464 | 23.47110 | 14.4056 | 18.2368 |    6.44189 | 1485.36 |   6.38171 | 135.6922 |    0 |   0.28379 |     0.47353 |   0 |   44.697 |   31.4564 | 34.233 |  823 |   13.2018 |    0 |   36 |

``` r
pander(Ex2$meta)
```

*StationNr= 0009*, *EinsatzNr= 0009*, *SerieNr = 01 Operator= Krueger*,
*StatBez = MSM33/28 aus .eMission.*, *Startzeit= 03:41:07 12-Nov-13*,
*GPS\_Posn = 44 41.8229N 031 27.3851E*, *Echolote = m 153.2 m*,
*Luftdruck= 1023.7 hPa*, *ThermoSal= 14.408 grdC 18.254 ppth* and
*WsStartID= 76*

``` r
plot.CTD.data(Ex2)
```

![](README_files/figure-gfm/Example2-1.png)<!-- -->

``` r
plot.CTD.data(Ex2, depvar = "prDM")
```

![](README_files/figure-gfm/Example2-2.png)<!-- -->

``` r
plot.CTD.data(Ex2, depvar = "sigma.é00", not2plot = c("flag", "nbin", "nbf", "upoly0", "upoly1"))
```

![](README_files/figure-gfm/Example2-3.png)<!-- -->

``` r
plot.CTD.data(Ex2, not2plot = "par")
```

![](README_files/figure-gfm/Example2-4.png)<!-- -->

## Example CNV-files from other sources

### Savannah

via mail from [SimplySav101](https://github.com/SimplySav101)

``` r
Sav <- read.cnv.file("example data/Savannah/2017-03-10T075604 SBE02501006.cnv")

knitr::kable(head(Sav$data))
```

|  prdM |  t090C |  c0uS.cm | sbox0Mm.Kg | flECO.AFL | turbWETntu0 |    upoly0 |    upoly1 | flag |
|------:|-------:|---------:|-----------:|----------:|------------:|----------:|----------:|-----:|
| 0.124 | 5.1496 | 9.369485 |   -100.279 |   -0.3196 |     -0.2622 | 0.0475319 | 0.0485237 |    0 |
| 0.118 | 5.1406 | 9.369485 |    508.636 |   -0.3188 |     -0.2619 | 0.0476081 | 0.0486000 |    0 |
| 0.115 | 5.1311 | 9.540741 |   1010.594 |   -0.3196 |     -0.2619 | 0.0475319 | 0.0485237 |    0 |
| 0.121 | 5.1225 | 9.637391 |    549.142 |   -0.3203 |     -0.2622 | 0.0476081 | 0.0485237 |    0 |
| 0.109 | 5.1139 | 9.564480 |    717.860 |   -0.3196 |     -0.2622 | 0.0475319 | 0.0485237 |    0 |
| 0.111 | 5.1053 | 9.954473 |    841.882 |   -0.3196 |     -0.2622 | 0.0476081 | 0.0486000 |    0 |

``` r
pander(Sav$meta)
```

*Station: SH*, *Depth: 50.0 m*, *Latitude: 60 40.277 N*, *Longitude: 145
52.522 W*, *AKST (time): 10 Mar 2017 07:56*, *Cruise: LTM2017-01* and
*Comment: Touched bottom*

``` r
plot.CTD.data(Sav)
```

![](README_files/figure-gfm/Savannah-1.png)<!-- -->

### Github

-   <https://github.com/castelao/seabird>
-   <https://github.com/NatalyaEvans/cnv_concatenator>
-   <https://github.com/labons/cnv_reader>
-   <https://github.com/cmunozmas/plot_raw_ctd>

``` r
path_CNVs <- "example data/fromGithub/"

files <- list.files(path = path_CNVs, 
                    pattern = "\\.cnv$",
                    full.names = TRUE,
                    recursive = T, ignore.case = T)

for(file in files){
    print(file)
    import <- read.cnv.file(file)
    print(plot.CTD.data(import))
}
```

    ## [1] "example data/fromGithub//from castelao_seabird/dPIRX003.cnv"

    ## Warning: Removed 4 row(s) containing missing values (geom_path).

![](README_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

    ## [1] "example data/fromGithub//from castelao_seabird/dPIRX010.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-2.png)<!-- -->

    ## [1] "example data/fromGithub//from castelao_seabird/Hotin.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-3.png)<!-- -->

    ## [1] "example data/fromGithub//from castelao_seabird/PIRA001.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-4.png)<!-- -->

    ## [1] "example data/fromGithub//from castelao_seabird/sta0860.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-5.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_01.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-6.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_02.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-7.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_03.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-8.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_04.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-9.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_05.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-10.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_06.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-11.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_07.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-12.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_08.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-13.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_09.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-14.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/dradmed_10.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-15.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_02.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-16.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_03.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-17.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_04.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-18.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_05.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-19.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_06.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-20.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_07.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-21.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_08.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-22.png)<!-- -->

    ## [1] "example data/fromGithub//from cmunozmas_plot_raw_ctd/ds2_085.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-23.png)<!-- -->

    ## [1] "example data/fromGithub//from labons_cnv_reader/PIRA001.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-24.png)<!-- -->

    ## [1] "example data/fromGithub//from labons_cnv_reader/TSG_PIR_001.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-25.png)<!-- -->

    ## [1] "example data/fromGithub//from NatalyaEvans_cnv_concatenator/Station00_test_cast1.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-26.png)<!-- -->

    ## [1] "example data/fromGithub//from NatalyaEvans_cnv_concatenator/Station01_test_cast2.cnv"

![](README_files/figure-gfm/unnamed-chunk-1-27.png)<!-- -->
