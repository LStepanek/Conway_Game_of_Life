###############################################################################
###############################################################################
###############################################################################

## loaduju globální proměnné --------------------------------------------------

source("global.R")


## ----------------------------------------------------------------------------

###############################################################################

## loaduju tvary --------------------------------------------------------------

source("patterns.R")


## ----------------------------------------------------------------------------

###############################################################################

## loaduju balíčky ------------------------------------------------------------

library(shiny)


## ----------------------------------------------------------------------------

###############################################################################

## ----------------------------------------------------------------------------

shinyUI(fluidPage(
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  ## zavádím busy indicator ---------------------------------------------------
  
  tagList(
    
    tags$head(
      
      tags$link(rel = "stylesheet",
                type = "text/css",
                href = "style.css"),
      
      tags$script(type = "text/javascript",
                  src = "busy.js")
      
    )
    
  ),
  
  
  div(class = "busy",
      p("Aplikace je zaneprázdněná..."),
      img(src = "busy_indicator.gif")
  ),
  
  
  ## zavádím graficky hezky vypadající header ---------------------------------
  
  div(id = "header",
      div(id = "title", "Conwayova hra života"),
      div(id = "subsubtitle",
          
          "Implementace",
          
          tags$a(
            href = "http://cs.wikipedia.org/wiki/Hra_života",
            "známého celulárního automatu",
            target = "_blank"
          ),
          
          HTML("&bull;"),
          
          "Vytvořil",
          
          tags$a(
            href = "http://www.fbmi.cvut.cz/user/stepalu2",
            "Lubomír Štěpánek",
            target = "_blank"
          )
          
      )
  ),
  
  
  ## --------------------------------------------------------------------------
  
  #############################################################################
  
  sidebarLayout(
    
    sidebarPanel(
      
      #########################################################################
      
      ## první záložka --------------------------------------------------------
      
      conditionalPanel(
        
        condition = "input.conditionedPanels == 1",
        
        selectInput(inputId = "my_pattern",
                    label = "Vyberte rozestavení buněk:",
                    choices = c("náhodné buňky" = "random_cells",
                                "blok" = "block",
                                "včelín" = "beehive",
                                "bochník" = "loaf",
                                "loď" = "boat",
                                "dvojblok" = "biblock",
                                "blikač" = "blinker",
                                "ropucha" = "toad",
                                "maják" = "beacon",
                                "pulzar" = "pulsar",
                                "křídlo" = "glider",
                                "lehká hvězdná loď" = "LWSS",
                                "Gosperovo křídlové dělo" = paste("Gosper",
                                                                  "glider",
                                                                  "gun",
                                                                  sep = "_"),
                                "R-pentomino" = "R_pentomino",
                                "žalud" = "acorn",
                                "králíci" = "rabbits",
                                "benátské rolety" = "venetian_blinds",
                                "zápalná šňůra" = "fuse"),
                    selected = 1),
        
        uiOutput(outputId = "covering_percentage_of_board"),
        
        tags$hr(),
        
        "Kliknutím spustíte nový celulární automat.",
        
        tags$br(),
        tags$br(),
        
        actionButton(inputId = "start_button",
                     label = "Start!",
                     width = 150),
        
        tags$hr(),
        
        uiOutput("my_text_origination"),
        
        tags$br(),

        uiOutput(outputId = "my_step_button_origination")
        
      ),
      
      
      ## ----------------------------------------------------------------------
      
      #########################################################################
      
      ## druhá záložka --------------------------------------------------------
      
      conditionalPanel(
        
        condition = "input.conditionedPanels == 2",
        
        HTML("<b>Diagram závislosti počtu živých buněk na čase.</b>"),
        
        tags$br(),
        tags$br(),
        
        "Diagram se týká aktuálně simulovaného celulárního automatu",
        
        "v záložce 'Simulace'."
        
      ),
      
      
      ## ----------------------------------------------------------------------
      
      #########################################################################
      
      ## třetí záložka --------------------------------------------------------
      
      conditionalPanel(
        
        condition = "input.conditionedPanels == 3",
        
        HTML("<b>Stručný úvod ke Conwayově hře života</b>")
        
      ),
      
      
      ## ----------------------------------------------------------------------
      
      #########################################################################
      
      ## čtvrtá záložka -------------------------------------------------------
      
      conditionalPanel(
        
        condition = "input.conditionedPanels == 4",
        
        HTML("<b>Stručně o aplikaci</b>")
        
      ), width = 3
      
      
      ## ----------------------------------------------------------------------
      
      #########################################################################
      
      
    ),
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## ------------------------------------------------------------------------
    
    mainPanel(
      
      tabsetPanel(
        
        #######################################################################
        
        ## první záložka ------------------------------------------------------
        
        tabPanel(
          title = HTML("<b>Simulace</b>"),
          plotOutput("my_printable_board"),
          value = 1
        ),
        
        
        ## --------------------------------------------------------------------
        
        #######################################################################
        
        ## druhá záložka ------------------------------------------------------
        
        tabPanel(
          title = HTML("<b>Počet živých buněk v čase</b>"),
          plotOutput("number_of_alive_cells_vs_time"),
          value = 2
        ),
        
        
        ## --------------------------------------------------------------------
        
        #######################################################################
        
        ## třetí záložka ------------------------------------------------------
        
        tabPanel(
          title = HTML("<b>O Conwayově hře života</b>"),
          
          HTML("<h2>Conwayova hra života jako celulární automat</h2>"),
          
          HTML(
          "Conwayova hra života, běžně zvaná jen <i>Hra života</i> či jen",
          "<i>Život</i>",
          "je známý dvourozměrný celulární automat, který má svým chováním",
          "připomínat vývoj kolonie konečného počtu jednoduchých",
          "(jednobuněčných) živých organismů (buněk) v čase. Na počátku",
          "je dána pouze iniciální konfigurace rozestavení (a počtu) buněk",
          "a systém jednoduchých a neměnných pravidel, které říkají, za",
          "jakých podmínek může mrtvá buňka oživnou a naopak. Konfigurace",
          "je v každém časovém okamžiku prezentována maticí, kdy hodnoty",
          "matice rovné 1 představují buňky, jež jsou v daném okamžiku",
          "živé, a hodnoty matice rovné 0 představují naopak ty, které",
          "jsou v daném okamžiku mrtvé. Vývoj konfigurace a počtu",
          "žijících buněk v dalších časových okamžicích, kdy čas je chápán",
          "diskrétně, je iterativně aktualizován pro každou buňku matice",
          "podle daných pravidel, tím pádem je již plně determinován.",
          "Dopředu je však vývoj pro velkou část vstupních konfigurací",
          "nevypočitatelný, je tedy nutné jej krok po kroku simulovat."
          ),
          
          tags$br(),
          tags$br(),
          
          HTML(
          "Myšlenka celulárních automatů se datuje do roku 1940, kdy",
          "první koncepty navrhl známý maďarský matematik John von Neumann",
          "ve snaze vytvořit stroj, který by repdoukoval sám sebe.",
          "Implementace automatů vša tou dobou narážela na omezené možnosti",
          "výpočetní techniky, proto zájem o další vývoj opadl a byl oživen",
          "až v 70. letech. Autorem samotné Hry života je britský",
          "matematik John Horton Conway, emeritní profesor na Princetonské",
          "univerzitě, který precisoval její pravidla v roce 1970. Díky",
          "relativně snadné uchopitelnosti konceptu Hry života se získal",
          "tento typ celulárního automatu oblibu i mimo vědeckou komunitu",
          " -- vnikaly různé výzvy o tvorbu iniciální konfigurace buněk s",
          "nějakou <i>danou</i> vlastností, kterých se účastnila i široká",
          "veřejnost. Díky zájmu o <i>Hru života</i> vznikl i časopis",
          "věnovaný přímo problematice diskrétního celulárního automatu.",
          "Zajímavými se tehdy jevily především tyto dvě otázky, obě",
          "vyslovil sám Conway:"
          ),
          
          tags$br(),
          tags$br(),
          
          HTML("<ol>
            <li>Existuje nějaká (vstupní) konečná konfigurace buněk,
                která může neomezeně růst (velikostí, ne nutně počtem buněk),
                i nad limity dané velikostí mřížky? Pro větší mřížku tedy,
                konfigurace dosáhne opět hranic mřížky.</li>
            <li>Existuje nějaká konečná konfigurace buněk, která se,
                vyskytuje pouze v druhé generaci a poté již ne? Jde též
                o problém zvaný <i>The Grandfather Problem</i>.</li>
          </ol>"),
          
          tags$br(),
          
          HTML(
          "Pro první otázku byly takové konfigurace již nalezeny,",
          "autorem jedné z nich je William Gosper; jeho konfigurace",
          "řešící první otázku je nazývána <i>Gosper glider gun</i>,",
          "česky nejspíše <i>Gosperovo křídlové dělo</i>; to je",
          "mimochodem implementováno i v naší aplikace (viz dále).",
          "Na druhou otázku není známá odpověď dodnes."
          ),
          
          tags$br(),
          tags$br(),
          
          HTML(
          "Zajímavých otázek a výzkumných problémů je celá řada --",
          "jsou například zkoumány konfigurace, které mají právě <i>k</i>",
          "různých stavů, jež se periodicky střídají (s periodou <i>k</i>);",
          "tedy že dva stavy konfigurace v okamžicích <i>i</i> a",
          "<i>i + k</i> pro všechna <i>i</i> &isin; <i>Z</i> a dané",
          "<i>k</i> &isin; <i>N</i> jsou zcela shodné."
          ),
          
          tags$br(),
          tags$br(),
          
          HTML(
          "V průběhu každé konkrétní hry (tedy pro danou iniciální",
          "konfiguraci buněk) mohou vznikat různě komplexní sestavy buněk.",
          "I přes jednoduchá pravidla je složitost vznikajících sestav",
          "buněk a složitost změn mezi jendotlivými sousedními časovými",
          "kroky značná; v tomto smyslu jsou někdy celulární automaty",
          "považovány za diskrétní analogie spojitých komplexních",
          "nelineárních systémů, které studuje nelineární dynamika",
          "(z této oblasti pochází populárně známé pojmy jako",
          "<i>chaos</i> či <i>butterfly-wing effect</i>)."
          ),
          
          tags$br(),
          tags$br(),
          
          HTML(
          "Některé iniciální či vzniklé sestavy buněk mají naopak",
          "chování (tedy vývoj v čase) dobře predikovatelné, mnohdy",
          "bylo spočítáno a známo dřív, než byla vůbec technicky možná",
          "první solidní implementace <i>Hry života</i>. Jindy bylo",
          "pozorování vypozorováno až empiricky sledováním vývoje dané",
          "hry. Kategorie některých sestav buněk podle typu chování",
          "(tzv. <i>tvary</i>) budou probrány dále."
          ),
          
          tags$br(),
          tags$br(),
          
          "Celulární automaty obecně jsou aplikovány jako modely v",
          "experimentální fyzice či biologii, díky vztahům mezi",
          "jednoduchými a komplexními konfiguracemi pomocí jednoduchých",
          "pravidel lze celulární automaty použít i v kompresi dat,",
          "např. v některých zvukových formátech.",
          
          HTML("<h3>Prostor a pravidla hry</h3>"),
          
          HTML(
          "Prostorem hry je dvourozměrná matice, též nazývaná mřížka.",
          "V reálných simulacích včetně naší musíme obvykle vystačit s",
          "konečnou mřížkou; hypoteticky lze ale uvažovat i nekonečně",
          "velkou dvourozměrnou matici. Hodnotami matice jsou obecně",
          "jedničky, resp. nuly představující živé, resp. mrtvé buňky.",
          "Rozestavení živých (a mrtvých) buněk na mřížce se nazývá",
          "konfigurace či vzor nebo tvar. Čas je vnímán diskrétně,",
          "okamžik 0 odpovidá iniciálnímu (vstupnímu) stavu, pro",
          "každý přechod do následujícího okamžiku je podle daných",
          "pravidel (podle tzv. <i>přechodové funkce</i>) pro každou",
          "buňku spočítáno, jestli bude i v následujícím okamžiku živá,",
          "či mrtvá. O tom v zásadě rozhoduje to, zda je buňka v daném",
          "okamžiku živá a jaký je počet živých buněk v jejím těsném",
          "okolí (tj. v osmici polí matice, které sousedí s danou",
          "buňkou alespoň rohem). Probíhá-li <i>Hra života</i> na",
          "matici <i>m x n</i>, pak je počet všech navzájem možných",
          "konfigurací, do kterých může hra teoreticky dojít, roven",
          "2<sup><i>mn</i></sup>, neboť každá z <i>mn</i> buněk je buďto",
          "živá, nebo mrtvá."
          ),
          
          tags$br(),
          tags$br(),
          
          HTML(
          "Původní pravidla přechodové funkce <i>Hry života</i>",
          "definoval již v roce 1970 sám profesor Conway. Jedná se o",
          "čtveřici relativně jednoduchých pravidel:"
          ),
          
          tags$br(),
          tags$br(),
          
          HTML("<ol>
            <li>Každá živá buňka s méně než dvěma živými sousedy zemře.</li>
            <li>Každá živá buňka se dvěma nebo třemi živými sousedy zůstává
                žít.</li>
            <li>Každá živá buňka s více než třemi živými sousedy zemře.</li>
            <li>Každá mrtvá buňka s právě třemi živými sousedy oživne.</li>
          </ol>"),
          
          tags$br(),

          "Postupně vznikla celá řada variací původních pravidel; především",
          "jsou diskutována taková, která zajišťují, že vývoj konfigurace v",
          "čase není dopředu předvídatelný, či zajišťují dlouhodobé přežití",
          "populace. Jejich uvedení je však nad rámec tohoto textu.",
          
          tags$br(),
          tags$br(),
          
          "Aplikace pravidel je na jedné z možných konfigurací předvedena",
          "na následujícím obrázku.",
          
          tags$br(),
          tags$br(),
          
          img(src = "progress.jpg", align = "center", width = "500px"),
          HTML("<figcaption>Vývoj jedné z možných konfigurací</figcaption>"),
          
          tags$br(),
          tags$br(),
          
          HTML("<h3>Přehled tvarů</h3>"),
          
          HTML(
          "<ul>
            <li><b>Zátiší (Still life)</b>. Jedná se o stabilní konfigurace,
                které jsou vždy i svým vlastním rodičem, tj. ve dvou po sobě
                následujících okamžicích je taková konfigurace zcela totožná.
                Proto jsou někdy nazývány též jako invariantní formy. Patří
                sem např. blok (block), včelín (beehive), bochník (loaf),
                loď (boat) či dvojblok (bi-block)
                <ul><li>
                <br>
                <figure>
                <img src='block.jpg' align = 'center', width = '100px'/>
                <figcaption>Blok (block)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='beehive.jpg' align = 'center', width = '100px'/>
                <figcaption>Včelín (beehive)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='loaf.jpg' align = 'center', width = '100px'/>
                <figcaption>Bochník (loaf)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='boat.jpg' align = 'center', width = '100px'/>
                <figcaption>Loď (boat)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='bi_block.jpg' align = 'center', width = '100px'/>
                <figcaption>Dvojblok (bi-block)</figcaption>
                </figure>
                </li>
                </ul>
            </li>
            <br>
            <br>
            <li><b>Oscilátory (Oscillators).</b> Oscilátor je nestabilní
                vzor, který je sám sobě předchůdcem, tj. vyvinul se sám
                ze sebe po konečném počtu časových okamžiků. Oscilátory
                pravidelně přechází mezi konstantním počtem konfigurací,
                po počtu okamžiků rovným periodě oscilátoru se oscilátor
                vrací do své původní konfiguraci. Oscilátory s periodou
                2 jsou někdy nazývány alternátory -- mezi ně patří blikač
                (blinker), ropucha (toad) či maják (beacon). Periodu 3 má
                pulzar (pulsar)
                <ul><li>
                <br>
                <figure>
                <img src='blinker.jpg' align = 'center', width = '100px'/>
                <figcaption>Blikač (blinker)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='toad.jpg' align = 'center', width = '100px'/>
                <figcaption>Ropucha (toad)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='beacon.jpg' align = 'center', width = '100px'/>
                <figcaption>Maják (beacon)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='pulsar.jpg' align = 'center', width = '200px'/>
                <figcaption>Pulsar (pulsar)</figcaption>
                </figure>
                </li>
                </ul>
            </li>
            <br>
            <br>
            <li><b>Děla (guns).</b> Jde o stacionární vzor, který
                donekonečna produkuje posunující se vzory. Příkladem je
                již zmíněné </i>Gosperovo křídlové dělo</i>.</li>
                <ul><li>
                <br>
                <figure>
                <img src='Gosper_glider_gun.jpg' align = 'center',
                     width = '500px'/>
                <figcaption>Gosperovo křídlové dělo (Gosper glider gun)
                </figcaption>
                </figure>
                </li></ul>
            </li>
            <br>
            <br>
            <li><b>Posunující se vzory (Spaceships).</b> Jedná se o
                pohybující se vzor, který se znovu objevuje po konečném
                počtu časových okamžiků. Protože je zřejmě maximální možnou
                rychlostí posunu vzoru rychlost 1 buňka/1 časový okamžik,
                je někdy taková rychlost označovaná za rychlost světla a
                míra posunu každého posunujícího se vzoru se uvádí jako
                podíl rychlosti světla. Mezi posunující se vzory patří
                křídlo (glider) a lehká hvězdná loď (LWSS).</li>
                <ul><li>
                <br>
                <figure>
                <img src='glider.jpg' align = 'center', width = '100px'/>
                <figcaption>Křídlo (glider)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='LWSS.jpg' align = 'center', width = '100px'/>
                <figcaption>Lehká hvězdná loď (LWSS)</figcaption>
                </figure>
                </li>
                </ul>
            </li>
            <br>
            <br>
            <li><b>Metuzalémové (Methuselahs).</b> Jde o jakýkoliv malý vzor,
                jehož stabilizace trvá dlouhou dobu. Např. R-pentomino se
                stabilizuje až po 1103 generacích, žalud (accorn) po 5206
                generacích a králíkům (rabbits) přechod do stabilního stavu
                trvá 17332 generací</li>
                <ul><li>
                <br>
                <figure>
                <img src='R_pentomino.jpg' align = 'center', width = '100px'/>
                <figcaption>R-pentomino</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='acorn.jpg' align = 'center', width = '200px'/>
                <figcaption>Žalud (acorn)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='rabbits.jpg' align = 'center', width = '200px'/>
                <figcaption>Králíci (rabbits)</figcaption>
                </figure>
                </li>
                </ul>
            </li>
            <br>
            <br>
            <li><b>Agary (Agars).</b> Jsou vzory, které pokrývají celou
                plochu či její velkou část a pediodicky se mění. Příkladem
                jsou </i>benátské záclony</i> (venetian blinds)</li>
                <ul><li>
                <br>
                <figure>
                <img src='venetian_blinds.jpg' align = 'center',
                     width = '200px'/>
                <figcaption>Benátské záclony (venetian blinds)</figcaption>
                </figure>
                </li>
                <br>
                <li>
                <figure>
                <img src='venetian_blinds_processed.jpg' align = 'center',
                     width = '200px'/>
                <figcaption>Benátské záclony (v 8. časovém okamžiku)
                </figcaption>
                </figure>
                </li>
                </ul>
            </li>
            <br>
            <br>
                <li><b>Knoty (Wicks).</b> Vzory složené ze zátiší či
                    oscilátorů,
                    což ve výsledku vrací efekt uhořívající zápalné šňůry.
                    Příkladem je <i>zápalná šňůra</i> (fuse)</li>
                <ul><li>
                <br>
                <figure>
                <img src='fuse.jpg' align = 'center',
                width = '200px'/>
                <figcaption>Zápalná šňůra (fuse)</figcaption>
                </figure>
                </li>
                </ul>
                </li>
            </ul>"
          ),
          
          value = 3
        ),
        
        
        ## --------------------------------------------------------------------
        
        #######################################################################
        
        ## třetí záložka ------------------------------------------------------
        
        tabPanel(
          title = HTML("<b>O aplikaci</b>"),
          
          HTML("<h3>Poděkování</h3>"),
          
          "Veškerý kredit jde autorům celulárních automatů a",
          "autorům jazyka a prostředí R. Až v poslední řadě",
          "autorovi aplikace.",
          
          tags$hr(),
          
          HTML("<h3>Náměty a bug reporting</h3>"),
          
          "Svoje náměty, připomínky či upozornění na chyby můžete",
          "směřovat na",
          
          tags$br(),
          tags$br(),

          HTML(
            "<a href='http://www.fbmi.cvut.cz/user/stepalu2'
             target='_blank'>
            <b>Lubomír Štěpánek, M. D.</b></a>"
            ),
          
          tags$br(),
          
          "Katedra biomedicínské informatiky",
          
          tags$br(),
          
          "Fakulta biomedicínského inženýrství",
          
          tags$br(),
          
          "České vysoké učení technické v Praze",
          
          tags$br(),
          
          HTML("<a href='mailto:lubomir.stepanek@fbmi.cvut.cz'>
               lubomir.stepanek[AT]fbmi[DOT]cvut[DOT]cz</a>"),
          
          tags$br(),
          
          value = 4
        ),
        
        
        ## --------------------------------------------------------------------
        
        #######################################################################
        
        ## --------------------------------------------------------------------
        
        id = "conditionedPanels"
        
        
        ## --------------------------------------------------------------------
        
      ), width = 9
      
    )
    
    )
  
))


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################


