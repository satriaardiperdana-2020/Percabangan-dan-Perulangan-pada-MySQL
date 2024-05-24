-- PERTEMUAN 3
-- Variable 
SHOW SESSION VARIABLES;

use view_procedure;

-- User Variable

   SET @Name = 'Satria'; -- set value
   
   SELECT @Name; -- get value
   
   -- value di set langsung
   SELECT @Name := 'Satria';
  
  -- contoh lengkap dari tabel cari stok max / min
  
  SELECT @tbmb_stok := MIN(tbmb_stok) FROM tb_master_barang;
  SELECT * from tb_master_barang where tbmb_stok = @tbmb_stok;

-- LOCAL variable

CREATE OR REPLACE PROCEDURE gaji()
BEGIN
   DECLARE Robert INT;
   DECLARE Mila INT DEFAULT 3000000;
   DECLARE Toni INT;
   DECLARE Total INT;
   SET Robert = 2000000;
   SET Toni = 2900000;
   SET Total = Robert+Mila+Toni;
   SELECT Total,Robert,Mila,Toni;
END; 
            
CALL gaji();

-- Contoh local variable


-- SYSTEM VARIABLE -- MYSQL ONLY -> ERROR DI POSTGREE
SHOW [GLOBAL | SESSION] VARIABLES;
SHOW GLOBAL VARIABLES;

SHOW SESSION VARIABLES;

SHOW VARIABLES LIKE '%table%';              
              
-- Loopand perulangan

-- IF Satu Kondisi

IF(ekspresi, true, false)

IF kondisi THEN statemen
	
END IF

-- IF Banyak kondisi

IF kondisi THEN statemen
	ELSE IF kondisi THEN statemen
	...
	ELSE statemen
END IF

-- Case Statement
CASE (ekspresi)
	WHEN nilai_1 THEN statemen_1;
	WHEN nilai_2 THEN statemen_2;
	...
	WHEN nilai_n THEN statemen_n;

	ELSE statemen_lain;
END CASE




-- CONTOH IF SATU KONDISI, IN MYSQL ONLY, TEST DI POSTGREE TDK RUNNING
SELECT
    * ,
    IF (tbmb_harga  < 5000, 'Murah', 'Mahal') AS Harga
FROM tb_master_barang;

SELECT * FROM tb_master_barang;

-- IF DIATAS CONVERT KE CASE WHEN
SELECT *,
       CASE
           WHEN tbmb_harga  < 5000 THEN 'Murah'
           ELSE 'Mahal'
       END AS Harga
FROM tb_master_barang;


-- Contoh IF 1 kondisi dalam Store Procedure


CREATE OR REPLACE PROCEDURE salary(v_salary INT)
BEGIN
DECLARE v_hasil varchar(200);
  IF v_salary < 5000000 THEN SET v_hasil = 'Salary is less than 5000000.';
  END IF;
  SELECT v_hasil;
END; 


CALL salary(4000000);-- > 5000
-- OR
CALL salary(4500);-- < 5000


-- Contoh IF 2 kondisi dalam Store Procedure

CREATE OR REPLACE PROCEDURE salary_2_kondisi(v_salary INT)
BEGIN
DECLARE v_hasil varchar(200);
  IF v_salary < 5000000 THEN SET v_hasil = 'Salary is less than 5000000.';
  ELSE  SET v_hasil = 'Salary is more than 5000000.';
  END IF;
  SELECT v_hasil;
END; 


CALL salary_2_kondisi(5500000);-- > 5000
-- OR
CALL salary_2_kondisi(4500000);-- < 5000


-- Contoh IF 3 kondisi dalam Store Procedure

CREATE OR REPLACE PROCEDURE salary_3_kondisi(v_salary INT)
BEGIN
DECLARE v_hasil varchar(200);
  IF 	   v_salary < 5000000 THEN SET v_hasil = 'Salary is less than 5000000.';
  ELSEIF  v_salary = 5000000 THEN SET v_hasil = 'Salary is equal to 5000000.';
  ELSE SET v_hasil = 'Salary is more than 5000000.';
  END IF;
  SELECT v_hasil;
END; 


CALL salary_3_kondisi(5500000);-- > 5000000
-- OR
CALL salary_3_kondisi(4500000);-- < 5000000
-- OR
CALL salary_3_kondisi(5000000);-- = 5000000



-- CONTOH IF lebih dari 3 kondisi
CREATE OR REPLACE PROCEDURE bulan(v_bulan INT)
BEGIN 
DECLARE v_nama_bulan varchar(20);
	IF v_bulan = 1      THEN SET v_nama_bulan = 'Januari';
	ELSEIF v_bulan = 2  THEN SET v_nama_bulan = 'Februari';
	ELSEIF v_bulan = 3  THEN SET v_nama_bulan = 'Maret';
	ELSEIF v_bulan = 4  THEN SET v_nama_bulan = 'April';
	ELSEIF v_bulan = 5  THEN SET v_nama_bulan = 'Mei';
	ELSEIF v_bulan = 6  THEN SET v_nama_bulan = 'Juni';
	ELSEIF v_bulan = 7  THEN SET v_nama_bulan = 'Juli';
	ELSEIF v_bulan = 8  THEN SET v_nama_bulan = 'Agustus';
	ELSEIF v_bulan = 9  THEN SET v_nama_bulan = 'September';
	ELSEIF v_bulan = 10 THEN SET v_nama_bulan = 'Oktober';
	ELSEIF v_bulan = 11 THEN SET v_nama_bulan = 'November';
	ELSEIF v_bulan = 12 THEN SET v_nama_bulan = 'Desember';
	ELSE                     SET v_nama_bulan = 'Not Found';
	END IF;
	SELECT v_nama_bulan;
