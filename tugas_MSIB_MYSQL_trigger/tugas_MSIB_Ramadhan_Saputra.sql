--  Soal
-- Buatlah bisnis proses pembayaran dengan menggunakan trigers, dengan skenario sebagai berikut :

-- 1. pelanggan memesan didalam table pesanan

-- 2. dilanjutkan dengan proses pembayaran di table pembayara

-- 3. didalam table pembayaran tambahkan kolom status_pembayaran

-- 4. jika pesanan sudah dibayar maka status pembayaran akan berubah menjadi lunas 

-- Jawaban

-- Tambahkan Field status pada tabel Pembayaran
ALTER TABLE pembayaran ADD COLUMN status_pembayaran ENUM('Belum Lunas','Lunas') NOT NULL;

DESC pembayaran;

--  +-------------------+-----------------------------+------+-----+---------+----------------+
-- | Field             | Type                        | Null | Key | Default | Extra          |
-- +-------------------+-----------------------------+------+-----+---------+----------------+
-- | id                | int(11)                     | NO   | PRI | NULL    | auto_increment |
-- | nokuitansi        | varchar(10)                 | YES  | UNI | NULL    |                |
-- | tanggal           | date                        | YES  |     | NULL    |                |
-- | jumlah            | double                      | YES  |     | NULL    |                |
-- | ke                | int(11)                     | YES  |     | NULL    |                |
-- | pesanan_id        | int(11)                     | NO   | MUL | NULL    |                |
-- | status_pembayaran | enum('Belum Lunas','Lunas') | NO   |     | NULL    |                |
-- +-------------------+-----------------------------+------+-----+---------+----------------+

-- Membuat trigger Total harga pesanan sehingga saat menambahkan item data total pesanan akan update otomatis
DELIMITER $$
CREATE TRIGGER total_harga_pesanan AFTER INSERT ON pesanan_items
    FOR EACH ROW
    BEGIN
    SET @total = (SELECT total FROM pesanan WHERE id = NEW.pesanan_id);
    SET @hasil = @total + NEW.harga;
    UPDATE pesanan SET total = @hasil WHERE id = NEW.pesanan_id;
    END
    $$

-- Membuat trigger update pesanan items  sehingga saat mengupdate item data total pesanan akan update otomatis
DELIMITER $$
CREATE TRIGGER update_pesanan_items AFTER UPDATE ON pesanan_items
    FOR EACH ROW
    BEGIN
    SET @total_lama = (SELECT total FROM pesanan WHERE id = OLD.pesanan_id);
    SET @hasil = (@total_lama - OLD.harga) + NEW.harga;
    UPDATE pesanan SET total = @hasil WHERE id = NEW.pesanan_id;
    END
    $$

-- Membuat trigger hapus pesanan items  sehingga saat menhapus item data total pesanan akan update otomatis
DELIMITER $$
CREATE TRIGGER hapus_pesanan_items AFTER DELETE ON pesanan_items
    FOR EACH ROW
    BEGIN
    SET @total_lama = (SELECT total FROM pesanan WHERE id = OLD.pesanan_id);
    SET @hasil = @total_lama - OLD.harga;
    UPDATE pesanan SET total = @hasil WHERE id = OLD.pesanan_id;
    END
    $$

-- tambah pesanan
INSERT INTO pesanan (tanggal, total , pelanggan_id)
    VALUES ('2023-05-06',0,1);

-- lihat data pesanan 
SELECT * FROM pesanan;
-- +----+------------+---------+--------------+
-- |  1 | 2015-11-04 | 9720000 |            1 |
-- |  2 | 2015-11-04 |   17500 |            3 |
-- |  3 | 2015-11-04 |       0 |            6 |
-- |  4 | 2015-11-04 |       0 |            7 |
-- |  5 | 2015-11-04 |       0 |           10 |
-- |  6 | 2015-11-04 |       0 |            2 |
-- |  7 | 2015-11-04 |       0 |            5 |
-- |  8 | 2015-11-04 |       0 |            4 |
-- |  9 | 2015-11-04 |       0 |            8 |
-- | 10 | 2015-11-04 |       0 |            9 |
-- | 11 | 2023-05-06 |       0 |            1 |
-- +----+------------+---------+--------------+


