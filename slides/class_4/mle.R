---
  title: "Análisis de Datos Categóricos (SOC3070)"
subtitle: "Clase #3"
author: "<br> Mauricio Bucca<br> Profesor Asistente, Sociología UC"
date: "[github.com/mebucca](https://github.com/mebucca)"
output:
  xaringan::moon_reader:
  lib_dir: libs
css: ["default","default-fonts","gentle-r.css"]
df_print: default
nature:
  ratio: 16:9
highlightStyle: github
highlightLines: true
countIncrementalSlides: true
slideNumberFormat: "%current%"
editor_options: 
  chunk_output_type: console
---
  class: inverse, center, middle

#Variables Aleatorias

---
  
  ## Variables Aleatorias
  
  Una .bold[variable aleatoria] es una variable cuyos valores son el resultado de un fenómeno aleatorio.

Si $\Omega$ es el espacio muestral de un experimento, una variable aleatoria es una función que _mapea_ el espacio muestral a los números reales: $\Omega \to \mathbb{R}$.

<br>
  --
  Ejemplo:
  - Experimento: tirar 2 dados simultáneamente
- Espacio muestral: $\{(1;1),(1;2), \dots, (5;6),(6;6)\}$
  
  
  <br>
  --
  A partir de un experimento es posible definir una variedad de variables aleatorias. Por ejemplo:
  
  --
  
  1) $X$ es la variable que resulta de registrar el valor de los dados (el experimento tal como es): 
  * $X: \{(1;1),(1;2), \dots, (5;6),(6;6)\}$
  
  --
  
  2) $Y$ es la variable que resulta de sumar el resultado de ambos dados:
  * $Y: \{2,3, \dots, 11,12 \}$
  
  
  ---
  
  ## Variables Aleatorias
  
  Cada valor posible de una variable aleatoria tiene una cierta probabilidad de ocurrencia, denotada como $\mathbb{P}(Y=y)$.

.bold[Ejercicio rápido]:
  
  - Experimento: tirar 2 dados justos simultáneamente
- $Y$ es la variable que resulta de sumar el resultado de ambos dados

--
  
  .full-width[.content-box-red[
    .bold[Pregunta]:
      ¿Cuál es la probabilidad que la variable $Y$ tome valor 12?
  ]
  ]

--
  
  .full-width[.content-box-blue[
    .bold[Respuesta]:
      $$\mathbb{P}(Y=12) = \frac{1}{36}$$
  ]
  ]

---
  
  ### Distribución de una variable aleatoria
  
  Cada valor posible de una variable aleatoria tiene una cierta probabilidad de ocurrencia. El conjunto de estas probabilidades se denomina la .bold[distribución] de la variable.

<br>
  --
  
  #### Función de probabilidad
  La función que describe la distribución de una variable aleatoria se denomina .bold[función de probabilidad (pf)], denotada $f_{X}(x)$. 

--
  
  - En el caso de variables discretas la función de probabilidad $f_{X}(x)$ entrega la probabilidad de que la variable $X$ tome valor $x$. Formalmente

$$f_{X}(x) = \mathbb{P}(X=x)$$
  
  ---
  ### Distribución de una variable aleatoria
  
  Dos características cruciales de una distribución de probabilidad son:
  
  <br>
  --
  
  - densidad/masa no negativa: $f(x) \geq 0$
  
  --
  
  - suma a 1: si $x_{1}, x_{2}, \dots, x_{n}$ son todos los valores posibles de una variable discreta $X$, entonces

--
  
  $$\sum^{\infty}_{i=1} f(x_{i}) = 1$$
  
  --
  
  Análogamente, si $X$ es continua, entonces

$$\int ^{+\infty}_{-\infty} f(x)dx = 1$$
  
  
  ---
  ### Distribución de una variable aleatoria
  
  Continuando con nuestro ejemplo:
  
  - $Y$ es la variable que resulta de sumar el resultado de tirar dos dados justos

