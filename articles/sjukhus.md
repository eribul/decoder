# Alternative hospital names

``` r

library(decoder)
```

## Bakgrund

Vad vi nedan menar med sjukhus omfattar i många fall även vårdcentraler
och privatläkare.

Paketet innehåller fyra olika kodverk för sjukhuskoder:

| keyvalue     | Källa                         | Antal |
|--------------|-------------------------------|------:|
| sjukhus_inca | Organisationsregistret i INCA |  4467 |
| sjukhus      | Rockan                        |   690 |
| sjukhus_par  | SOS Patientregistret          |   452 |

## sjukhus_inca

Detta kodverk baseras på organisationsenhetsregistret i INCA. Här
inkluderas både aktiva INCA-inrapporterande enheter, samt historiska
eheter inlästa från historiska data.

Se
[`?sjukhus_inca`](https://eribul.github.io/decoder/reference/sjukhus_inca.md)
för mer info.

## sjukhus

Dessa koder hämtas från Rockan, det äldre systemet för cancer- och
kvalitetsregister som historiskt använts av regionerna Väst och Norr.
Dessa koder var de första att inkluderas i paketet. Nyare enheter
(exempelvis Angereds Närsjukhus i Göteborg) saknas i denna lista.

Se [`?sjukhus`](https://eribul.github.io/decoder/reference/sjukhus.md)
för mer info.

## sjukhus_par

Koder som används i Socialstyrelsnes Patientregister. Denna förteckning
avser endast sjukhus och endast de enheter som var aktuella 2014 (vilket
var senaste året en sådan lista sammanställdes).

Se
[`?sjukhus_par`](https://eribul.github.io/decoder/reference/sjukhus_par.md)
för mer info.

## Samma kod kan ge olika klartext

Även om samma kod hanteras av fler än ett kodverk så kan namnet i
klartext vara olika:

| key | inca | par | rockan |
|:---|:---|:---|:---|
| 10010 | SABBATSBERGS SJUKHUS | Sabbatsbergs sjukhus | Sabbatsbergs sjukhus |
| 10011 | Capio S:t Görans sjukhus | S:t Görans sjukhus | S:t Görans sjukhus |
| 10012 | S:T ERIKS SJUKHUS | S:t Eriks sjukhus | S:t Eriks sjukhus |
| 10013 | Södersjukhuset | Södersjukhuset | Södersjukhuset |
| 10481 | Ersta sjukhus | Ersta sjukhus | Ersta sjukhus, Stockholm |
| 10483 | Sophiahemmet | Sophiahemmet | Sophiahemmet |
| 10501 | ASIH LÅNGBRO PARK | Långbro sjukhus | Långbro sjukhus |
| 10502 | BECKOMBERGA SJUKHUS | Beckomberga sjukhus | Beckomberga sjukhus |
| 10503 | NORRTULLS SJUKHUS | Norrtulls sjukhus | Nortulls sjukhus |
| 11001 | KS Solna | Karolinska sjukhuset | Karolinska sjukhuset |
| 11002 | KS Huddinge | Huddinge sjukhus | Huddinge sjukhus |
| 11010 | Danderyds sjukhus | Danderyds sjukhus | Danderyds sjukhus |
| 11011 | Södertälje sjukhus | Södertälje sjukhus | Södertälje sjukhus |
| 11012 | Norrtälje sjukhus | Norrtälje sjukhus | Norrtälje sjukhus |
| 11013 | Löwenströmska sjukhuset | Löwenströmska sjukhuset | Löwenströmska sjukhuset |
| 11014 | Nacka Närsjh Proxima | Nacka sjukhus | Nacka sjukhus |
| 12001 | UAS | Akademiska sjukhuset | Akademiska sjukhuset |
| 12010 | Enköping las | Enköpings lasarett | Lasarettet i Enköping |
| 12481 | Elisabethsjukhuset | Elisabethkliniken | Elisabeth sjukhus |
| 13010 | Eskilstuna M.sjh | Mälarsjukhuset | Eskilstuna lasarett |
| 13011 | Nyköping las | Nyköpings lasarett | Nyköpings lasarett |
| 13540 | KARSUDDENS SJUKHUS | Karsuddens sjukhus | Karsuddens sjukhus |
| 21001 | Linköping US | Universitetssjukhuset i Linköping | Regionsjukhuset i Linköping |
| 21011 | Finspång | Finspångs lasarett | Lasarettet i Finspång |
| 21013 | Norrköping ViN | Vrinnevisjukhuset | Centrallasarettet i Norrköping |
| 21014 | Motala | Motala lasarett | Lasarettet i Motala |
| 22010 | Jönköping | Ryhov, länssjukhus | Jönköpings lasarett |
| 22011 | Eksjö | Höglandssjukhuset | Eksjö-Nässjö lasarett |
| 22012 | Värnamo | Värnamo sjukhus | Värnamo lasarett |
| 23010 | Centrallasarettet i Växjö | Växjö lasarett | Växjö lasarett |
| 23011 | Ljungby lasarett | Ljungby lasarett | Ljungby lasarett |
| 24010 | Västervik | Västerviks sjukhus | Västerviks sjukhus |
| 25010 | Kalmar | Länssjukhuset Kalmar | Kalmar lasarett |
| 25011 | Oskarshamn | Oskarshamns sjukhus | Oskarshamns lasarett |
| 26010 | Visby Lasarett | Visby lasarett | Visby lasarett |
| 28010 | Centralsjukhuset i Kristianstad | Kristianstads sjukhus | Kristianstads centralsjukhus |
| 28011 | Ängelholms sjukhus | Ängelholms sjukhus | Ängelholms sjukhus |
| 28012 | Sjukhuset i Hässleholm | Hässleholms sjukhus | Hässleholms sjukhus |
| 28013 | Simrishamns praktiker tjänst | Simrishamns sjukhus | Simrishamns sjukhus |
| 30001 | Skånes universitetssjukhus-Malmö | Skånes Universitetssjukhus Malmö | Malmö Allmänna Sjukhus |
| 41001 | Skånes universitetssjukhus-Lund | Skånes Universitetssjukhus Lund | Lund Universitetssjukhus |
| 41010 | Landskrona lasarett | Landskrona lasarett | Landskrona lasarett |
| 41011 | Trelleborgs lasarett | Trelleborgs lasarett | Trelleborgs lasarett |
| 41012 | Helsingborgs lasarett | Helsingborgs lasarett | Helsingborgs lasarett |
| 41013 | Ystads lasarett | Ystads lasarett | Ystads lasarett |
| 42010 | Länssjukhuset i Halmstad | Hallands sjukhus Halmstad | Hallands sjukhus Halmstad |
| 42011 | Varberg | Hallands sjukhus Varberg | Hallands sjukhus Varberg |
| 42301 | Kungsbacka sjukhem | Kungsbacka sjukhus | Kungsbacka sjukhem |
| 50070 | Lundby | Lundby sjukhus | Capio Lundby Närsjukhus |
| 50071 | V:a Frölunda | Västra Frölunda sjukhus | Frölunda specialistsjukhus |
| 50410 | Vasa sjukhus | Vasa sjukhus | Vasa sjukhus |
| 51012 | Kungälv | Kungälvs sjukhus | Kungälvs sjukhus |
| 52012 | Alingsås | Alingsås lasarett | Alingsås lasarett |
| 54010 | Karlstad C.sjh | Karlstads sjukhus | Centralsjh, Karlstad |
| 54011 | Kristinehamns sjh | Kristinehamns sjukhus | Kristinehamn sjukhus |
| 54012 | Arvika sjh | Arvika sjukhus | Arvika sjukhus |
| 54013 | Säffle sjh | Säffle sjukhus | Säffle sjukhus |
| 54014 | Torsby sjh | Torsby sjukhus | Torsby sjukhus |
| 55010 | Örebro U.sjh | Universitetssjukhuset Örebro | Regionsjukhuset i Örebro |
| 55011 | Karlskoga las | Karlskoga lasarett | Karlskoga lasarett |
| 55012 | Lindesbergs las | Lindesbergs lasarett | Lindesbergs lasarett |
| 56010 | Västerås C.las | Västerås lasarett | Västerås lasarett |
| 56011 | Sala las | Sala lasarett | Sala lasarett |
| 56012 | Köping las | Köpings lasarett | Köpings lasarett |
| 56013 | Fagersta las | Fagersta lasarett | Fagersta lasarett |
| 57010 | Falun F.las | Falu lasarett | Falu lasarett |
| 57011 | Mora Las | Mora lasarett | Mora lasarett |
| 57012 | Ludvika las | Ludvika lasarett | Ludvika lasarett |
| 57013 | Avesta las | Avesta lasarett | Avesta lasarett |
| 57316 | Borlänge sjukhus | Borlänge sjukhus | Borlänge sjukhus |
| 57500 | Säters sjukhus | Säters sjukhus | Säters sjukhus |
| 61010 | Gävle sjh | Gävle sjukhus | Gävle sjukhus |
| 61011 | Bollnäs sjh | Bollnäs sjukhus | Bollnäs sjukhus |
| 61012 | Hudiksvalls sjh | Hudiksvalls sjukhus | Hudiksvalls sjukhus |
| 62010 | Sundsvalls sjukhus | Sundsvalls sjukhus | Sundsvalls sjukhus |
| 62011 | Öviks sjukhus | Örnsköldsviks sjukhus | Örnsköldsviks sjukhus |
| 62012 | Härnösands sjukhus | Härnösands sjukhus | Härnösands sjukhus |
| 62013 | Sollefteå sjukhus | Sollefteå sjukhus | Sollefteå sjukhus |
| 63010 | Östersunds sjukhus | Östersunds sjukhus | Östersunds sjukhus |
| 64001 | NUS Umeå | Norrlands Universitetssjukhus | Regionsjukhuset i umeå |
| 64010 | Skellefteå lasarett | Skellefteå lasarett | Skellefteå lasarett |
| 64011 | Lycksele lasarett | Lycksele lasarett | Lycksele lasarett |
| 65012 | Gällivare sjukhus | Gällivare sjukhus | Gällivare lasarett |
| 65013 | Piteå älvdals sjukhus | Piteå sjukhus | Piteå lasarett |
| 65014 | Kalix sjukhus | Kalix sjukhus | Kalix lasarett |
| 65015 | Kiruna sjukhus | Kiruna sjukhus | Kiruna lasarett |
| 65016 | Sunderby sjukhus | Sunderby sjukhus | Sunderbysjh |
