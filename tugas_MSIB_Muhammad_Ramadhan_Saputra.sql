-- TUGAS 7 Database MYSQL

-- Buat fungsi inputPelanggan(), setelah itu panggil fungsinya
DELIMITER $$
 CREATE PROCEDURE inputanPelanggan()
    -> BEGIN
    -> INSERT INTO pelanggan (kode, nama_pelanggan, jk , tmp_lahir, tgl_lahir,  email, alamat, kartu_id) VALUES
    -> ('OR006', 'Rangga Gumilang', 'L', 'Surabaya', '2000-12-25', 'rangga@email.com' , 'Jl. Raya Pahlawan','3');
    -> END
    -> $$
DELIMITER ;
CALL inputanPelanggan();

-- Buat fungsi showPelanggan(), setelah itu panggil fungsinya
DELIMITER $$
CREATE PROCEDURE showPelanggan()
    -> BEGIN
    -> SELECT p.id, p.kode, p.nama_pelanggan, p.jk, p.tmp_lahir, p.tgl_lahir, p.email, p.alamat,kartu_id, k.nama
    -> FROM pelanggan p JOIN kartu k ON p.kartu_id = k.id;
    -> END
    -> $$
DELIMITER ;
CALL showPelanggan();

-- +----+-------+----------------------+------+-----------+------------+------------------+----------------------+----------+----------+
-- | id | kode  | nama_pelanggan       | jk   | tmp_lahir | tgl_lahir  | email            | alamat               | kartu_id | nama     |
-- +----+-------+----------------------+------+-----------+------------+------------------+----------------------+----------+----------+
-- |  1 | OR001 | Ramadhan Saputra     | L    | Situbondo | 2002-08-28 | ramadh@gmail.com | Bondowoso Jawa Timur |        2 | PLATINUM |
-- |  2 | OR002 | Zafran Gazi          | L    | Jember    | 2002-05-02 | zafrn@gmail.com  | Jember Jatim         |        2 | PLATINUM |
-- |  3 | OR003 | Sofyan Saori         | L    | Bondowoso | 1998-04-01 | sof@gmail.com    | Bondowoso Jawa Timur |        2 | PLATINUM |
-- |  4 | OR004 | Laili Laiya          | P    | Jember    | 2000-05-02 | lay@email.com    | Jember Jatim         |        3 | Gold     |
-- |  5 | OR005 | Budi                 | L    | Jakarta   | 1990-01-01 | Budi@email.com   | Jl. Raya Gaspol      |        3 | Gold     |
-- |  7 | OR006 | Rangga Gumilang      | L    | Surabaya  | 2000-12-25 | rangga@email.com | Jl. Raya Pahlawan    |        3 | Gold     |
-- +----+-------+----------------------+------+-----------+------------+------------------+----------------------+----------+----------+

-- Buat fungsi inputProduk(), setelah itu panggil fungsinya
DELIMITER $$
CREATE PROCEDURE inputProduk()
    -> BEGIN
    -> INSERT INTO produk (kode, nama, harga_beli,harga_jual, stok,min_stok,jenis_produk_id) VALUES
    -> ('TV002','Samsung', 2000000, 2500000, 10, 5, 1);
    -> END
    -> $$
DELIMITER ;
CALL inputProduk();

-- Buat fungsi showProduk(), setelah itu panggil fungsinya
DELIMITER $$
CREATE PROCEDURE showProduk()
    -> BEGIN
    -> SELECT p.id, p.kode, p.nama, p.harga_beli, p.harga_jual, p.stok, p.min_stok, p.jenis_produk_id, jp.nama
    -> FROM produk p JOIN jenis_produk jp ON p.jenis_produk_id = jp.id;
    -> END
    -> $$
DELIMITER ;
CALL showProduk();

