# Representação de Dados Espaciais

Source: 
<br> [Prof Tiago Badre Marino](http://www.ufrrj.br/lga/tiagomarino/aulas/5%20-%20Representacao%20de%20Dados%20Espaciais%20-%20Raster%20x%20Vetor%20x%20TIN.pdf)
<br> [Profa Flavia Feitosa](https://flaviafeitosa.files.wordpress.com/2015/06/02a_sistreferencia-compressed.pdf)

Toda descrição da realidade é uma abstração parcial e individual, ela conta apenas uma das estórias passíveis de serem contadas. Por nunca ser uma representação exata, algumas características são aproximadas, outras simplificadas e outras ainda ignoradas.

Os dados geográficos descrevem os objetos geográficos, usando dos seguintes artifícios:

* **Localização geográfica:** posição em relação a um sistema de coordenadas conhecidas;
* **Relacionamentos espaciais ou topológicas:** relações espaciais entre os objetos;
* **Atributos Temáticos:** propriedades medidas ou observadas.

Todo dado espacial é composto por:

* **Sistema de Referência ou DATUM:** Estabelecem uma relação entre um ponto no terreno com o elipsóide de referência escolhido; é a referência para o sistema de coordenadas.
* **Sistema de Coordenadas:** Expressa a posição dos pontos sobre uma superfície; os pontos na superfície são localizados a partir da intersecção de um meridiano e um paralelo e seu posicionamento é dado por meio de valores angulares (longitude e latitude);
* **Sistema de Projeção Cartográfica:** Ajudam a representar uma surperfície curva em um plano.

Os dados espaciais podem ser representados **vetorialmente** usando as seguintes geometrias:
* **Ponto:** um par ordenado (x,y) de coordenadas espaciais;
* **Linha:** um conjunto de pontos conectados entre si e que "conhecem" essa conexão;
* **Polígono:** uma região no plano formada por um conjunto de linhas cujo o último ponto de uma linha é idêntico ao primeiro ponto da próxima linha.

Dados espaciais também podem ser representados **matricialmente** (também conhecido domo raster). Cada célula da matrix é um pixel e cada pixel contém a informação relativa a uma área no espaço.

* s