.pull-left[
  ```{r, echo=FALSE,message=FALSE, warning=FALSE}
  library("tidyverse", "knitr")
  
  d1 = 1:6
  d2 = 1:6
  
  Y = NULL
  for (i in d1) {
    for (j in d2) {
      sum_ij = i + j
      Y <- c(Y,sum_ij)
    }
  }
  
  ditrib_Y <- table(Y) %>% as_tibble() %>% mutate(p=round(n/sum(n),2)) %>% select(-n)
  names(ditrib_Y) <- c("y","P(Y=y)") 
  knitr::kable(ditrib_Y, format = "markdown", align = 'lc')
  ```
]

--
  
  .pull-right[
    \begin{align}
    f_{Y}(y) =
      \begin{cases}
    \frac{1}{36}  & \quad \text{si } y=2 \text{ o } y=12\\
    \frac{2}{36}  & \quad \text{si } y=3 \text{ o } y=11\\
    \frac{3}{36}  & \quad \text{si } y=4 \text{ o } y=10\\
    \frac{4}{36}  & \quad \text{si } y=5 \text{ o } y=9\\
    \frac{5}{36}  & \quad \text{si } y=6 \text{ o } y=8\\
    \frac{6}{36}  & \quad \text{si } y=7 \\
    0             & \quad \text{otherwise}
    \end{cases}
    \end{align}
  ]

---
  
  ### Distribuciones discretas (categóricas)
  
  <br>
  
  - Una .bold[variable discreta] es una variable que sólo puede tomar un número contable de valores

--
  
  - La función de probabilidad de las variables aleatorias discretas se denomina "función de masa de probabilidad" (pmf) 

--
  - En el caso de las variables continuas, la función de probabilidad se denomina "función de densidad de probabilidad" (pdf)

--
  
  - En lo que sigue cubriremos las distribuciones discretas fundamentales: .bold[Bernoulli] y .bold[Binomial]


---
  
  ### Distribución Bernoulli
  
  Una variable aleatoria sigue una distribución de Bernoulli si solo puede tomar valores 0 o 1, con probabilidad $p$ y $q=1-p$, respectivamente.

--
  
  Por ejemplo,
- Experimento: tirar una moneda
- Definamos la variable $X$ tal que $X=1$ si obtenemos Cara y $X=0$ si obtenemos Sello

--
  
  $X$ es una variable Bernoulli con función de probabilidad:
  
  \begin{align}
f_{X}(x) =
  \begin{cases}
p  & \quad \text{si } x=1\\
1 - p  & \quad \text{si } x=0 \\
0 & \quad \text{otherwise}
\end{cases}
\end{align}

--
  
  En modo más sintético:
  
  $$f_{X}(x) = p^{x}(1-p)^{1-x}  \quad \text{si } x=1 \text{ o } x=0$$
  ---
  
  ### Distribución Bernoulli
  
  .bold[Ilustración via simulación en] `R`


Tiremos una moneda con probabilidad de obtener "Cara" ( $1$ ) de 70% ( $p=0.7$ )

```{r}
set.seed(12345)
moneda <- rbinom(n=1, size=1, p=0.7)
print(moneda)
```

--
  
  Repitamos el proceso 100 veces ...

```{r}
set.seed(12345)
monedas <- rbinom(n=100, size=1, p=0.7)
print(monedas)
```

---
  
  ### Distribución Bernoulli
  
  .bold[Ejercicio rápido]:
  
  - Experimento: tirar la misma moneda 2 veces

- Denotemos cada tiro como variables $X$ e $Y$
  
  - $X$ e $Y$ distribuyen Bernoulli con parámetro $\mathbb{P}(1)=p$
  
  - $X$ e $Y$ son independientes 

<br>
  --
  
  .content-box-red[
    .bold[Pregunta]:
      ¿Cuál es la probabilidad de obtener "Sello" (0) en ambas ocasiones?
  ]


---
  
  ### Distribución Bernoulli
  
  * Ambas variables siguen misma distribución, $X$ e $Y \sim \text{Bernoulli}(p)$
  <br>
  
  $$p^{x}(1-p)^{1-x} = p^{y}(1-p)^{1-y}$$
  
  --
  
  * Dado que $X \bot Y$
  <br>
  $$\mathbb{P}(X=x,Y=y) = \mathbb{P}(X=x)\mathbb{P}(Y=y)$$
  --
  
  * Combinando 
