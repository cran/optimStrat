#library(shiny)

fluidPage(

HTML('
   <!DOCTYPE html> 
   <head>
   <title>Optimal Strategy</title>
   <style type="text/css">
   body {background-color: #E6E6E6; font-family: Verdana, Arial, sans-serif; font-size: 1.5em; line-height:1.5em}
   p {position: relative; line-height=5em}
   h1 {font-family:Stencil; font-variant:small-caps; font-size:5em; text-align:center; color:#060D5B}
   #Subtitulo {font-size:2em; color:#060D5B; text-align:center}
   table {border:2px solid black; border-style:inset; text-align:center; margin:0 auto}
   th {text-align:center; padding:0.5em 1em; border-width:2px 1px; border-style:solid; border-color: black;
      background-color:#646464; color:white}
   td {text-align:center; padding:0.5em 1em; border:1px solid black}
   tr:nth-child(even) {background-color: #fafafa}
   #grafico1,#grafico2,#grafico3,#grafico4,#grafico5,#grafico6,#grafico7 {
      border:1px solid black; border-style:inset; width=100px; margin:0 auto}
   #Nota {text-align:center; margin:0 0 2em 0}
   #Objective {width:50em; margin:0 auto 1em; border-style:outset; background-color:#AFC8AF; font-weight:bold}
   #encabezado {margin-bottom: 4em}
   #Marco1 {float:left; position:fixed; width:25%; font-size:0.9em; border-style:outset; margin: 0em 0 0 0; padding:0 1em; 
   line-height:1.6em; background-color:#C7CAC9; margin:0em 0 0 0}
   #Marco2 {margin: 0 5% 0 30%}
   #Marco3 {clear:left; padding:15px; background-color:#C7CAC9; border-style:outset; text-align:center}
   .seccion {border:1px solid black; padding:0 1em 1em; margin:2em 0}
   .modelo {text-align:center}
   .basura {visibility: hidden}
   </style>
   </head>

   <body>
   <div id="encabezado">
   <h1 id="Top">Optimal Strategy</h1>

   <p id="Subtitulo">Looking for an optimal sampling strategy</p>
   </div>

   <div id="principal">
   <div id="Marco1">
   <h2 id="Description">Description</h2>

   <p>This app compares the anticipated variance of five sampling strategies
    allowing the user to study the impact of assuming a working model that differs from the true model. The app 
    works in steps as described below:</p>

   <ol><li><a href="#Step1">Uploading/Simulating the auxiliary variable.</a></li>
   <li><a href="#Step2">Defining the <em>working</em> model.</a></li>
   <li><a href="#Step3">Defining the five sampling strategies.</a></li>
   <li><a href="#Step4">Defining the <em>true</em> generating model.</a></li>
   <li><a href="#Step5">Simulating the study variable.</a></li>
   <li><a href="#Step6">Computing the variance of the five strategies.
   </a></li>
   <li><a href="#Step7">Iterating steps 5 and 6.</a></li>
    </ol></div>

   <div id="Marco2">
   <p id="Objective">The objective is to find an efficient sampling strategy for the case when we want to estimate 
    the total of one <em>study variable</em> using one quantitative <em>auxiliary variable</em>. A model that 
    relates the study variable and the auxiliary variable is assumed by the statistician, but it 
    may differ from the true generating model i.e. there might be some type of model 
    misspecification.</p>

   <p id="Note"><strong>Note:</strong> In order to see the formulas correctly, it is recommended to use Firefox.</p>

   <!-- <p id="Note"><strong>Note:</strong> The theory behind this app can be found in Bueno, E. (2018). 
   On the decision between Stratified simple random sampling and Probability proportional-to-size sampling.</p> -->

   <div class="seccion">
   <h2 id="Introduction">Introduction</h2>

   <p>The strategy that couples probability proportional-to-size sampling with the general 
    regression estimator, <math <mi>&#x03C0;</mi></math>ps-GREG, is sometimes called optimal. 
    However, this optimality is based on the strong assumption that the study variable is a realization 
    of a model with some of its parameters known. As these assumptions are hardly satisfied in 
   practice, one might find that a different strategy is, in fact, more efficient than the so-called optimal.</p>

   <p> The idea behind this app is as follows:</p>

   <p>At the planning stage of a study, the statistician has one quantitative auxiliary variable at 
    hand, <em>x</em>, and needs to decide on the best way for making use of that auxiliary 
    information in order to obtain a good estimate of the total of the variable of interest, 
    <em>y</em>. In other words, the statistician wants to find an efficient sampling strategy.</p>

   <p>For doing so, the statistician <em>assumes</em> that the <em>y</em>-values are realizations of the following model, 
   <math> <msub><mi>&#x03BE</mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>0</mn></mrow></msub></math>:</p>

   <div class="modelo">
   <p><span class="ecuacion parte1" id="modasumido">
    <math xmlns="http://www.w3.org/1998/Math/MathML"> <msub> <mi>Y</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> 
    <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> <mo>+</mo>
    <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow> </msub>
    <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4;<!-- ?? --></mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
    <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> </math>
    </span>
   <span class="basura">MM</span>with<span class="basura">MM</span>
   <span class="ecuacion parte2" id="asumidocon1"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;</mi>
    <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
    </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
   <span class="ecuacion parte3" id="asumidocon2"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;</mi>
    <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
    </msub> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>l</mi> </mrow> </msub>
    <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
   <span class="ecuacion parte4" id="asumidocon3"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;<!-- ?? --></mi>
    <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub> <mrow> <mo>(</mo>
    <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
    <mo>)</mo> </mrow> <mo>=</mo> <msub> <mi>&#x03B4;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>3</mn> </mrow> </msub> <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
    </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>2&#x03B4;<!-- ?? --></mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> </mrow> </msubsup> </math></span>
   </p>
   </div>

   <p>However, the statistician is not 100% optimistic regarding the model: he/she knows that it is 
    very unlikely that the <em>assumed</em> model is completely right. Therefore, wants to study 
    the impact of assuming the model above when the <em>true generating model</em>, 
    <math xmlns="http://www.w3.org/1998/Math/MathML"><mi>&#x03BE;<!-- ?? --></mi></math>, 
    differs and can be written as:</p>

   <div class="modelo">
   <p> <span class="ecuacion" id="modelover"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>Y</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo>
    <msub> <mi>&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub>
    <mo>+</mo> <msub> <mi>&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow>
    </msub> <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
    <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
    </math></span>
   <span class="basura">MM</span>with<span class="basura">MM</span>
   <span class="ecuacion" id="verdadcon1"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;<!-- ?? --></mi> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
    </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
   <span class="ecuacion" id="verdadcon2"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;<!-- ?? --></mi> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
    </mrow> </msub> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>l</mi>
    </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
   <span class="ecuacion" id="verdadcon3"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;<!-- ?? --></mi> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
    </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <msub> <mi>&#x03B2;<!-- ?? --></mi>
    <mrow class="MJX-TeXAtom-ORD"> <mn>3</mn> </mrow> </msub> <msubsup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD">
    <msub> <mi>2&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub>
    </mrow> </msubsup> </math></span>
   </p>
   </div>

   <p>Note that both, the <em>true</em> and the <em>working</em>, models have the same functional 
    form. The misspecification that the statistician is going to investigate relies in those cases
    where the 
    <math> <mi>&#x03B4</mi> </math>-parameters differ from the 
    <math> <mi>&#x03B2;</mi> </math>-parameters. In particular, when 
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>2</mn></mrow> </msub></math> 
    differs from
    <math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"><mn>2</mn></mrow> </msub></math>
    or 
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>4</mn></mrow> </msub></math>
    differs from
    <math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"><mn>4</mn></mrow> </msub></math>.
    </p>

   <p>To begin with, let us say that the working model, <math> <msub><mi>&#x03BE</mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>0</mn></mrow></msub></math>, is correct. Then, the strategy that couples a <math> <mi>&#x03C0</mi> </math>ps design and the 
    regression estimator is called optimal, with:</p>
 
   <p><span class="ecuacion" id="optimalinc"><math> <msub> <mi>&#x03C0</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> <mi>n</mi> <mfrac>
    <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
    <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
    </msubsup> <msub> <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
    <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
    </msup> </mrow> </msub> </mfrac> </math></span>
    the inclusion probability of the <em>k</em>-th element, where <em>n</em> is the desired sample 
    size and 
    <math> <msub> <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
    <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </mrow> </msub> <mo>=</mo> <munder> <mo>&#x2211</mo> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>U</mi> </mrow> </munder> <msubsup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
    <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub>
    <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msubsup> </math>
   </p>

   <p> <span class="ecuacion" id="optimalvec"><math> <msub> <mrow class="MJX-TeXAtom-ORD">
    <mi mathvariant="bold">x</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
    <mo>=</mo> <mrow> <mo>(</mo> <mn>1</mn> <mo>,</mo> <msubsup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
    <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup>
    <mo>)</mo> </mrow> </math></span> 
   is the auxiliary vector to be used in the regression 
    estimator.</p>

   <p><strong>Interpretation:</strong> Both models consist of two terms:</p>

   <ul><li>A <em>trend</em> term:
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> <mo>+</mo> 
    <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow> </msub> <msubsup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub> 
    <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup> </math>, 
    where 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </math>
   indicates the intercept, 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow> </msub> </math> 
    is a scale factor and 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </math> 
    is a shape factor.</li>
   <li>A <em>variance</em> term:
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>3</mn> </mrow> </msub> <msubsup>
    <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
    <mi>2&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> </mrow> </msubsup> </math>,
    where
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>3</mn> </mrow> </msub> </math>
    is a scale factor for the variance (which defines the correlation between <em>x</em> and <em>y</em>),
    and
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> </math>
    indicates the shape of the variance.</li></ul>

   <p>In this sense, the sampling design in the optimal strategy is supposed to explain the variance term (through 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> </math>)
    and the estimator is supposed to explain the trend term (through 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </math>). 
    The remaining parameters in the model are not involved in the strategy, therefore it is not necessary 
    to have previous knowledge about them.</p>
   <p>The above strategy is called optimal as it minimizes an approximation to the Anticipated
    Variance, which is a model-dependent statistic. However, a strategy is considered efficient 
    if its Mean Square Error -MSE- is small. The strategies compared through 
    this app are all unbiased or with a negligible bias, therefore,
    the MSE reduces to the variance.</p>

   <p>It is expected then that the strategy <math <mi>&#x03C0;</mi></math>ps-GREG as defined 
    above behaves well when the assumed model is close to the true model. But what if not?</p>

   <p>This app allows for comparing five strategies when the 
    working model differs from the true generating model.</p>

   <a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">
   <h2 id="Step1">Uploading/Simulating the auxiliary variable</h2>

   <p>In this step the quantitative auxiliary variable, <em>x</em>, that will be used 
    for assisting the estimation of the total of the study variable, <em>y</em>, is defined. 
    Two methods are allowed: the observations can be loaded from an external file, or, 
    they can be simulated from a gamma distribution with fixed mean 48 plus one unit and the
    skewness defined by the user.

   <p>If the first option is chosen, the file must be formatted as follows: it has to be a 
    <em>csv</em> file with only one column without headers. The decimal indicator must be the 
    point. Negative values are not allowed.</p>

   <p>Two outputs will be shown: 1. The histogram 
    of the auxiliary variable, and, 2. A vector with four summary statistics: the size, mean, 
    variance and skewness of <em>x</em>.</p>'),

sidebarLayout(
   sidebarPanel(tabsetPanel(id="tabset",
      tabPanel("Select",fileInput("select","Please select a file",accept=".csv"),
                verbatimTextOutput("basura")),
   tabPanel("Simulate",
   numericInput("N",label="N (Population size)",value=5000,min=2,max=10000000),
   numericInput("sk",label="Skewness",value=3,min=0,max=100))),
   actionButton("go","Accept")),
   mainPanel()),

plotOutput("grafico1"),

verbatimTextOutput("tabla1"),

HTML('<a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">'),
 
tags$h2(id="Step2","Defining the working model"),

HTML('
   <p>The user assumes that the auxiliary variable defined in the step above and the 
    unknown study variable are related through the following model, <math> 
    <msub><mi>&#x03BE</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn></mrow></msub></math>:</p>

   <div class="modelo">
   <p><span class="ecuacion" id="modasumido3">
     <math xmlns="http://www.w3.org/1998/Math/MathML"> <msub> <mi>Y</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> 
     <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> <mo>+</mo>
     <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow> </msub>
     <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4;<!-- ?? --></mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
     <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> </math>
     </span> 
     <span class="basura">MM</span>with<span class="basura">MM</span>
     <span class="ecuacion" id="asumidocon13"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;</mi>
     <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub>
     <mrow> <mo>(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
     </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
     <span class="ecuacion" id="asumidocon23"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;</mi>
     <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub>
     <mrow> <mo>(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
     </msub> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>l</mi> </mrow> </msub>
     <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
     <span class="ecuacion" id="asumidocon33"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;<!-- ?? --></mi>
     <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub> <mrow> <mo>(</mo>
     <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
     <mo>)</mo> </mrow> <mo>=</mo> <msub> <mi>&#x03B4;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD">
     <mn>3</mn> </mrow> </msub> <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
     </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>2&#x03B4;<!-- ?? --></mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> </mrow> </msubsup> </math></span>
     </p>
   </div>
      
   <p>In this step, the user specifies the parameters of the model above. Note that only 
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>2</mn></mrow> </msub></math>
    and
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>4</mn></mrow> </msub></math>
    are required. This is so, because these are the only parameters required 
    for defining the sampling strategy.</p>

   <p>The output is a plot showing the model assumed by the user, where 
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </math>, 
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow> </msub> </math> and 
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>3</mn> </mrow> </msub> </math>
    are predefined by convenience. The red line indicates the trend and the shaded area around
    indicates the spread around the trend.</p>'),

numericInput("delta2",label=HTML('<math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                  <mn>2</mn> </mrow> </msub> </math>'),value=1,min=-5,max=5),

numericInput("delta4",label=HTML('<math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                  <mn>4</mn> </mrow> </msub> </math>'),value=1,min= 0,max=5),

plotOutput("grafico2"),

HTML('<a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">'),

tags$h2(id="Step3","Defining the sampling strategies"),

HTML('
   <p>The app allows for comparing five sampling strategies. The auxiliary
    variable and the model defined above are almost everything that is required for the strategies to be
    completely specified. However, one last input is needed: the number of strata/poststrata to be used 
    in those strategies involving stratification/poststratification.</p>

   <p>In this step the user specifies the desired number of strata. Then the five strategies compared by
   the app are described.</p>'),

numericInput("H",label="H (number of strata)",value=4,min=2,max=20),

HTML('
   <h3>Strategy 1: Probability Proportional-to-Size sampling with the regression estimator</h3>

   <p>This strategy, denoted <math> <mi>&#x03C0</mi> </math>ps-reg, uses the auxiliary 
    variable at both, the design and the estimation stages. Due to the use of the regression estimator, it
    is biased, but its bias is known to be small particularly for large samples. This is the so-called
    optimal strategy defined in the Introduction and will be considered as a strongly model dependent 
    strategy as it relies on the model at both stages. The <math <mi>&#x03C0;</mi></math>ps scheme implemented in the app
    is Pareto <math <mi>&#x03C0;</mi></math>ps sampling.</p>

   <p><strong>How is the auxiliary variable used by this strategy?</strong> At the design stage the
    variance term of the model is explained by defining inclusion probabilities proportional to 
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> 
   </mrow> </msup> </math>. At the estimation stage, the trend term of the model is explained by using 
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msup> </math>
    in the auxiliary vector, i.e. 
    <span class="ecuacion" id="optimalvec2"><math> <msub> <mrow class="MJX-TeXAtom-ORD">
    <mi mathvariant="bold">x</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
      <mo>=</mo> <mrow> <mo>(</mo> <mn>1</mn> <mo>,</mo> <msubsup> <mi>x</mi> 
      <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
      <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup>
      <mo>)</mo> </mrow> </math></span>.
   </p>

   <h3>Strategy 2: Stratified Simple Random Sampling with the regression estimator</h3>

   <p>This strategy, denoted STSRS-reg, uses the auxiliary variable at both stages too.
   At the design stage the quantitative auxiliary
   variable is used for defining the boundaries of the strata using the cum-sqrt-rule on 
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math>, 
    so explaining the variance term of the model. At the estimation stage, on the other hand, the auxiliary
    variable is used for defining the auxiliary vector that will be used in the regression estimator.</p>

   <p><strong>How is the auxiliary variable used by this strategy?</strong> At the estimation stage, the
   auxiliary variable is used for defining the auxiliary vector as in the optimal strategy described in the 
   Introduction, i.e. 
   <math> <msub> <mrow class="MJX-TeXAtom-ORD">
    <mi mathvariant="bold">x</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
     <mo>=</mo> <mrow> <mo>(</mo> <mn>1</mn> <mo>,</mo> <msubsup> <mi>x</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
     <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup>
     <mo>)</mo> </mrow> </math>.
    Therefore it will be said that this strategy is strongly model-dependent in the estimator. Regarding 
    the design, it uses the auxiliary variable in a way that will be referred as medium model-dependent as
    it uses the information in the model but not in the straight way suggested by the optimal strategy.</p>

   <p>The following plot illustrates the stratification obtained for this strategy. (The same stratification is used in trategy 5.)</p>'),

plotOutput("grafico4"),

HTML('<h3>Strategy 3: Stratified Simple Random Sampling with the Horvitz-Thompson estimator</h3>

   <p>This strategy, denoted STSRS-HT, is strictly design
    unbiased. It uses the auxiliary information only at the design stage, therefore it is considered that
    it relies on the model more weakly than the other strategies. It will be considered as a benchmark.</p>

   <p><strong>How is the auxiliary variable used by this strategy?</strong> At the design stage the 
    quantitative auxiliary variable is used for defining the boundaries of the strata, the stratification is 
    defined using the cum-sqrt-rule on 
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msup> </math>.
    No auxiliary information is used at the estimation stage.</p>

   <p>The following plot illustrates the stratification obtained for this strategy. (This stratification is considered 
    as the poststratification in strategies 4 and 5.)</p>'),

plotOutput("grafico3"),

HTML('
   <h3>Strategy 4: Probability Proportional-to-Size sampling with the poststratified estimator</h3>
 
   <p>This strategy, denoted <math> <mi>&#x03C0</mi> </math>ps-pos, also makes use of the
    auxiliary variable at both stages. At the estimation stage the quantitative auxiliary variable is used for defining the boundaries of the poststrata
    using the cum-sqrt-rule on 
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msup> </math>,
    thus explaining the trend term of the model. At the design stage, on the other hand, the quantitative
    auxiliary variable is used for defining the inclusion probabilities so that they are proportional to
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> 
   </mrow> </msup> </math>, 
    thus explaining the variance term of the model. Again, Pareto <math> <mi>&#x03C0</mi> </math>ps sampling is used.</p>

   <p><strong>How is the auxiliary variable used by this strategy?</strong> At the design stage, the 
    auxiliary variable is used for defining the inclusion probabilities as in the optimal strategy 
    described in the Introduction, i.e. 
   <math> <msub> <mi>&#x03C0</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> <mi>n</mi> <mfrac>
     <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
     <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
     </msubsup> <msub> <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>x</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
     <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
     </msup> </mrow> </msub> </mfrac> </math>. 
   Therefore, it will be said that this strategy is strongly model-dependent in the design. Regarding the
   estimator, it uses the auxiliary variable in a way that will be referred as medium model-dependent, as
   it uses the information in the assumed model but not in the straight way suggested by the optimal
   strategy.  It
    is worth noting that Strategy 4 uses the design suggested by the optimal strategy but not its estimator, 
    whereas Strategy 2 is the opposite, it uses the estimator suggested by the optimal strategy, but not 
    its design.</p>'),

HTML('<h3>Strategy 5: Stratified Simple Random Sampling with the poststratified estimator</h3>

   <p>This strategy, denoted STSRS-pos, uses the auxiliary variable in both, the design 
    and the estimation stage. Due to the use of the poststratified estimator, it is biased, but its bias
    is known to be small, particularly for large samples.</p>

   <p><strong>How is the auxiliary variable used by this strategy?</strong> As the sampling design is
    supposed to explain the variance term, the quantitative auxiliary variable is used for defining the 
    boundaries of the strata, the stratification is therefore defined using the cum-sqrt-rule on
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math>.
    In the same sense, as the estimator is supposed to explain the trend term, the quantitative auxiliary 
    variable is used again, this time for defining the boundaries of the poststrata, the poststratification is 
    therefore defined using the cum-sqrt-rule on
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msup> </math>.
    Note that the poststrata in this strategy coincide with the strata in Strategy 3.</p>'),

HTML('<p>The following table shows the boundaries for the strata/poststrata: The first and third columns indicate
    the boundaries with respect to
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math>
   and <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math>
   , respectively. The second and fourth columns indicate the number of elements in each stratum.</p>

      <p>Note that the actual number of strata might differ from the desired number specified by the user.</p>'),

tableOutput("tabla2"),

HTML('
   <a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">
   <h2 id="Step4">Defining the true generating model</h2>

   <p>The beliefs of the statistician about the model that relates <em>x</em> and <em>y</em> are expressed
    in the <em>working</em> model defined above. With this model and the number of strata, the five 
    strategies compared by the app are completely defined. However, the
    goal is to investigate what happens with the strategies
    when the true model differs from the working model. In this step, the user defines the parameters of
    the <em>true model</em>, 
    <math> <mi>&#x03BE</mi> </math>, 
    that relates <em>x</em> and <em>y</em> in the following form</p>

   <div class="modelo">
   <p> <span class="ecuacion" id="modelover"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>Y</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo>
     <msub> <mi>&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub>
     <mo>+</mo> <msub> <mi>&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1</mn> </mrow>
     </msub> <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD">
     <mn>2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
     <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
     </math></span>
     <span class="basura">MM</span>with<span class="basura">MM</span>
     <span class="ecuacion" id="verdadcon1"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;<!-- ?? --></mi> </mrow> </msub>
     <mrow> <mo>(</mo> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
     </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
     <span class="ecuacion" id="verdadcon2"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;<!-- ?? --></mi> </mrow> </msub>
     <mrow> <mo>(</mo> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
     </mrow> </msub> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>l</mi>
     </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
     <span class="ecuacion" id="verdadcon3"><math xmlns="http://www.w3.org/1998/Math/MathML">
     <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;<!-- ?? --></mi> </mrow> </msub>
     <mrow> <mo>(</mo> <msub> <mi>&#x03F5;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
     </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <msub> <mi>&#x03B2;<!-- ?? --></mi>
     <mrow class="MJX-TeXAtom-ORD"> <mn>3</mn> </mrow> </msub> <msubsup> <mi>x</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD">
     <msub> <mi>2&#x03B2;<!-- ?? --></mi> <mrow class="MJX-TeXAtom-ORD"> <mn>4</mn> </mrow> </msub>
     </mrow> </msubsup> </math></span>
     </p>
</div>

   <p>The output is a plot that compares the <em>working</em> model (red) with the <em>true</em>
    model (green). The lines indicate the trend and the shaded areas indicate the spread around the trend.</p>
      '),

numericInput("beta0",label=HTML('<math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD">
                                <mn>0</mn> </mrow> </msub> </math>'),value=0),

numericInput("beta1",label=HTML('<math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                <mn>1</mn> </mrow> </msub> </math>'),value=1),

numericInput("beta2",label=HTML('<math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                  <mn>2</mn> </mrow> </msub> </math>'),value=1,min=-5,max=5),

numericInput("beta3",label=HTML('<math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                <mn>3</mn> </mrow> </msub> </math>'),value=1),

numericInput("beta4",label=HTML('<math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                <mn>4</mn> </mrow> </msub> </math>'),value=1,min= 0,max=5),

plotOutput("grafico5"),

HTML('
   <a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">
   <h2 id="Step5">Simulating the study variable</h2>

   <p>In this step the superpopulation model
    <math> <mi>&#x03BE</mi> </math> 
    together with the auxiliary variable is used for simulating one finite population of 
    <em>N</em> observations for the study variable.</p>

   <p>No inputs are required from the user in this step.</p>

   <p>The output is the scatter plot of the simulated finite population together with some summary statistics of both variables.</p>

   <p><strong>Note:</strong> If <em>N>5000</em> then a random sample of 5000 observations will be shown in
    the scatter plot.</p>'),

plotOutput("grafico6"),

tableOutput({'tabla3'}),

HTML('
   <a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">
   <h2 id="Step6">Computing the variance of the five strategies</h2>

   <p>Using the finite population simulated in the step above the app
    computes the (approximated) variance for each strategy in order to determine which one is more 
    efficient in the estimation of the total of <em>y</em>. The variances are shown both in absolute 
    and relative terms. Relativeness is computed with respect to Strategy 3, 
    STSRS-HT, the benchmark.</p>

   <p>The only input required from the user in this step is the desired sample size, <em>n</em>.</p>

   <p>The output is a table comparing the variances of the five strategies for the finite population
    simulated above.</p>'),

numericInput("nn",label="n (sample size)",value=500,min=2,max=100000),

tags$table(id="Tabla",tags$tr(tags$th('Strategy'),tags$th('Notation'),tags$th('Formula'),
   tags$th(HTML('<math> <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>p</mi> </mrow> </msub>
                 <mrow> <mo>(</mo> <mrow class="MJX-TeXAtom-ORD"> <mover> <mi>t</mi> 
                 <mo stretchy="false">&#x005E</mo> </mover> </mrow> <mo>)</mo> </mrow> </math>')),
   tags$th(HTML('<math> <mn>100</mn> <mo>&#x00D7</mo> <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD">
                 <mi>p</mi> </mrow> </msub> <mrow> <mo>(</mo> <mrow class="MJX-TeXAtom-ORD"> <mover> 
                 <mi>t</mi> <mo stretchy="false">&#x005E</mo> </mover> </mrow> <mo>)</mo> </mrow> 
                 <mrow class="MJX-TeXAtom-ORD"> <mo>/</mo> </mrow> <msub> <mi>V</mi> <mtext>STSRS</mtext>
                 </msub> <mrow> <mo>(</mo> <msub> <mrow class="MJX-TeXAtom-ORD"> <mover> <mi>t</mi>
                 <mo stretchy="false">&#x005E</mo> </mover> </mrow> <mrow class="MJX-TeXAtom-ORD"> 
                 <mi>&#x03C0</mi> </mrow> </msub> <mo>)</mo> </mrow> </math>'))),
           tags$tr(tags$td(1),tags$td(HTML('<math> <mi>&#x03C0</mi> </math>ps-reg')),
              tags$td(HTML('<math> <mfrac> <mi>N</mi> <mrow> <mi>N</mi> <mo>&#x2212</mo> <mn>1</mn> </mrow> </mfrac> <mrow> <mo>(</mo> <msub> 
                 <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>D</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msup> 
                 <mo stretchy="false">(</mo> <mn>1</mn> <mo>&#x2212</mo> <mi>&#x03C0</mi> <mo stretchy="false">)</mo> 
                 <mrow class="MJX-TeXAtom-ORD"> <mo>/</mo> </mrow> <mi>&#x03C0</mi> </mrow> </msub> <mo>&#x2212</mo> <mfrac> <msubsup> 
                 <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>D</mi> <mo stretchy="false">(</mo> <mn>1</mn> <mo>&#x2212</mo> 
                 <mi>&#x03C0</mi> <mo stretchy="false">)</mo> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> <msub> 
                 <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03C0</mi> <mo stretchy="false">(</mo> <mn>1</mn> <mo>&#x2212</mo> 
                 <mi>&#x03C0</mi> <mo stretchy="false">)</mo> </mrow> </msub> </mfrac> <mo>)</mo> </mrow> </math>')),
              tags$td(htmlOutput('varianza1')),tags$td(htmlOutput('varianza6'))),
           tags$tr(tags$td(2),tags$td('STSRS-reg'),
              tags$td(HTML('<math> <munderover> <mo movablelimits="false">&#x2211</mo> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> <mo>=</mo> 
                 <mn>1</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>H</mi> </mrow> </munderover> <mfrac> <msubsup> <mi>N</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> 
                 <msub> <mi>n</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> </mfrac> <mrow> <mo>(</mo> <mn>1</mn> 
                 <mo>&#x2212</mo> <mfrac> <msub> <mi>n</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> <msub> <mi>N</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> </mfrac> <mo>)</mo> </mrow> <msubsup> <mi>S</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>D</mi> <mo>,</mo> <msub> <mi>U</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> 
                 </msub> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>')),
              tags$td(htmlOutput('varianza2')),tags$td(htmlOutput('varianza7'))),
           tags$tr(tags$td(3),tags$td('STSRS-HT'),
              tags$td(HTML('<math> <munderover> <mo movablelimits="false">&#x2211</mo> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> <mo>=</mo> 
                 <mn>1</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>H</mi> </mrow> </munderover> <mfrac> <msubsup> <mi>N</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> <msub> 
                 <mi>n</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> </mfrac> <mrow> <mo>(</mo> <mn>1</mn> 
                 <mo>&#x2212</mo> <mfrac> <msub> <mi>n</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> <msub> <mi>N</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> </mfrac> <mo>)</mo> </mrow> <msubsup> <mi>S</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>y</mi> <mo>,</mo> <msub> <mi>U</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> 
                 </msub> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>')),
              tags$td(htmlOutput('varianza3')),tags$td(htmlOutput('varianza8'))),
           tags$tr(tags$td(4),tags$td(HTML('<math> <mi>&#x03C0</mi> </math>ps-pos')),
              tags$td(HTML('<math> <mfrac> <mi>N</mi> <mrow> <mi>N</mi> <mo>&#x2212</mo> <mn>1</mn> </mrow> </mfrac> <mrow> <mo>(</mo> <msub> 
                 <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msup> 
                 <mo stretchy="false">(</mo> <mn>1</mn> <mo>&#x2212</mo> <mi>&#x03C0</mi> <mo stretchy="false">)</mo> 
                 <mrow class="MJX-TeXAtom-ORD"> <mo>/</mo> </mrow> <mi>&#x03C0</mi> </mrow> </msub> <mo>&#x2212</mo> <mfrac> <msubsup> 
                 <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>E</mi> <mo stretchy="false">(</mo> <mn>1</mn> <mo>&#x2212</mo> 
                 <mi>&#x03C0</mi> <mo stretchy="false">)</mo> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> <msub> 
                 <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03C0</mi> <mo stretchy="false">(</mo> <mn>1</mn> <mo>&#x2212</mo> 
                 <mi>&#x03C0</mi> <mo stretchy="false">)</mo> </mrow> </msub> </mfrac> <mo>)</mo> </mrow> </math>')),
              tags$td(htmlOutput('varianza4')),tags$td(htmlOutput('varianza9'))),
           tags$tr(tags$td(5),tags$td('STSRS-pos'),
              tags$td(HTML('<math> <munderover> <mo movablelimits="false">&#x2211</mo> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> <mo>=</mo> 
                 <mn>1</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>H</mi> </mrow> </munderover> <mfrac> <msubsup> <mi>N</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> <msub> 
                 <mi>n</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> </mfrac> <mrow> <mo>(</mo> <mn>1</mn> <mo>&#x2212</mo> 
                 <mfrac> <msub> <mi>n</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> <msub> <mi>N</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> </msub> </mfrac> <mo>)</mo> </mrow> <msubsup> <mi>S</mi> 
                 <mrow class="MJX-TeXAtom-ORD"> <mi>E</mi> <mo>,</mo> <msub> <mi>U</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>h</mi> </mrow> 
                 </msub> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>')),
              tags$td(htmlOutput('varianza5')),tags$td(htmlOutput('varianza0')))),

HTML('
   <a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">
   <h2 id="Step7">Monte Carlo simulation</h2>
     
   <p>In the last two steps above one finite population was generated from the superpopulation model. The 
    variance of each strategy was computed for this particular population. However, the process has to be
    iterated so the behavior of the strategies can be identified.</p>

   <p>In this step, the app generates <em>R</em> finite populations from the
    superpopulation model. The user is asked for defining the number of desired iterations.</p>

   <p>Three outputs are returned: 1. The results of (at most) the first ten iterations are shown. 2. A boxplot
    comparing the <em>R</em> variances obtained for each strategy is also returned. 3. By clicking the 
    "Download" button the user has the option to download the results of the simulations, which are stored
    externally under the name <em>Iterations.csv</em>, so that the user can perform his/her own analysis of
    the results.</p>'),

numericInput("it",label="Number of iterations",value=10,min=0,max=100000),

actionButton(inputId="itera",label="Execute iterations"),

textOutput("tabla5"),

downloadButton('downdata','Download'),

verbatimTextOutput("tabla6"),

plotOutput("grafico7"),

HTML('<a href="#Top">Back to Top</a></div>
   </div>
   </div>

   <div id="Marco3">
   <p>If you have comments or questions about the app please contact <a href="mailto:embuenoc@hotmail.com">Edgar Bueno</a></p>
   </div>
   </body>')
)