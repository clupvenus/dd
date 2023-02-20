use sys;
/*============================== JOIN ISLEMLERI ===============================
    
    Union,Union All Operatorleri farkli tablolardaki sutunlari 
    birlestirmek kullanilir.
    
    Join islemleri ise farkli Tablolari birlestirmek icin kullanilir. Diger 
    bir ifade ile farkli tablolardaki secilen sutunlar ile yeni bir tablo 
    olusturmak icin kullanilabilir.
    
    JOIN islemleri Iliskisel Veritabanlari icin cok onemli bir ozelliktir. Cunku
    Foreign Key'ler ile iliskili olan tablolardan istenilen sutunlari cekmek 
    icin JOIN islemleri kullanilabilir.
    
    mySQL'de 3 Cesit Join islemi kullanilabilmektedir.
    
    1) INNER JOIN:  Tablolardaki ortak olan sonuc kumesini gosterir
    2) LEFT JOIN:  Ilk tabloda (Sol) olan sonuclari gosterir
    3) RIGHT JOIN:  Ikinci tabloda (Sag) olan tum sonuclari gosterir
      
    full JOIN=(left join + union + right join) Tablodaki tum sonuclari gosterir
==============================================================================*/   
drop table sirketler;
CREATE TABLE sirketler
    (
        sirket_id int,
        sirket_isim VARCHAR(20)
    );
    INSERT INTO sirketler VALUES(100, 'Toyota');
    INSERT INTO sirketler VALUES(101, 'Honda');
    INSERT INTO sirketler VALUES(102, 'Ford');
    INSERT INTO sirketler VALUES(103, 'Hyundai');
    
    CREATE TABLE siparisler
    (
        siparis_id int,
        sirket_id int,
        siparis_tarihi DATE
    );
    INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
    INSERT INTO siparisler VALUES(22, 102, '2020-04-18');
    INSERT INTO siparisler VALUES(33, 103, '2020-04-19');
    INSERT INTO siparisler VALUES(44, 104, '2020-04-20');
    INSERT INTO siparisler VALUES(55, 105, '2020-04-21');

select *from sirketler;
select * from siparisler;
drop table siparisler;
/*=============================== INNER JOIN  ==================================
    
    Iki tablonun kesisim kumesi ile yeni bir tablo olusturmak icin kullanilir.
    
    1) Select`ten sonra tabloda gormek istediginiz sutunlari yazarken
       table_name.field_name seklinde yazin.
    2) From`dan sonra table_name yazarken 
       1. table_name + INNER JOIN + 2. table_name yazmaliyiz.
    3) Join`i hangi kurala gore yapacaginizi belirtmelisiniz. 
       Bunun icin ON kuralimiz yazilmali.
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    INNER JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
================================================================================  
    
  
/* -----------------------------------------------------------------------------
  ORNEK1: Iki Tabloda sirket_id'si ayni olanlarin sirket_ismi, siparis_id ve 
  siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/    

select sirketler.sirket_id, 
sirketler.sirket_isim,
siparisler.siparis_id,
 siparisler.siparis_tarihi
from sirketler
inner join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

-- INNER JOIN ile sadece iki tablodaki ortak olan satirlar secilir.
-- Diger bir ifadeyle iki tablodaki ortak olan sirket_id degerleri icin 
-- ilgili sutunlar listenir.

/*=============================== LEFT JOIN  ==================================
    
    LEFT JOIN, 1. tablodan (sol tablo) SELECT ile ifade edilen sutunlara ait tum
    satirlari getirir. 
    Ancak, diger tablodan sadece ON ile belirtilen kosula uyan satirlari getirir. 
    
    1) Left Join'de ilk tablodaki tum record'lar gosterilir.
    2) Ilk tablodaki datalara 2.tablodan gelen ek datalar 
       varsa bu ek datalar ortak datalar icin gosterilir, 
       ancak ortak olmayan datalar icin o kisimlar bos kalir.
    3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu
       istedigimize karar verip once onu yazmaliyiz. 
        
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    LEFT JOIN tablo2
    ON tablo1.sutun = tablo2.sutun;
    
==============================================================================*/  
        
/* -----------------------------------------------------------------------------
  ORNEK2: sirketler tablosundaki tum sirketleri ve bu sirketlere ait olan 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

select sirketler.sirket_id,
 sirketler.sirket_isim,
 siparisler.siparis_id,
 siparisler.siparis_tarihi
 from sirketler left join siparisler
 on sirketler.sirket_id=siparisler.sirket_id;
 /* -----------------------------------------------------------------------------
  ORNEK3: siparisler tablosundaki tum siparis_id ve siparis_tarihleri ile 
  bunlara karsilik gelen sirket_isimlerini listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/ 
-- ************ LEFT COZUMU **************
SELECT sirketler.sirket_id,
	   sirketler.sirket_isim,
       siparisler.siparis_id,
       siparisler.siparis_tarihi
FROM sirketler LEFT JOIN siparisler
ON sirketler.sirket_id = siparisler.sirket_id;
-- ************ RIGHT COZUMU **************
SELECT sirketler.sirket_id,
	   sirketler.sirket_isim,
       siparisler.siparis_id,
       siparisler.siparis_tarihi
FROM siparisler RIGHT JOIN sirketler
ON sirketler.sirket_id = siparisler.sirket_id;

/*=============================== full JOIN  ==================================
    full JOIN: (left join + union + right join)
    full  JOIN, Her iki tablo icin secilen sutunlara ait olan tum satirlari 
    getirmek icin kullanilir. 
    
    Syntax
    -----------
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    left JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    union all
    SELECT sutun1,sutun2....sutunN
    FROM tablo1 
    right JOIN tablo2
    ON tablo1.sutun = tablo2.sutun
    
    1) JOIN'de iki tabloda var olan tum record'lar gosterilir.
    2) Bir tabloda olup otekinde olmayan data'lar bos kalir.
==============================================================================*/