<br>
  $$\mathbb{P}(X=x,Y=y) = p^{x}(1-p)^{1-x} \times p^{y}(1-p)^{1-y}$$
  --
  
  .content-box-blue[
    .bold[Respuesta]:
      $$\mathbb{P}(X=0,Y=0) = p^{0}(1-p)^{1} \times p^{0}(1-p)^{1} = (1-p)^{2}$$
      
  ]

---
  
  ### Distribución Binomial 
  
  La distribución binomial es la distribución de la suma de variables Bernoulli *independientes y con distribución idéntica* (.bold[iid]). 

<br>
  --
  
  Ejemplo,

- Supongamos que $X$ es una variable de Bernoulli que toma el valor 1 cuando se obtiene "Cara" al lanzar una moneda

- $\mathbb{P}(X=1)=p$ 
  
  --
  
  - Ahora, supongamos que lanzamos la misma moneda 3 veces. Llamamos a estas variables $X_{1}, X_{2}, X_{3}$
  
  - Definamos $Y = X_{1} + X_{2} + X_{3}$ 
  
  --
  
  - $Y \sim \text{Binomial()}$
  
  ---
  ### Distribución Binomial 
  
  
  .bold[Ejercicio rápido]:
  
  <br>
  
  .content-box-red[
    .bold[Pregunta 1]:
      ¿Cuál es la probabilidad de obtener tres "Caras"? Es decir, ¿Cuál es la probabilidad de que $Y=3$?]

--
  
  .content-box-blue[
    - Dado que los 3 ensayos son independientes podemos expresar esta probabilidad como:
      
      $$\mathbb{P}(Y=3) =  \mathbb{P}(X_{1}=1,X_{2}=1,X_{3}=1) = \mathbb{P}(X_{1}=1)\mathbb{P}(X_{2}=1)\mathbb{P}(X_{3}=1)$$
      <br>
      
      - Y dado que las tres variables distribuyen Bernoulli con la misma probabilidad $p$, obtenemos: 
      
      $$\mathbb{P}(Y=3) = p \times p \times p =  p^{3}$$
  ]
---
  ### Distribución Binomial 
  
  .content-box-red[
    .bold[Pregunta 2]:
      ¿Cuál es la probabilidad de obtener 2 "Caras" con 3 tiros? Es decir, ¿Cuál es la probabilidad de que $Y=2$?
  ]

--
  
  - Por simpleza, consideremos la siguiente secuencia: $\{X_{1}=1,X_{2}=1,X_{3}=0\}$, que satisface $Y=2$
  
  --
  
  - La probabilidad de obtener esta secuencia es:
  
  \begin{align}
\mathbb{P}(X_{1}=1,X_{2}=1,X_{3}=0)  &= \mathbb{P}(X_{1}=1) \times \mathbb{P}(X_{2}=1) \times \mathbb{P}(X_{3}=0)  \\
&= p \times p \times (1-p) =  p^{2}(1-p)
\end{align}

--
  
  - Sin embargo, hay 3 secuencias que satisfacen $Y=2$.
--
  También $\{X_{1}=1,X_{2}=0,X_{3}=1\}$ y $\{X_{1}=0,X_{2}=1,X_{3}=1\}$, cada una con probabilidad de ocurrencia $p^{2}(1-p)^{1}$. Por tanto:
  
  --
  
  .content-box-blue[
    .bold[Respuesta]: la probabilidad de conseguir 2 "Caras" con 3 tiros es:
      $$\mathbb{P}(Y=2) = 3 \times  p^{2}(1-p)^{1}$$
  ]

---
  
  ### Distribución Binomial 
  
  Generalización: lanzamos la misma moneda $n$ veces y la variable $Y$ cuantifica el número de "Caras" (1) obtenidas.

