#library(shiny)

fluidPage(

HTML('
   <!DOCTYPE html> 
   <head>
   <title>optimStrat</title>
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
   img {float:right}
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
   <!--   <img src="logo.png" alt="SU_logo" width=170 height=133 /> -->

   <h1 id="Top">optimStrat</h1>

   <p id="Subtitulo">Looking for a robust sampling strategy</p>
   </div>

   <div id="principal">
   <div id="Marco1">
   <h2 id="Description">Description</h2>

   <p>This app compares the anticipated variance of five sampling strategies
    allowing the user to study the impact of assuming a working model that differs from the true model. The app 
    works in steps as described below:</p>

   <ol><li><a href="#Step1">Uploading/Simulating the auxiliary variable.</a></li>
   <li><a href="#Step2">Defining the <em>working</em> model.</a></li>
   <li><a href="#Step3">Defining the uncertainty about the parameters.</a></li>
   <li><a href="#Step4">Defining the sampling strategies.</a></li>
   <li><a href="#Step5">Comparing the strategies.</a></li>
    </ol></div>

   <div id="Marco2">
   <p id="Objective">The objective is to find an efficient and robust sampling strategy for the estimation of 
    the total of one <em>study variable</em> using one quantitative <em>auxiliary variable</em>. A model that 
    relates the study variable and the auxiliary variable is assumed but it 
    may differ from the true generating model i.e. there might be some type of model 
    misspecification.</p>

   <p id="Note"><strong>Note:</strong> In order to see the formulas correctly, it is recommended to use Firefox.</p>

   <!-- <p id="Note"><strong>Note:</strong> The theory behind this app can be found in Bueno, E. (2018). 
   On the decision between Stratified simple random sampling and Probability proportional-to-size sampling.</p> -->

   <div class="seccion">
   <h2 id="Introduction">Introduction</h2>

   <p>The strategy that couples probability proportional-to-size sampling with the general 
    regression estimator, <math <mi>&#x03C0;</mi></math>ps-GREG, is sometimes called optimal. 
    This optimality is based on the strong assumption that the study variable is a realization 
    of a model with some parameters known. As these assumptions are hardly satisfied in 
   practice, one might find that a different strategy is, in fact, more efficient.</p>

   <p> The idea behind this app is as follows. At the planning stage of a study, the statistician has one positive quantitative auxiliary variable at 
    hand, <em>x</em>, and needs to decide on the best way for making use of it in order to obtain a good estimate 
    of the total of the variable of interest, 
    <em>y</em>. In other words, the statistician wants to find an efficient sampling strategy.</p>

   <p>For doing so, the statistician <em>assumes</em> that the <em>y</em>-values are realizations of the following model, 
   <math> <msub><mi>&#x03BE</mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>0</mn></mrow></msub></math>:</p>

   <div class="modelo">
   <p><span class="ecuacion parte1" id="modasumido">
    <math xmlns="http://www.w3.org/1998/Math/MathML"> <msub> <mi>Y</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> 
    <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,0</mn> </mrow> </msub> <mo>+</mo>
    <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,1</mn> </mrow> </msub>
    <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4;</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
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
  <span class="ecuacion parte4" id="asumidocon3"> <math xmlns="http://www.w3.org/1998/Math/MathML" display="block">
  <msub> <mi>V</mi> <mrow> <msub> <mi>&#x3BE;</mi> <mrow> <mn>0</mn> </mrow> </msub> </mrow> </msub>
  <mo stretchy="false">(</mo> <msub> <mi>&#x3F5;</mi> <mrow> <mi>k</mi> </mrow> </msub> <mo stretchy="false">)</mo>
  <mo>=</mo> <msubsup> <mi>&#x3C3;</mi> <mrow> <mn>0</mn> </mrow> <mrow> <mn>2</mn> </mrow> </msubsup> <msubsup>
    <mi>x</mi> <mrow> <mi>k</mi> </mrow> <mrow> <mn>2</mn> <msub> <mi>&#x3B4;</mi> <mrow> <mn>2</mn> </mrow> </msub>
    </mrow> </msubsup> </math></span> </p> </div>

   <p>However, the statistician is not 100% optimistic regarding the model: (s)he knows that it is 
    very unlikely that the <em>assumed</em> model is completely right. Therefore the statistician wants to study 
    the impact of assuming the model above when the <em>true generating model</em>, 
    <math xmlns="http://www.w3.org/1998/Math/MathML"><mi>&#x03BE;</mi></math>, 
    differs and can be written as:</p>

   <div class="modelo">
   <p> <span class="ecuacion" id="modelover"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>Y</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo>
    <msub> <mi>&#x03B2;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,0</mn> </mrow> </msub>
    <mo>+</mo> <msub> <mi>&#x03B2;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,1</mn> </mrow>
    </msub> <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B2;</mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
    <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
    </math></span>
   <span class="basura">MM</span>with<span class="basura">MM</span>
   <span class="ecuacion" id="verdadcon1"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;</mi> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
    </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
   <span class="ecuacion" id="verdadcon2"><math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>E</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;</mi> </mrow> </msub>
    <mrow> <mo>(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi>
    </mrow> </msub> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>l</mi>
    </mrow> </msub> <mo>)</mo> </mrow> <mo>=</mo> <mn>0</mn> </math></span>,<span class="basura">MM</span>
   <span class="ecuacion" id="verdadcon3"> <math xmlns="http://www.w3.org/1998/Math/MathML">
    <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>&#x03BE;</mi> </mrow> </msub>
    <mo stretchy="false">(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
    </msub> <mo stretchy="false">)</mo> <mo>=</mo> <msubsup> <mi>&#x3C3;</mi>
    <mrow class="MJX-TeXAtom-ORD"> <mn></mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow>
    </msubsup> <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> <msub> <mi>&#x03B2;</mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>2</mn> </mrow> </msub> </mrow> </msubsup> </math> </span>
   </p>
   </div>

   <p>Note that both, the <em>true</em> and the <em>working</em>, models have the same functional 
    form. The misspecification that the statistician is going to investigate relies in those cases
    where the 
    <math> <mi>&#x03B4</mi> </math>-parameters differ from the 
    <math> <mi>&#x03B2;</mi> </math>-parameters. In particular, when 
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>1,2</mn></mrow> </msub></math> 
    differs from
    <math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"><mn>1,2</mn></mrow> </msub></math>
    or 
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>2</mn></mrow> </msub></math>
    differs from
    <math> <msub> <mi>&#x03B2</mi> <mrow class="MJX-TeXAtom-ORD"><mn>2</mn></mrow> </msub></math>.
    </p>

   <p>To begin with, let us say that the working model, <math> <msub><mi>&#x03BE</mi> <mrow class="MJX-TeXAtom-ORD">
    <mn>0</mn></mrow></msub></math>, is correct. Then, the strategy that couples a <math> <mi>&#x03C0</mi> </math>ps design and the 
    regression estimator is called optimal, with:</p>
 
   <p><span class="ecuacion" id="optimalinc"><math> <msub> <mi>&#x03C0</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> <mi>n</mi> <mfrac>
    <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
    <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
    </msubsup> <msub> <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
    <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
    </msup> </mrow> </msub> </mfrac> </math></span>
    the inclusion probability of the <em>k</em>-th element, where <em>n</em> is the desired sample 
    size and </p>

   <p> <span class="ecuacion" id="optimalvec"><math> <msub> <mrow class="MJX-TeXAtom-ORD">
    <mi mathvariant="bold">x</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
    <mo>=</mo> <mrow> <mo>(</mo> <mn>1</mn> <mo>,</mo> <msubsup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
    <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup>
    <mo>)</mo> </mrow> </math></span> 
   is the auxiliary vector to be used in the regression 
    estimator.</p>

   <p>Both models are composed of two terms. A <em>trend</em> term:
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,0</mn> </mrow> </msub> <mo>+</mo> 
    <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,1</mn> </mrow> </msub> <msubsup> <mi>x</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub> 
    <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup> </math>, 
    where 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,0</mn> </mrow> </msub> </math>
   indicates the intercept, 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,1</mn> </mrow> </msub> </math> 
    is a scale factor and 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </math> 
    is a shape factor; and a <em>variance</em> term:
   <math> <msubsup> 
    <mi>&#x3C3;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> <msubsup>
    <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
    <mi>2&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msubsup> </math>,
    where
   <math> <msub> <mi>&#x3C3;</mi> <mrow> <mn>0</mn> </mrow> </msub> </math>
    is a scale factor for the variance (which defines the correlation between <em>x</em> and <em>y</em>),
    and
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </math>
    indicates the shape of the variance.</p>

   <p>In this sense, the sampling design is supposed to explain the variance term (through 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </math>)
    and the estimator is supposed to explain the trend term (through 
   <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </math>). 
    The remaining parameters in the model are not involved in the strategy, therefore it is not necessary 
    to have previous knowledge about them.</p>

   <p>The above strategy is called optimal as it minimizes asymptotically the Anticipated
    Mean Squared Error, which is a model-dependent statistic. It is expected then that the strategy
    <math <mi>&#x03C0;</mi></math>ps-GREG as defined 
    above behaves well when the assumed model is close to the true model. But what if not?</p>

   <p>This app allows for comparing five strategies when the 
    working model differs from the true generating model.</p>

   <a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">
   <h2 id="Step1">Uploading/Simulating the auxiliary variable</h2>

   <p>In this step the positive quantitative auxiliary variable, <em>x</em>, that will be used 
    for assisting the estimation of the total of the study variable, <em>y</em>, is defined. 
    Two methods are allowed: the observations can be loaded from an external file, or, 
    they can be simulated from a gamma distribution with fixed mean 48 plus one unit and the
    skewness defined by the user.</p>

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
     <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,0</mn> </mrow> </msub> <mo>+</mo>
     <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,1</mn> </mrow> </msub>
     <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow>
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4;</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup> <mo>+</mo>
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
    <msub> <mi>V</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03BE;</mi>
    <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </mrow> </msub>
    <mo stretchy="false">(</mo> <msub> <mi>&#x03F5;</mi> <mrow class="MJX-TeXAtom-ORD">
    <mi>k</mi> </mrow> </msub> <mo stretchy="false">)</mo> <mo>=</mo> <msubsup> 
    <mi>&#x3C3;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> <msubsup> <mi>x</mi>
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn>
    <msub> <mi>&#x03B4;</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub>
    </mrow> </msubsup> </math></span>
     </p>
   </div>
      
   <p>In this step the user specifies the parameters of the model above. Note that only 
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>1,2</mn></mrow> </msub></math>
    and
    <math> <msub> <mi>&#x03B4;</mi><mrow class="MJX-TeXAtom-ORD"><mn>2</mn></mrow> </msub></math>
    are required for defining the sampling strategy, as well as some guess about the correlation 
    between both variables.</p>

   <p>The output is a plot showing the model assumed by the user (where 
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,0</mn> </mrow> </msub> </math>, 
    <math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,1</mn> </mrow> </msub> </math> and 
    <math> <msub> <mi>&#x3C3</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>0</mn> </mrow> </msub> </math>
    are predefined by convenience). The red line indicates the trend and the shaded area around
    indicates the spread around the trend.</p>'),

fluidRow(column(3,numericInput("delta2",label=HTML('<math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                  <mn>1,2</mn> </mrow> </msub> </math>'),value=1,min=0,max=5)),
         column(3,numericInput("delta4",label=HTML('<math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
                                  <mn>2</mn> </mrow> </msub> </math>'),value=1,min=0,max=5)),
         column(3,numericInput("rho",label=HTML('<math> <msub> <mi>R</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>x</mi> <mo>,
                               </mo> <mi>y</mi> </mrow> </msub> </math>'),value=0.95,min=0,max=1))),

#numericInput("delta2",label=HTML('<math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
#                                  <mn>2</mn> </mrow> </msub> </math>'),value=1,min=0,max=5),

#numericInput("delta4",label=HTML('<math> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
#                                  <mn>4</mn> </mrow> </msub> </math>'),value=1,min=0,max=5),

#numericInput("rho",label=HTML('<math> <msub> <mi>R</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>x</mi> <mo>,
#                               </mo> <mi>y</mi> </mrow> </msub> </math>'),value=0.95,min=0,max=1),

plotOutput("grafico2"),

HTML('<a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">'),

tags$h2(id="Step3","Defining the uncertainty about the parameters"),

HTML('<p>The working model specified above reflects the best available knowledge about the association 
   between the auxiliary and the study variable. However, it is subject to misspecification.</p>

   <p>In this step, the user specifies the variances and correlation of a prior distribution on the parameters of the
   model using a bivariate normal distribution with mean equal to the parameters given above. The variances should 
   reflect the uncertainty about each parameter: the smaller 
   the variance, the more confident the user is about the parameter.</p>

   <p>Two outputs are returned: the covariance matrix and a heat map illustrating the resulting
   distribution with contours for the 50, 90, 95 and 99% of the density. The heat map is intended to 
   assist the user in the definition of the hyper-parameters.</p>

   <p><strong>Note:</strong> The resulting matrix might use smaller 
   variances than those provided by the user in order to keep the density in the first quadrant.</p>

   <p><strong>Note 2:</strong> A correlation of zero will make the calculations in <a href="#Step5">step 5</a> faster.</p>'),

fluidRow(column(4,numericInput("sigma1",label=HTML('<math> <msubsup> <mi>&#x03C3;</mi> <mrow class="MJX-TeXAtom-ORD"> 
   <mn>1,2</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>'),
   value=0.06,min=0,max=1.66)),
         column(4,numericInput("sigma2",label=HTML('<math> <msubsup> <mi>&#x03C3;</mi> <mrow class="MJX-TeXAtom-ORD"> 
   <mn>2</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>'),
   value=0.06,min=0,max=1.66)),
         column(4,numericInput("rho12",label=HTML('<math> <mi>&#x03C1;</mi> </math>'),value=0,min=-1,max=1))),

#numericInput("sigma1",label=HTML('<math> <msubsup> <mi>&#x03C3;</mi> <mrow class="MJX-TeXAtom-ORD"> 
#   <mn>1</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>'),
#   value=0.06,min=0,max=1.66),

#numericInput("sigma2",label=HTML('<math> <msubsup> <mi>&#x03C3;</mi> <mrow class="MJX-TeXAtom-ORD"> 
#   <mn>2</mn> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msubsup> </math>'),
#   value=0.06,min=0,max=1.66),

#numericInput("rho12",label=HTML('<math> <msub> <mi>&#x03C1;</mi> <mrow class="MJX-TeXAtom-ORD">
#      <mn>1</mn> <mo>,</mo> <mn>2</mn> </mrow> </msub> </math>'),value=0,min=-1,max=1),

verbatimTextOutput("tab_variance"),

plotOutput("gra_density"),

HTML('<a href="#Top">Back to Top</a>
   </div>

   <div class="seccion">'),

tags$h2(id="Step4","Defining the sampling strategies"),

HTML('
   <p>The app allows for comparing five sampling strategies. The auxiliary
    variable and the model defined above are almost everything that is required for the strategies to be
    completely specified. However, two last inputs are needed: the number of strata/poststrata and the desired 
    sample size.</p>

   <p>In this step the user specifies these inputs. Then a file with the inclusion probabilities and the 
   stratification with respect to both <math> <msup> <mi>x</mi> 
   <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> 
   </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math> and <math> <msup> <mi>x</mi> 
   <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> 
   </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math> can be downloaded. Finally, the
   five strategies compared by the app are described.</p>'),

fluidRow(column(4,numericInput("H",label="H (number of strata)",value=4,min=2,max=20)),
         column(4,numericInput("nn",label="n (sample size)",value=500,min=2,max=100000)),
         column(4,tags$br(),downloadButton('down_data','Download'))),

tags$hr(),

#numericInput("H",label="H (number of strata)",value=4,min=2,max=20),

#numericInput("nn",label="n (sample size)",value=500,min=2,max=100000),

HTML('
   <h4>Strategy 1: Probability Proportional-to-Size sampling with the regression estimator</h3>

   <p>At the design stage the
    variance term of the model is explained by defining inclusion probabilities proportional to 
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> 
   </mrow> </msup> </math>. At the estimation stage, the trend term of the model is explained by using 
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msup> </math>
    in the auxiliary vector, i.e. 
    <span class="ecuacion" id="optimalvec2"><math> <msub> <mrow class="MJX-TeXAtom-ORD">
    <mi mathvariant="bold">x</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
      <mo>=</mo> <mrow> <mo>(</mo> <mn>1</mn> <mo>,</mo> <msubsup> <mi>x</mi> 
      <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
      <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup>
      <mo>)</mo> </mrow> </math></span>.</p>

   <h4>Strategy 2: Stratified Simple Random Sampling with the regression estimator</h3>

   <p>At the estimation stage, the
   auxiliary variable is used for defining the auxiliary vector as in strategy 1, i.e. 
   <math> <msub> <mrow class="MJX-TeXAtom-ORD">
    <mi mathvariant="bold">x</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub>
     <mo>=</mo> <mrow> <mo>(</mo> <mn>1</mn> <mo>,</mo> <msubsup> <mi>x</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> <mrow class="MJX-TeXAtom-ORD"> <msub>
     <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msubsup>
     <mo>)</mo> </mrow> </math>.
    Regarding 
    the design, the strata are generated using the cum-sqrt-rule and Neyman optimal allocation on 
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msup> </math>.</p>

   <h4>Strategy 3: Stratified Simple Random Sampling with the Horvitz-Thompson estimator</h3>

   <p>This strategy uses the auxiliary information only at the design stage, where the auxiliary variable is used for 
   defining the boundaries of the strata using the cum-sqrt-rule on 
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msup> </math>.
    No auxiliary information is used at the estimation stage.</p>

   <h4>Strategy 4: Probability Proportional-to-Size sampling with the poststratified estimator</h3>
 
   <p>At the design stage, the 
    auxiliary variable is used for defining the inclusion probabilities as in strategy 1, i.e. 
   <math> <msub> <mi>&#x03C0</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> </msub> <mo>=</mo> <mi>n</mi> <mfrac>
     <msubsup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <mi>k</mi> </mrow> 
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
     <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
     </msubsup> <msub> <mi>t</mi> <mrow class="MJX-TeXAtom-ORD"> <msup> <mi>x</mi> 
     <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> <mrow class="MJX-TeXAtom-ORD"> 
     <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow>
     </msup> </mrow> </msub> </mfrac> </math>. At the estimation stage the auxiliary 
   variable is used for defining the boundaries of the poststrata
    using the cum-sqrt-rule on 
   <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msup> </math>,
    thus explaining the trend term of the model.</p>

   <h4>Strategy 5: Stratified Simple Random Sampling with the poststratified estimator</h3>

   <p>As the sampling design is
    supposed to explain the variance term, the stratification is defined using the cum-sqrt-rule on
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> <mrow class="MJX-TeXAtom-ORD"> </mrow> </mrow> </msup> </math>.
    In the same sense, as the estimator is supposed to explain the trend term, the poststratification is 
    defined using the cum-sqrt-rule on
    <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msup> </math>.</p>'),

#downloadButton('down_data','Download'),

#plotOutput("grafico4"),

#plotOutput("grafico3"),

#tableOutput("tabla2"),

HTML('
   <p><a href="#Top">Back to Top</a></p>
   </div>

   <div class="seccion">
   <h2 id="Step5">Comparing the strategies and computing the risk</h2>

   <p>This step is divided in two parts. First, it allows the user to compare the anticipated MSE of any two strategies when
    the working model with <math> <msup> <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>1,2</mn> </mrow> </msub> </mrow> </msup> </math> and <math> <msup> 
   <mi>x</mi> <mrow class="MJX-TeXAtom-ORD"> <msub> <mi>&#x03B4</mi> 
    <mrow class="MJX-TeXAtom-ORD"> <mn>2</mn> </mrow> </msub> </mrow> </msup> </math> is assumed but they
   differ from the parameters in the true model. Second, it computes the risk of each strategy so the user
   can choose the one where the least risk is incurred.</p>

   <p>Before proceeding, please verify that all parameters defined in the previous steps are correct, then click the button.</p>

   <p><strong>Note:</strong> The calculations might take a few minutes. The first increment in the progress bar is at 10%.</p>'),

actionButton(inputId="calcula",label="Accept and run"),

tags$hr(),

HTML('
   <h4>Comparing the MSE of the strategies</h4>

   <p>The following plot shows the difference in MSE between any pair of strategies
   in a logarithmic scale.</p>

   <p>Please choose two strategies to compare...</p>'),

fluidRow(column(4,selectInput("compare1",label="Strategy 1",c("PIps-reg"=1,"STSI-reg"=2,"STSI-HT"=3,"PIps-pos"=4,"STSI-pos"=5,"---"=6))),
         column(4,selectInput("compare2",label="Strategy 2",c("PIps-reg"=1,"STSI-reg"=2,"STSI-HT"=3,"PIps-pos"=4,"STSI-pos"=5,"---"=6),selected=2))),

#selectInput("compare1",label="Strategy 1",c("PIps-reg"=1,"STSI-reg"=2,"STSI-HT"=3,"PIps-pos"=4,"STSI-pos"=5,"---"=6)),
#selectInput("compare2",label="Strategy 2",c("PIps-reg"=1,"STSI-reg"=2,"STSI-HT"=3,"PIps-pos"=4,"STSI-pos"=5,"---"=6),selected=2),

plotOutput("gra_loss"),

fluidRow(column(4,sliderInput("theta",label="theta",value=30,min=-180,max=180,step=5)),
         column(4,sliderInput("phi",label="phi",value=30,min=-180,max=180,step=5))),

#sliderInput("theta",label="theta",value=30,min=-180,max=180,step=5),

#sliderInput("phi",label="phi",value=30,min=-180,max=180,step=5),

tags$hr(),

HTML('
   <h4>Computing the risk</h4>

   <p>The following table shows the risk of each strategy (the expected value of the anticipated MSE under the prior distribution defined above) in both, 
   absolute terms and in relative terms with respect to strategy 3 (STSI-HT).</p>'),

tags$table(id="Tabla",tags$tr(tags$th('Strategy'),tags$th('Notation'),tags$th('Risk'),tags$th('Relative')),
           tags$tr(tags$td(1),tags$td(HTML('<math> <mi>&#x03C0</mi> </math>ps-reg')),
              tags$td(htmlOutput('risk1')),tags$td(htmlOutput('risk6'))),
           tags$tr(tags$td(2),tags$td('STSRS-reg'),
              tags$td(htmlOutput('risk2')),tags$td(htmlOutput('risk7'))),
           tags$tr(tags$td(3),tags$td('STSRS-HT'),
              tags$td(htmlOutput('risk3')),tags$td(htmlOutput('risk8'))),
           tags$tr(tags$td(4),tags$td(HTML('<math> <mi>&#x03C0</mi> </math>ps-pos')),
              tags$td(htmlOutput('risk4')),tags$td(htmlOutput('risk9'))),
           tags$tr(tags$td(5),tags$td('STSRS-pos'),
              tags$td(htmlOutput('risk5')),tags$td(htmlOutput('risk0')))),

HTML('<p>Strategy '),

tags$html(htmlOutput('mejor',inline=TRUE)),

HTML('yields the smallest risk. The sampling parameters (inclusion probabilities/stratification) can be found in 
   the downloadable file Design at the end of <a href="#Step4">step 4.</a></p>
   <p><a href="#Top">Back to Top</a></p>
   </div>
   </div>
   </div>

   <div id="Marco3">
   <p>If you have comments or questions about the app please contact <a href="mailto:embuenoc@hotmail.com">Edgar Bueno</a></p>
   </div>
   </body>')
)