END;

CALL bulan(15);

use view_procedure;

-- CASE STATEMENT 1 Kondisi
CREATE OR REPLACE PROCEDURE salary_case(v_salary INT)
BEGIN
DECLARE v_hasil varchar(200);
  CASE 
	 WHEN v_salary < 5000000 THEN SET v_hasil = 'Salary is less than 5000000.';
  END CASE;
  SELECT v_hasil;
END; 

CALL salary_case(6000000);

-- CASE STATEMENT 2 Kondisi
CREATE OR REPLACE PROCEDURE salary_case_2_kondisi(v_salary INT)
BEGIN
DECLARE v_hasil varchar(200);
  CASE 
	 WHEN v_salary < 5000000 THEN SET v_hasil = 'Salary is less than 5000000.';
	 ELSE  SET v_hasil = 'Salary is equal or more than 5000000.';
  END CASE;
  SELECT v_hasil;
END; 

CALL salary_case_2_kondisi(5000000);

DELIMITER //

CREATE FUNCTION CalcIncome ( starting_value INT )
RETURNS INT

BEGIN

   DECLARE income INT;

   SET income = 0;

   label1: LOOP
     SET income = income + starting_value;
     IF income < 4000 THEN
       ITERATE label1;
     END IF;
     LEAVE label1;
   END LOOP label1;

   RETURN income;

END; //

DELIMITER ;
-- CASE STATEMENT 3 Kondisi

CREATE OR REPLACE PROCEDURE salary_case_3_kondisi(v_salary INT)
BEGIN
DECLARE v_hasil varchar(200);
	CASE 
	 	WHEN v_salary < 5000000 THEN SET v_hasil = 'Salary is less than 5000000.';
	 	WHEN v_salary = 5000000 THEN SET v_hasil = 'Salary is equal to 5000000.';
	 	ELSE  SET v_hasil = 'Salary is more than 5000000.';
  	END CASE;	
  	SELECT v_hasil;
END; 

CALL salary_case_3_kondisi(4000000);
OR
CALL salary_case_3_kondisi(6000000);
OR

CALL salary_case_3_kondisi(5000000);


-- CASE STATEMENT lebih 3 Kondisi

CREATE OR REPLACE PROCEDURE case_bulan(v_bulan INT)
BEGIN
DECLARE v_nama_bulan varchar(20);
	CASE 
		WHEN v_bulan = 1  THEN SET v_nama_bulan = 'Januari';
		WHEN v_bulan = 2  THEN SET v_nama_bulan = 'Februari';
		WHEN v_bulan = 3  THEN SET v_nama_bulan = 'Maret';
		WHEN v_bulan = 4  THEN SET v_nama_bulan = 'April';
		WHEN v_bulan = 5  THEN SET v_nama_bulan = 'Mei';
		WHEN v_bulan = 6  THEN SET v_nama_bulan = 'Juni';
		WHEN v_bulan = 7  THEN SET v_nama_bulan = 'Juli';
		WHEN v_bulan = 8  THEN SET v_nama_bulan = 'Agustus';
		WHEN v_bulan = 9  THEN SET v_nama_bulan = 'September';
		WHEN v_bulan = 10 THEN SET v_nama_bulan = 'Oktober';
		WHEN v_bulan = 11 THEN SET v_nama_bulan = 'November';
		WHEN v_bulan = 12 THEN SET v_nama_bulan = 'Desember';
		ELSE                   SET v_nama_bulan = 'Not Found';
	END CASE;
	SELECT v_nama_bulan;
END;


-- Panggil  case_bulan
CALL case_bulan(15);




-- Perulangan / Looping

-- LOOP Statement

CREATE OR REPLACE PROCEDURE test_loop_leave()
BEGIN 
	DECLARE x int;
	DECLARE output varchar(50);
	
	SET x = 1;
	SET output = "";
	
	loop_label_name: LOOP
		IF x >5 THEN
			LEAVE loop_label_name;
		END IF;
		SET output = CONCAT(output,x,", ");
	SET x = x + 1;
		
	END LOOP loop_label_name;
	SELECT output;
	
END;

-- SELECT CONCAT('DU',' A'); -- Concat untuk menggabungkan string

CALL test_loop_leave();

-- Contoh loop 2
CREATE OR REPLACE PROCEDURE test_loop_repeat(IN batas INT)
BEGIN 
	DECLARE i int;
	DECLARE hasil varchar(50) DEFAULT '';
	
	SET i = 1;
	-- SET output = "";
	
	REPEAT
	SET hasil = CONCAT(hasil, i, ' ');
	SET i = i + 1;
	UNTIL i > batas
	END REPEAT;
		
	
	SELECT hasil;
	
END;

CALL test_loop_repeat(10);



-- Contoh loop 3
CREATE OR REPLACE PROCEDURE test_loop_while(IN batas INT)
BEGIN 
	DECLARE i int;
	DECLARE hasil varchar(50) DEFAULT '';
	
	SET i = 1;
	
	REPEAT
	SET hasil = CONCAT(hasil, i, ' ');
	SET i = i + 1;
	UNTIL i > batas
	END REPEAT;
		
	
	SELECT hasil;
	
END;