$$Y = \sum^{n}_{i=1} X_{i}$$
  --
  
  .content-box-red[
    .bold[Pregunta]:
      ¿Cuál es la probabilidad de conseguir $y$ "Caras" con $n$ tiros?
  ]

--
  
  * La probabilidad de obtener una secuencia particular con $y$ "Caras" a partir de $n$ lanzamientos es $p^{y}(1-p)^{n-y}$ 
  
  * Existen ${n \choose y} = \frac{n!}{y! (n-y)!}$ secuencias de este tipo...

--
  Por tanto,

$$\mathbb{P}(Y=y) = f_{Y}(y) = \frac{n!}{y! (n-y)!} \times p^{y} (1-p)^{n-y}$$
  --
  En otras palabras, $Y$ distribuye binomial con .bold[parámetros] $n$ y $p$: $Y \sim \text{Binomial}(n,p)$
  
  ---
  ### Distribución Binomial 
  
  En práctica ...
--
  Supongamos que supiéramos que la moneda es justa ( $p=0.5$ )

--
  
  - ¿Cuál es la probabilidad de obtener 3 "Caras" con 10 lanzamientos?
  
  --
  
  $$\mathbb{P}(Y=3) =  \frac{10!}{3! 7!} \times (0.5)^{3} \times (1-0.5)^{7} = 120 \times (0.5)^{10} = 0.12$$
  --
  
  - ¿Cuál es la probabilidad de obtener 5 "Caras" con 10 lanzamientos?
  
  --
  
  $$\mathbb{P}(Y=5) =  \frac{10!}{5! 5!} \times (0.5)^{5} \times (1-0.5)^{5} = 252 \times (0.5)^{10} = 0.25$$
  <br>
  --
  
  Si la probabilidad de obtener "Cara" es 90% ( $p=0.9$ ) ...

- ¿Cuál es la probabilidad de obtener 5 "Caras" con 10 lanzamientos? 
  
  --
  
  $$\mathbb{P}(Y=5) =   \frac{10!}{5! 5!} \times (0.9)^{5} \times (0.1)^{5} = 252 \times \text{número muy chico}= 0.0015$$
  ---
  ### Distribución Binomial 
  
  Puedes comprobar estos cálculos en `R`:
  
  ```{r}
# Probability of getting 5 successes out of 10 trials if probability of success is 0.9 

#Manually
choose(10,5)*(0.9^5)*(0.1^5) 

# Using random variable distribution functions
dbinom(x=5,size=10,prob=0.9)
```


---
  ### Distribución Binomial 
  
  Veamos cómo se ve la distribución completa para diferentes valores de $p$, y $n=100$.

--
  
  ```{r, echo=FALSE, message=FALSE, warning=FALSE, fig.height=6, fig.width=10}
library("cowplot")
library("viridis")

theme_set(theme_cowplot())

plot <- ggplot(data = data.frame(y = 0), mapping = aes(Y = y), )
binom_distrib <- function(p,n,y) choose(n,y)*(p^(y))*((1-p)^(n-y))

plot <- plot + stat_function(fun = binom_distrib, args = list(n= 100, p= 0.2), aes(color="red"), size=1.5) +
  stat_function(fun = binom_distrib, args = list(n= 100,p=0.5), aes(color="blue"), size=1.5) +
  stat_function(fun = binom_distrib, args = list(n= 100,p=0.8), aes(color="green"), size=1.5) +
  xlim(0,100) + labs(y="P(Y=y)", title="Probability function of Y, f(y | n=100, p)") +
  scale_color_viridis_d( name = "Legend",
                         breaks = c("red", "blue", "green"),
                         labels = c("p=0.2", "p=0.5", "p=0.8"),
                         guide = "legend") +
  theme(axis.text.y = element_text(size = 22), axis.text.x = element_text(size = 22),
        axis.title.y = element_text(size = 24), axis.title.x = element_text(size = 24), 
        legend.text = element_text(size = 18), legend.position="bottom") 

print(plot)
```


Más detalles: https://seeing-theory.brown.edu/es.html