-- +----+-------+-----------------+------------+------------+------+----------+-----------------+----------+
-- | id | kode  | nama            | harga_beli | harga_jual | stok | min_stok | jenis_produk_id | nama     |
-- +----+-------+-----------------+------------+------------+------+----------+-----------------+----------+
-- |  1 | TV001 | Toshiba         |     100000 |     120000 |   12 |       15 |               1 | Televisi |
-- |  2 | K0001 | Home Kulkas     |     300000 |     320000 |   10 |       12 |               2 | Kulkas   |
-- |  3 | C0001 | Blue Jeans      |     120000 |     130000 |    3 |        4 |               4 | Celana   |
-- |  4 | KM001 | Flanel Kemejaku |      70000 |      80000 |    3 |        5 |               3 | Kemeja   |
-- |  5 | TV002 | Samsung         |    2000000 |    2500000 |   10 |        5 |               1 | Televisi |
-- +----+-------+-----------------+------------+------------+------+----------+-----------------+----------+

-- Buat fungsi totalPesanan(), setelah itu panggil fungsinya
DELIMITER $$
CREATE PROCEDURE totalPesanan()
    -> BEGIN
    ->  SELECT COUNT(*) AS total_pesanan FROM pesanan;
    -> END
    -> $$
DELIMITER ;
CALL totalPesanan();

-- +---------------+
-- | total_pesanan |
-- +---------------+
-- |             2 |
-- +---------------+

-- tampilkan seluruh pesanan dari semua pelanggan
SELECT * from pelanggan p JOIN pesanan ps ON p.id = ps.pelanggan_id;

-- +----+-------+----------------------+------+-----------+------------+------------------+----------------------+----------+----+------------+-------+--------------+
-- | id | kode  | nama_pelanggan       | jk   | tmp_lahir | tgl_lahir  | email            | alamat               | kartu_id | id | tanggal    | total | pelanggan_id |
-- +----+-------+----------------------+------+-----------+------------+------------------+----------------------+----------+----+------------+-------+--------------+
-- |  1 | OR001 | Muhammad Yusril Amin | L    | Situbondo | 2002-08-28 | yusril@gmail.com | Bondowoso Jawa Timur |        2 |  1 | 2023-05-03 |     5 |            1 |
-- |  2 | OR002 | Zafran Gazi          | L    | Jember    | 2002-05-02 | zafrn@gmail.com  | Jember Jatim         |        2 |  2 | 2023-05-03 |     8 |            2 |
-- +----+-------+----------------------+------+-----------+------------+------------------+----------------------+----------+----+------------+-------+--------------+

-- buatkan query panjang di atas menjadi sebuah view baru: pesanan_produk_vw (menggunakan join dari table pesanan,pelanggan dan produk)
 CREATE VIEW pesanan_produk_vw AS
    -> SELECT ps.tanggal as tanggal_pesanan, ps.total as total, p.kode as kode_pelanggan, p.nama_pelanggan, p.jk, p.tmp_lahir, p.tgl_lahir, p.email, p.kartu_id, pr.kode as kode_produk,
    -> pr.nama as nama_produk, pr.harga_beli, pr.harga_jual, pr.stok, pr.min_stok, pr.jenis_produk_id
    -> FROM pesanan as ps JOIN pelanggan as p ON ps.pelanggan_id = p.id JOIN pesanan_items as pi ON pi.pesanan_id = p.id JOIN produk as pr ON pi.produk_id = pr.id;

SELECT * FROM pesanan_produk_vw;
-- +-----------------+-------+----------------+----------------------+------+-----------+------------+------------------+----------+-------------+-----------------+------------+------------+------+----------+-----------------+
-- | tanggal_pesanan | total | kode_pelanggan | nama_pelanggan       | jk   | tmp_lahir | tgl_lahir  | email            | kartu_id | kode_produk | nama_produk     | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
-- +-----------------+-------+----------------+----------------------+------+-----------+------------+------------------+----------+-------------+-----------------+------------+------------+------+----------+-----------------+
-- | 2023-05-03      |     5 | OR001          | Muhammad Yusril Amin | L    | Situbondo | 2002-08-28 | yusril@gmail.com |        2 | TV001       | Toshiba         |     100000 |     120000 |   12 |       15 |               1 |
-- | 2023-05-03      |     8 | OR002          | Zafran Gazi          | L    | Jember    | 2002-05-02 | zafrn@gmail.com  |        2 | KM001       | Flanel Kemejaku |      70000 |      80000 |    3 |        5 |               3 |
-- +-----------------+-------+----------------+----------------------+------+-----------+------------+------------------+----------+-------------+-----------------+------------+------------+------+----------+-----------------+