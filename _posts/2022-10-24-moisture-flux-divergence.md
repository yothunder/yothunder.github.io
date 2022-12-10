---
title: Moisture Flux Divergence
author: wtyo
date: 2022-10-31 07:00:00 +0700 
categories: [Meteorology & Climatology] 
tags: [met, physical meteorology]
math: true
---

<div style="text-align: right;"><input onclick="window.print()" type="button" value="Print this page" /></div><br>

*Moisture flux divergence* (MFD) merupakan besaran skalar yang menunjukkan laju aliran hulu dan hilir (*source and sink*) yang membawa konstituen kelembapan atau uap air pada koordinat tekanan atmosfer. MFD diformulasikan sebagai berikut.

$$ MFD = \nabla \cdot q\vec{V} \tag{1} $$

dimana

$\nabla = \left(\frac{\partial}{\partial x}\right)\hat{i} + \left(\frac{\partial}{\partial y}\right)\hat{j}$<br>
$q =$ kelembapan spesifik ($g/kg$)<br>
$\vec{V} =$ komponen angin horizontal ($u$ dan $v$) ($m/s$)<br>
$q\vec{V} =$ *moisture flux* ($kg/m.s$)<br>

MFD berlaku pada lapisan atmosfer tertentu. Untuk mendapatkan kuantitas yang merepresentasikan seluruh lapisan atmosfer, maka *moisture flux* dapat diintegrasikan dari lapisan atmosfer permukaan ($ps$) hingga lapisan atas troposfer ($pt$) dibagi dengan percepatan gravitasi ($g$). Istilah *moisture flux* (MF, $q\vec{V}$) kemudian dikenal sebagai *vertically integrated moisture flux* (VIMF, $<q\vec{V}>$).

$$ <q\vec{V}> = \frac{1}{g} \int_{ps}^{pt} q\vec{V} dp \tag{2} $$

$<q\vec{V}>$ memiliki satuan $kg\cdot m^{-1} \cdot s^{-1}$. *Vertically integrated moisture flux divergence* (VIMFD) kemudian dapat didapatkan dengan mentransformasikan Pers. 2 ke besaran skalar.

$$ VIMFD = \nabla \cdot <q\vec{V}> $$

VIMFD memiliki satuan $kg\cdot m^{-2} \cdot s^{-1}$.

Istilah VIMF juga dikenal sebagai [transpor uap air](https://yothunder.github.io/posts/transpor-uap-air/){:target="_blank"} dan VIMFD sama dengan divergensi transpor uap air. Dalam hal ini istilah *moisture* kadang juga disebut dengan *water vapor*, i.e *water vapor transport = vertically integrated moisture flux*.

Bagaimana cara mendapatkan nilai VIMF dan VIMFD? Ini dijelaskan pada postingan [transpor uap air](https://yothunder.github.io/posts/transpor-uap-air/#implementasi-di-ncl){:target="_blank"}.