---
  ### Bernoulli es Binomial con un "intento" (n=1)
  
  Si $Y \sim \text{Binomial}(p,n)$ su función de probabilidad es:
  
  $$\mathbb{P}(Y=y) = f_{Y}(y) = \frac{n!}{y! (n-y)!}  p^{y} (1-p)^{n-y}$$
  La función describe la probabilidad de obtener $y$ éxitos con $n$ intentos.

<br>
  --
  
  Cual es la probabilidad de obtener $y$ éxitos con $1$ intento? ( $y \in [0,1]$ )? Evaluemos la .bold[pf] para $n=1$:
  
  <br>
  --
  
  $$\mathbb{P}(Y=y) = f_{Y}(y) = \begin{cases}
\frac{1!}{0!1!} \text{ } p^{0} (1-p)^{1}  = (1-p) &\quad \text{si } y=0 \\ \\
\frac{1!}{1!0!} \text{ } p^{1} (1-p)^{0}  = p &\quad \text{si } y=1 
\end{cases}$$
  
  
  ---
  ### Bernoulli/Binomial
  
  .bold[Recordatorio:] Como toda distribución de probabilidad 


$$\sum_{\text{all }y} \mathbb{P}(Y=y) = \sum_{\text{all }y}  f_{Y}(y) = \frac{n!}{y! (n-y)!}  p^{y} (1-p)^{n-y} = 1$$
  --
  
  E.j, evaluemos la suma para el caso el caso con 2 intentos $n=2$.

<br>
  --
  
  $$\sum_{\text{de 0 a 2}}  f_{Y}(y) = \frac{n!}{y! (n-y)!}  p^{y} (1-p)^{n-y}$$
  <br>
  --
  
  $$ \frac{2!}{0!2!}  p^{0} (1-p)^{2} + \frac{2!}{1!1!}  p^{1} (1-p)^{1} + \frac{2!}{2!0!}  p^{2} (1-p)^{0}$$
  <br>
  --
  
  $$ (1-p)^{2} + 2p(1-p) + p^{2}  = 1 - 2p + p^{2} + 2p - 2p^{2} + p^{2} = 1$$
  ---
  class: inverse, center, middle

#Estimación
##Maximum Likelihood Estimation (MLE)

---
  
  ##Estimación 
  
  .bold[Modelos de probabilidad]: ¿Cuál es la probabilidad de observar los *datos* dado los *parámetros* que conocemos?
  
  Ej. ¿Cuán probable es que obtengamos 9 "Caras" (1) si lanzamos una moneda "justa" ( $p=0.5$ ) 10 veces? 
  
  ```{r}
dbinom(x=9,size=10,prob=0.5)
```

---
  ##Estimación 
  
  .bold[Modelos estadísticos]:  ¿Cuáles son los valores más .bold[plausibles][1].footnote[[1] Notar que no dice "más probables"!] de los *parámetros* dado los *datos* que observamos? 
  
  
  Ej. Supongamos que alguien lanza 100 veces la misma moneda y registra los resultados en una base de datos. Los datos se ven así:  
  
  .pull-left[
    ```{r, echo=FALSE, fig.height=5, fig.width=6, message=FALSE, warning=FALSE}
    library("tidyverse")
    set.seed(481)
    data_coins <- data.frame(X = rbinom(n=100, size=1, prob=0.8))
    
    data_coins %>% ggplot(aes(x=factor(X), fill="")) + 
      geom_bar() +
      geom_text(aes(label=..count..), stat='count', vjust=-0.2) +
      scale_fill_viridis_d() + 
      guides(fill=FALSE, color=FALSE) + labs(x="") +
      theme(axis.text.y = element_text(size = 22), axis.text.x = element_text(size = 22),
            axis.title.y = element_text(size = 24), axis.title.x = element_text(size = 24), 
            legend.text = element_text(size = 18), legend.position="bottom") 
    ```
  ]

