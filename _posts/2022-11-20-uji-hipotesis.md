---
title: 'Uji Hipotesis Statistik: Penerapannya dalam Meteorologi/Klimatologi'
author: wtyo
date: 2022-11-28 07:00:00 +0700 
categories: [Blogging] 
tags: [met, stat]
math: true
---

<div style="text-align: right;"><input onclick="window.print()" type="button" value="Print this page" /></div><br>

Sebuah uji hipotesis statistik dilakukan berdasarkan data sampel untuk menguji apakah hipotesis yang diajukan dapat diterima atau ditolak. Dalam hal ini, hipotesis statistik mengacu pada asumsi mengenai parameter populasi[^1].

> <details>
    <summary>Table of Contents</summary>
    <ul style="list-style: none">
        <li>
            <a href="https://yothunder.github.io/posts/uji-hipotesis/#langkah">Langkah</a>
            <ol>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#1-ajukan-hipotesis">Ajukan hipotesis</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#2-tentukan-level-signifikan">Tentukan level signifikan</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#3-tentukan-uji-statistik">Tentukan uji statistik</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#4-interpretasi-hasil">Interpretasi hasil</a></li>
            </ol>
        </li>
        <li>
            <a href="https://yothunder.github.io/posts/uji-hipotesis/#contoh-penerapan">Contoh penerapan</a>
            <ol>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#1-merumuskan-hipotesis">Merumuskan hipotesis</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#2-menentukan-level-signifikan">Menentukan level signifikan</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#3-melakukan-uji-statistik">Melakukan uji statistik</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#4-menentukan-level-kritis">Menentukan level kritis</a></li>
                <li><a href="https://yothunder.github.io/posts/uji-hipotesis/#5-interpretasi-hasil">Interpretasi hasil</a></li>
            </ol>
        </li>
    </ul>

## Langkah

### 1. Ajukan hipotesis

Terdapat dua jenis hipotesis dalam statistik, yaitu hipotesis nol (H0) dan hipotesis alternatif (H1). H0 diajukan dengan asumsi bahwa sampel data tidak dipengaruhi oleh penyebab tertentu atau murni karena probabilitas. Sementara, H1 diajukan dengan asumsi bahwa sampel data dipengaruhi oleh penyebab tertentu.

### 2. Tentukan level signifikan

Diterima atau tidaknya hipotesis bergantung pada area dimana nilai probabilitas itu berada. Ingat bahwa probabilitas memiliki rentang nilai 0 hingga 1. Dalam hal ini, area penentu diterima tidaknya hipotesis ditentukan oleh kita sendiri. Tidak ada batasan yang pasti berapa nilai yang dijadikan acuan, namun level signifikan yang biasa dipakai bernilai 0.01, 0.05, dan 0.1.

### 3. Tentukan uji statistik

Uji statistik dilakukan untuk menghasilkan nilai p-value yang nantinya digunakan sebagai penentu apakah hipotesis yang diajukan sebelumnya diterima atau ditolak. Terdapat beberapa jenis uji statistik yang bisa digunakan, bergantung pada seperti apa sampel data yang digunakan [^2].

### 4. Interpretasi hasil

Jika p-value berada diluar level signifikan, maka H0 ditolak atau H1 diterima dan data sampel dipengaruhi oleh penyebab tertentu. Begitu juga sebaliknya, jika p-value berada pada level signifikan, maka H0 diterima atau H1 ditolak dan data sampel tidak dipengaruhi oleh suatu penyebab tertentu (murni karena probabilitas).

## Contoh penerapan

Dalam studi meteorologi atau klimatologi, seringkali kita mengkaji suatu fenomena dan menghubungkannya dengan variabel meteorologi. Pada contoh ini, kita akan mencoba melakukan uji signifikansi apakah [*cold surge* (CS) dan *cross equatorial northerly surge* (CENS)](https://yothunder.github.io/posts/cold-surge-cross-equatorial-northerly-surge/){:target="_blank"} berpengaruh terhadap transpor uap air ketika berpropagasi di Benua Maritim Bagian Barat.

Data yang digunakan adalah data model ERA5, rentang tahun 2010-2019 dengan resolusi temporal harian.

### 1. Merumuskan hipotesis

H0 = rata-rata variabel transpor uap air saat kejadian CS dan CENS sama dengan rata-rata variabel secara keseluruhan.
H1 = rata-rata variabel transpor uap air saat kejadian CS dan CENS tidak sama dengan rata-rata variabel secara keseluruhan.

### 2. Menentukan level signifikan (𝛼)

Level signifikan yang diambil bernilai 5%.

### 3. Melakukan uji statistik

Uji statistik dilakukan dengan menggunakan uji student-t dua sisi[^3]. Berikut merupakan formulanya.

$$ t = \frac{\overline{x_1} - \overline{x_2}} {\sqrt{\frac{s_1^2}{n_1} + \frac{s_2^2}{n_2}}} $$

di mana 𝑥̅, 𝑠̅, dan 𝑛 masing-masing merupakan rata-rata, varians, dan jumlah sampel data. Sementara itu, subscript 1 dan 2 menandakan variabel saat kejadian CS atau CENS dan rata-rata secara keseluruhan. Dalam hal ini, perhitungan statistik dilakukan untuk tiap grid spasial.Data tiap grid dihitung dengan memanfaatkan fungsi `ttest`[^4] yang telah tersedia di NCL. Perhitungan ini menghasilkan p-value dan nilai t.

### 4. Menentukan level kritis

Oleh karena uji statistik dilakukan menggunakan metode student-t test dua sisi, maka level kritis adalah ± 𝛼⁄2. Sehingga, level signifikan menjadi 2.5% untuk masing-masing sisi. Nilai 2.5% dalam uji signifikansi termasuk dalam kategori kuat (*substantial*) (Wilks, 2019).[3]

### 5. Interpretasi hasil

H0 diterima apabila p-value berada pada rentang ± 𝛼⁄2. Sedangkan H0 ditolak apabila p-value bernilai lebih besar atau kurang dari sama dengan nilai ± 𝛼⁄2. Dengan ditolaknya H0, maka perbedaan variabel saat kejadian CS atau CENS dengan variabel pada kondisi reratanya dapat dikatakan bermakna atau signifikan secara statistik.

##

## Notes

[^1]: Kata parameter digunakan untuk menyatakan properti sebenarnya dari suatu populasi, sedangkan statistik didasarkan pada properti suatu sampel yang diambil secara acak dari suatu populasi.
[^2]: [https://www.statology.org/hypothesis-testing/](https://www.statology.org/hypothesis-testing/){:target="_blank"}
[^3]: Wilks, D., 2019, Frequentist Statistical Inference, in Statistical Methods in the Atmospheric Sciences, Elsevier Ltd, Amsterdam.
[^4]: [https://www.ncl.ucar.edu/Document/Functions/Built-in/ttest.shtml](https://www.ncl.ucar.edu/Document/Functions/Built-in/ttest.shtml){:target="_blank"}