-- tambah pesanan items
INSERT INTO pesanan_items (produk_id, pesanan_id, qty, harga)
    -> VALUES (5,11,2,7000);

INSERT INTO pesanan_items (produk_id, pesanan_id, qty, harga)
    -> VALUES (7,11,4,10000);

-- lihat data pesanan 
SELECT * FROM pesanan;
-- +----+------------+---------+--------------+
-- | id | tanggal    | total   | pelanggan_id |
-- +----+------------+---------+--------------+
-- |  1 | 2015-11-04 | 9720000 |            1 |
-- |  2 | 2015-11-04 |   17500 |            3 |
-- |  3 | 2015-11-04 |       0 |            6 |
-- |  4 | 2015-11-04 |       0 |            7 |
-- |  5 | 2015-11-04 |       0 |           10 |
-- |  6 | 2015-11-04 |       0 |            2 |
-- |  7 | 2015-11-04 |       0 |            5 |
-- |  8 | 2015-11-04 |       0 |            4 |
-- |  9 | 2015-11-04 |       0 |            8 |
-- | 10 | 2015-11-04 |       0 |            9 |
-- | 11 | 2023-05-06 |   24000 |            1 |
-- +----+------------+---------+--------------+

-- update pesanan items
UPDATE pesanan_items SET qty = 5, harga = 12500 WHERE id = 17;

-- lihat data pesanan 
SELECT * FROM pesanan;
-- +----+------------+---------+--------------+
-- | id | tanggal    | total   | pelanggan_id |
-- +----+------------+---------+--------------+
-- |  1 | 2015-11-04 | 9720000 |            1 |
-- |  2 | 2015-11-04 |   17500 |            3 |
-- |  3 | 2015-11-04 |       0 |            6 |
-- |  4 | 2015-11-04 |       0 |            7 |
-- |  5 | 2015-11-04 |       0 |           10 |
-- |  6 | 2015-11-04 |       0 |            2 |
-- |  7 | 2015-11-04 |       0 |            5 |
-- |  8 | 2015-11-04 |       0 |            4 |
-- |  9 | 2015-11-04 |       0 |            8 |
-- | 10 | 2015-11-04 |       0 |            9 |
-- | 11 | 2023-05-06 |   26500 |            1 |
-- +----+------------+---------+--------------+

-- hapus pesanan items
DELETE FROM pesanan_items WHERE id = 16;

-- lihat data pesanan 
SELECT * FROM pesanan;
-- +----+------------+---------+--------------+
-- | id | tanggal    | total   | pelanggan_id |
-- +----+------------+---------+--------------+
-- |  1 | 2015-11-04 | 9720000 |            1 |
-- |  2 | 2015-11-04 |   17500 |            3 |
-- |  3 | 2015-11-04 |       0 |            6 |
-- |  4 | 2015-11-04 |       0 |            7 |
-- |  5 | 2015-11-04 |       0 |           10 |
-- |  6 | 2015-11-04 |       0 |            2 |
-- |  7 | 2015-11-04 |       0 |            5 |
-- |  8 | 2015-11-04 |       0 |            4 |
-- |  9 | 2015-11-04 |       0 |            8 |
-- | 10 | 2015-11-04 |       0 |            9 |
-- | 11 | 2023-05-06 |   19500 |            1 |
-- +----+------------+---------+--------------+

-- Insert Pembayaran
INSERT INTO pembayaran (nokuitansi, tanggal, jumlah, ke, pesanan_id, status_pembayaran) VALUES ('K-001','2023-05-06',19500,1,11,'Lunas');

-- lihat pembayaran
SELECT * FROM pembayaran;
-- +----+------------+------------+--------+------+------------+-------------------+
-- | id | nokuitansi | tanggal    | jumlah | ke   | pesanan_id | status_pembayaran |
-- +----+------------+------------+--------+------+------------+-------------------+
-- |  1 | K-001      | 2023-05-06 |  19500 |    1 |         11 | Lunas             |
-- +----+------------+------------+--------+------+------------+-------------------+