--
  
  .pull-right[
    
    - Lo que vemos en la izquierda son .bold[datos]
    
    - Datos: realización de $n$ variables aleatorias 
    
    - Normalmente *no conocemos* la distribución de las variables
    
    - Datos nos dan una pista sobre cuál podría ser esa distribución
    
    - .bold[Estadística]: aprender de los datos para .bold[*estimar*] los parámetros que los generan
    
  ]

---
  ##Estimación via Maximum Likelihood (MLE) 
  
  Previamente lanzamos la misma moneda 100 veces y obtuvimos "Cara" (1) 82 veces.
--
  ¿Qué valor de $p$ es más plausible ("likely") que genere estos datos?
  
  MLE es justamente la formalización de esta pregunta. Pasos:
  
  --
  
  1) Decidir sobre la distribución subyacente que genera los datos. En este caso, podemos asumir que: 
  
  * Cada lanzamiento $X_{1}, X_{2}, \dots X_{100} \sim \text{Bernoulli}(p)$, donde X's son $iid$ 

--

2)  Escribir una función que cuantifique la plausibilidad de diferentes valores del parámetro. Dicha función se denomina .bold[likelihood function]: 

<br>
  * $\mathcal{L}(p \mid \text{ Datos}) = \mathbb{P}(\text{ Datos : \{1,0,1,1,....0,1\}} | \text{ } p)$

<br>
--

  * $\mathcal{L}(p \mid \text{ Datos}) = \mathbb{P}(x_{1})\mathbb{P}(x_{2}) \dots \mathbb{P}(x_{100}) = p^{82}(1-p)^{18}$


---
##Estimación via Maximum Likelihood (MLE) 

Podemos inspeccionar visualmente la "likelihood" de diferentes valores $p$.

```{r, echo=FALSE, fig.height=5, fig.width=9, message=FALSE, warning=FALSE}
plot <- ggplot(data = data.frame(p = 0), mapping = aes(x = p, color=""))
binom_distrib <- function(p,n,k) (p^(k))*((1-p)^(n-k))

plot + stat_function(fun = binom_distrib, args = list(n= 100, k= 82), size=1.5) + 
  xlim(0,1) + labs(title="Likelihood of p", x="p", y=expression(paste(p^{82}, (1-p)^{18})) ) +
    scale_color_viridis_d() + 
    guides(fill=FALSE, color=FALSE) +
    theme(axis.text.y = element_text(size = 10), axis.text.x = element_text(size = 16),
    axis.title.y = element_text(size = 24), axis.title.x = element_text(size = 24), 
    legend.text = element_text(size = 12), legend.position="bottom") 
```

Intuitivamente: habiendo obtenido 82 caras, $p=0.82$ es el valor más plausible de $p$


---

##Estimación via Maximum Likelihood (MLE) 

3) Encontrar matemáticamente el valor de $p$ que maximiza $\mathcal{L}(p \mid \text{ Datos})$.


- $\mathcal{L}(p \mid \text{ Datos}) = \mathbb{P}(x_{1})\mathbb{P}(x_{2}) \dots \mathbb{P}(x_{n}) =\prod_{i=1}^{n} f(x_{i}) =  p^{k}(1-p)^{n-k} \quad \text{   donde  } k= \sum x_{i}$

--

- Para facilitar el cálculo tomamos logaritmo natural en ambos lados (.bold[log-likelihood])

  - $\ell\ell(p) = \ln \mathcal{L}(p \mid \text{ Datos})  = k \ln(p) + (n - k) \ln(1-p)$ 

