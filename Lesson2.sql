

USE Northwind;

-- ctrl + r bildirim ekranını açıp kapatır
-- DML => Data Manipulation Language
-- TABLOLARI SORGULAMAK
-- select <sütun isimleri,> from <tablo adı> -- (birden fazla sütun ismi verilecek ise virgül(,) ile ayırmanız gerekemektedir.)
-- Employees tablosu içerisinde yer alan tüm verilerin sorgulanması

SELECT *
FROM Employees; -- (*) anahtar değeri, tablo içerisinde yer alan tüm sütun isimlerini temsil eder. 
-- Eğer tüm alanlar seçilmeyecek ise, mutlaka sütun isimleri yazılmalıdır. Aksi takdirde gereksiz veri çekerek sorgunuzun performansını düşürecektir.
-- Employees tablosundan, Çalışanlara ait - isim, soyisim, görev ve doğum tarihi bilgilerinin listelenmesi

SELECT FirstName , LastName , Title , BirthDate
FROM Employees; -- Seçmek istediğimiz sütunları aralarına virgül koyarak belirtiyoruz. 
-- Sütun isimlerinin Intellisense menüsü ile gelmesi için Select ifadesinden sonra From <tablo_adı> yazıp, daha sonra Select ile From arasına sütun isimlerini yazarsak, sütun isimleri bize listelenir.

SELECT [EmployeeID] , [LastName] , [FirstName] , [Title] , [TitleOfCourtesy] , [BirthDate] , [HireDate] , [Address] , [City] , [Region] , [PostalCode] , [Country] , [HomePhone] , [Extension] , [Photo] , [Notes] , [ReportsTo] , [PhotoPath]
FROM Employees;

-- Employees tablosunun sütunlarını sürükle bırak yardımı ile de ekleyebiliriz.
-- Sütunların isimlendirilmesi.
-- 1. YOL

SELECT FirstName AS Ad , LastName AS Soyad , Title AS Görev
FROM Employees; -- Sorgu sonucu oluşacak olan sonuç kümesindeki (result set) sütun isimleri değiştirilecektir, tablodaki orijinal sütun isimlerinin değiştirilmesi gibi bir durum söz konusu değildir.
-- 2. YOL

SELECT FirstName AS Ad , LastName AS Soyad , Title AS Görev , BirthDate AS 'Doğum Tarihi'
FROM Employees;

-- 3. YOL 

SELECT Ad = FirstName , Soyad = LastName , Görev = Title , 'Doğum Tarihi' = BirthDate , [İşe Giriş Tarihi] = HireDate
FROM Employees;

-- Tekil kayıtların listelenmesi

SELECT DISTINCT 
       City
FROM Employees;


SELECT DISTINCT 
       City , FirstName
FROM Employees;

-- metinlerin yan yana yazdirilmasi, (metin birlestirme islemi)
-- + operatoru (sayisal verilerde toplama) (metinsel verilerde yan yana yazdirma islemi yapar)

SELECT FirstName + ' ' + LastName AS [Personel Adı]
FROM Employees;
-- Ad = Sütun adı
-- Sütun adı as Ad
-- Sütun adı Ad
 
SELECT CONCAT(FirstName , ' ' , LastName) AS 'Personel Adı'
FROM Employees;



-- Tabloları filtrelemek
-- where

-- yazdigimiz sorgulari belirli bir alana gore filtrelemek icin kullandigimiz anahtar kelime.
-- Mr. olanlarin listelenmesi

SELECT FirstName , LastName , Title , TitleOfCourtesy
FROM Employees
WHERE TitleOfCourtesy = 'Mr.'; -- Metinsel ifadeler tek tirnak içinde yazilir.
-- EmployeeID degeri 5'ten buyuk olan personellerin listelenmesi

SELECT EmployeeID , FirstName , LastName
FROM Employees
WHERE EmployeeID > 5;

-- 1960 yılında dogan personelleri listeleyiniz.


SELECT FirstName , LastName , Title , YEAR(BirthDate) AS [Doğum Yılı]
FROM Employees
WHERE YEAR(BirthDate) = 1960; -- YEAR(datetime parametre) fonksiyonu bizden datetime tipinde bir değer alir ve geriye o tarih bilgisinin yilini döndürür.

 
-- 1950 ile 1961 yillari arasinda doğanlar
 
