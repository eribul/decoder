# incadata

<details>

* Version: 0.8.2
* Source code: https://github.com/cran/incadata
* URL: https://cancercentrum.bitbucket.io/incadata
* BugReports: https://www.bitbucket.org/cancercentrum/incadata/issues
* Date/Publication: 2019-05-05 20:30:04 UTC
* Number of recursive dependencies: 67

Run `revdep_details(,"incadata")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in 'incadata-Ex.R' failed
    The error most likely occurred in:
    
    > ### Name: dplyr_methods
    > ### Title: dplyr methods for INCA data
    > ### Aliases: dplyr_methods filter.incadata mutate.incadata arrange.incadata
    > ###   rename.incadata select.incadata slice.incadata summarise.incadata
    > ###   summarize.incadata group_by.incadata
    > ### Keywords: internal
    > 
    > ### ** Examples
    > 
    > x <- dplyr::slice(as.incadata(incadata::ex_data), 1:10)
    The following variables have new formats: 
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in 'tests/testthat.R' failed.
    Last 13 lines of output:
      [90m 13. [39mdecoder:::decode.default(x[[d$x.var]], d$value)
      [90m 15. [39mdecoder:::as.keyvalue.default(keyvalue)
      [90m 16. [39mbase::exists(x, envir = as.environment("package:decoder"))
      
      == testthat results  ===========================================================
      [ OK: 104 | SKIPPED: 5 | WARNINGS: 0 | FAILED: 6 ]
      1. Error: (unknown) (@test-as.incadata.data.frame.R#3) 
      2. Error: (unknown) (@test-as.incadata.data.frame.R#3) 
      3. Error: print.incadata (@test-misc.R#4) 
      4. Error: print.incadata (@test-misc.R#4) 
      5. Error: (unknown) (@test-use_incadata.R#3) 
      6. Error: (unknown) (@test-use_incadata.R#3) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

