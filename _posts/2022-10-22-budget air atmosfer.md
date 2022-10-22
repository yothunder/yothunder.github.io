---
title: Budget Air Atmosfer
author: wtyo
date: 2022-10-22 10:00:00 +0700 
categories: [Blogging] 
tags: [met]
math: true
---

<div style="text-align: right;"><input onclick="window.print()" type="button" value="Print this page" /></div><br>

Persamaan *budget* air atmosfer (*atmospheric water budget*) didasarkan pada konsep konservasi atau kekekalan uap air pada koordinat tekanan atmosfer.

$$ \frac{dq}{dt} = S \tag{1} $$

dimana

$$ \frac{d}{dt} = \frac{\partial}{\partial t} + u\frac{\partial}{\partial x} + v\frac{\partial}{\partial y} + \omega \frac{\partial}{\partial p} $$

$u$ dan $v$ merupakan komponen angin horizontal ($m/s$), $\omega$ merupakan kecepatan vertikal pada koordinat tekanan atmosfer ($Pa/s$), $q$ merupakan kelembapan spesifik ($g/kg$), dan $S$ merupakan simpanan (*storage*) uap air di atmosfer. $S = e-c$ (evaporasi minus kondensasi pada parsel udara).

Berdasarkan persamaan kontinuitas massa,

$$ \frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} + \frac{\partial \omega}{\partial p} = 0 $$

Pers. 1 dapat diubah ke bentuk *flux*

$$ \frac{\partial q}{\partial t} + \underbrace{u \frac{\partial q}{\partial x} + v \frac{\partial q}{\partial y} + \omega \frac{\partial q}{\partial p}}_\text{advection term} + \underbrace{q \left( \frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} + \frac{\partial \omega}{\partial p} \right)}_\text{divergence term} = e-c \tag{2} $$

$$ \frac{\partial q}{\partial t} + \underbrace{\frac{\partial \left( qu \right)}{\partial x} + \frac{\partial \left( qv \right)}{\partial y} + \frac{\partial \left( q\omega \right)}{\partial p}}_\text{flux form} = e-c $$

$$ \underbrace{\frac{\partial q}{\partial t}}_\text{local rate of change} + \underbrace{\nabla \cdot \left( q\vec{V} \right)}_\text{horizontal MFD} + \underbrace{\frac{\partial \left( q\omega \right)}{\partial p}}_\text{vertical MFD} = e-c \tag{3} $$

dimana

$MFD$ merupakan moisture flux divergence.