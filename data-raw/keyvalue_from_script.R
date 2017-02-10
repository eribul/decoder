############################### Sjukvårdsområde ################################

# Currently only for Region Väst but could be extended in the future

sjukvardsomrade <-
  list(
    Storgoteborg    = c(1401, 1402, 1407, 1480, 1481),
    Fyrbodal        = c(1421, 1427, 1430, 1435, 1438, 1439, 1460, 1461, 
                        1462, 1484, 1485, 1486, 1487, 1488, 1492 ),
    Sodra_Alvsborg  = c(1441, 1442, 1443, 1452, 1463, 1465, 1466, 1489, 1490, 
                        1491),
    Skaraborg       = c(1444, 1445, 1446, 1447, 1470, 1471, 1472, 1473, 1493, 
                        1494, 1495, 1496, 1497, 1498, 1499 ),
    Norra_Halland   = c(1382, 1383, 1384),
    Kungalv         = c(1482, 1415, 1419, 1440)
  )
sjukvardsomrade <- as.keyvalue(sjukvardsomrade)



#################################### Region ####################################
region <- 1:6
names(region) <- paste("Region", 
  c("Sthlm/Gotland", "Uppsala/Örebro", "Sydöstra", "Syd", "Väst", "Norr"))

region <- as.keyvalue(region, standard_var_names = "region")


##################################### Kön ######################################

kon <- c(Man = 1, Kvinna = 2)
kon <- as.keyvalue(kon, standard_var_names =
                     c("kon_value", "kön", "kon", "sex"))


##################################### Avgångsmarkering #########################

avgm <-
  c(
    `lever i regionen`         = NA,
    `utflyttad ur regionen`    = 1,
    avliden                    = 2,
    `obefintlig (sep-06)`      = 4,
    utvandrad                  = 5,
    `Tekniskt avreg (sep-06)`  = 6,
    `okänd ej från Västfolket` = 7,
    `okänt enl bestånd 991007` = 8,
    okänd                      = 9
  )
avgm <- as.keyvalue(avgm, standard_var_names =  c("avgm"))


##################################### Manuell #########################

manuell <-
  as.keyvalue(c(ja = 1), standard_var_names =  c("manuell"))


##################################### ben #########################

ben <-
  as.keyvalue(c(malign = NA, benign = 3), standard_var_names =  c("ben"))


##################################### digr #########################
digr <- c(
  `klinisk us`                     = 1,
  rtg                              = 2,
  `provex. el op m pad`            = 3,
  `obduktion m pad`                = 4,
  `cyt us`                         = 5,
  `op utan pad`                    = 6 ,
  `obduktion utan pad`             = 7,
  `annan labundersökning (sep-03)` = 8
)

digr <- as.keyvalue(digr, standard_var_names =  c("digr"))


##################################### obd #########################

obd <- as.keyvalue(
  c(
    `tumören upptäckt vid obduktion` = 1,
    `tumören känd innan obduktion`   = 2
  ),
  standard_var_names =  c("obd")
)

##################################### dödca #########################

dödca <- 
  as.keyvalue(
    c(
      ja                = 1,
      nej               = 2,
      `dödsorsak okänd` = 3
    ),
    standard_var_names =  c("dödca")
  )


##################################### status #########################

status <-
  as.keyvalue(
    c(
      ofullständig       = NA,
      fullständig        = 1,
      `skickad till SOS` = 2
    ),
    standard_var_names =  c("status")
  )