SELECT FirstName , LastName , BirthDate
FROM Employees
WHERE YEAR(BirthDate) >= 1950
      AND 
      YEAR(BirthDate) <= 1961;

-- ingiltere'de oturan bayanlarin adi, soyadi, mesleği, ünvani, ülkesi ve doğum tarihini listeleyiniz (Employees)



SELECT *
FROM Employees
WHERE ( TitleOfCourtesy = 'Ms.'
        OR 
        TitleOfCourtesy = 'Mrs.' )
      AND 
      Country = 'UK';


-- Ünvani Mr. olanlar veya yaşi 60'tan büyük olanlarin listelenmesi


SELECT FirstName , LastName , BirthDate , TitleOfCourtesy , ( YEAR(GETDATE()) - YEAR(BirthDate) ) AS Age
FROM Employees
WHERE TitleOfCourtesy = 'Mr.'
      OR 
      (YEAR(GETDATE()) - YEAR(BirthDate)) > 60;

 -- GETDATE() fonksiyonu güncel tarih bilgisini verir, YEAR() fonksiyonu ile birlikte o tarihe ait olan yil bilgisini öğreniyoruz. Where ifadesi ile  birlikte kendi isimlendirdiğimiz sütunlari kullanamayiz. Örneğin yukarida Yaş olarak isimlendirdiğimiz sütun ismini Where ifadesi ile birlikte kullanamayiz.

 -- NULL VERiLERi SORGULAMAK
 -- Bölgesi belirtilmeyen çalişanlarin listelenmesi


SELECT FirstName , LastName , Region
FROM Employees
WHERE Region IS NULL;  -- NULL olan sütunlari bu şekilde sorgulayabiliriz.

-- Bölgesi belirtilen çalişanlarin listelenmesi

SELECT FirstName , LastName , Region
FROM Employees
WHERE Region IS NOT NULL;  -- NULL değer içermeyen sütunlarin listelenmesi
-- NOT: NULL değerler sorgulanirken = veya <> gibi operatörler kullanilmaz. Bunun yerine IS NULL veya IS NOT NULL ifadeleri kullanilir.




-- Siralama islemleri (OrderBy) (A-Z, 0-9)Ascending (Z-A, 9-0)Descending

SELECT EmployeeID, FirstName, LastName
FROM Employees
WHERE EmployeeID > 2
      AND 
      EmployeeID < 8
ORDER BY FirstName ASC; -- Ascending (artan sirada)


SELECT FirstName , LastName , BirthDate
FROM Employees
ORDER BY BirthDate; -- Eğer ASC ifadesini belirtmezsek de default olarak bu şekilde siralama yapacaktir. Bu sorguda BirthDate sütununa göre artan sirada siralama yaptik.




SELECT FirstName , LastName , BirthDate
FROM Employees
ORDER BY BirthDate DESC ;-- Descending (azalan sirada)
-- ASC ifadesi sayisal sütunlarda küçükten büyüğe, metinsel sütunlarda A'dan Z'ye doğru siralama işlemi yaparken, DESC ifadesi tam tersi şekilde siralama yapar.

 
SELECT FirstName , LastName
FROM Employees
ORDER BY FirstName , LastName DESC; -- Elde ettiğimiz sonuç kümesini ada göre artan sirada siraladik. Eğer ayni ada sahip birden fazla kayit varsa bunlari da soyadina göre azalan sirada siraliyoruz. (Bu işlemi yapmak için Employees tablosuna yer alan bazi kayitlari Margaret olarak duzenledik)



SELECT FirstName , LastName , TitleOfCourtesy , ( YEAR(GETDATE()) - YEAR(BirthDate) ) AS Age , HireDate , BirthDate , TitleOfCourtesy
FROM Employees
ORDER BY 5 , 6 DESC;  -- Sorguda yazdiğimiz sütunun sirasina göre siralama işlemini yapabiliriz.
-- Yukaridaki sorguda yer alan 5. sutuna gore(HireDate) artan sirada siralama islemi yaptik, eger bu alan icerisinde aynı datalar var ise, 6. sutuna gore (BirthDate) alanina gore azalan sirada siralama yaptik.


