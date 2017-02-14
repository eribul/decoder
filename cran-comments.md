Dear CRAN maintainer!

Previous submission of the package had 1 error for an older version for Windows:
* This has been fixed

There were also some problems with Solaris and Release version for Mac.
* These are not fixeed but I have found that the problem arise frmo the DT package 
I have informed the authors about the problem (also evident from their CRAN checks).
I hope they will take care of it and I think my warnings will disapear as soon as they fix the problem on their side. (This seems to be a problem for several packages at the time.)

Best Regards!
Erik B

---

Dear maintainer,

please see
https://cran.r-project.org/web/checks/check_results_decoder.html

and find your package fails under R-oldrelease (R < 3.3.0).

Please fix by not using the function or declare a proper version dependency.

Please also fix the warnings on some platforms.

Please fix and resubmit.

Best,
Uwe Ligges
