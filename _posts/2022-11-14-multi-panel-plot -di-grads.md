---
title: Plotting Multi Panel di GrADS
author: wtyo
date: 2022-11-20 07:00:00 +0700 
categories: [Blogging] 
tags: [met]
math: true
---

Untuk memplot banyak panel di GrADS, kita bisa menggunakan perintah `set parea`[^1] atau `set vpage`[^2]. Fungsi keduanya serupa, namun implementasinya tidak sama dan kadang mungkin cukup membingungkan bagi yang baru belajar GrADS. 

Sederhananya, `set parea` memungkinkan kita untuk lebih leluasa untuk memplot beberapa panel sesuai dengan ukuran dan posisi display. Namun, kita harus mengerti di posisi mana dan koordinat display berapa panel tersebut ingin di plot.

Di lain sisi, perintah `set vpage` lebih memudahkan kita dalam melakukan plotting sebanyak panel yang ingin kita plot. Perintah ini akan menentukan sendiri posisi panel sesuai dengan urutan yang kita inginkan. Perintah ini terdengar lebih menjanjikan karena kita tinggal menginput berapa banyak panel yang ingin diplot, dan `vpage` dengan sendirinya akan menentukan posisi dan koordinat display panel tersebut. Namun, perintah ini justru sering menghasilkan ruang kosong antar panel dan kita tidak bisa leluasa untuk mengatur `colorbar`[^3] karena pasti akan terplot di panel terakhir.

## GrADS display

Terdapat dua posisi display di GrADS, yaitu posisi landscape dan posisi portrait.
![GrADS display](https://raw.githubusercontent.com/yothunder/yothunder.github.io/main/img/posts/GrADS/gradsdisplay.png){: .shadow }
<p style="text-align: center; font-size: 14px">GrADS display. 11 x 8.5 merupakan koordinat display tanpa satuan.</p>

Dalam postingan ini, kita akan fokus pada posisi landscape.

## Set parea

## Set vpage

## Looping menggunakan `set parea`

## Notes
[^1]: [http://cola.gmu.edu/grads/gadoc/gradcomdsetparea.html](http://cola.gmu.edu/grads/gadoc/gradcomdsetparea.html){:target="_blank"}
[^2]: [http://cola.gmu.edu/grads/gadoc/gradcomdsetvpage.html](http://cola.gmu.edu/grads/gadoc/gradcomdsetvpage.html){:target="_blank"}
[^3]: [http://cola.gmu.edu/grads/gadoc/colorcontrol.html](http://cola.gmu.edu/grads/gadoc/colorcontrol.html){:target="_blank/}