--
-  Calcular la primera* derivada de $\ell\ell(p)$ con respecto a $p$: pendiente de la curva en cada valor de $p$.

  - $\ell\ell^{\text{ '}}(p) = \frac{k}{p} -  \frac{n-k}{1-p}$
    
    --
    
    - Encontrar el máximo de la función $\ell\ell(p)$: valor de $p$ en el cual la curva no cambia, es decir cuando $\ell\ell^{\text{ '}}(p)=0$ 

  - $\frac{k}{p} -  \frac{n-k}{1-p} = 0$
  
--

- Después de resolver por $p$ obtenemos:
  
   $$p = \frac{k}{n} = \frac{\sum x_{i}}{n}$$


---
##Estimación via Maximum Likelihood (MLE) 

<br>

- El estimador ML de $p$ es ....


- $\hat{p} = \frac{\sum x_{i}}{n}$


- Es decir, el porcentaje de 1's en la muestra!
        
        --
        
        - Intuitivo y elegante
      
      
      ---
        
        .bold["Optimización" numérica en R]
      
      ```{r, include=TRUE, echo=TRUE, warning=FALSE, message=FALSE}
      
      # log-likelihood function
      ll <- function(p,n,k) {
        ell = k * log(p) + (n - k)*log(1-p)
        return(ll = ell)
      }
      
      
      # Evaluate the log-likelihood function for some arbitrary values
      ll(p=0.1,n=100,k=82); ll(p=0.7,n=100,k=82)
      ```
      --
        
        ```{r, include=TRUE, echo=TRUE, warning=FALSE, message=FALSE}
      
      # Evaluate the log-likelihood function for many possible values of p
      
      parameter_space <- tibble(p=seq(0,1,by=0.01)) %>% 
        rowwise() %>% mutate(loglik = ll(p,n=100,k=82)) 
      
      # Find the value of p that yield the largest value for the log-likelihood function
      
      parameter_space %>% as.matrix() -> m
      m[which.max(m[,2]),]
      ```
      
      ---
        .bold["Optimización" numérica en R]
      
      .center[
        ```{r loglik_density,  include=TRUE, echo=FALSE, warning=FALSE, message=FALSE, fig.height=10, fig.width=12}
        parameter_space %>% as.data.frame() %>% ggplot(aes(x=p, y=loglik, colour=loglik)) + 
          geom_line(size=1.5) + geom_point(aes(x=m[which.max(m[,2]),1], m[which.max(m[,2]),2]), size=2.5) +
          scale_color_viridis() + guides(fill=FALSE, color=FALSE) + labs(title="Log-likelihood function",x="p", y="82*log(p) + (100 - 82)*log(1-p)") +
          annotate(geom="text", x=0.82, y=-35, label='bold("0.82")', color="black", parse=TRUE, size=8) +
          theme(axis.text.y = element_text(size = 22), axis.text.x = element_text(size = 22),
                axis.title.y = element_text(size = 24), axis.title.x = element_text(size = 24), title=element_text(size = 24),
                legend.text = element_text(size = 18), legend.position="bottom") 
        ```
      ]
      
      ---
        ##Estimación via Maximum Likelihood (MLE) 
        
        .bold[Generalización]
      
      <br>
        
        
        $$\hat{\boldsymbol{\beta}}_{MLE} = \underset{\beta}{\arg\max\ } \mathcal{L}(\boldsymbol{\beta} \mid \boldsymbol{X})$$
        $\hat{\boldsymbol{\beta}}$ es el MLE de $\boldsymbol{\beta}$ si es el(los) valor(es) que maximiza(n) la "likelihood function", condicional en los datos observados.
      
      <br>
        --
        
        - Recordar que   $\mathcal{L}(\boldsymbol{\beta} \mid \boldsymbol{X}) = \mathbb{P}(\boldsymbol{X} \mid \boldsymbol{\beta})$.
      
      --
        
        - Requiere especificar de antemano la distribución conjunta de las observaciones (dif. de OLS, por ejemplo).
      
      --
        
        - ML es probablemente el approach de estimación más popular. 
      
      --
        
        - Intuitivo, pero, por lo general, no tan simple como el ejemplo que vimos hoy.
      
      --
        
        - Normalmente la maximización se realiza numéricamente (ej. método Newton–Raphson)
      
      ---
        class: fullscreen,left, top, text-white
      background-image: url(valdorcia.jpeg)
      
      ##Estimación via Maximum Likelihood (MLE) 
      
      
      ---
        class: inverse, center, middle
      
      .huge[
        **Hasta la próxima clase. Gracias!**
      ]
      
      <br>
        Mauricio Bucca <br>
        https://mebucca.github.io/ <br>
        github.com/mebucca
      
      
      
      
      