
# PGR301 DevOps-Eksamen - Kandidatnummer: 62







## Oppgave 1
* 1a)
Endpoint URL: https://dy4e2mcdgh.execute-api.eu-west-1.amazonaws.com/Prod/gen-image
Screenshots fra kjøring:
![screenshot](https://i.imgur.com/LbyAZmS.png)
![screenshot](https://i.imgur.com/MTWJiar.png)
![screenshot](https://i.imgur.com/xzLpANh.png)

* 1b)
Vellykket kjøring med GitHub actions:\
https://github.com/MathiasTor/DevOps---Eksamen-2024/actions/runs/11915069135/job/33204464542

## Oppgave 2
* 2b)
Vellykket kjøring med GitHub actions på main branch:\
https://github.com/MathiasTor/DevOps---Eksamen-2024/actions/runs/11996936988/job/33441964551

Vellykket kjøring med GitHub actions på annen branch:\
https://github.com/MathiasTor/DevOps---Eksamen-2024/actions/runs/11996981818/job/33442051238

SQS-kø: \
https://sqs.eu-west-1.amazonaws.com/244530008913/image-generator-queue

## Oppgave 3
* Jeg har valgt å tagge containeren med :latest, jeg tenker på dette som et utviklingsmiljø og :latest er praktisk for rask iterasjon, ettersom det lar meg referere til den nyeste byggingen. Hvis derimot dette hadde vært et produksjonsmiljø hadde versjonsnumre vært en bedre løsning

Container URL:\
https://hub.docker.com/r/mato058/java-sqs-client

SQS-kø URL: \
https://sqs.eu-west-1.amazonaws.com/244530008913/image-generator-queue

For å kjøre:
docker run --rm ^\
  -e SQS_QUEUE_URL="https://sqs.eu-west-1.amazonaws.com/244530008913/image-generator-queue" ^ \
  -e AWS_ACCESS_KEY_ID="access key her " ^ \
  -e AWS_SECRET_ACCESS_KEY="access secret her" ^ \
  java-sqs-client "prompt her "

Velykket kjøring: \
![screenshot](https://i.imgur.com/5bpuvlk.png)

## Oppgave 4
Alarm epost:
![screenshot](https://imgur.com/MVGsvVg.png)

## Oppgave 5
* Automatisering og kontinuerlig levering (CI/CD 

Det er flere fordeler med FaaS. AWS sørger for automatisk skalering, og pipelines trenger ikke å håndtere ressursallokering. Funksjoner kan også distribueres hver for seg, noe som gjør CI/CD lettere å segmentere. Disse funksjonene kan dessuten endres uten å påvirke resten av systemet. En ulempe med å ha mange små funksjoner er håndtering av versjoner og kompleksiteten i CI/CD-pipelines. Hver funksjon har sin egen livssyklus, noe som kan føre til et mer komplekst system, spesielt hvis funksjonene er avhengige av hverandre.

Med mikrotjenestearkitektur har man fordelen av at hele tjenester pakkes sammen og distribueres som en helhet, noe som kan gjøre pipelines mer forutsigbare og lettere å teste. Mikrotjenestearkitektur krever imidlertid ofte mer ressurser, ettersom hele tjenesten må redistribueres når endringer gjøres, og ikke bare én funksjon.

* Observability (overvåkning) 
  
Overvåkning er en viktig del av nesten alle systemer, uavhengig av systemarkitektur. AWS tilbyr tjenester som AWS CloudWatch, som kan integreres med Lambda-funksjoner. Dette gir en god oversikt over systemmetrikker uten behov for ekstra konfigurasjon. Hver funksjon kan overvåkes individuelt, noe som gir innsikt i spesifikke problemer. Dette kan imidlertid være krevende hvis man ønsker å samle alle logger på ett sted for å få et bedre innblikk i systemets helhet.

Mikrotjenestearkitektur løser dette på en enklere måte, enten ved å bruke et ferdigutviklet rammeverk, eller ved å utvikle en egen løsning. En slik løsning gjør det lettere å få en sentralisert oversikt over hele systemet.

* Skalerbarhet og kostnadskontroll 
  
En stor fordel med skalerbarhet er at AWS Lambda automatisk skalerer basert på antall forespørsler, noe som eliminerer behovet for manuell skalering. Dette fører ofte også til lavere kostnader, ettersom Lambda-funksjoner kun tar betalt for den faktiske kjøretiden. Ved inaktivitet koster det ingenting å drifte systemet.

På den andre siden, i et system med høy trafikk, kan kostnadene bli store, siden funksjonene kjører ofte og skalerer med trafikken. En containerbasert løsning kan i mange tilfeller være billigere å drifte ved stor trafikk. For oppgaver som krever store maskinressurser kan det også være en fordel å benytte seg av en containerbasert løsning, ettersom Lambda-funksjoner har en maksimal kjøretid på 15 minutter.

* Eierskap og ansvar 
  
Ved en serverless-løsning er det for det meste leverandøren som tar hånd om ansvaret for drift og vedlikehold. Dette gjør at utviklere kan bruke mer tid på å optimalisere funksjoner og sørge for god ytelse. Utviklere har imidlertid et større ansvar for å optimalisere ytelsen for å holde kostnadene så lave som mulig. En ulempe med dette kan være at man blir "låst" til leverandøren og gjør det vanskeligere å bytte i fremtiden, ved en containerbasert løsning er det enklere å bytte leverandør.

Ved mikrotjenestearkitektur kan det være lettere å fordele ansvar mellom de forskjellige tjenestene. Dette kan gjøre det enklere å feilsøke og vedlikeholde tjenester uavhengig av hverandre. Utviklerne har full kontroll over infrastrukturen til systemet og står fritt til å velge tjenester og rammeverk som er best egnet for hver tjeneste. Dette betyr imidlertid også at utviklerne må håndtere drift, skalering, sikkerhet og oppdateringer, noe som igjen kan føre til økt arbeidsmengde.

## Dokumentstruktur

### Oppgave 1
- **Endpoint URL**
- **Skjermbilder av kjøring**
- **Vellykket GitHub Actions-kjøring**

### Oppgave 2
- **Vellykket GitHub Actions-kjøring (main branch)**
- **Vellykket GitHub Actions-kjøring (annen branch)**

### Oppgave 3
- **Container URL**
- **SQS-kø URL**
- **Skjermbilder av kjøring**
- **Kommando for kjøring**

### Oppgave 4
- **Skjermbilde av e-post med alarm**

### Oppgave 5
- **Drøfting**
  
