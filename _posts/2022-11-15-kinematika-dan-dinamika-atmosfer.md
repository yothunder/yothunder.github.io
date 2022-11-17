---
title: Kinematika dan Dinamika Atmosfer
author: wtyo
date: 2022-11-21 07:00:00 +0700 
categories: [Blogging] 
tags: [met]
math: true
---

Kinematika dan dinamika atmosfer merupakan studi yang mempelajari gerakan udara di atmosfer. Keduanya memiliki kesamaan, yaitu mencoba menjelasakan secara kuantitatif proses fisis pada gerakan atmosfer. Bedanya, dinamika atmosfer juga meninjau faktor gaya penggeraknya, sedangkan kinematika hanya mendeskripsikan gerakannya saja. Tentu saja, karena dijelaskan secara kuantitatif, maka proses pendeskripsiannya dilakukan secara matematis. Tulisan ini tidak akan menjelaskan secara detail, hanya sebagai overview saja.

## Sedikit konsep matematika

### Penting

Atmosfer bumi merupakan sistem yang dinamis, artinya bergerak terus menerus (meskipun mungkin kita tidak merasakannya). Maka, kita perlu paham mengenai konsep matematika yang berhubungan dengan perubahan, yap [kalkulus](https://id.wikipedia.org/wiki/Kalkulus){:target="_blank"}. Di SMA, pengenalan awal kalkulus seperti limit, turunan, dan integral cukup berguna sebagai bekal dasar. Dalam hal ini, karena kita memerlukan pemahaman mengenai pergerakan di atmosfer (atau juga bisa dibilang perubahan-perubahan di atmosfer seiring berjalannya waktu), maka turunan lebih digunakan daripada integral.

Persamaan yang mendeskripsikan gerakan atmosfer melibatkan tidak hanya satu variabel, namun bisa dua atau lebih variabel. Variabel atmosfer yang cukup penting dalam hal ini seperti temperatur dan kelembapan. Maka, untuk menyelesaikannya, kita memerlukan konsep mengenai [turunan parsial](https://id.wikipedia.org/wiki/Turunan_parsial){:target="_blank"}. Sederhananya, turunan parsial diselesaikan dengan menurunkan satu variabel serta mengasumsikan variabel lain tetap konstan.

> <details>
    <summary>Sedikit contoh</summary>
    Misal, $$ h = (x-3)^2 \cos(y) $$
    Turunan parsial $h$ terhadap $x$ adalah<br>
    $$ \frac{\partial h}{\partial x} = \frac{\partial\left((x-3)^2 \cos(y) \right)}{\partial x} = 2(x-3).1 \cos(y) = (2x-3)\cos(y) $$
    Turunan parsial $h$ terhadap $y$ adalah<br>
    $$ \frac{\partial h}{\partial y} = \frac{\partial\left((x-3)^2 \cos(y) \right)}{\partial y} = (x-3)^2 -\sin(y) = -(x-3)^2 \sin(y) $$
<br>

Cuaca sebetulnya hanya berbicara mengenai angin (gerakan udara secara horizontal dan vertikal) dan akibat dari adanya angin tersebut. Karena angin memiliki nilai dan arah, maka angin termasuk dalam vektor. Hubungan antar vektor dapat diketahui melalui operator produk dot dan produk cross. Manipulasi produk tersebut sering diterapkan dalam dimensi dua dan tiga. Maka, operator del ($\nabla$) berguna dalam hal ini. Sederhananya, del merupakan operator yang menurunkan vektor untuk semua arah dua atau tiga dimensi $(x, y, z)$.

$$ \nabla = \left(\frac{\partial}{\partial x}\right)\hat{i} + \left(\frac{\partial}{\partial y}\right)\hat{j} + \left(\frac{\partial}{\partial z}\right)\hat{k} $$

### Aplikatif

Operasi vektor kalkulus mudah diterapkan untuk koordinat kartesian $(x, y, z)$. Namun, sebagaimana yang kita tahu, bumi berbentuk bulat, maka koordinat yang tepat yang merepresentasikan bentuk bumi secara keseluruhan adalah koordinat sperikal $(\lambda, \phi, r)$. Meski demikian, koordinat kartesian tetap digunakan ketika menganalisis untuk skala yang tidak terlalu luas (hingga skala sinoptik), sedangkan koordinat sperikal digunakan untuk skala yang lebih dari skala sinoptik (skala global).

Dalam memahami gerakan atmosfer, terdapat dua *framework* atau kerangka, yaitu kerangka eulerian dan kerangka lagrangian. Singkatnya, kerangka eulerian diterapkan ketika kita mengamati parsel udara[^1] di satu tempat tanpa mengikuti pergerakan dari parsel udara tersebut. Di lain sisi, kerangka lagrangian diterapkan ketika seorang pengamat mengikuti pergerakan dari parsel udara tersebut. Meskipun dua sudut pandang ini sangat berbeda, keduanya bisa direlasikan melalui konsep adveksi.

<!-- Masukkan contohnya-->

Misal, untuk variabel temperatur ($T$), persamaan gerakan umum di atmosfer adalah sebagai berikut.

$$ \frac{DT}{Dt} = \frac{\partial T}{\partial t} + \vec{V} \cdot \vec{\nabla}T \tag{1} $$

Ruas kiri merupakan *total derivative* yang merupakan perubahan yang terjadi pada parsel udara saat bergerak, suku pertama di ruas kanan merupakan laju perubahan temperatur secara lokal (kerangka eulerian), dan suku kedua di ruas kanan merupakan *advective derivative* (kerangka lagrangian). Persamaan 1 dapat diubah menjadi Euler's Relation.

$$ \frac{\partial T}{\partial t} = \frac{DT}{Dt} - \vec{V} \cdot \vec{\nabla}T \tag{2} $$

dimana suku kedua pada ruas kanan merupakan adveksi. Sederhananya, adveksi merupakan nilai negatif produk dot dari gradien suatu variabel dengan vektor angin.
<!--Jelaskan mengapa adveksi dapat menjelaskan hubungan antara kerangka eulerian dan lagrangian.-->

## Kinematika atmosfer

Gerakan udara di atmosfer dapat direpresentasikan melalui beberapa cara.
1. Vektor angin
2. Wind barb
3. Streamline
4. Isotach
5. Trayektori
6. Streakline
7. Streamfunction
8. Velocity potential

Dalam praktiknya, untuk analisis dan prediksi berdasarkan peta cuaca, poin nomor 1 hingga 3 yang paling sering digunakan. Isotcah sudah sangat jarang digunakan karena kecepatan angin lebih baik direpresentasikan dalam bentuk *shaded* yang di*overlay* dengan streamline, khususnya dari output model numerik. Sementara itu, poin 5 hingga terakhir bermanfaat untuk menganalisis secara mendetail, khususnya dalam ranah penelitian.

Setidaknya terdapat empat properti dasar dari kinematika atmosfer, yaitu translasi, deformasi, rotasi, dan divergensi.

### 1. Translasi

Translasi merupakan gerakan tanpa perubahan bentuk dan orientasi. Translasi mungkin terdengar mustahil terjadi pada gerak udara di atmosfer yang sifatnya *chaotic*. Maka, dalam praktiknya, jenis gerak ini tidak begitu digunakan selain hanya pelengkap teori.

### 2. Deformasi

m

### 3. Rotasi

### 4. Divergensi

<!--Pada peta cuaca, angin dapat direpresentasikan sebagai vektor angin, wind barb, dan streamline. Secara konvensional, angin yang diamati berdasarkan stasiun-stasiun pengamatan meteorologi biasanya ditampilkan dalam bentuk wind barb. Kemudian, streamline dibuat berdasarkan data-data observasi untuk tiap titik tersebut.

Sederhananya, streamline merupakan garis yang paralel dengan vector angin dan menghubungkan nilai yang sama antar titik atau lokasi dalam satu waktu. Ini tentu berbeda dengan trayektori yang merupakan lintasan suatu parsel udara terhadap waktu.
-->

## Dinamika atmosfer

> Cek ency of atmos sci

## Penerapan

> Penerapan menggunakan peta cuaca

## Refs & Notes

1: Encyclopedia of atmospheric sciences<br>
2: [https://www.e-education.psu.edu/meteo300/node/694](https://www.e-education.psu.edu/meteo300/node/694){:target="_blank"}<br>
3: [https://www.e-education.psu.edu/meteo300/node/695](https://www.e-education.psu.edu/meteo300/node/695){:target="_blank"}<br>
4: [https://www.e-education.psu.edu/meteo300/node/696](https://www.e-education.psu.edu/meteo300/node/696){:target="_blank"}<br>

[^1]: Istilah parsel udara digunakan untuk menggambarkan gumpalan udara yang memiliki karakteristik tersendiri dibandingkan udara sekitar atau lingkungannya. Meskipun istilah ini terkesan imajinatif, penggunaanya cukup penting dan telah menjadi semacam standar dalam studi meteorologi untuk menjelaskan pergerakan udara di atmosfer.