-- Çalişanlari ünvanlarina göre ve ünvanlari ayniysa yaşlarina göre büyükten küçüğe siralayiniz.



SELECT FirstName , LastName , TitleOfCourtesy , ( YEAR(GETDATE()) - YEAR(BirthDate) ) AS Age
FROM Employees
ORDER BY 3 , Age DESC;

-- Order By ifadesi ile sütunlara vermiş olduğumuz takma isimleri kullanabiliriz. Örneğin Age sütunundaki gibi.



-- BETWEEN - AND Kullanimi
 
-- Aralik bildirmek için kullanacağimiz bir yapi sunar.
-- 1952 ile 1960 arasinda doğanlarin listelenmesi
-- 1. YOL


SELECT FirstName , LastName , BirthDate
FROM Employees
WHERE YEAR(BirthDate) >= 1952
      AND 
      YEAR(BirthDate) <= 1960;

-- 2. YOL

SELECT FirstName , LastName , BirthDate
FROM Employees
WHERE YEAR(BirthDate) BETWEEN 1952 AND 1960
ORDER BY 3;
 
-- Alfabetik olarak Janet ile Robert arasinda olanlarin listelenmesi

-- 1. YOL 


SELECT FirstName , LastName
FROM Employees
WHERE FirstName >= 'Janet'
      AND 
      FirstName <= 'Robert'
ORDER BY 1;

-- 2. YOL

SELECT FirstName , LastName
FROM Employees
WHERE FirstName BETWEEN 'Janet' AND 'Robert'
ORDER BY 1;
-- NOT: Order By ifadesi bir sorguda en sonda olmalidir.


-- IN Kullanimi
-- Ünvani Mr. veya Dr. olanlarin listelenmesi
-- I. YOL


SELECT FirstName , LastName , TitleOfCourtesy
FROM Employees
WHERE TitleOfCourtesy = 'Dr.'
      OR 
      TitleOfCourtesy = 'Mr.'
      OR 
      TitleOfCourtesy = 'Mrs.'
      OR 
      TitleOfCourtesy = 'Ms.';

-- 2. YOL

SELECT FirstName , LastName , TitleOfCourtesy
FROM Employees
WHERE TitleOfCourtesy IN ( 'Mr.' , 'Dr.'
                         );


-- 1950, 1955 ve 1960 yillarinda doğanlarin listelenmesi


SELECT FirstName , LastName , BirthDate
FROM Employees
WHERE YEAR(BirthDate) IN ( 1950 , 1955 , 1960
                         );


-- TOP Kullanimi

select Top 3 EmployeeID, FirstName, LastName, BirthDate from Employees -- Tabloda yer alan ilk 3 kaydi teslim eder.



SELECT TOP 5 EmployeeID , FirstName , LastName , TitleOfCourtesy
FROM Employees;

-- 1	Nancy	 Davolio	Ms.
-- 2	Andrew	 Fuller	    Dr.
-- 3	Janet	 Leverling	Ms.
-- 4	Margaret Peacock	Mrs.
-- 5	Margaret Buchanan	Mr.


SELECT TOP 5 EmployeeID , FirstName , LastName , TitleOfCourtesy
FROM Employees
ORDER BY TitleOfCourtesy;

-- 2	Andrew	    Fuller	  Dr.
-- 6	Margaret	Suyama	  Mr.
-- 5	Margaret	Buchanan  Mr.
-- 7	Margaret	King	  Mr.
-- 4	Margaret	Peacock	  Mrs.

-- TOP ifadesi bir sorguda en son çalişan kisimdir. Yani öncelikle sorgumuz çaliştirilir ve oluşacak olan sonuç kümesinin (result set) ilk 5 kaydi alinir.

-- Çalişanlari yaşlarina göre azalan sirada siraladiktan sonra, oluşacak sonuç kümesinin %25'lik kismini listeleyelim.



SELECT TOP 25 PERCENT FirstName , LastName , ( YEAR(GETDATE()) - YEAR(BirthDate) ) AS Age
FROM Employees
ORDER BY Age DESC;

-- Eğer belirttiğimiz oran sonucu 3.2 gibi bir kayit sayisi oluşuyorsa, bu durumda bize ilk 4 kayit gösterilir, yani yukari tamamlama işlemi gerçekleştirilir.