/* -----------------------------------------------------------------------------
  ORNEK4: sirketler ve siparisler adÄ±ndaki tablolarda yer alan sirket_id,sirket_isim, 
  siparis_id ve siparis_tarihleri listeleyen bir sorgu yaziniz.
------------------------------------------------------------------------------*/

select sirketler.sirket_id,
sirketler.sirket_isim,
siparisler.siparis_id,
siparisler.siparis_tarihi
from sirketler left join siparisler
on sirketler.sirket_id = siparisler.sirket_id
union
select siparisler.sirket_id,
sirketler.sirket_isim,
siparisler.siparis_id,
siparisler.siparis_tarihi
from sirketler right join siparisler
on sirketler.sirket_id = siparisler.sirket_id;

-- *************************************************************************************    
    
    CREATE TABLE bolumler (
      bolum_id   int PRIMARY KEY,
      bolum_isim VARCHAR(14),
      konum      VARCHAR(13)
    );
    
    INSERT INTO bolumler VALUES (10,'MUHASEBE','IST');
    INSERT INTO bolumler VALUES (20,'MUDURLUK','ANKARA');
    INSERT INTO bolumler VALUES (30,'SATIS','IZMIR');
    INSERT INTO bolumler VALUES (40,'ISLETME','BURSA');
    INSERT INTO bolumler VALUES (50,'DEPO', 'YOZGAT');
    
    CREATE TABLE calisanlar (
      personel_id   int PRIMARY KEY,
      personel_isim VARCHAR(10),
      meslek        VARCHAR(9),
      mudur_id      int,
      maas          int,
      bolum_id      int
    );
  

  
    INSERT INTO calisanlar VALUES (7369,'AHMET','KATIP',1111,800,20);
    INSERT INTO calisanlar VALUES (7499,'BAHATTIN','SATISE',1222,1600,30);
    INSERT INTO calisanlar VALUES (7521,'NESE','SATISE',1222,1250,30);
    INSERT INTO calisanlar VALUES (1111,'MUZAFFER','MUDUR',7839,2975,20);
    INSERT INTO calisanlar VALUES (7654,'MUHAMMET','SATISE',1222,1250,30);
    INSERT INTO calisanlar VALUES (1222,'EMINE','MUDUR',7839,2850,30);
    INSERT INTO calisanlar VALUES (1333,'HARUN','MUDUR',7839, 2450,10);
    INSERT INTO calisanlar VALUES (7788,'MESUT','ANALIST',1111,3000,20);
    INSERT INTO calisanlar VALUES (7839,'SEHER','BASKAN',NULL,5000,10);
    INSERT INTO calisanlar VALUES (7844,'DUYGU','SATISE',1222,1500,30);
    INSERT INTO calisanlar VALUES (7876,'ALI','KATIP',1111,1100,20);
    INSERT INTO calisanlar VALUES (7900,'MERVE','KATIP',1222,950,30);
    INSERT INTO calisanlar VALUES (7902,'NAZLI','ANALIST',1111,3000,20);
    INSERT INTO calisanlar VALUES (7934,'EBRU','KATIP',1333,1300,10);
    INSERT INTO calisanlar VALUES (7956,'SIBEL','MIMAR',1333,3300,60);
    INSERT INTO calisanlar VALUES (7933,'ZEKI','MUHENDIS',1333,4300,60);
       SELECT * FROM bolumler;
       select * from calisanlar;
    /* -----------------------------------------------------------------------------
  ORNEK1: SATIS ve MUHASABE bolumlerinde calisanlarin isimlerini ve 
  bolumlerini, once bolum sonra isim sÄ±ralÄ± olarak listeleyiniz
------------------------------------------------------------------------------*/
select calisanlar.personel_isim, bolumler.bolum_isim
from bolumler join calisanlar
on calisanlar.bolum_id= bolumler.bolum_id
where bolum_isim in('Satis','Muhasebe')
order by bolum_isim,personel_isim;

/* -----------------------------------------------------------------------------
  ORNEK2: SATIS,ISLETME ve DEPO bolumlerinde calisan personelin isimlerini,  
  bolumlerini  isim sirali olarak listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/
select calisanlar.personel_isim, bolumler.bolum_isim
from bolumler left join calisanlar
on calisanlar.bolum_id= bolumler.bolum_id
where bolum_isim in ('satis','isletme','depo')
order by personel_isim;

-- odev
/* -----------------------------------------------------------------------------
  ORNEK3: Tum bolumlerde calisan personelin isimlerini, bolum isimlerini ve 
  maaslarini bolum ters ve maas sirali listeleyiniz. 
  NOT: calisani olmasa bile bolum ismi gosterilmelidir.
------------------------------------------------------------------------------*/ 
/* -----------------------------------------------------------------------------
  ORNEK4: SATIS ve MUDURLUK bolumlerinde calisan personelin maaslari 2000'den
  buyuk olanlarin isimlerini, bolum isimlerini ve 
  maaslarini bolume ve isme gore siralayarak listeleyiniz. 
------------------------------------------------------------------------------*/ 





