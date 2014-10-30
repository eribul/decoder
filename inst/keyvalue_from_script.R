############################### Sjukvårdsområde ################################

# Currently only for Region Väst but could be extended in the future

sjukvardsomrade <-
    list(
        Storgoteborg    = c(1401,1402,1407,1480,1481),
        Fyrbodal        = c(1421,1427,1430,1435,1438,1439,1460,1461,1462,1484,1485,1486,1487,1488,1492),
        Sodra_Alvsborg  = c(1441,1442,1443,1452,1463,1465,1466,1489,1490,1491),
        Skaraborg       = c(1444,1445,1446,1447,1470,1471,1472,1473,1493,1494,1495,1496,1497,1498,1499),
        Norra_Halland   = c(1382,1383,1384),
        Kungalv         = c(1482, 1415, 1419, 1440)
    )
sjukvardsomrade <- as.keyvalue(sjukvardsomrade)



#################################### Region ####################################
region <- c(`Stockholm/Gotland` = 1, `Uppsala/Örebro` = 2, Sydost = 3, Syd = 4, Väst = 5, Norr = 6)
region <- as.keyvalue(region, standard_var_names = "Region")



##################################### Kön ######################################

kon <- c(Man = 1, Kvinna = 2)
kon <- as.keyvalue(kon, standard_var_names =  c("KON_VALUE", "kön", "sex"))


